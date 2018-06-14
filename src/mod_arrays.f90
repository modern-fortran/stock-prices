module mod_arrays

  ! Utility functions that operate on arrays.

  implicit none

  private
  public :: average, intdate, moving_average, reverse, std

contains

  pure real function average(x)
    ! Returns a average of x.
    real, intent(in) :: x(:)
    average = sum(x) / size(x)
  end function average

  pure elemental integer function intdate(t)
    ! Converts a time stamp in format YYYY-mm-dd to integer.
    character(len=10), intent(in) :: t
    character(len=8) :: str
    str = t(1:4) // t(6:7) // t(9:10)
    read(str, *) intdate
  end function intdate

  pure function moving_average(x, w) result(res)
    ! Returns the moving average of x with window w.
    real, intent(in) :: x(:)
    integer, intent(in) :: w
    real :: res(size(x))
    integer :: i, i1, i2
    res = 0
    do i = 1, size(x)
      i1 = max(i-w/2, 1)
      i2 = min(i+w/2, size(x))
      res(i) = average(x(i1:i2))
    end do 
  end function moving_average

  pure function reverse(x)
    ! Reverses the order of elements of x.
    real, intent(in) :: x(:)
    real :: reverse(size(x))
    reverse = x(size(x):1:-1)
  end function reverse

  pure real function std(x)
    ! Returns the standard deviation of x.
    real, intent(in) :: x(:)
    std = sqrt(average((x - average(x))**2))
  end function std

end module mod_arrays
