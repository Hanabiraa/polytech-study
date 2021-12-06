module Group_IO
    use Environment

    implicit none

contains
    subroutine readMatrixAndVecColumn(matrix, vecColumn, nRows, filepath)
        real(R_),       intent(inout)   :: matrix(:,:), vecColumn(:,:)
        integer(I_),    intent(in)      :: nRows
        character(*),   intent(in)      :: filepath

        integer(I_)                     :: In, ix

        open (file=filepath, newunit=In)
            ! read matrix
            do ix = 1, nRows
                read(In, *) matrix(ix, :)
            end do

            ! read vector-column
            do ix = 1, nRows
                read(In, *) vecColumn(ix, :)
            end do
        close (In)
    end subroutine readMatrixAndVecColumn

    subroutine printMatrix(matrix, nRows, message, format, position, filepath)
        real(R_),       intent(inout)   :: matrix(:,:)
        integer(I_),    intent(in)      :: nRows
        character(*),   intent(in)      :: message, format, position, filepath

        integer(I_)                     :: Out, ix

        open (file=filepath, encoding=E_, position=position, newunit=Out)
            write(Out, *) message
            write(Out, *) "--------------------"

            do ix = 1, nRows
                write(Out, format) matrix(ix, :)
            end do
            write(Out, *) " "
            write(Out, *) " "
        close (Out)
    end subroutine printMatrix

subroutine printVectorRow(vector, message, format, position, filepath)
        real(R_),       intent(inout)   :: vector(:)
        character(*),   intent(in)      :: message, format, position, filepath

        integer(I_)                     :: Out

        open (file=filepath, encoding=E_, position=position, newunit=Out)
            write(Out, *) message
            write(Out, *) "--------------------"
            write(Out, format) vector(:)
            write(Out, *) " "
            write(Out, *) " "
        close (Out)
    end subroutine printVectorRow
end module Group_IO

