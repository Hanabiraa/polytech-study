program task8_18
    use Environment
    use Group_Process
    use Group_IO

    implicit none

    character(kind=CH_), parameter                  :: MALE = Char(1052, CH_),&
                                                        CIVIL_OF_CUR_CITY = Char(1055, CH_)
    character(:), allocatable                       :: input_file, output_file, data_file
    type(civil)                                     :: dataset(CIVIL_AMOUNT)
    type(civil), allocatable                        :: clean_dataset(:), y_data(:)

    ! Название выходного и входного файлов, а также неформатированного файла
    input_file = "../data/input.txt"
    output_file = "output.txt"
    data_file   = "class.dat"

    call Create_data_file(input_file, data_file)

    dataset = Read_class_list(data_file)

    call Output_class_list(output_file, dataset, "row data:", "rewind")

    clean_dataset = pack(dataset, dataset%loc == CIVIL_OF_CUR_CITY .and.&
            dataset%gender == MALE)

    call output_class_list(output_file, clean_dataset, "clean data:", "append")
    ! function(array, count_of_elem) standard - 1
    y_data = get_young_saint_p_civil(clean_dataset,3)

    call output_class_list(output_file, y_data, "result data:", "append")

end program task8_18
