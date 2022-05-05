module Group_Process
    use Environment

contains
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