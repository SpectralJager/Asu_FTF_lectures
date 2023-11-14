name lights

main segment code
vars segment data

rseg vars
mod_vr: ds 1
spead_vr: ds 1
delay_time: ds 4
sp_start equ 3fh

cseg at 0
    ljmp start

rseg main
using 0
start:
    mov sp, #sp_start
    mov spead_vr, #02h
    mov mod_vr, #00h

mod0:
    mov sp, #sp_start
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
    mov sp, #sp_start
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
    mov sp, #sp_start
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
    mov sp, #sp_start
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
    mov sp, #sp_start
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
    mov sp, #sp_start
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
    mov sp, #sp_start
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
    mov sp, #sp_start
    mov p1, #0ffh
    mov a, #09fh
mod_7_loop:
    swap a
    mov p1, a
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_7_loop

mod8:
    mov sp, #sp_start
    mov p1, #0ffh
mod_8_loop:
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_8_loop

mod9:
    mov sp, #sp_start
    mov p1, #0ffh
mod_9_loop:
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_9_loop

mod10:
    mov sp, #sp_start
    mov p1, #0ffh
mod_10_loop:
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_10_loop

mod11:
    mov sp, #sp_start
    mov p1, #0ffh
mod_11_loop:
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_11_loop

mod12:
    mov sp, #sp_start
    mov p1, #0ffh
mod_12_loop:
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_12_loop

mod13:
    mov sp, #sp_start
    mov p1, #0ffh
mod_13_loop:
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_13_loop

mod14:
    mov sp, #sp_start
    mov p1, #0ffh
mod_14_loop:
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_8_loop
    
mod15:
    mov sp, #sp_start
    mov p1, #0ffh
mod_15_loop:
    call delay
    call check_spd_btns
    call check_mod_btns
    sjmp mod_15_loop

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
    clr c
    mov a, mod_vr
    jnz next_mod_2
    mov mod_vr, #01h
    call mod1
next_mod_2:
    mov a, mod_vr
    subb a, #01h
    jnz next_mod_3
    mov mod_vr, #02h
    call mod2
next_mod_3:
    mov a, mod_vr
    subb a, #02h
    jnz next_mod_4
    mov mod_vr, #03h
    call mod3
next_mod_4:
    mov a, mod_vr
    subb a, #03h
    jnz next_mod_5
    mov mod_vr, #04h
    call mod4
next_mod_5:
    mov a, mod_vr
    subb a, #04h
    jnz next_mod_6
    mov mod_vr, #05h
    call mod5
next_mod_6:
    mov a, mod_vr
    subb a, #05h
    jnz next_mod_7
    mov mod_vr, #06h
    call mod6
next_mod_7:
    mov a, mod_vr
    subb a, #06h
    jnz next_mod_8
    mov mod_vr, #07h
    call mod7
next_mod_8:
    mov a, mod_vr
    subb a, #07h
    jnz next_mod_9
    mov mod_vr, #08h
    call mod8
next_mod_9:
    mov a, mod_vr
    subb a, #08h
    jnz next_mod_10
    mov mod_vr, #09h
    call mod9
next_mod_10:
    mov a, mod_vr
    subb a, #09h
    jnz next_mod_11
    mov mod_vr, #0ah
    call mod10
next_mod_11:
    mov a, mod_vr
    subb a, #0ah
    jnz next_mod_12
    mov mod_vr, #0bh
    call mod11
next_mod_12:
    mov a, mod_vr
    subb a, #0bh
    jnz next_mod_13
    mov mod_vr, #0ch
    call mod12
next_mod_13:
    mov a, mod_vr
    subb a, #0ch
    jnz next_mod_14
    mov mod_vr, #0dh
    call mod13
next_mod_14:
    mov a, mod_vr
    subb a, #0dh
    jnz next_mod_15
    mov mod_vr, #0eh
    call mod14
next_mod_15:
    mov a, mod_vr
    subb a, #0eh
    jnz next_mod_0
    mov mod_vr, #0fh
    call mod15
next_mod_0:
    mov mod_vr, #00h
    call mod0

prev_mod:
    clr c
    mov a, mod_vr
    jnz prev_mod_14
    mov mod_vr, #0fh
    call mod15
prev_mod_14:
    mov a, mod_vr
    subb a, #0fh
    clr c
    jnz prev_mod_13
    mov mod_vr, #0eh
    call mod14
prev_mod_13:
    mov a, mod_vr
    subb a, #0eh
    clr c
    jnz prev_mod_12
    mov mod_vr, #0dh
    call mod13
prev_mod_12:
    mov a, mod_vr
    subb a, #0dh
    clr c
    jnz prev_mod_11
    mov mod_vr, #0ch
    call mod12
prev_mod_11:
    mov a, mod_vr
    subb a, #0ch
    clr c
    jnz prev_mod_10
    mov mod_vr, #0bh
    call mod11
prev_mod_10:
    mov a, mod_vr
    subb a, #0bh
    clr c
    jnz prev_mod_9
    mov mod_vr, #0ah
    call mod10
prev_mod_9:
    mov a, mod_vr
    subb a, #0ah
    clr c
    jnz prev_mod_8
    mov mod_vr, #09h
    call mod9
prev_mod_8:
    mov a, mod_vr
    subb a, #09h
    clr c
    jnz prev_mod_7
    mov mod_vr, #08h
    call mod8
prev_mod_7:
    mov a, mod_vr
    subb a, #08h
    clr c
    jnz prev_mod_6
    mov mod_vr, #07h
    call mod7
prev_mod_6:
    mov a, mod_vr
    subb a, #07h
    clr c
    jnz prev_mod_5
    mov mod_vr, #06h
    call mod6
prev_mod_5:
    mov a, mod_vr
    subb a, #06h
    clr c
    jnz prev_mod_4
    mov mod_vr, #05h
    call mod5
prev_mod_4:
    mov a, mod_vr
    subb a, #05h
    clr c
    jnz prev_mod_3
    mov mod_vr, #04h
    call mod4
prev_mod_3:
    mov a, mod_vr
    subb a, #04h
    clr c
    jnz prev_mod_2
    mov mod_vr, #03h
    call mod3
prev_mod_2:
    mov a, mod_vr
    subb a, #03h
    clr c
    jnz prev_mod_1
    mov mod_vr, #02h
    call mod2
prev_mod_1:
    mov a, mod_vr
    subb a, #02h
    clr c
    jnz prev_mod_0
    mov mod_vr, #01h
    call mod1
prev_mod_0:
    mov mod_vr, #00h
    call mod0
end




























