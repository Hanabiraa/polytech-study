module Group_Process
    use Environment
    use Group_IO

    implicit none

contains
    pure recursive subroutine get_new_dataset_by_gender(dataset, new_dataset, amount, sex)
        type(civil), intent(in)        :: dataset
        type(civil), pointer           :: new_dataset
        integer(I_), intent(inout)       :: amount
        character(kind=CH_), intent(in)  :: sex

        ! Если найден студент нужного пола, то размещаем в новом списке элемент и копируем его данные.
        if (dataset%gender == sex) then
            allocate (new_dataset, source=dataset)
            Amount = Amount + 1
            new_dataset%next => Null()
            ! Если ещё остались студенты, сканируем дальше, а в создаваемом списке передаём место СОСЕДА.
            if (Associated(dataset%next)) &
                    call get_new_dataset_by_gender(dataset%next, new_dataset%next, amount, sex)
            ! Если ещё остались студенты, сканируем дальше, а в создаваемом списке передаём ПРЕЖНЕЕ место.
        else if (Associated(dataset%next)) then
            call get_new_dataset_by_gender(dataset%next, new_dataset, amount, sex)
        end if
    end subroutine get_new_dataset_by_gender

    pure recursive subroutine get_new_dataset_by_civil(dataset, new_dataset, amount, geo)
        type(civil), intent(in)        :: dataset
        type(civil), pointer           :: new_dataset
        integer(I_), intent(inout)       :: amount
        character(kind=CH_), intent(in)  :: geo

        ! Если найден студент нужного пола, то размещаем в новом списке элемент и копируем его данные.
        if (dataset%loc == geo) then
            allocate (new_dataset, source=dataset)
            Amount = Amount + 1
            new_dataset%next => Null()
            ! Если ещё остались студенты, сканируем дальше, а в создаваемом списке передаём место СОСЕДА.
            if (Associated(dataset%next)) &
                    call get_new_dataset_by_civil(dataset%next, new_dataset%next, amount, geo)
            ! Если ещё остались студенты, сканируем дальше, а в создаваемом списке передаём ПРЕЖНЕЕ место.
        else if (Associated(dataset%next)) then
            call get_new_dataset_by_civil(dataset%next, new_dataset, amount, geo)
        end if
    end subroutine get_new_dataset_by_civil

    ! Сортировка списка по дате рождения
    pure recursive subroutine Sort_class_list(ClassList, N)
        type(civil), pointer, intent(inout)  :: ClassList
        integer, intent(in)                    :: N

        ! Работаем только с первыми N элементами: помещаем в ИХ конец менее успешного.
        call Drop_down(ClassList, 1, N-1)

        ! Если необходимо, делаем то же с первыми N-1 элементами.
        if (N >= 3) &
                call Sort_class_list(ClassList, N-1)
    end subroutine Sort_class_list

    ! Помещаем c j-ой на N-ую позицию менее успешного, поочерёдно сравнивая.
    pure recursive subroutine Drop_down(ClassList, j, N)
        type(civil), pointer  :: ClassList
        integer, intent(in)                    :: j, N

        ! Если требуется, то меняем местами текущего студента со следующим.
        if (Swap(ClassList)) &
                call Swap_from_current(ClassList)
        if (j < N) &
                call Drop_down(ClassList%next, j+1, N)
    end subroutine Drop_down

    ! Проверка того, стоит ли менять местами текущего учащегося со следующим.
    pure logical function Swap(Current)
        type(civil), intent(in)  :: Current

        Swap = .false.
        if (Current%years < Current%next%years) then
            Swap = .true.
        else if (Current%years == Current%next%years) then
            if (Current%Surname > Current%next%Surname) then
                Swap = .true.
            else if (Current%Surname==Current%next%Surname .and. Current%Initials>Current%next%Initials) then
                Swap = .true.
            end if
        end if
    end function Swap

    ! Перестановка местами двух эелементов списка, начиная с текущего.
    pure subroutine Swap_from_current(Current)
        type(civil), pointer  :: Current

        type(civil), pointer  :: tmp_stud

        tmp_stud       => Current%next
        Current%next   => Current%next%next
        tmp_stud%next  => Current
        Current        => tmp_stud
    end subroutine Swap_from_current

    pure recursive subroutine get_young(dataset, new_dataset, amount)
        type(civil), intent(in)        :: dataset
        type(civil), pointer           :: new_dataset
        integer(I_), intent(in)         :: amount

        if (amount > 0) then
            allocate (new_dataset, source=dataset)
            new_dataset%next => Null()
            if (Associated(dataset%next)) &
                    call get_young(dataset%next, new_dataset%next, amount-1)
        end if
    end subroutine get_young

end module Group_Process