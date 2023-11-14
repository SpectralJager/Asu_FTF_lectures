public incr_spd, decr_spd
extrn data (spead_vr)

change_spead segment code

rseg change_spead
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
end
