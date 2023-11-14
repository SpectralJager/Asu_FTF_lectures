name lights

main segment code
vars segment data

rseg vars
mod_vr: ds 1
spead_vr: ds 1
delay_time: ds 4

cseg at 0
    ljmp start

rseg main
using 0
start:
    mov sp, #040h
    mov spead_vr, #02h
    mov mod_vr, #00h
mod_0:
    jmp mod0
mod_1:
    jmp mod1
mod_2:
    jmp mod2
mod_3:
    jmp mod3
mod_4:
    jmp mod4
mod_5:
    jmp mod5
mod_6:
    jmp mod6
mod_7:
    jmp mod7
mod_8:
    jmp mod8
mod_9:
    jmp mod9
mod_10:
    jmp mod10
mod_11:
    jmp mod11
mod_12:
    jmp mod12
mod_13:
    jmp mod13
mod_14:
    jmp mod14
mod_15:
    jmp mod15

mod0:
    mov r3, #0ffh
    mov r1, #08h
    mov r2, #01h
mod_0_loop:
    mov a, r3
    mov b, r2
    clr c
    subb a, b
    mov p1, a
    mov a, r2
    mov b, #02h
    mul ab
    mov r2, a
    call delay
    call check_spd_btns
    call check_mod_btns
    djnz r1, mod_0_loop
    sjmp mod0

mod1:
    mov r3, #0ffh
    mov r1, #08h
    mov r2, #080h
mod_1_loop:
    mov a, r3
    mov b, r2
    clr c
    subb a, b
    mov p1, a
    mov a, r2
    mov b, #02h
    div ab
    mov r2, a
    call delay
    call check_spd_btns
    call check_mod_btns
    djnz r1, mod_1_loop
    sjmp mod1
    
mod2:
    mov p1, #0ffh
    mov a, #066h
mod_2_loop:
    cpl a
    mov p1, a
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_2_loop

mod3:
    mov p1, #0ffh
    mov a, #0cch
mod_3_loop:
    cpl a
    mov p1, a
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_3_loop

mod4:
    mov p1, #0ffh
    mov a, #0aah
mod_4_loop:
    cpl a
    mov p1, a
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_4_loop

mod5:
    mov p1, #0ffh
    mov a, #069h
mod_5_loop:
    swap a
    mov p1, a
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_5_loop

mod6:
    mov p1, #0ffh
    mov a, #05ah
mod_6_loop:
    swap a
    mov p1, a
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_6_loop

mod7:
    mov p1, #0ffh
    mov a, #09fh
mod_7_loop:
    swap a
    mov p1, a
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_7_loop

delay:
    mov delay_time, #00h
    mov delay_time+1, #00h
    mov delay_time+2, spead_vr
delay_loop:
    djnz delay_time, delay_loop
    djnz delay_time+1, delay_loop
    djnz delay_time+2, delay_loop
    ret

check_spd_btns:
    jnb p3.4, check_incr
    jnb p3.5, check_decr
    sjmp check_exit
check_incr:
    call incr_spd
    sjmp check_exit
check_decr:
    call decr_spd
    sjmp check_exit

check_mod_btns:
    jnb p3.2, check_next
    jnb p3.3, check_prev
    sjmp check_exit 
check_next:
    call next_mod
    sjmp check_exit
check_prev:
    call prev_mod
    sjmp check_exit

check_exit:
    ret

incr_spd:
    clr c
    mov a, spead_vr
    subb a, #020h
    jz incr_spd_exit
    mov a, spead_vr
incr_spd_exit:
    add a, #02h
    mov spead_vr, a
    ret

decr_spd:
    clr c
    mov a, spead_vr
    subb a, #02h
    clr c
    jnz decr_spd_exit
    mov a, #020h
decr_spd_exit:
    mov spead_vr, a
    ret

next_mod:	
    pop acc
    pop acc
    clr c
    mov a, mod_vr
    jz next_mod_1
    mov a, mod_vr
    subb a, #01h
    jz next_mod_2
    mov a, mod_vr
    subb a, #02h
    jz next_mod_3
    mov a, mod_vr
    subb a, #03h
    jz next_mod_4
    mov a, mod_vr
    subb a, #04h
    jz next_mod_5
    mov a, mod_vr
    subb a, #05h
    jz next_mod_6
    mov a, mod_vr
    subb a, #06h
    jz next_mod_7
    mov a, mod_vr
    subb a, #07h
    jz next_mod_8
    mov a, mod_vr
    subb a, #08h
    jz next_mod_9
    mov a, mod_vr
    subb a, #09h
    jz next_mod_10
    mov a, mod_vr
    subb a, #0ah
    jz next_mod_11
    mov a, mod_vr
    subb a, #0bh
    jz next_mod_12
    mov a, mod_vr
    subb a, #0ch
    jz next_mod_13
    mov a, mod_vr
    subb a, #0dh
    jz next_mod_14
    mov a, mod_vr
    subb a, #0eh
    jz next_mod_15
    mov a, mod_vr
    subb a, #0fh
    jz next_mod_0
next_mod_0:
    mov mod_vr, #00h
    mov a, #mod_0
    push acc
    sjmp next_mod_exit
next_mod_1:
    mov mod_vr, #01h
    mov a, #mod_1
    push acc
    sjmp next_mod_exit
