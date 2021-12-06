program task7_2b
    use Environment

    character(*), parameter :: input_file = "../data/input.txt", output_file = "output.txt"
    integer(I_)                         :: In=0, Out=0, massive_count=0
    integer(I_), allocatable, target    :: massive(:)
    integer(I_), pointer                :: ptr(:)
    real(R_), allocatable               :: r_num_massive(:)

    open (file=input_file, newunit=In)
        read (In, *) massive_count

        ! Создание памяти массивов дин. длины
        allocate(massive(massive_count))
        allocate(r_num_massive(massive_count))

        ! рандомные значения для массива дипазона от -50 до 50
        call random_number(r_num_massive)
        massive = int(r_num_massive * 100)-50
        
        ! указатель на массив
        ptr => massive
    close (In)

    ! вызов сортировки O(N log N)
    ! massive, first index, last index
    call quicksort(ptr, 1, massive_count)

    open (file=output_file, newunit=Out)
        write(Out, "(a14,"//massive_count//"i4)")   "massive = ",     massive 
    close(Out)

contains
    ! Чистыми ни субрутина ни функция быть не могут из-за переменных на intent(out)
    recursive subroutine quicksort(ptr_mas, low, high)
        integer(I_), intent(in)     :: low, high
        integer(I_), intent(out)    :: ptr_mas(:)
        integer(I_)                 :: middle
        if (low < high) then
            middle = partition(ptr_mas, low, high)
            call quicksort(ptr_mas, low, middle)
            call quicksort(ptr_mas, middle+1, high)
        end if
    end subroutine quicksort
    
    integer function partition(ptr_mas_in, low_in, high_in)
        integer(I_), intent(in)     :: low_in, high_in
        integer(I_), intent(out)    :: ptr_mas_in(:)
        integer(I_)                 :: mediana, i, j, tmp

        mediana = ptr_mas_in((int(low_in + high_in) / 2))
        i = low_in
        j = high_in

        do while (i <= j)
            do while (ptr_mas_in(i) < mediana)
                i = i + 1
            end do
            do while (ptr_mas_in(j) > mediana)
                j = j - 1
            end do
            if (i >= j) then
                partition = j; exit
            else
                tmp = ptr_mas_in(i)
                ptr_mas_in(i) = ptr_mas_in(j)
                ptr_mas_in(j) = tmp
                i = i+1
                j = j-1
            end if
        end do
    end function partition
end program task7_2b
