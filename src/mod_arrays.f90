module mod_arrays

  ! Utility functions that operate on arrays.

  implicit none

  private
  public :: argsort, average, crossneg, crosspos, intdate, moving_average,&
            moving_std, reverse, std

contains

  pure function argsort(x) result(a)
    ! Returns indices that sort x from low to high.
    real, intent(in):: x(:)
    integer :: a(size(x))
    integer :: i, i0, tmp1
    real :: tmp2
    real :: xwork(size(x))
    a = [(real(i), i = 1, size(x))]
    xwork = x
    do i = 1, size(x) - 1
      i0 = minloc(xwork(i:), 1) + i - 1
      if (i0 /= i) then
        tmp2 = xwork(i)
        xwork(i) = xwork(i0)
        xwork(i0) = tmp2
        tmp1 = a(i)
        a(i) = a(i0)
        a(i0) = tmp1
      end if
    end do
  end function argsort

  pure real function average(x)
    ! Returns a average of x.
    real, intent(in) :: x(:)
    average = sum(x) / size(x)
  end function average

  pure function crossneg(x, w) result(res)
    ! Returns indices where input array x crosses its
    ! moving average with window w from positive to negative.
    real, intent(in) :: x(:)
    integer, intent(in) :: w
    integer, allocatable :: res(:)
    real, allocatable :: xavg(:)
    logical, allocatable :: greater(:), smaller(:)
    integer :: i
    res = [(i, i = 2, size(x))]
    xavg = moving_average(x, w)
    greater = x > xavg
    smaller = x < xavg
    res = pack(res, smaller(2:) .and. greater(:size(x)-1))
  end function crossneg

  pure function crosspos(x, w) result(res)
    ! Returns indices where input array x crosses its
    ! moving average with window w from negative to positive.
    real, intent(in) :: x(:)
    integer, intent(in) :: w
    integer, allocatable :: res(:)
    real, allocatable :: xavg(:)
    logical, allocatable :: greater(:), smaller(:)
    integer :: i
    res = [(i, i = 2, size(x))]
    xavg = moving_average(x, w)
    greater = x > xavg
    smaller = x < xavg
    res = pack(res, greater(2:) .and. smaller(:size(x)-1))
  end function crosspos

  pure elemental integer function intdate(t)
    ! Converts a time stamp in format YYYY-mm-dd to integer.
    character(len=10), intent(in) :: t
    character(len=8) :: str
    str = t(1:4) // t(6:7) // t(9:10)
    read(str, *) intdate
  end function intdate

  pure function moving_average(x, w) result(res)
    ! Returns the moving average of x with one-sided window w.
    real, intent(in) :: x(:)
    integer, intent(in) :: w
    real :: res(size(x))
    integer :: i, i1
    do i = 1, size(x)
      i1 = max(i-w, 1)
      res(i) = average(x(i1:i))
    end do 
  end function moving_average

  pure function moving_std(x, w) result(res)
    ! Returns the moving standard deviation of x with one-sided window w.
    real, intent(in) :: x(:)
    integer, intent(in) :: w
    real :: res(size(x))
    integer :: i, i1
    do i = 1, size(x)
      i1 = max(i-w, 1)
      res(i) = std(x(i1:i))
    end do 
  end function moving_std

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
