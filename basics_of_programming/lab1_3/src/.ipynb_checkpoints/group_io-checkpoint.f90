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
        character(SURNAME_LEN, kind=CH_)        ::  surname     = ""
        character(INITIALS_LEN, kind=CH_)       ::  initials    = ""
        integer(I_)                             ::  years       = 0
        character(kind=CH_)                     ::  loc         = ""
        character(kind=CH_)                     ::  gender      = ""
    end type civil

contains
    ! Создание неформатированного файла данных.
    subroutine create_data_file(input_File, data_File)
        character(*), intent(in)   :: input_File, data_file

        type(civil)                :: civil_once
        integer                    :: In, Out, IO, i, recl
        character(:), allocatable  :: format

        open (file=Input_File, encoding=E_, newunit=In)
            recl = (SURNAME_LEN + INITIALS_LEN)*CH_ + I_ + CH_*2
            open (file=Data_File, form='unformatted', newunit=Out, access='direct', recl=recl)
                format = '(2(a, 1x), i4, x, a, x, a)'
                do i = 1, CIVIL_AMOUNT
                    read (In, format, iostat=IO) civil_once
                    call Handle_IO_status(IO, "reading formatted class list, line " // i)
                    write (Out, iostat=IO, rec=i) civil_once
                    call Handle_IO_status(IO, "creating unformatted file with class list, record " // i)
                end do
            close (In)
        close (Out)
    end subroutine Create_data_file

    ! Чтение списка класса: фамилии, инициалы, полы и оценки.
    function Read_class_list(Data_File) result(dataset_f)
        type(civil)                :: dataset_f(CIVIL_AMOUNT)
        character(*), intent(in)   :: data_File

        integer(I_) :: In, IO, recl

        recl = ((SURNAME_LEN + INITIALS_LEN)*CH_ + I_ + CH_*2) * CIVIL_AMOUNT
        open (file=Data_File, form='unformatted', newunit=In, access='direct', recl=recl)
            read (In, iostat=IO, rec=1) dataset_f
            call Handle_IO_status(IO, "reading unformatted class list")
        close (In)
    end function Read_class_list

    ! Вывод списка класса.
    subroutine Output_class_list(output_File, dataset, list_name, position)
        character(*), intent(in)    :: output_File, position, list_name
        type(civil), intent(in)     :: dataset(:)

        integer                     :: Out, IO
        character(:), allocatable   :: format

        open (file=Output_File, encoding=E_, position=Position, newunit=Out)
            write (out, '(/a)') list_name
            format = '(2(a, 1x), i4, x, a, x, a)'
            write (Out, format, iostat=IO) dataset
            call Handle_IO_status(IO, "writing " // List_name)
        close (Out)
    end subroutine Output_class_list
end module Group_IO

