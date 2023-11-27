name timer_delay
main segment code
cseg at 0bh
ljmp tm_int
cseg at 0
ljmp start
rseg main
using 0
timer_delay:
    mov th0, #00h
    mov tl0, #00h
    mov tmod, #01h
    setb tcon.4
    jnb tcon.5, $
    ret
start:
    setb ie.7
    setb ie.1
    mov r0, #098h
    call timer_delay
    jmp $

tm_int:
    mov a, r0
    jz tm_int_end 
    dec r0
    reti
tm_int_end:
    clr tcon.5
    reti
end