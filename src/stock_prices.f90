program stock_prices

  use mod_io, only: read_stock

  implicit none

  character(len=4), allocatable :: symbols(:)
  character(len=10), allocatable :: time(:)
  real, allocatable :: open(:), high(:), low(:), close(:), adjclose(:), volume(:)
  integer :: i

  symbols = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ ',&
             'IBM ', 'INTC', 'MSFT', 'NVDA', 'ORCL']

  do i = 1, size(symbols)
    call read_stock('data/' // trim(symbols(i)) //  '.csv', time,&
      open, high, low, close, adjclose, volume)
    write(*,*) symbols(i), maxval((close - open) / open * 100)
  end do

end program stock_prices
