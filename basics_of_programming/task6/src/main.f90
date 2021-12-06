program task6_2d
    use Environment

    character(*), parameter :: input_file = "../data/input.txt", output_file = "output.txt"
    integer(I_)             :: In=0, Out=0, i=0
    double precision        :: relerr=0., x=0.

    open (file=input_file, newunit=In)
        read (In, *) x, relerr
    close (In)
        
    open (file=output_file, newunit=Out)
        write (*,"(A50,f40.35)")     "Относительная погрешность = ", relerr
        write (*,"(A20,f15.12)")  "my ch(x) = ", check_cub_cos(x, relerr)
        write (*,"(A20,f15.12)")  "math ch(x) = ", dcosh(x)
    close (Out)

contains
    double precision function fact(n)
        integer, intent(in) :: n
        integer :: i_f
        
        if (n < 0) error stop 'factorial is singular for negative integers'
            fact = 1.0
        do i_f = 2, n
            fact = fact * i_f
        end do
    end function fact

    double precision function new_varian_for_cub_cos(root, pos)
        double precision,   intent(in)   :: root
        integer,            intent(in)   :: pos
        
        new_varian_for_cub_cos = (root ** (2 * pos + 1)) / fact(2 * pos + 1)
    end function new_varian_for_cub_cos
    
    double precision function check_cub_cos(root, area_of_root)
        double precision,   intent(in)  :: root, area_of_root
        double precision                :: local_chx, new_x_local
        integer                         :: i_f=0
        
        do  
            new_x_local = new_varian_for_cub_cos(root, i_f)
            local_chx = local_chx + new_x_local
            i_f = i_f + 1
            if (abs(new_x_local / local_chx) < area_of_root) exit
        end do
        check_cub_cos = local_chx
    end function check_cub_cos

end program task6_2d
