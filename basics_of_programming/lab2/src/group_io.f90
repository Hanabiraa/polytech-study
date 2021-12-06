module Group_IO
    use Environment

    implicit none

    ! тип для однонаправленного списка строк
    type list_line
        character(:, CH_), allocatable  :: line
        type(list_line), pointer        :: next => Null()
    end type list_line

    type list_char
        character(1,CH_)                :: char
        type(list_char), pointer        :: next => Null()
    end type list_char

contains
    ! чтение строк в однонаправленный список строк
    function read_file_in_list_line(input_file) result(string)
        ! входные переменные
        type(list_line), pointer            :: string
        character(*), intent(in)            :: input_file
        ! локальные переменные
        integer(I_)                         :: In=1

        open (file=input_file, encoding=E_, newunit=In)
            string => read_line(In)
        close (In)

        contains
            ! чтение одной строки в однонаправленный список строк
            recursive function read_line(in) result(line)
                ! входные переменные
                type(list_line), pointer    :: line
                integer, intent(in)         :: In
                ! локальные переменные
                integer, parameter          :: max_len = 1024
                character(max_len, CH_)     :: string
                integer                     :: IO

                ! Чтение строки во временную строку бОльшей длины.
                read (In, "(a)", iostat=IO) string
                call Handle_IO_Status(IO, "reading line from source code")
                if (IO == 0) then
                    allocate (line)
                    ! Хранение в размещаемом поле символов без завершающих пробелов.
                    line%line = trim(string)
                    line%next => read_line(in)
                else
                    line => Null()
                end if
            end function read_line
    end function read_file_in_list_line

    ! создание из одного элемента списка строк - список символов
    function create_list_of_chars(tmp_file, line) result(string)
        ! Входные переменные
        type(list_char),    pointer     :: string
        character(*),       intent(in)  :: tmp_file
        character(*, CH_),  intent(in)  :: line
        ! Локальные переменные
        integer(I_)                     :: Out=0
        integer(I_)                     :: In=1
        integer(I_)                     :: IO

        open (file=tmp_file, encoding=E_, newunit=Out, position="rewind")
            write (Out, "(a)", iostat=IO) line
            call Handle_IO_Status(IO, "writing line to file")
        close (Out)

        open (file=tmp_file, encoding=E_, newunit=In)
            string => read_line_from_tmp(In)
        close (In)

    contains
        ! чтение одной строки в однонаправленный список символов
        recursive function read_line_from_tmp(in) result(line)
            ! входные переменные
            type(list_char), pointer    :: line
            integer, intent(in)         :: In
            ! локальные переменные
            integer(I_)                 :: IO
            character(:),   allocatable :: format

            allocate (line)
            format = '(1a1)'
            read (In, format, iostat=IO, advance="no") line%char
            call Handle_IO_status(IO, "reading line from tmp file")
            if (IO == 0) then
                line%next => read_line_from_tmp(In)
            else
                deallocate (line)
            end if
        end function read_line_from_tmp
    end function create_list_of_chars

    ! Вывод одногосвязного списка символов
    subroutine output_list_chars(output_File, string, head_of_list, position)
        ! входные переменные
        character(*),       intent(in)  :: output_File, position, head_of_list
        type(list_char),    intent(in)  :: string
        ! локальные переменные
        integer(I_)                     :: Out

        open (file=Output_File, encoding=E_, position=Position, newunit=Out)
            write (out, '(/a)') head_of_list
            call output_char_from_list_chars(Out, string)
        close (Out)

        contains
            recursive subroutine output_char_from_list_chars(Out, string)
                ! входные переменные
                integer,            intent(in)  :: Out
                type(list_char),   intent(in)  :: string
                ! локальные переменные
                integer  :: IO
                character(:), allocatable  :: format

                format = '(1a1)'
                write (Out, format, iostat=IO, advance="no") string%char
                call Handle_IO_status(IO, "writing list_char")
                if (Associated(string%next)) &
                        call output_char_from_list_chars(Out, string%next)
            end subroutine output_char_from_list_chars
    end subroutine output_list_chars

    subroutine write_position(pos, output_file)
        integer(I_),    intent(in)  :: pos
        character(*),   intent(in)  :: output_file

        integer(I_)                 :: Out=0

        open (file=output_file, encoding=E_, position='append', newunit=Out)
            write (out, '(a61, i2)') 'Позиция входа подстроки в строку: ', pos
        close (Out)
    end subroutine write_position

end module Group_IO

