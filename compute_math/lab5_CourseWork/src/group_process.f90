module Group_Process
    use Environment

contains
    ! подинтегральная функция
    real(R_) function integralFunc(x)
        ! Параметры
        real(R_)    :: x

        integralFunc = (x**2) * sqrt(1 + (x**2))
        return
    end function integralFunc
end module Group_Process