module Group_Process
    use Environment
    use Group_IO

    implicit none

contains
    recursive subroutine find_sub_str(line1, line2, position)
        type(list_char),    pointer, intent(inout)  :: line1, line2
        integer(I_),        intent(inout)           :: position

        if (line1%char == line2%char) then
            if (associated(line2%next)) then
                if (associated(line1%next)) then
                    if (check_sub(line1%next, line2%next)) then
                        position = position
                    else
                        position = position + 1
                        call find_sub_str(line1%next, line2, position)
                    end if
                else
                    position = -1
                end if
            else
                position = position
            end if
        else
            if (associated(line1%next)) then
                position = position + 1
                call find_sub_str(line1%next, line2, position)
            else
                position = -1
            end if
        end if
    end subroutine find_sub_str

    recursive function check_sub(line1, line2) result(answer)
        type(list_char),    pointer  :: line1, line2
        logical :: answer

        if (associated(line2%next)) then
            if (associated(line1%next)) then
                if (line1%char == line2%char) then
                    if (check_sub(line1%next, line2%next)) then
                        answer = .true.
                    else
                        answer = .false.
                    end if
                else
                    answer = .false.
                end if
            else
                answer = .false.
            end if
        else
            if (line1%char == line2%char) then
                answer = .true.
            else
                answer = .false.
            end if
        end if
    end function check_sub

end module Group_Process