program task7_52
    use Environment

    character(*), parameter :: input_file = "../data/input.txt", output_file = "output.txt"
    integer(I_)                         :: In=0, Out=0, rank, i
    integer(I_), allocatable            :: matrix(:,:), vector(:,:)
    real(R_), allocatable               :: r_num_massive(:,:)

    open (file=input_file, newunit=In)
        read (In, *) rank

        ! Создание памяти массивов дин. длины
        allocate(matrix(rank, rank))
        allocate(r_num_massive(rank, rank))
        allocate(vector(2, rank))
        ! рандомные значения для массива дипазона от -50 до 50
        call random_number(r_num_massive)
        matrix = int(r_num_massive * 100)-50
    close (In)

    do i = 1, rank
        vector(1,i) = sum(matrix(i:,i))
        vector(2,i) = sum(matrix(:i,i))
    end do


    open (file=output_file, newunit=Out)
        write(Out, *) "----------------MATRIX clean---------------------"
        write(Out, "("//rank//"i4)") matrix 
        write(Out, *) "-------------------------------------------------"
        write(Out, "(a40,"//rank//"i4)") "Верхний треугольник:", vector(1,:) 
        write(Out, "(a39,"//rank//"i4)") "Нижний треугольник:", vector(2,:) 
    close(Out)
    
contains
  end program task7_52
