module mod_io

  ! A helper module for parsing stock price data in csv format.

  use mod_alloc, only: alloc

  implicit none

  private
  public :: read_stock, write_stock

contains

  integer function num_records(filename)
    ! Return the number of records (lines) of a text file.
    character(len=*), intent(in) :: filename
    integer :: fileunit
    open(newunit=fileunit, file=filename)
    num_records = 0
    do
      read(unit=fileunit, fmt=*, end=1)
      num_records = num_records + 1
    end do
    1 continue
    close(unit=fileunit)
  end function num_records

  subroutine read_stock(filename, time, open, high, low, close, adjclose, volume)
    ! Read daily stock prices from a csv file.
    character(len=*), intent(in) :: filename
    character(len=:), allocatable, intent(in out) :: time(:)
    real, allocatable, intent(in out) :: open(:), high(:), low(:),&
                                         close(:), adjclose(:), volume(:)
    integer :: fileunit, n, nm
    nm = num_records(filename) - 1
    if (allocated(time)) deallocate(time)
    allocate(character(len=10) :: time(nm))
    call alloc(open, nm)
    call alloc(high, nm)
    call alloc(low, nm)
    call alloc(close, nm)
    call alloc(adjclose, nm)
    call alloc(volume, nm)
    open(newunit=fileunit, file=filename)
    read(fileunit, fmt=*, end=1)
    do n = 1, nm
      read(fileunit, fmt=*, end=1) time(n), open(n),&
        high(n), low(n), close(n), adjclose(n), volume(n)
    end do
    1 close(fileunit)
  end subroutine read_stock

  subroutine write_stock(filename, time, price, mvavg, mvstd)
    ! Write derived stock data to file.
    character(len=*), intent(in) :: filename
    character(len=:), allocatable, intent(in) :: time(:)
    real, intent(in) :: price(:), mvavg(:), mvstd(:)
    integer :: fileunit, n
    open(newunit=fileunit, file=filename)
    do n = 1, size(time)
      write(fileunit, fmt=*) time(n), price(n), mvavg(n), mvstd(n)
    end do
    close(fileunit)
  end subroutine write_stock 

end module mod_io
