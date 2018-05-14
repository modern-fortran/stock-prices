module mod_io

  ! A helper module for parsing buoy data in csv format.

  implicit none

  private
  public :: read_stock

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
    character(len=10), allocatable, intent(in out) :: time(:)
    real, allocatable, intent(in out) :: open(:), high(:), low(:),&
                                         close(:), adjclose(:), volume(:)
    integer :: fileunit
    integer :: n, nm
    if (allocated(time)) deallocate(time)
    if (allocated(open)) deallocate(open)
    if (allocated(high)) deallocate(high)
    if (allocated(low)) deallocate(low)
    if (allocated(close)) deallocate(close)
    if (allocated(adjclose)) deallocate(adjclose)
    if (allocated(volume)) deallocate(volume)
    nm = num_records(filename) - 1
    allocate(time(nm), open(nm), high(nm), low(nm),&
             close(nm), adjclose(nm), volume(nm))
    open(newunit=fileunit, file=filename)
    read(fileunit, fmt=*, end=1)
    do n = 1, nm
      read(fileunit, fmt=*, end=1) time(n), open(n),&
        high(n), low(n), close(n), adjclose(n), volume(n)
    end do
    1 continue
    close(fileunit)
  end subroutine read_stock

end module mod_io
