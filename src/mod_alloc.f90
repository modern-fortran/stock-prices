module mod_alloc

  implicit none

  private
  public :: alloc, free

contains

  subroutine alloc(a, n)
    real, allocatable, intent(in out) :: a(:)
    integer, intent(in) :: n
    integer :: stat
    character(len=100) :: errmsg
    if (allocated(a)) call free(a)
    allocate(a(n), stat=stat, errmsg=errmsg)
    if (stat > 0) error stop errmsg
  end subroutine alloc

  subroutine free(a)
    real, allocatable, intent(in out) :: a(:)
    integer :: stat
    character(len=100) :: errmsg
    if (.not. allocated(a)) return
    deallocate(a, stat=stat, errmsg=errmsg)
    if (stat > 0) error stop errmsg
  end subroutine free

end module mod_alloc
