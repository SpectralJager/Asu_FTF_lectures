name lights

extrn code (mod0)
extrn data (sp_start, spead_vr, mod_vr)

main segment code

cseg at 0
    ljmp start

rseg main
using 0
start:
    mov sp, #sp_start
    mov spead_vr, #02h
    mov mod_vr, #00h
    call mod0
    jmp start
end
