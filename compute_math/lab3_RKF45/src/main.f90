program lab3_RKF

    use Environment
    use Group_Process
    ! Важные переменные для RKF45
    real(R_)                    ::  T, TOUT, RELERR, ABSERR
    real(R_),       allocatable ::  WORK(:), x(:), dx(:)
    integer(I_)                 ::  NEQN, IFLAG
    integer(I_),    allocatable ::  IWORK(:)

    ! Важные переменные для Рунгу-Кутыы
    real(R_)                    ::  TR1, TR2
    real(R_)                    ::  xr1(2), xr2(2)


    ! Для циклов, ввода-вывода и прочего
    integer(I_)                 :: i = 0, Out = 1
    character(:),   allocatable :: output_file, format
    ! подготовка файла
    output_file = "rkf45.txt"

    ! подготовка к решению по RKF45
    NEQN    = 2                     ! число уравнений

    ! EPS = 0.0003
    ABSERR  = 1.E-4
    RELERR  = 1.E-4

    allocate(x(NEQN))
    allocate(dx(NEQN))

    allocate(WORK(3+6*NEQN))        ! рассчет как 3+6*NEQN
    allocate(IWORK(5))              ! не меньше 5

    ! начальные условия
    x(1)    = 0
    x(2)    = 1

    ! границы
    T       = 0.0
    TOUT    = 0.0
    IFLAG   = +1                    ! указатель настройки программы
                                    ! режим: многошаговый интегратор

    ! подготовка к решению по Рунге-Кутты системе
    TR1     = 0.0
    TR2     = 0.0
    xr1(1)  = 0
    xr1(2)  = 1
    xr2(1)  = 0
    xr2(2)  = 1

    ! чистка файла
    open (file=output_file, newunit=Out, position="rewind")
    close(Out)

    do while (TOUT < 4.1)
        open (file=output_file, newunit=Out, position="append")
            write(Out, "(a, 1f3.1, a, 1f3.1)") " Отрезок: ", T, " до ", TOUT

            call RKF45(system, NEQN, x, T, TOUT, RELERR, ABSERR, IFLAG, WORK, IWORK)
            call runge_kutte(system, xr1, TR1, TOUT, 0.0001)
            call runge_kutte(system, xr2, TR2, TOUT, 0.2)

            write(Out, *) "RKF45, h=0.2000, x1:", x(1)
            write(Out, *) "RU-KU, h=0.0001, x1:", xr1(1)
            write(Out, *) "RU-KU, h=0.2000, x1:", xr2(1)
            write(Out, *) " "
            write(Out, *) "RKF45, h=0.2000, x2:", x(2)
            write(Out, *) "RU-KU, h=0.0001, x2:", xr1(2)
            write(Out, *) "RU-KU, h=0.2000, x2:", xr2(2)
            if (IFLAG /= 2) then
                write(Out, *) "Flag :", IFLAG
            end if
            write(Out, *) "------------------"
        close(Out)


        ! RKF45
        T       = TOUT
        ! RU-KU
        TR1     = TOUT
        TR2     = TOUT

        ! GLOBAL
        TOUT    = TOUT + 0.2
    end do

contains
    real(R_) function find_dx1(x1, x2, t)
        real(R_)    :: x1, x2, t
        find_dx1 = -71 * x1 -70 * x2 + exp(1 - t * t)
    end function find_dx1

    real(R_) function find_dx2(x1, t)
        real(R_)    :: x1, t
        find_dx2 = x1 + sin(1 - t)
    end function find_dx2

    subroutine system(t, x, dx)
        real(R_),   intent(inout)   :: t, x(2)
        real(R_),   intent(inout)   :: dx(2)

        dx(1) = find_dx1(x(1), x(2), t)
        dx(2) = find_dx2(x(1), t)
    end subroutine system


    subroutine runge_kutte(func, x, T, TOUT, step)
        ! входные переменные
        external                    ::  func
        real(R_),   intent(inout)   :: x(2)
        real(R_),   intent(inout)   :: T
        real(R_),   intent(in)      :: TOUT, step

        ! локальные
        real(R_)                    :: k1(2), k2(2), k3(2), k4(2), k5(2), k6(2)

        do while (T < TOUT)
            k1(1) = step * find_dx1(x(1), x(2), T)
            k1(2) = step * find_dx2(x(1), T)


            k2(1) = step * find_dx1(x(1) + k1(1)/3,&
                                    x(2) + k1(2)/3,&
                                    T + step/3)
            k2(2) = step * find_dx2(x(1) + k1(1)/3,&
                                    T + step/3)


            k3(1) = step * find_dx1(x(1) + 0.16 * k1(1) + 0.24 * k2(1),&
                                    x(2) + 0.16 * k1(2) + 0.24 * k2(2),&
                                    T + 0.4 * step)
            k3(2) = step * find_dx2(x(1) + 0.16 * k1(1) + 0.24 * k2(1),&
                                    T + 0.4 * step)


            k4(1) = step * find_dx1(x(1) + 0.25 * k1(1) - 3 * k2(1) + 3.75 * k3(1),&
                                    x(2) + 0.25 * k1(2) - 3 * k2(2) + 3.75 * k3(2),&
                                    T + step)
            k4(2) = step * find_dx2(x(1) + 0.25 * k1(1) - 3 * k2(1) + 3.75 * k3(1),&
                                    T + step)


            k5(1) = step * find_dx1(x(1) + (6 * k1(1) + 90 * k2(1) - 50 * k3(1) + 8 * k4(1)) / 81,&
                                    x(2) + (6 * k1(2) + 90 * k2(2) - 50 * k3(2) + 8 * k4(2)) / 81,&
                                    T + 2 * step / 3)
            k5(2) = step * find_dx2(x(1) + (6 * k1(1) + 90 * k2(1) - 50 * k3(1) + 8 * k4(1)) / 81,&
                                    T + 2 * step / 3)


            k6(1) = step * find_dx1(x(1) + (6 * k1(1) + 36 * k2(1) + 10 * k3(1) + 8 * k4(1)) / 75,&
                                    x(2) + (6 * k1(2) + 36 * k2(2) + 10 * k3(2) + 8 * k4(2)) / 75,&
                                    T + 4 * step / 5)
            k6(2) = step * find_dx2(x(1) + (6 * k1(1) + 36 * k2(1) + 10 * k3(1) + 8 * k4(1)) / 75,&
                                    T + 4 * step / 5)

            x(1) = x(1) + (23 * k1(1) + 125 * k3(1) - 81 * k5(1) + 125 * k6(1)) / 192
            x(2) = x(2) + (23 * k1(2) + 125 * k3(2) - 81 * k5(2) + 125 * k6(2)) / 192

            T = T + step
        end do
    end subroutine runge_kutte
end program lab3_RKF