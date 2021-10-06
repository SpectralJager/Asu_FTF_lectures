.MODEL small
.STACK 100h
.DATA
	a   dw 11
    b   dw 11
    c   db 6
    d   db 3
    e   db 10
.CODE
start:
	mov ax, @data
    mov ds, ax
    mov ax, a
    mov bx, b 
    div bx
    push ax
    mov ax, 0h
    mov bx, 0h
    mov al, c
    mov bl, d
    div bl
    mov bl, e
    mul bl
    mov bx, ax 
    pop ax
    sub ax, bx
    neg ax
    mov ah, 4ch
    int 21h
END START