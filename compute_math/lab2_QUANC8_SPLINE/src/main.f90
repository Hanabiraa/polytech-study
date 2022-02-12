program lab1_DECOMP_SOLVE

    use Environment
    use Group_Process

    ! Важные перменные для интерполяции
    real(R_)    :: xk(11), yk(11), zk(10)
    ! Важные переменные для интегрирования
    real(R_)    :: A, B, ABSERR, RELERR, RESULT, ERREST, FLAG
    integer(I_) :: NOFUN=0

    ! Для циклов, ввода-вывода и прочего
    integer(I_)                 :: i = 0, Out = 1
    character(:),   allocatable :: template, output_file, format

    ! Создания x, y значений для функции f(x)
    do i=1, 11
        xk(i) = real(0.1, R_) * (i - 1)
        yk(i) = fx(xk(i))
    end do

    ! Создания значений z для проверки всех функций
    do i=1, 10
        zk(i) = real(0.05, R_) + 0.1 * (i - 1)
    end do

    ! Запись всех параметров в файл
    output_file = "interpolation.txt"
    open (file=output_file, newunit=Out, position="append")
        write(Out, "(a)") "Таблица значений функций:"
        write(Out, "(a)") "1: f(x): 1/(1+x)"
        write(Out, "(a)") "2: Полинома Лагранажа 10 степени L(x)"
        write(Out, "(a)") "3: Кубического сплайна S(x)"
        write(Out, "(a)") "4: Отклонение L(x) от f(x)"
        write(Out, "(a)") "5: Отклонение S(x) от f(x)"
        write(Out, "(a)") "для аргумента z: 0.05 + 0.1 * k, k=0,1,..,9"
        write(Out, "(a)") "=======================================================================&
                =================================="
        write(Out, "(a3, 6(a3, a14))") "#", " | ", "z", " | ", "f(x)", " | ", "L(x)", " | ",&
                "S(x)", " | ", "ABS(f(x)-L(x))", " | ", "ABS(f(x)-S(x))"

        write(Out, "(a)") "-----------------------------------------------------------------------&
                ----------------------------------"

        format = "(i3, 6(4(a3, 1f14.7), 2(a3, 1e14.7)))"
        do i=1, 10
            write(Out, format) i - 1, " | ",&
                    zk(i), " | ",&
                    fx(zk(i)), " | ",&
                    L_poly10(zk(i), xk, yk), " | ",&
                    Sx(zk(i), xk, yk), " | ", &
                    abs((fx(zk(i)) - L_poly10(zk(i), xk, yk))), " | ", &
                    abs((fx(zk(i)) - Sx(zk(i), xk, yk)))
        end do
    close(Out)


    ! вычисление двух интегралов и запись их в файл
    output_file = "integral.txt"
    open (file=output_file, newunit=Out, position="append")
        write(Out, "(a)") "Вычисление интеграла с границами 2..5,"
        write(Out, "(a)") "с подинтегральной функцией (abs(x-tan(x))) ** m, m: -1, -0.5"
        write(Out, "(a)") "ABSERR и RELERR = 10**(-6)"
        write(Out, "(a)") "=========================="

        ! вычисление для m=-1
        A = 2
        B = 5
        ABSERR = 1.E-06
        RELERR = 1.E-06
        call QUANC8(integralFunc1, A, B, ABSERR, RELERR, RESULT, ERREST, NOFUN, FLAG)

        write(Out, "(a)") " "
        write(Out, "(a)") "m = -1"
        format = "(a10, e14.7/, a10, e14.7/, a10, i14/, a10, f14.3)"
        write(Out, format) "Result: ", RESULT, &
                "Errest: ", ERREST, &
                "NOFUN: ", NOFUN, &
                "FLAG: ", FLAG


        ! вычисление для m=-0.5
        A = 2
        B = 5
        ABSERR = 1.E-06
        RELERR = 1.E-06
        call QUANC8(integralFunc2, A, B, ABSERR, RELERR, RESULT, ERREST, NOFUN, FLAG)

        write(Out, "(a)") " "
        write(Out, "(a)") "m = -0.5"
        format = "(a10, e14.7/, a10, e14.7/, a10, i14/, a10, f14.3)"
        write(Out, format) "Result: ", RESULT, &
                "Errest: ", ERREST, &
                "NOFUN: ", NOFUN, &
                "FLAG: ", FLAG
    close(Out)

contains
    ! подинтегральная функция m = -1
    real(R_) function integralFunc1(x)
        ! Параметры
        real(R_)    :: x
        ! Переменные
        real(R_)    :: m = -1.0

        integralFunc1 = (abs(x - tan(x))) ** m
        return
    end function integralFunc1

    ! подинтегральная функция m = -0.5
    real(R_) function integralFunc2(x)
        ! Параметры
        real(R_)    :: x
        ! Переменные
        real(R_)    :: m = -0.5

        integralFunc2 = (abs(x - tan(x))) ** m
        return
    end function integralFunc2
end program lab1_DECOMP_SOLVE
