name timer_delay
main segment code
using 0
cseg at 0
ljmp start
rseg main
timer_delay:
    mov th0, #00h
    mov tl0, #00h
    mov tmod, #01h
    setb tcon.4
    jnb tcon.5, $
    clr tcon.5
    ret
start:
    call timer_delay
end





