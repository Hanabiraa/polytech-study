module Group_Process
    use Environment

contains
    ! dx1 по dt
    real(R_) function diff_eq1(x1, x2, t)
        real(R_)    :: x1, x2, t
        diff_eq1 = -14 * x1 + 13 * x2 + cos(1 + t)
    end function diff_eq1

    ! dx2 по dt
    real(R_) function diff_eq2(x1, x2, t)
        real(R_)    :: x1, t
        diff_eq2 = 20 * x1 - 30 * x2 + atan(1 + t * t)
    end function diff_eq2

    ! дифф. система уравнений
    subroutine diff_system(t, x, dx)
        real(R_),   intent(inout)   :: t, x(2)
        real(R_),   intent(inout)   :: dx(2)

        dx(1) = diff_eq1(x(1), x(2), t)
        dx(2) = diff_eq2(x(1), x(2), t)
    end subroutine diff_system

    ! метод Рунге-КУтты 3-й степени точности
    subroutine RKF3(func, x, LOW, HIGH, STEP)
        ! входные переменные
        external                    ::  func
        real(R_),   intent(inout)   ::  x(2)
        real(R_),   intent(inout)   ::  LOW
        real(R_),   intent(in)      ::  HIGH, STEP

        ! локальные
        real(R_)                    :: k1(2), k2(2), k3(2)

        do while (LOW < HIGH)
            k1(1) = step * diff_eq1(x(1), x(2), LOW)
            k1(2) = step * diff_eq2(x(1), x(2), LOW)

            k2(1) = step * diff_eq1(x(1) + k1(1) / 2, x(2) + k1(2) / 2, LOW + STEP / 2)
            k2(2) = step * diff_eq2(x(1) + k1(1) / 2, x(2) + k1(2) / 2, LOW + STEP / 2)

            k3(1) = step * diff_eq1(x(1) + 3 * k2(1) / 4, x(2) + 3 * k2(2) / 4, LOW + 3 * STEP / 4)
            k3(2) = step * diff_eq2(x(1) + 3 * k2(1) / 4, x(2) + 3 * k2(2) / 4, LOW + 3 * STEP / 4)

            x(1) = x(1) + (2 * k1(1) + 3 * k2(1) + 4 * k3(1)) / 9
            x(2) = x(2) + (2 * k1(2) + 3 * k2(2) + 4 * k3(2)) / 9

            LOW = LOW + STEP
        end do
    end subroutine rkf3
end module Group_Process