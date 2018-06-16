program stock_crossover

  use mod_arrays, only: crossneg, crosspos, reverse
  use mod_io, only: read_stock

  implicit none

  character(len=4), allocatable :: symbols(:)
  character(len=10), allocatable :: time(:)
  real, allocatable :: open(:), high(:), low(:), close(:), adjclose(:), volume(:)
  integer :: i, im, n
  integer, allocatable :: crossover(:)

  symbols = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ ',&
             'IBM ', 'INTC', 'MSFT', 'NVDA', 'ORCL']

  do n = 1, size(symbols)

    call read_stock('data/' // trim(symbols(n)) //  '.csv', time,&
      open, high, low, close, adjclose, volume)

    adjclose = reverse(adjclose)
    time = time(size(time):1:-1)
    crossover = crosspos(adjclose, 100)
    print *, symbols(n), crossover

    !if (n == 1) then
    !  print *, 'Symbol, Time, Price (USD), Moving average (USD)'
    !  print *, '-----------------------------------------------'
    !end if
!
!    do i = 1, size(time)
!      print *, symbols(n), time(i), adjclose(i), movavg(i)
!    end do

  end do

end program stock_crossover
