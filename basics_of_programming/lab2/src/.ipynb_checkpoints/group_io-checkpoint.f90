module Group_IO
    use Environment
  !  write (Out, '(15a1, 1x, 5a1, 1x, i4, 1x, 1a, 1x, 1a)') (dataset(i)%surname, &

    implicit none

    ! Длины форматирования данных 15 5 4 1 1, между ними - пробелы
    integer(I_), parameter  :: CIVIL_AMOUNT = 15
    integer(I_), parameter  :: SURNAME_LEN  = 15
    integer(I_), parameter  :: INITIALS_LEN = 5
    integer(I_), parameter  :: LOCATION     = 1
    integer(I_), parameter  :: SEX          = 1

    ! Структура данных для хранения данных о гражданине
    type civil
        character(SURNAME_LEN, kind=CH_)        :: surname     = ""
        character(INITIALS_LEN, kind=CH_)       :: initials    = ""
        integer(I_)                             :: years       = 0
        character(kind=CH_)                     :: loc         = ""
        character(kind=CH_)                     :: gender      = ""
        type(civil), pointer                    :: next         => Null()
    end type civil

contains
    ! Чтение списка класса: фамилии, инициалы, полы и оценки.
    function Read_class_list(Input_File) result(Class_List)
        type(civil), pointer     :: Class_List
        character(*), intent(in)   :: Input_File
        integer  In

        open (file=Input_File, encoding=E_, newunit=In)
        Class_List => Read_civil(In)
        close (In)
    end function Read_class_list

    ! Чтение следующего студента.
    recursive function Read_civil(In) result(civ)
        type(civil), pointer  :: civ
        integer, intent(in)     :: In
        integer  IO
        character(:), allocatable  :: format

        allocate (civ)
        format = '(2(a, x), i4, x, a, x, a)'
        read (In, format, iostat=IO) civ%surname, &
                civ%initials, &
                civ%years, &
                civ%loc, &
                civ%gender
        call Handle_IO_status(IO, "reading line from file")
        if (IO == 0) then
            civ%next => Read_civil(In)
        else
            deallocate (civ)
        end if
    end function Read_civil

    ! Вывод списка класса со средним баллом или без него.
    subroutine Output_class_list(Output_File, dataset, List_Name, Position)
        character(*), intent(in)   :: Output_File, Position, List_Name
        type(civil), intent(in)  :: dataset
        integer  :: Out

        open (file=Output_File, encoding=E_, position=Position, newunit=Out)
        write (out, '(/a)') List_Name
        call Output_civil(Out, dataset)
        close (Out)
    end subroutine Output_class_list

    recursive subroutine Output_civil(Out, civ)
        integer, intent(in)        :: Out
        type(civil), intent(in)  :: civ

        integer  :: IO
        character(:), allocatable  :: format

        format = '(2(a, x), i4, x, a, x, a)'
        write (Out, format, iostat=IO) civ%surname, &
                civ%initials, &
                civ%years, &
                civ%loc, &
                civ%gender
        call Handle_IO_status(IO, "writing student")
        if (Associated(civ%next)) &
                call Output_civil(Out, civ%next)
    end subroutine Output_civil

end module Group_IO

