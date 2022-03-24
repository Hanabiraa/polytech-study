program lab3_RKF

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


end program lab3_RKF
