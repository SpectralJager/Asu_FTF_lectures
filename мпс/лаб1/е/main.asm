main segment code

cseg at 0h
call main

rseg main
    using 0
    main: 
        %set(cnt, 0)
        %while(%cnt lt 5)(
            %set(cnt, %cnt + 1)
        )
        mov ar0, #%cnt
        %if(%eqs(r0, 0) then (
            mov ar1, #01h
        ) else (
            mov ar2, #01h
        ) fi
    ret
end






