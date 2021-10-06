MODEL MEDIUM
.STACK 200H
.DATA
	; message
	;  1	2	3	4	5	6	7	8	9	10	11	12	13
	;| -	-	-	-	-	-	-	-	-	-	-	-	-	|
	;|													e	|1
	;|												g		|2
	;|											a			|3
	;|										s				|4
	;|									s					|5
	;|								e						|6
	;|							m						e	|7
	;|													g	|8
	;|													a	|9
	;|													s	|10
	;|													s	|11
	;|													e	|12
	;|	m	e	s	s	a	g	e						m	|13
	;| -	-	-	-	-	-	-	-	-	-	-	-	-	|

	msgCtTR db '            e',10,'           g',10,'          a',10,'         s',10,'        s',10,'       e',10,'      m',10,10,10,10,10,10,10,36
	msgBLtR db 10,10,10,10,10,10,10,10,10,10,10,10,"message",10,36
	msgBRtT db 10,10,10,10,10,10,'            e',10,'            g',10,'            a',10,'            s',10,'            s',10,'            e',10,'            m',10,36
	greetings db 10,"Press some of keys(Enter,F4,Space) or '+' key for exit.",10,36
.CODE
start:
	mov ax, @data
	mov ds, ax

	lea dx, greetings
	jmp print

check:
	mov ah, 7
	int 21h
	cmp al, 13
	je centerToTopRight
	cmp al, 62;20
	je bottomLeftToRight
	cmp al, 32
	je bottomRightToTop 
	cmp al, 43
	je exit
	jmp check 

centerToTopRight:
	lea dx, msgCtTR
	jmp print

bottomLeftToRight:
	lea dx, msgBLtR
	jmp print
	
bottomRightToTop:
	lea dx, msgBRtT
	jmp print

print:
	mov ah, 9
	int 21h
	jmp check

exit:
	mov ah, 4ch
	int 21h

END start

