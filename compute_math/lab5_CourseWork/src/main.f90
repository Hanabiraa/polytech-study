program lab4_ZEROIN

    use Environment
    use Group_Process


    ! Переменные для интегрирования QUANC8
    real(R_)    :: A_integ, B_integ, ABSERR, RELERR, RESULT, ERREST, FLAG
    integer(I_) :: NOFUN=0
    ! Переменные для ZEROIN
    real(R_)    :: A, B, ANS, TOL

    ! переменные для RKF45
    real(R_)                    ::  WORK(15), z(2), dz(2)
    integer(I_)                 ::  NEQN = 2, IFLAG = +1
    integer(I_)                 ::  IWORK(5)
    real(R_)                    ::  T, TOUT

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
        result = result * 25
        write(Out, format) "A = ", result
        write(Out, *) " "
    close(Out)

    ! Вычисления lambda посредством ZEROIN
    open (file=output_file, newunit=Out, position="append")
        A = result
        B = 1.5
        TOL = 10 ** (-6)
        ANS = zeroin(A, B, f, TOL)

        format = "(a)"
        write(Out, format) "функция ZEROIN вычислила lambda."
        format = "(a, 1f10.5)"
        write(Out, format) "lambda = ", ANS
        write(Out, *) " "
    close(Out)



    ! Вычисления RKF45 после найденного lambda
    open (file=output_file, newunit=Out, position="append")
        RELERR = 1.E-6
        ABSERR = 1.E-6
        T = 0.0
        TOUT = 1.0
        z(1) = ANS
        z(2) = 0
        call RKF45(system, NEQN, z, T, TOUT, RELERR, ABSERR, IFLAG, WORK, IWORK)

        format = "(a)"
        write(Out, format) "Подставим в RKF45 lambda и проведем вычисления еще раз."
        format = "(a, 1f10.5)"
        write(Out, format) "z1 = ", z(1)
        write(Out, format) "z2 = ", z(2)
        write(Out, *) " "
    close(Out)

    ! Невязка
    open (file=output_file, newunit=Out, position="append")
        format = "(a, 1f10.5)"
        write(Out, format) "Невязка равна: ", 1 - z(2)
    close(Out)

contains
    ! функция для ZEROIN
    real(R_) function f(lambda)
        ! Входные переменные
        real(R_)    :: lambda

        ! Локальные переменные
        ! Для RKF45
        real(R_)                    :: RELERR = 1.E-6, ABSERR = 1.E-6
        real(R_)                    ::  WORK(15), z(2), dz(2)
        integer(I_)                 ::  NEQN = 2, IFLAG = +1
        integer(I_)                 ::  IWORK(5)
        real(R_)                    ::  T, TOUT

        ! Границы интегрирования
        T = 0
        TOUT = 1

        ! Начальные значения
        z(1) = lambda
        z(2) = 0
        call RKF45(system, NEQN, z, T, TOUT, RELERR, ABSERR, IFLAG, WORK, IWORK)

        f = z(2) - 1
    end function f
end program lab4_ZEROIN
