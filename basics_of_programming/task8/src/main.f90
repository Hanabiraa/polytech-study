program task7_16g
    use Environment

    character(*), parameter :: input_file = "../data/input.txt", output_file = "output.txt"
    integer(I_)             :: Out=0
    integer(I_)             :: matrix(10,10), Z, min_j=1, max_j=10, i, sum_k=0, max_k(2)=[0,0]
    real(R_)                :: r_num_massive(10,10)

    ! рандомные значения для массива
    call random_number(r_num_massive)
    matrix = int(r_num_massive * 10)
    
    ! В итоге окажется тот столбец, у которого наибольшая сумма элементов
    do i = min_j, max_j
        sum_k = sum(matrix(i,:))
        if (sum_k > max_k(1)) then
            max_k(1) = sum_k
            ! номер строки
            max_k(2) = i
        end if
    end do
    

    Z = minval(matrix(max_k(2),:))

    open (file=output_file, newunit=Out)
        write(Out, *) "-------------MATRIX-----------"
        write(Out, "(10i3)") matrix
        write(Out, *) "--------------END-------------"
        write(Out, "(a25, 2i3)") "index of column for Z = ", max_k(2)
        write(Out, "(a25, 10i3)") "Z = ", Z
    close (Out)
end program task7_16g
