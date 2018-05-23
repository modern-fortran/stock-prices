program stock_prices

  use mod_arrays, only: mean, reverse
  use mod_io, only: read_stock

  implicit none

  character(len=4), allocatable :: symbols(:)
  character(len=10), allocatable :: time(:)
  real, allocatable :: open(:), high(:), low(:), close(:), adjclose(:), volume(:)
  integer :: i, im, n

  symbols = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ ',&
             'IBM ', 'INTC', 'MSFT', 'NVDA', 'ORCL']

  write(*,*) 'Symbol, Open, Close, Average, Max. growth [%]'

  do n = 1, size(symbols)

    call read_stock('data/' // trim(symbols(n)) //  '.csv', time,&
      open, high, low, close, adjclose, volume)

    open = reverse(open)
    close = reverse(close)

    im = size(close)

    write(*,*) symbols(n), open(1), close(im), mean(open),&
               maxval((close - open) / open * 100)

  end do

end program stock_prices
