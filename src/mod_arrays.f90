module mod_arrays

  ! Utility functions that operate on arrays.

  implicit none

  private
  public :: average, reverse, moving_average, std

contains

  pure real function average(x)
    ! Returns a average of x.
    real, intent(in) :: x(:)
    average = sum(x) / size(x)
  end function average

  pure function reverse(x)
    ! Reverses the order of elements of x.
    real, intent(in) :: x(:)
    real :: reverse(size(x))
    reverse = x(size(x):1:-1)
  end function reverse

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

  pure real function std(x)
    ! Returns the standard deviation of x.
    real, intent(in) :: x(:)
    std = sqrt(average((x - average(x))**2))
  end function std

end module mod_arrays
