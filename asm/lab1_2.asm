.MODEL small
.STACK 100h
.DATA
	a   db 12
    b   db 56
    c   db 34
    d   db 1
    e   db 76
.CODE
start:
	mov ax, @data
    mov ds, ax
    mov ax, 0
    mov al, a
    mov bl, b
    not bl
    and al, bl
    not al
    mov bl, c
    or al, bl
    push ax
    mov al, d
    mov bl, e
    and al, bl
    mov bx, 0
    pop bx
    not al
    or al, bl
    mov ah, 4ch
    int 21h
END START