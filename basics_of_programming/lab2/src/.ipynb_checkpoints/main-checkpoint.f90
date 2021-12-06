program task8_18
    use Environment
    use Group_Process
    use Group_IO

    implicit none

    character(kind=CH_), parameter                  :: MALE = Char(1052, CH_),&
            CIVIL_OF_CUR_CITY = Char(1055, CH_)
    integer(I_), parameter                           :: YOUNG_AMOUNT=3

    character(:), allocatable                       :: input_file, output_file
    type(civil), pointer                            :: dataset => Null(), &
            men_dataset => Null(), man_saint_p_dataset => Null(), young_dataset => Null()
    integer(I_)                                     :: men_amount=0, citizen_amount=0
    ! Название выходного и входного файлов, а также неформатированного файла
    input_file = "../data/input.txt"
    output_file = "output.txt"
!    data_file   = "class.dat"
    dataset => Read_class_list(input_file)
    if (Associated(dataset)) then
        call Output_class_list(output_file, dataset, "Исходный список:", "rewind")

        call get_new_dataset_by_gender(dataset, men_dataset, men_amount, MALE)
        call Output_class_list(output_file, men_dataset, "список из мужчин:", "append")

        call get_new_dataset_by_civil(men_dataset, man_saint_p_dataset, citizen_amount, CIVIL_OF_CUR_CITY)
        call Output_class_list(output_file, man_saint_p_dataset, "список из петербуржцев:", "append")

        call Sort_class_list(man_saint_p_dataset, citizen_amount)
        call Output_class_list(output_file, man_saint_p_dataset, "сортировка из петербуржцев:", "append")

        call get_young(man_saint_p_dataset, young_dataset, young_amount)
        call Output_class_list(output_file, young_dataset, "молодые петербуржцы:", "append")
    end if

end program task8_18
