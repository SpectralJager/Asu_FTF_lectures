public  next_mod, prev_mod
extrn data (mod_vr)
extrn code (mod0, mod1, mod2, mod3, mod4, mod5, mod6, mod7, mod8, mod9, mod10, mod11, mod12, mod13, mod14, mod15, mod_blip)

select_mod segment code

rseg select_mod

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
    call mod_blip
    call mod0

prev_mod:
    clr c
    mov a, mod_vr
    jnz prev_mod_14
    mov mod_vr, #0fh
    call mod_blip
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













