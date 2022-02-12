module Group_Process
    use Environment

contains
    ! функция f(x)
    real(R_) function fx(x)
        ! Параметры
        real(R_) x

        fx = 1 / (1 + x)
        return
    end function fx

    ! Функция полинома Лагранжа 10 степени
    real(R_) function L_poly10(dot, xk, yk)
        ! Параметры
        real(R_)    :: dot, xk(11), yk(11)
        ! Локальные переменные
        integer(I_) :: i, j
        real(R_)    :: basis_poly

        L_poly10 = 0
        do i=1, 11
            basis_poly = 1
            do j=1, 11
                if (i /= j) then
                    basis_poly = basis_poly * ((dot - xk(j)) / (xk(i) - xk(j)))
                end if
            end do
            L_poly10 = L_poly10 + basis_poly * yk(i)
        end do
        return
    end function L_poly10

    ! cплайн
    real(R_) function Sx(dot, xk, yk)
        ! Параметры
        real(R_)    :: dot, xk(11), yk(11)
        ! Локальные переменные
        real(R_)    :: B(11)=0, C(11)=0, D(11)=0

        call SPLINE(11, xk, yk, B, C, D)
        Sx = SEVAL(11, dot, xk, yk, B, C, D)
    end function Sx

end module Group_Process