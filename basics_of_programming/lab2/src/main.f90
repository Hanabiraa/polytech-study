program lab2

    use Environment
    use Group_Process
    use Group_IO

    implicit none

    character(:),       allocatable     :: input_file, output_file, tmp_file
    type(list_line),    pointer         :: row_lines => Null()
    type(list_char),    pointer         :: line1 => Null(), line2 => Null()
    integer(I_)                         :: position=1

    input_file  = "../data/input.txt"
    output_file = "output.txt"
    tmp_file    = "tmp.txt"

    row_lines => read_file_in_list_line(input_file)
    if (associated(row_lines)) then
        line1 => create_list_of_chars(tmp_file, row_lines%line)
        call output_list_chars(output_file, line1, "строка:", "rewind")

        line2 => create_list_of_chars(tmp_file, row_lines%next%line)
        call output_list_chars(output_file, line2, "подстрока для поиска в строке:", "append")

        call find_sub_str(line1, line2, position)
        call write_position(position, output_file)
    end if

    open (file=tmp_file, unit=8)
    close (8, status='delete')

end program lab2
