program task8_18
    use Environment

    ! Длины форматирования данных 15 5 4 1 1, между ними - пробелы
    integer(I_), parameter               :: CIVIL_AMOUNT = 15, SURNAME_LEN = 15, INITIALS_LEN = 5, BORN_YEAR=4, LOCATION=1, SEX=1

    ! Массивы фамилий, инициалов, года рождения, прописки, пола
    character(SURNAME_LEN, kind=CH_)                :: surnames(CIVIL_AMOUNT) = ""
    character(INITIALS_LEN, kind=CH_)               :: initials(CIVIL_AMOUNT) = ""
    integer(I_), target                             :: years(CIVIL_AMOUNT) = 0
    character(kind=CH_), target                     :: loc(CIVIL_AMOUNT) = ""
    character(kind=CH_), target                     :: gender(CIVIL_AMOUNT) = ""

    ! другие переменные
    character(:), allocatable                       :: input_file, output_file, format
    integer(I_)                                     :: In, Out, i, temp
    logical, target                                 :: mask_for_civil(CIVIL_AMOUNT) = .false.

    ! Указатели
    logical, pointer                                :: mask_ptr(:)
    character(kind=CH_), pointer                    :: ptr_loc(:), ptr_gender(:)
    integer(I_), pointer                            :: ptr_years(:)

    ! Присваивание указателей
    mask_ptr    => mask_for_civil(:)
    ptr_loc     => loc(:)
    ptr_gender  => gender(:)
    ptr_years   => years(:)

    ! Название выходного и входного файлов
    input_file = "../data/input.txt"
    output_file = "output.txt"

    ! Чтение списка класса: фамилия, инициалы, дата рождения, прописка, пол
    open (file=input_file, encoding=E_, newunit=In)
        format = '(2(a, x), i4, x, a, x, a)'
        read (In, format) (surnames(i), initials(i), years(i), loc(i), gender(i), i = 1, CIVIL_AMOUNT)
    close (In)

    call make_only_men_citizen(CIVIL_AMOUNT, mask_ptr, ptr_loc, ptr_gender)

    ! Вывод исходного списка
    open (file=output_file, encoding=E_, newunit=Out)
        write (out, '(a)') "Молодые петербуржцы"
        do i = 1,3
            temp = get_young_citizen_men_index(mask_ptr, ptr_years)
            write (Out, format) surnames(temp), initials(temp), years(temp), loc(temp), gender(temp)
        end do
    close (Out)

contains
    integer function get_young_citizen_men_index(mask_ptr, ptr_years)
        logical, intent(inout)           :: mask_ptr(:)
        integer(I_), intent(in)          :: ptr_years(:)
        integer(I_)                      :: index(1) = 0

        index = minloc(ptr_years, mask=mask_ptr)
        mask_ptr(index(1)) = .false.
        get_young_citizen_men_index = index(1)
    end function get_young_citizen_men_index

    logical pure function check_citizen(gender)
        character(kind=CH_), intent(in)     :: gender
        integer(I_), parameter              :: letter_p=1055
        ! стандартное значение возвращения функции
        check_citizen = .false.
        if (gender == char(letter_p, CH_)) check_citizen = .true.
    end function check_citizen

    logical pure function check_sex(sex)
        character(kind=CH_), intent(in)     :: sex
        integer(I_), parameter              :: letter_m=1052
        ! стандартное значение возвращения функции
        check_sex = .false.
        if (sex == char(letter_m, CH_)) check_sex = .true.
    end function check_sex

    subroutine make_only_men_citizen(CIVIL_AMOUNT, mask_ptr, ptr_loc, ptr_gender)
        logical, intent(inout)              :: mask_ptr(:)
        integer(I_), intent(in)             :: CIVIL_AMOUNT
        character(kind=CH_), intent(in)     :: ptr_loc(:), ptr_gender(:)

        do concurrent (i = 1:CIVIL_AMOUNT)
            if (check_citizen(ptr_loc(i)) .and. check_sex(ptr_gender(i))) then
                mask_ptr(i) = .true.
            end if
        end do
    end subroutine make_only_men_citizen

end program task8_18
