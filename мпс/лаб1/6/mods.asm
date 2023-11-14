public mod0, mod1, mod2, mod3, mod4, mod5, mod6, mod7, mod8, mod9, mod10, mod11, mod12, mod13, mod14, mod15

extrn data (sp_start)
extrn code (delay, check_spd_btns, check_mod_btns)

mods segment code

rseg mods
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

end
