name lights

main segment code
litterals segment code
interups segment code

mod equ 08h
spd equ 09h
dseg at 0ah
delay_time: ds 4

cseg at 0
ljmp main

cseg at 03h
ljmp select_mode
cseg at 013h
ljmp select_spd

rseg litterals
    mods: db 0feh, 0fch, 0f8h, 0f0h, 0e0h, 0c0h, 080h, 0fah, 0eah, 0aah, 0e4h, 0a4h, 099h, 011h, 0b3h, 0bdh
    spds: db 002h, 004h, 006h, 008h, 00ah, 00ch, 00eh, 010h, 012h, 014h, 016h, 018h, 01ah, 01ch, 01eh, 020h

rseg interups
select_mode:
    push psw
    push acc
    jnb p3.4, next_mode
    jnb p3.5, prev_mode
    mov a, mod
    xrl a, #0ffh
    mov p2, a
    ljmp exit_int

select_spd:
    push psw
    push acc
    jnb p3.4, next_spd
    jnb p3.5, prev_spd
    mov a, spd
    xrl a, #0ffh
    mov p2, a
    ljmp exit_int

next_mode:
    clr c
    mov a, mod
    subb a, #0fh
    jz next_mode_reset
    mov a, mod
    inc a
    ljmp mode_exit
next_mode_reset:
    mov a, #00h

prev_mode:
    push acc
    clr c
    mov a, mod
    jz prev_mode_reset
    dec a
    ljmp mode_exit
prev_mode_reset:
    mov a, #0fh

mode_exit:
    mov mod, a
    ljmp exit_int

next_spd:
    clr c
    mov a, spd
    subb a, #0fh
    jz next_spd_reset
    mov a, spd
    inc a
    ljmp spd_exit
next_spd_reset:
    mov a, #00h

prev_spd:
    clr c
    mov a, spd
    jz prev_spd_reset
    dec a
    ljmp spd_exit
prev_spd_reset:
    mov a, #0fh

spd_exit:
    mov spd, a
    ljmp exit_int

exit_int:
    pop acc
    pop psw
    mov dptr, #exec_mode
    mov a, dpl
    push acc
    mov a, dph
    push acc
    reti

rseg main
using 0
main:
    mov ie, #010000101
    mov sp, #020h
    ljmp exec_mode

exec_mode:
    mov sp, #020h
    mov a, mod
    mov dptr, #mods
    movc a, @a+dptr
exec_mode_loop:
    mov p2, a
    rl a
    push acc
    acall delay
    pop acc
    jmp exec_mode_loop
    ret

delay:
    mov a, spd
    mov dptr, #spds
    movc a, @a+dptr
    mov delay_time+3, a 
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
end

