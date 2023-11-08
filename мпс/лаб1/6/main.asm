name lights
main segment code
i0 segment code

cseg at 0
ljmp start

cseg at 03h
ljmp in0

rseg i0	
in0:	
    pop acc
    pop acc
    clr c
    mov a, r1
    jz in0_0
    mov a, r1
    subb a, #01h
    jz in0_1
    sjmp in0_rst
in0_0:
    mov a, #mod_0
    push acc
    sjmp in0_exit
in0_1:
	 mov a, #mod_1
	 push acc
	 sjmp in0_exit
in0_rst:
	 mov r1, #0ffh
in0_exit:
	 inc r1
    mov a, #00h
    push acc
    reti

rseg main
using 0
start:
    orl ie, #81h
mod_0:
	sjmp mod0
mod_1:
	sjmp mod1

mod0:
    mov r3, #0ffh
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
    djnz r1, mod_0_loop
    sjmp mod0
mod1:
    mov r3, #0ffh
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
    djnz r1, mod_1_loop
    sjmp mod1
end



















