program stock_crossover

  use mod_arrays, only: crossneg, crosspos, reverse
  use mod_io, only: read_stock

  implicit none

  character(len=4), allocatable :: symbols(:)
  character(len=:), allocatable :: time(:)
  real, allocatable :: open(:), high(:), low(:), close(:), adjclose(:), volume(:)
  integer :: fileunit, i, im, n
  integer, allocatable :: buy(:), sell(:)

  symbols = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ ',&
             'IBM ', 'INTC', 'MSFT', 'NVDA', 'ORCL']

  do n = 1, size(symbols)

    print *, 'Processing moving average crossover for ' // symbols(n)

    call read_stock('data/' // trim(symbols(n)) //  '.csv', time,&
      open, high, low, close, adjclose, volume)

    time = time(size(time):1:-1)
    adjclose = reverse(adjclose)

    buy = crosspos(adjclose, 30)
    sell = crossneg(adjclose, 30)

    open(newunit=fileunit, file=trim(symbols(n)) // '_crossover.txt')
    do i = 1, size(buy)
      write(fileunit, fmt=*) 'Buy ', time(buy(i))
    end do
    do i = 1, size(sell)
      write(fileunit, fmt=*) 'Sell ', time(sell(i))
    end do
    close(fileunit)

  end do

end program stock_crossover
