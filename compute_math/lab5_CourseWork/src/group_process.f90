module Group_Process
    use Environment

contains
    ! функция для ZEROIN
    real(R_) function f(lambda)
        ! Входные переменные
        real(R_)    :: lambda

        ! Локальные переменные
        ! Для RKF45
        real(R_)                    ::  RELERR = 1.E-6, ABSERR = 1.E-6
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

    ! система дифф. уравнений
    real(R_) function find_dz1(z2)
        real(R_)    :: z2
        find_dz1 = z2 * z2 - 1
    end function find_dz1

    real(R_) function find_dz2(z1)
        real(R_)    :: z1
        find_dz2 = z1
    end function find_dz2

    subroutine system(t, z, dz)
        real(R_),   intent(inout)   :: t, z(2)
        real(R_),   intent(inout)   :: dz(2)

        dz(1) = find_dz1(z(2))
        dz(2) = find_dz2(z(1))
    end subroutine system

    ! подинтегральная функция
    real(R_) function integralFunc(x)
        ! Параметры
        real(R_)    :: x

        integralFunc = (x**2) * sqrt(1 + (x**2))
        return
    end function integralFunc
end module Group_Process