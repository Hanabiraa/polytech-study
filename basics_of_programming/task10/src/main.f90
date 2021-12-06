program task7_32v
    use Environment

    character(*), parameter :: input_file = "../data/input.txt", output_file = "output.txt"
    integer(I_)                         :: In=0, Out=0, row=-1, column=-1, i
    integer(I_), allocatable, target    :: massive(:,:)
    integer(I_), pointer                :: ptr(:)
    real(R_), allocatable               :: r_num_massive(:,:)

    open (file=input_file, newunit=In)
        read (In, *) row, column

        ! Создание памяти массивов дин. длины
        allocate(massive(row, column))
        allocate(r_num_massive(row, column))

        ! рандомные значения для массива дипазона от -50 до 50
        call random_number(r_num_massive)
        massive = int(r_num_massive * 100)-50
    close (In)

    open (file=output_file, newunit=Out)
        write(Out, *) "----------------MATRIX clean---------------------"
        write(Out, "("//row//"i4)") massive 
    close(Out)
    
    do i = 1, column
        ptr => massive(:, i)    
        ! вызов сортировки O(N), like insertion sort
        ! massive 1 размерности
        call gnomesort(ptr)
    end do

    open (file=output_file, newunit=Out, position="append")
        write(Out, *) "----------------MATRIX MOD---------------------"
        write(Out, "("//row//"i4)") massive 
    close(Out)

contains
    subroutine gnomesort(massive)
        integer, intent(inout) :: massive(:)
        integer :: i, j, temp
        
        i = 2
        j = 3
        do while (i <= size(massive))
            if (abs(massive(i-1)) > abs(massive(i))) then
                i = j
                j = j + 1
            else
                temp = massive(i-1)
                massive(i-1) = massive(i)
                massive(i) = temp
                i = i -  1
                if (i == 1) then
                    i = j
                    j = j + 1
                end if
            end if
        end do
    end subroutine Gnomesort  
end program task7_32v
