program lab1_DECOMP_SOLVE

    use Environment
    use Group_Process
    use Group_IO

    implicit none

    ! parameters (Matrix NDIM, N, also task var p = ...)
    integer(I_),    parameter   :: nRows = 8, nCols = 8
    real(R_)                    :: p(5) = [1.0, 0.1, 0.01, 0.0001, 0.000001]
    ! matrix\vectors (tmp matrix/vectors, true matrix/vectors)
    real(R_)                    :: A(nRows, nCols) = 0, AT(nRows, nCols) = 0, B1(nRows, 1) = 0,  B2(nRows, 1) = 0
    real(R_)                    :: TMPA(nRows, nCols) = 0, TMPB(nRows, 1) = 0, IPVT(nRows) = 0, WORK(nRows) = 0
    ! vars (filepaths, vars for loops, vars for DECOMP/SOLVE)
    character(:),   allocatable :: input_file, output_file_template, output_file, format
    integer(I_)                 :: ix = 0, j=0, In = 0, Out = 1
    real(R_)                    :: COND1=0, COND2=0, prodDiag=0, DELTA=0, x1Norm=0, x2Norm=0

    ! filepath, template for output, reading matrix A and vector-column B
    input_file  = "../data/input.txt"
    output_file_template = "output_iter_"
    ! read matrix and vector-column
    call readMatrixAndVecColumn(TMPA, TMPB, nRows, input_file)


    ! Main loop for p
    do ix=1, 5
        ! output file template creating
        output_file = output_file_template//ix//".txt"
        ! clean file
        open (file=output_file, newunit=Out, position="rewind")
        close(Out)

        ! frame for file
        open (file=output_file, newunit=Out, position="append")
            write(Out, *) "*************************************"
            write(Out, *) "*** current p = ", p(ix), "***"
            write(Out, *) "*************************************"
        close(Out)

        ! 1 solution
        open (file=output_file, newunit=Out, position="append")
            write(Out, *) " "
            write(Out, *) "| ==================== |"
            write(Out, *) "| Solution: A * x1 = B |"
            write(Out, *) "| ==================== |"
            write(Out, *) " "
        close(Out)

        ! Create components (with p)
        A       = TMPA
        B1      = TMPB
        A(1,1)  = TMPA(1,1) + p(ix)
        B1(1,1) = TMPB(1,1) + 4 * p(ix)

        ! matrix
        format = '(8F10.6)'
        call printMatrix(A, nRows, "Matrix A ("//nRows//"x"//nCols//"):", format, "append", output_file)

        ! vector column
        format = '(1F12.6)'
        call printMatrix(B1, nRows, "vector-column B ("//nRows//"x"//1//"):", format, "append", output_file)

        ! Gaussian matrix decomposition
        call DECOMP(nRows, nRows, A, COND1, IPVT, WORK)

        ! L/U matrix
        format = '(8F10.6)'
        call printMatrix(A, nRows, "Matrix L abd U (triangle):", format, "append", output_file)

        ! solve the linear system and find the vector X
        call SOLVE(nRows, nRows, A, B1, IPVT)

        ! vector column
        format = '(1F12.6)'
        call printMatrix(B1, nRows, "vector-column X ("//nRows//"x"//1//"):", format, "append", output_file)

        ! 2 solution
        open (file=output_file, newunit=Out, position="append")
            write(Out, *) " "
            write(Out, *) "| ============================== |"
            write(Out, *) "| Solution: AT * A * x2 = AT * B |"
            write(Out, *) "| ============================== |"
            write(Out, *) " "
        close(Out)

        !  Create components (with p)
        A       = TMPA
        B2      = TMPB
        A(1,1)  = TMPA(1,1) + p(ix)
        B2(1,1) = TMPB(1,1) + 4 * p(ix)
        AT      = TRANSPOSE(A)
        A       = MATMUL(AT, A)
        B2      = MATMUL(AT, B2)

        ! matrix
        format = '(8F14.6)'
        call printMatrix(A, nRows, "Matrix A (AT * A) ("//nRows//"x"//nCols//"):", format, "append", output_file)

        ! vector column
        format = '(1F12.6)'
        call printMatrix(B1, nRows, "vector-column B (AT * B) ("//nRows//"x"//1//"):", format, "append", output_file)

        ! Gaussian matrix decomposition
        call DECOMP(nRows, nRows, A, COND2, IPVT, WORK)

        ! L/U matrix
        format = '(8F15.9)'
        call printMatrix(A, nRows, "Matrix L abd U (triangle):", format, "append", output_file)

        ! solve the linear system and find the vector X
        call SOLVE(nRows, nRows, A, B2, IPVT)

        ! vector column
        format = '(1F12.6)'
        call printMatrix(B2, nRows, "vector-column X ("//nRows//"x"//1//"):", format, "append", output_file)


        ! --- OVERCOMES ---
        !
        ! DELTA =  ||x1 - x2|| / ||x1||
        ! Как норма = Манхэттеновская норма (l1 норма)
        ! sum(i=1,2,..,nRows) |xi|
        x1Norm = SUM(ABS(B1))
        x2Norm = SUM(ABS(B2))
        DELTA = SUM(ABS(B1 - B2)) / x1Norm
        ! overcome DELTA and METRICS
        open (file=output_file, newunit=Out, position="append")
            write(Out, *) " "
            write(Out, *) " "
            write(Out, *) "************ OVERCOMES ************"
            write(Out, *) "                p = ", p(ix)

            if ((COND1+1) == COND1) then
                write(Out, '(a, 1e10.3, a)') "      COND for x1 = Вырожденная матрица (", COND1, ")"
            else
                write(Out, '(a, 1e10.3)') "      COND for x1 = ", COND1
            end if

            if ((COND2+1) == COND2) then
                write(Out,'(a, 1e10.3, a)') "      COND for x2 = Вырожденная матрица (", COND2, " )"
            else
                write(Out, '(a, 1e10.3)') "      COND for x2 = ", COND2
            end if

            write(Out, *) "manhattan norm x1 = ", x1Norm
            write(Out, *) "manhattan norm x2 = ", x2Norm
            write(Out, *) "            delta = ", DELTA
        close(Out)
    end do


end program lab1_DECOMP_SOLVE
