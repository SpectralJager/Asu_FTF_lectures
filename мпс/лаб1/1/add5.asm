NAME addfive
MAIN SEGMENT CODE 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
; Написать программу сложения числа, находящегося во второй поло-
; вине внутренней памяти данных МК, с числом 5. Результат поместить
; во внешнюю память.
start: 
	MOV A, 40H
	CLR C
	ADD A, #5
	MOV DPTR, #0020H
   MOVX @DPTR, A
END
