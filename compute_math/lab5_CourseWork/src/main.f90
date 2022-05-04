program lab4_ZEROIN

    use Environment
    use Group_Process


    ! Переменные для интегрирования
    real(R_)    :: A_integ, B_integ, ABSERR, RELERR, RESULT, ERREST, FLAG
    integer(I_) :: NOFUN=0


    ! Для циклов, ввода-вывода и прочего
    integer(I_)                 :: i = 0, Out = 1
    character(:),   allocatable :: template, output_file, format

    output_file = "result.txt"

    ! ВЫчисление посредством интегрирования границы А
    open (file=output_file, newunit=Out, position="rewind")
        A_integ = 0
        B_integ = 0.5
        ABSERR = 1.E-06
        RELERR = 1.E-06
        call QUANC8(integralFunc, A_integ, B_integ, ABSERR, RELERR, RESULT, ERREST, NOFUN, FLAG)

        format = "(a)"
        write(Out, format) "Для метода пристрелки сперва найдем границу интервала."
        format = "(a, 1f10.5)"
        write(Out, format) "A = ", result
    close(Out)
contains
end program lab4_ZEROIN
