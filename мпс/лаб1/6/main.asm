name lights

main segment code
litterals segment code
interupts segment code

mod equ 038h
spd equ 039h

dseg at 030h
delay_time: ds 4
sleep_time: ds 3

cseg at 0
ljmp main

cseg at 03h
ljmp select_mode
cseg at 013h
ljmp select_spd
cseg at 0bh
ljmp timer0
cseg at 01bh
ljmp timer1

rseg litterals
    mods: db 0feh, 0fch, 0f8h, 0f0h, 0e0h, 0c0h, 080h, 0fah, 0eah, 0aah, 0e4h, 0a4h, 099h, 011h, 0b3h, 0bdh
    spds: db 002h, 004h, 006h, 008h, 00ah, 00ch, 00eh, 010h, 012h, 014h, 016h, 018h, 01ah, 01ch, 01eh, 020h

rseg interupts
using 1
select_mode:
    call slp20
    mov a, mod
    xrl a, #0ffh
    mov p1, a                                                                                     
    call delay_100
    jnb p3.4, next_mode
    jnb p3.5, prev_mode
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
    call blip_mod
    mov a, #00h
    ljmp mode_exit

prev_mode:
    clr c
    mov a, mod
    jz prev_mode_reset
    dec a
    ljmp mode_exit
prev_mode_reset:
    call blip_mod
    mov a, #0fh
    ljmp mode_exit

mode_exit:
    mov mod, a
    ljmp exit_int

blip_mod:
    mov ar0, #0ah
    mov ar1, #05h
    mov ar7, #000000011b
    clr p3.7
    setb tr0
    ret

select_spd:
    call slp20
    mov a, spd
    xrl a, #0ffh
    mov p1, a
    call delay_100
    jnb p3.4, next_spd
    jnb p3.5, prev_spd
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
    call blip_spd
    mov a, #00h
    ljmp spd_exit

prev_spd:
    clr c
    mov a, spd
    jz prev_spd_reset
    dec a
    ljmp spd_exit
prev_spd_reset:
    call blip_spd
    mov a, #0fh
    ljmp spd_exit

spd_exit:
    mov spd, a
    ljmp exit_int

blip_spd:
    mov ar0, #0ah
    mov ar1, #0ah
    clr p3.7
    setb tr0
    ret

exit_int:
    mov dptr, #exec_mode
    mov a, dpl
    push acc
    mov a, dph
    push acc
    reti

timer0:
    mov tl0, #0f6h
    mov th0, #0d8h
    dec ar0
    mov a, ar0
    jz timer0_0
    reti
timer0_0:
    dec ar1
    mov ar0, #0ah
    mov a, ar1
    jz timer0_1
    reti
timer0_1:
    clr c
    mov a, ar7
    subb a, #011b
    jz timer0_2
    clr c
    mov a, ar7
    subb a, #01b
    jz timer0_3
    jmp timer0_done
timer0_2:
    setb p3.7
    mov ar1, #05h
    mov ar7,#01b
    reti
timer0_3:
    clr p3.7
    mov ar1, #05h
    mov ar7, #00b
    reti
timer0_done:
    mov ar7, #00h
    setb p3.7
    clr tr0
    reti

timer1:
    mov tl1, #0f6h
    mov th1, #0d8h
    dec sleep_time
    mov a, sleep_time
    jz timer1_1
    reti
timer1_1:
    mov sleep_time, #0ah
    dec sleep_time+1
    mov a, sleep_time+1
    jz timer1_2
    reti
timer1_2:
    mov sleep_time+1, #01h
    dec sleep_time+2
    mov a, sleep_time+2
    jz timer1_done
    reti
timer1_done:
    lcall slp30
    ljmp next_mode

rseg main
using 0
main:
    mov ie, #010001111b
    mov ip, #0ah      
    mov tmod, #011h
    mov mod, #00h
    mov spd, #00h
    mov sp, #040h
    call slp20
    ljmp exec_mode

exec_mode:
    mov sp, #040h
    mov a, mod
    mov dptr, #mods
    movc a, @a+dptr
exec_mode_loop:
    mov p1, a
    rl a
    push acc
    call delay
    pop acc
    jmp exec_mode_loop

delay:
    mov a, spd
    mov dptr, #spds
    movc a, @a+dptr
    mov delay_time+3, a 
delay_loop:
    call delay_100
    djnz delay_time+3, delay_loop
    ret 

delay_100:
    mov delay_time+2, #064h
delay_ms:
    mov delay_time, #0f9h
    mov delay_time+1, #0f8h
    djnz delay_time, $
    djnz delay_time+1, $
    djnz delay_time+2, delay_ms
    ret 

slp20:
    mov sleep_time, #0ah
    mov sleep_time+1, #0c8h
    mov sleep_time+2, #01h
    setb tr1
    ret

slp30:
    mov sleep_time, #0ah
    mov sleep_time+1, #0ffh
    mov sleep_time+2, #02dh
    setb tr1
    ret
end










