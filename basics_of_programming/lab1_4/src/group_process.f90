module Group_Process
    use Environment
    use Group_IO

    implicit none

contains
    pure function get_young_saint_p_civil(dataset, count) result(young_dataset)
        type(civil), intent(in)             :: dataset(:)
        integer(I_), intent(in), optional   :: count

        type(civil), allocatable            :: young_dataset(:)
        integer(I_)                         :: index
        logical, allocatable                :: mask(:)

        if (present(count)) then
            allocate(mask(size(dataset)))
            mask = .true.
            call make_a_mask(dataset, mask, count)
            young_dataset = pack(dataset, mask .eqv. .false.)
        else
            index = maxloc(dataset%years, 1)
            young_dataset = dataset(index:index)
        end if

    end function get_young_saint_p_civil

    pure recursive subroutine make_a_mask(dataset, mask, count)
        type(civil), intent(in)     :: dataset(:)
        logical, intent(inout)      :: mask(:)
        integer(I_), intent(in)     :: count
        integer(I_)                 :: index

        if (count > 1) then
            index = maxloc(dataset%years, 1, mask)
            mask(index) = .false.
            call make_a_mask(dataset, mask, count-1)
        else
            index = maxloc(dataset%years, 1, mask)
            mask(index) = .false.
        end if

    end subroutine make_a_mask
end module Group_Process