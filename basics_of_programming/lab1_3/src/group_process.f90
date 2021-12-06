module Group_Process
    use Environment
    use Group_IO

    implicit none

contains
    pure function get_young_saint_p_civil(dataset, count) result(young_dataset)
        type(civil), intent(in)             :: dataset(:)
        integer(I_), intent(in), optional   :: count

        type(civil), allocatable            :: young_dataset(:)
        integer(I_)                         :: i, index
        logical, allocatable                :: mask(:)

        if (present(count)) then
            allocate(mask(size(dataset)))
            mask = .true.
            do i = 1, count
                index = maxloc(dataset%years, 1, mask)
                mask(index) = .false.
            end do
            young_dataset = pack(dataset, mask .eqv. .false.)
        else
            index = maxloc(dataset%years, 1)
            young_dataset = dataset(index:index)
        end if

    end function get_young_saint_p_civil
end module Group_Process