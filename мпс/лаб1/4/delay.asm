name delay
main segment code
using 0
cseg at 0
ljmp start
rseg main
delay:
    mov r1, #00h
x1:
    mov r2, #00h
x2:
    djnz r2, x2
    djnz r1, x1
    ret 
start:
    call delay
end