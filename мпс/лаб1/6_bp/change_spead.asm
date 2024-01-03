public incr_spd, decr_spd
extrn data (spead_vr)
extrn code (spead_blip)

change_spead segment code

rseg change_spead
incr_spd:
    clr c
    mov a, spead_vr
    subb a, #020h
    jz incr_spd_blip
    mov a, spead_vr
    jmp incr_spd_exit
incr_spd_blip:
    call spead_blip
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
    call spead_blip
decr_spd_exit:
    mov spead_vr, a
    ret
end















