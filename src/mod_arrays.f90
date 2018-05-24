module mod_arrays

  ! Utility functions that operate on arrays.

  implicit none

  private
  public :: mean, reverse, running_mean, std

contains

  pure real function mean(x)
    ! Returns a mean of x.
    real, intent(in) :: x(:)
    mean = sum(x) / size(x)
  end function mean

  pure function reverse(x)
    ! Reverses the order of elements of x.
    real, intent(in) :: x(:)
    real :: reverse(size(x))
    reverse = x(size(x):1:-1)
  end function reverse

  pure function running_mean(x, w) result(res)
    ! Returns the running mean of x with window w.
    real, intent(in) :: x(:)
    integer, intent(in) :: w
    real :: res(size(x))
    integer :: i, i1, i2
    res = 0
    do i = 1, size(x)
      i1 = max(i-w/2, 1)
      i2 = min(i+w/2, size(x))
      res(i) = mean(x(i1:i2))
    end do 
  end function running_mean

  pure real function std(x)
    ! Returns the standard deviation of x.
    real, intent(in) :: x(:)
    std = sqrt(mean((x - mean(x))**2))
  end function std

end module mod_arrays
