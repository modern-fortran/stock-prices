module mod_arrays

  ! Utility functions that operate on arrays.

  implicit none

  private
  public :: mean, reverse

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

end module mod_arrays
