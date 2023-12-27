name delay

main segment code
vars segment data

rseg vars
delay_time: ds 4

cseg at 0
    ljmp start

rseg main
using 0
delay:
    mov delay_time+3, #016h
delay_100:
    mov delay_time+2, #064h
delay_ms:
    mov delay_time, #0f9h
    mov delay_time+1, #0f8h
    djnz delay_time, $
    djnz delay_time+1, $
    djnz delay_time+2, delay_ms
    djnz delay_time+3, delay_100
    ret 
start:
    mov sp, #040h
    call delay
    jmp $
end










































