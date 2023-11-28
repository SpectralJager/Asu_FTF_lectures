name delay

main segment code
vars segment data

rseg vars
delay_time: ds 3

cseg at 0
    ljmp start

rseg main
using 0
delay:
    mov delay_time, #00h
    mov delay_time+1, #00h
    mov delay_time+2, #01h
delay_loop:
    djnz delay_time, delay_loop
    djnz delay_time+1, delay_loop
    djnz delay_time+2, delay_loop
    ret 
start:
    mov sp, #040h
    call delay
end



















