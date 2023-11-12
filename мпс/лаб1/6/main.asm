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
    sjmp mod0
mod_1:
    sjmp mod1

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
next_mod_exit:
    mov a, #00h
    push acc
    ;mov a, spead_vr
    ;mov spead_vr, #08h
    ;call delay
    ;mov spead_vr, a
    reti

prev_mod:
    pop acc
    pop acc
    clr c
    mov a, mod_vr
    jz prev_mod_1
    mov a, mod_vr
    subb a, #01h
    jz prev_mod_0
prev_mod_0:
    mov mod_vr, #00h
    mov a, #mod_0
    push acc
    sjmp prev_mod_exit
prev_mod_1:
    mov mod_vr, #01h
    mov a, #mod_1
    push acc
prev_mod_exit:
    mov a, #00h
    push acc
    ;mov a, spead_vr
    ;mov spead_vr, #08h
    ;call delay
    ;mov spead_vr, a
    reti
end










