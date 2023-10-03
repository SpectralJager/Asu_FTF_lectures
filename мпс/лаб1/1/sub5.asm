NAME addfive
MAIN SEGMENT CODE 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
; Написать программу вычитания из числа, находящегося во внешней
; памяти данных МК, числа 5. Результат поместить во внутреннюю па-
; мять данных, используя косвенную адресацию.start: 
start:
	MOV DPTR, #0020H
	MOVX A, @DPTR
	CLR C
	SUBB A, #5H
	MOV 40H, A
END



