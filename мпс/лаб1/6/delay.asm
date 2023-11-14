public delay

extrn data (delay_time, spead_vr)

dl segment code

rseg dl
delay:
    mov delay_time, #00h
    mov delay_time+1, #00h
    mov delay_time+2, spead_vr
delay_loop:
    djnz delay_time, delay_loop
    djnz delay_time+1, delay_loop
    djnz delay_time+2, delay_loop
    ret
end
