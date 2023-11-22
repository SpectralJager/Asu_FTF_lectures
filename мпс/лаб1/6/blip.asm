public mod_blip, spead_blip
extrn data (spead_vr)
extrn code (delay)

blips segment code

rseg blips

mod_blip:
    push spead_vr
    mov spead_vr, #04h
    clr p3.7
    call delay
    setb p3.7
    call delay
    clr p3.7
    call delay
    setb p3.7
    pop spead_vr
    ret

spead_blip:
    push spead_vr
    mov spead_vr, #08h
    clr p3.7
    call delay
    setb p3.7
    call delay
    clr p3.7
    call delay
    setb p3.7
    pop spead_vr
    ret





