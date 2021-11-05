MODEL MEDIUM
.STACK 200H
.DATA
	ver_offs dw 160
	hor_offs dw 2
	color db 10
	smb_code db 42 ;star char code
.CODE
start:
	mov ax, @data
	mov ds, ax

	mov ax, 0003h
	int 10h

	mov bx, 0b800h
	mov es, bx

	mov bx, 80*21 ; start possition (center offset)
	mov dh, 0 ; for clear screen
	mov dl, smb_code

	mov ax, bx
	jmp update_scrn

check:
	xor ax, ax
	mov ah, 7
	int 21h
	cmp al, 50h ; key down
	je down
	cmp al, 48h ; key up
	je up
	cmp al, 4bh ; key left
	je left
	cmp al, 4dh ; key right
	je right
	cmp al, 13 ; key enter for exit
	je exit
	jmp check

down:
	mov ax, bx
	add ax,ver_offs
	jmp update_scrn

up:
	mov ax, bx
	sub ax, ver_offs
	jmp update_scrn

left:
	mov ax, bx
	sub ax, hor_offs
	jmp update_scrn

right:
	mov ax, bx
	add ax, hor_offs
	jmp update_scrn

update_scrn:
	mov cx, 3
	clr_loop:
		mov es:[bx], dh
		add bx, 2
	loop clr_loop
	mov bx, ax
	mov cx, 3
	print_loop:
		mov es:[bx], dl
		add bx, 2
	loop print_loop
	mov bx, ax
	jmp check

exit:
	mov ah, 4ch
	int 21h

END start


