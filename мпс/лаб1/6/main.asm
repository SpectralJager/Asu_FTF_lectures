name lights

main segment code
litterals segment code
interups segment code

mod equ 40h
spd equ 41h
dseg at 48h
delay_time: ds 4

cseg at 0
ljmp main

cseg at 03h
ljmp next_mode_int

rseg litterals
    mods: db 0feh, 0fch, 0f8h, 0f0h, 0e0h, 0c0h, 080h, 0fah, 0eah, 0aah, 0e4h, 0a4h, 099h, 011h, 0b3h, 0bdh
    spds: db 002h, 004h, 006h, 008h, 00ah, 00ch, 00eh, 010h, 012h, 014h, 016h, 018h, 01ah, 01ch, 01eh, 020h

rseg interups
using 2
next_mode_int:
    mov r0, a
    mov a, mod
    inc a
    mov mod, a
    pop acc
    pop acc
    mov a, r0
    reti 

rseg main
using 0
main:
    mov ie, #010000101
    mov sp, #060h
    ljmp exec_mode
    ret

exec_mode:
    mov sp, #060h
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





