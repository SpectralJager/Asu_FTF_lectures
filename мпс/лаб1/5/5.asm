name timer_delay
main segment code

cseg at 0bh
ljmp timer_int

cseg at 0
ljmp start

rseg main
using 0

start:
    setb ie.7
    setb ie.1
    mov r0, #0ah
    mov r1, #047h
    call timer_delay
    jmp $

timer_delay:
    mov tmod, #001h
    mov tl0, #0f6h
    mov th0, #0d8h
    setb tr0
    jb tr0, $
    ret

timer_int:
    mov tl0, #0f6h
    mov th0, #0d8h
    dec r0
    mov a, r0
    jz timer_int_h
    reti
timer_int_h:
    dec r1
    mov r0, #0ah
    mov a, r1
    jz timer_int_exit
    reti
timer_int_exit:
    clr tr0
    reti
end
















































