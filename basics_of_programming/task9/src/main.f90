program task7_17g
    use Environment

    character(*), parameter :: input_file = "../data/input.txt", output_file = "output.txt"
    integer(I_)                         :: Out=0, matrix_rank=10, min_abs_num=-1
    integer(I_), allocatable, target    :: matrix(:,:)
    integer(I_), pointer                :: ptr(:,:)
    real(R_), allocatable               :: r_num_massive(:,:)
    
    allocate(matrix(matrix_rank, matrix_rank))
    allocate(r_num_massive(matrix_rank, matrix_rank))

    ! рандомные значения для массива
    call random_number(r_num_massive)
    matrix = int(r_num_massive * 10)-5
    ! указатель на массив
    ptr => matrix
    
    call find_val(ptr, matrix_rank, min_abs_num)

    open (file=output_file, newunit=Out)
        write(Out, *) "-------------MATRIX-----------"
        write(Out, "("//matrix_rank//"i3)") matrix
        write(Out, *) "--------------END-------------"
        write(Out, "(a21,i1)") "minimal abs elem = ", min_abs_num
    close (Out)
    ! вызов функции поиска и печатания в файл позиций элемента
    call get_pos(ptr, matrix_rank, min_abs_num)

contains
    subroutine find_val(row_matrix, rank, return_num)
        integer(I_), intent(inout)      :: row_matrix(:,:)
        integer(I_), intent(in)         :: rank
        integer(I_), intent(out)        :: return_num
        integer(I_)                     :: i, j, min_pos_num, max_neg_num
        logical                         :: pos_mask(rank,rank), neg_mask(rank, rank)

        pos_mask = .false.
        neg_mask = .false.

        do concurrent (i = 1:rank)
            do concurrent (j = 1:rank)
                if (row_matrix(i,j) >= 0) then
                    pos_mask(i,j) = .true.
                else
                    neg_mask(i,j) = .true.
                end if
            end do
        end do
    
    min_pos_num = minval(row_matrix, mask=pos_mask)
    max_neg_num = abs(maxval(row_matrix, mask=neg_mask))
    
    if (min_pos_num > max_neg_num) then
        min_pos_num = max_neg_num
    end if

    return_num = min_pos_num
    
    end subroutine find_val
    
    subroutine get_pos(mod_matrix, rank, abs_num)
        integer(I_), intent(inout)      :: mod_matrix(:,:)
        integer(I_), intent(in)         :: rank, abs_num
        integer(I_)                     :: i, j

    open (file=output_file, newunit=Out, position="append")
        do i = 1,rank
            do j = 1,rank
                if (mod_matrix(j,i) == abs_num) then
                    write(Out,"(a5,i2,a1,i2,a1)") "pos=(", i,":", j, ")"   
                end if
            end do
        end do
    close (Out)
    end subroutine get_pos

end program task7_17g
