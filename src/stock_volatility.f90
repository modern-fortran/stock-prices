program stock_volatility

  use mod_arrays, only: moving_average, moving_std
  use mod_io, only: read_stock, write_stock

  implicit none

  character(len=4), allocatable :: symbols(:)
  character(len=10), allocatable :: time(:)
  real, allocatable :: open(:), high(:), low(:), close(:), adjclose(:), volume(:)
  integer :: i, im, n
  real :: volatility

  symbols = ['AAPL', 'AMZN', 'CRAY', 'CSCO', 'HPQ ',&
             'IBM ', 'INTC', 'MSFT', 'NVDA', 'ORCL']

  do n = 1, size(symbols)

    call read_stock('data/' // trim(symbols(n)) //  '.csv', time,&
      open, high, low, close, adjclose, volume)

    !adjclose = reverse(adjclose)
    !volatility = std(adjclose)

    if (n == 1) then
      print *, time(size(time)) // ' through ' // time(1)
      print *, 'Symbol, Average (USD), Volatility (USD), Relative Volatility (%)'
      print *, '----------------------------------------------------------------'
    end if

    !print *, symbols(n), average(adjclose), std(adjclose),&
    !  nint(std(adjclose) / average(adjclose) * 100)

    call write_stock(trim(symbols(n)) // '.csv', time, adjclose,&
                     moving_average(adjclose, 100), moving_std(adjclose, 100))

  end do

end program stock_volatility
