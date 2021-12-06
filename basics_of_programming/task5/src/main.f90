program task5_19
    use Environment

    character(*), parameter :: input_file = "../data/input.txt", output_file = "output.txt"
    integer(I_)             :: In=0, Out=0, massive_count=0, massive_half_count=0, ERR_ALLOC
    integer(R_), allocatable   :: massive(:), f_half(:), s_half(:)
    real(R_), allocatable   :: r_num_massive(:)

    open (file=input_file, newunit=In)
        read (In, *) massive_count
    close (In)

    ! длина для подмассивов при условии, что длина основного массива всегда четная 
    massive_half_count=massive_count/2

    ! Создание памяти массивов дин. длины
    allocate(massive(massive_count), STAT=ERR_ALLOC)
    if (ERR_ALLOC /= 0) stop "Allocation ERROR (massive)"
    allocate(f_half(massive_half_count), STAT=ERR_ALLOC)
    if (ERR_ALLOC /= 0) stop "Allocation ERROR (r_half)"
    allocate(s_half(massive_half_count), STAT=ERR_ALLOC)
    if (ERR_ALLOC /= 0) stop "Allocation ERROR (s_half)"
    allocate(r_num_massive(massive_count), STAT=ERR_ALLOC)
    if (ERR_ALLOC /= 0) stop "Allocation ERROR (r_num_massive)"
   
    ! рандомные значения для массива
    call random_number(r_num_massive)
    massive = int(r_num_massive * 10)
    ! разбивка сечениями
    f_half = massive(1:massive_count:2)
    s_half = massive(2:massive_count:2)

    open (file=output_file, newunit=Out)
        write(Out, "(a14,"//massive_count//"i3)")       "massive = ",     massive 
        write(Out, "(a14,"//massive_half_count//"i3)")  "first_half = ",  f_half 
        write(Out, "(a14,"//massive_half_count//"i3)")  "second_half = ", s_half 
    close (Out)

end program task5_19
