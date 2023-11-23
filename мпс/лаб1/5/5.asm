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
    clr tcon.5
    ret
start:
    setb ie.7
    setb ie.1
    call timer_delay
    jmp $

tm_int:
    reti
end