next_mod_2:
    mov mod_vr, #02h
    mov a, #mod_2
    push acc
    sjmp next_mod_exit
next_mod_3:
    mov mod_vr, #03h
    mov a, #mod_3
    push acc
    sjmp next_mod_exit
next_mod_4:
    mov mod_vr, #04h
    mov a, #mod_4
    push acc
    sjmp next_mod_exit
next_mod_5:
    mov mod_vr, #05h
    mov a, #mod_5
    push acc
    sjmp next_mod_exit
next_mod_6:
    mov mod_vr, #06h
    mov a, #mod_6
    push acc
    sjmp next_mod_exit
next_mod_7:
    mov mod_vr, #07h
    mov a, #mod_7
    push acc
    sjmp next_mod_exit
next_mod_8:
    mov mod_vr, #08h
    mov a, #mod_8
    push acc
    sjmp next_mod_exit
next_mod_9:
    mov mod_vr, #09h
    mov a, #mod_9
    push acc
    sjmp next_mod_exit
next_mod_10:
    mov mod_vr, #0ah
    mov a, #mod_10
    push acc
    sjmp next_mod_exit
next_mod_11:
    mov mod_vr, #0bh
    mov a, #mod_11
    push acc
    sjmp next_mod_exit
next_mod_12:
    mov mod_vr, #0ch
    mov a, #mod_12
    push acc
    sjmp next_mod_exit
next_mod_13:
    mov mod_vr, #0dh
    mov a, #mod_6
    push acc
    sjmp next_mod_exit
next_mod_14:
    mov mod_vr, #0eh
    mov a, #mod_14
    push acc
    sjmp next_mod_exit
next_mod_15:
    mov mod_vr, #0fh
    mov a, #mod_15
    push acc
next_mod_exit:
    mov a, #00h
    push acc
    reti

prev_mod:
    pop acc
    pop acc
    clr c
    mov a, mod_vr
    jz next_mod_15
    mov a, mod_vr
    subb a, #01h
    jz next_mod_0
    mov a, mod_vr
    subb a, #02h
    jz next_mod_1
    mov a, mod_vr
    subb a, #03h
    jz next_mod_2
    mov a, mod_vr
    subb a, #04h
    jz next_mod_3
    mov a, mod_vr
    subb a, #05h
    jz next_mod_4
    mov a, mod_vr
    subb a, #06h
    jz next_mod_5
    mov a, mod_vr
    subb a, #07h
    jz next_mod_6
    mov a, mod_vr
    subb a, #08h
    jz next_mod_7
    mov a, mod_vr
    subb a, #09h
    jz next_mod_8
    mov a, mod_vr
    subb a, #0ah
    jz next_mod_9
    mov a, mod_vr
    subb a, #0bh
    jz next_mod_10
    mov a, mod_vr
    subb a, #0ch
    jz next_mod_11
    mov a, mod_vr
    subb a, #0dh
    jz next_mod_12
    mov a, mod_vr
    subb a, #0eh
    jz next_mod_13
    mov a, mod_vr
    subb a, #0fh
    jz next_mod_14
prev_mod_0:
    mov mod_vr, #00h
    mov a, #mod_0
    push acc
    sjmp prev_mod_exit
prev_mod_1:
    mov mod_vr, #01h
    mov a, #mod_1
    push acc
    sjmp prev_mod_exit
prev_mod_2:
    mov mod_vr, #02h
    mov a, #mod_2
    push acc
    sjmp prev_mod_exit
prev_mod_3:
    mov mod_vr, #03h
    mov a, #mod_3
    push acc
    sjmp prev_mod_exit
prev_mod_4:
    mov mod_vr, #04h
    mov a, #mod_4
    push acc
    sjmp prev_mod_exit
prev_mod_5:
    mov mod_vr, #05h
    mov a, #mod_5
    push acc
    sjmp prev_mod_exit
prev_mod_6:
    mov mod_vr, #06h
    mov a, #mod_6
    push acc
    sjmp prev_mod_exit
prev_mod_7:
    mov mod_vr, #07h
    mov a, #mod_7
    push acc
    sjmp prev_mod_exit
prev_mod_8:
    mov mod_vr, #08h
    mov a, #mod_8
    push acc
    sjmp prev_mod_exit
prev_mod_9:
    mov mod_vr, #09h
    mov a, #mod_9
    push acc
    sjmp prev_mod_exit
prev_mod_10:
    mov mod_vr, #0ah
    mov a, #mod_10
    push acc
    sjmp prev_mod_exit
prev_mod_11:
    mov mod_vr, #0bh
    mov a, #mod_11
    push acc
    sjmp prev_mod_exit
prev_mod_12:
    mov mod_vr, #0ch
    mov a, #mod_12
    push acc
    sjmp prev_mod_exit
prev_mod_13:
    mov mod_vr, #0dh
    mov a, #mod_13
    push acc
    sjmp prev_mod_exit
prev_mod_14:
    mov mod_vr, #0eh
    mov a, #mod_14
    push acc
    sjmp prev_mod_exit
prev_mod_15:
    mov mod_vr, #0fh
    mov a, #mod_15
    push acc
prev_mod_exit:
    mov a, #00h
    push acc
    reti
end
















