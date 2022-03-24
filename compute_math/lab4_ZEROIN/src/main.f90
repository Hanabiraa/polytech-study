program lab3_RKF

    use Environment
    use Group_Process


    ! Переменные
    real(R_)    :: AX, BX, TOL
    real(R_)    :: ANS, NEVYAZKA
    integer(I_) :: COUNTER

    ! Для циклов, ввода-вывода и прочего
    integer(I_)                 :: i = 0, Out = 1
    character(:),   allocatable :: template, output_file, format

    output_file = "root.txt"

    ! Границы интервала
    AX=1
    BX=2
    ! Запись всех параметров в файл
    open (file=output_file, newunit=Out, position="rewind")
        COUNTER = 0
        write(Out, "(a50, f9.5)")"Значение на левой границе:  ", f(AX)
        write(Out, "(a50, f10.5)")"Значение на правой границе: ", f(BX)

        write(Out, *)" "
        write(Out, *)"==================================="
        write(Out, "(a)")"Вычисление с точностью 10^-5:"
        COUNTER = 0
        TOL = 10 ** (-5)
        ANS = zeroin(AX, BX, f, TOL)
        write(Out, "(a, f20.16)") "Узел абсциссы: ", ANS
        write(Out, "(a, 1i3)")"Количество операций: ", COUNTER
        write(Out, "(a, 1e15.6)")"Невязка: ", ABS(0 - f(ANS))

        write(Out, *)" "
        write(Out, *)"==================================="
        write(Out, "(a)")"Вычисление с точностью 10^-6:"
        COUNTER = 0
        TOL = 10 ** (-6)
        ANS = zeroin(AX, BX, f, TOL)
        write(Out, "(a, f20.16)") "Узел абсциссы: ", ANS
        write(Out, "(a, 1i3)")"Количество операций: ", COUNTER
        write(Out, "(a, 1e15.6)")"Невязка: ", ABS(0 - f(ANS))

    close(Out)
contains
    real(R_) function f(x)
        ! Входные переменные
        real(R_)    :: x
        ! Локальные переменные
        real(R_), parameter :: PI= 3.1415926535897931_8
        COUNTER = COUNTER + 1
        f = SIN(x + PI/3) - x / 2
    end function f
end program lab3_RKF
