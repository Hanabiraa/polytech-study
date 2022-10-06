program lab3_RKF

    ! модули
    use Environment
    use Group_Process

    ! Важные переменные для RKF45
    real(R_)                    ::  LOW, HIGH, RELERR, ABSERR, STEP
    real(R_),       allocatable ::  WORK(:), x(:)
    integer(I_)                 ::  NEQN, IFLAG
    integer(I_),    allocatable ::  IWORK(:)

    ! Важные переменные для RKF3 (Метод Рунге-Кутты 3ьей степени точности)
    real(R_)                    ::  LOW_RKF3_1, LOW_RKF3_2, CUSTOM_STEP
    real(R_),       allocatable ::  x_rkf3_1(:),  x_rkf3_2(:)


    ! Для циклов, ввода-вывода и прочего
    integer(I_)                 :: i = 0, Out = 1
    character(:),   allocatable :: output_file, format

    ! подготовка к решению по RKF45

    output_file = "results .txt"    ! создания файла с результатми
                                    ! и его чистка
    open (file=output_file, newunit=Out, position="rewind")
    close(Out)

    NEQN    = 2                     ! число уравнений
    ABSERR  = 1.E-4                 ! EPS = 0.0001
    RELERR  = 1.E-4                 ! EPS = 0.0001

    allocate(x(NEQN))               ! выделение память под узлы для RKF45
    allocate(x_rkf3_1(NEQN))        ! выделение память под узлы для RKF3
    allocate(x_rkf3_2(NEQN))        ! выделение память под узлы для RKF3

    allocate(WORK(3+6*NEQN))        ! (требования по документации RKF45)
    allocate(IWORK(5))              ! (требования по документации RKF45)

    x(1)    = 2                     ! начальное условие x1
    x_rkf3_1(1) = x(1)
    x_rkf3_2(1) = x(1)
    x(2)    = 0.5                   ! начальное условие x2
    x_rkf3_1(2) = x(2)
    x_rkf3_2(2) = x(2)

    ! границы
    LOW         = 0.0               ! нижняя граница для RKF45
    LOW_RKF3_1  = LOW               ! нижняя граница для RKF3
    LOW_RKF3_1  = LOW               ! нижняя граница для RKF3
    HIGH        = 0.0               ! верхняя граница
    STEP        = 0.075             ! шаг увелечения границы
    CUSTOM_STEP = 0.0001            ! шаг увелечения границы для RKF3
    IFLAG       = +1                ! указатель настройки программы
                                    ! режим: многошаговый интегратор

    do while (HIGH < 1.501)
        ! вывод результатов пошагово
        open (file=output_file, newunit=Out, position="append")
            format = "(2(a, 1f5.3), a)"
            write(Out, format) "Отрезок (", LOW, ";", HIGH, ")"

            call RKF45(diff_system, NEQN, x, LOW, HIGH, RELERR, ABSERR, IFLAG, WORK, IWORK)
            call RKF3(diff_system, x_rkf3_1, LOW_RKF3_1, HIGH, STEP)
            call RKF3(diff_system, x_rkf3_2, LOW_RKF3_2, HIGH, CUSTOM_STEP)

            format = "(a, 1f5.3, a, 1f14.5)"
            write(Out, format) "RKF-45, step: ", STEP, ", x1: ", x(1)
            write(Out, format) "RKF-3 , step: ", CUSTOM_STEP, ", x1: ", x_rkf3_2(1)
            write(Out, format) "RKF-3 , step: ", STEP, ", x1: ", x_rkf3_1(1)

            write(Out, format) "RKF-45, step: ", STEP, ", x2: ", x(2)
            write(Out, format) "RKF-3 , step: ", CUSTOM_STEP, ", x2: ", x_rkf3_2(2)
            write(Out, format) "RKF-3 , step: ", STEP, ", x2: ", x_rkf3_1(2)

            if (IFLAG /= 2) then
                    write(Out, *) "Flag :", IFLAG
            end if
            write(Out, *) " "

        close(Out)

        ! изменение переменных для следующего шага
        LOW = HIGH
        LOW_RKF3_1 = HIGH
        LOW_RKF3_2 = HIGH
        HIGH = HIGH + STEP
    end do

contains

end program lab3_RKF