NAME mul24
MAIN SEGMENT CODE
XVARS SEGMENT XDATA

RSEG XVARS
NUM1: DS 3
NUM2: DS 3
RES:  DS 3
 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
; Написать программу умножения двух трехбайтных чисел. Первое чис-
; ло находится во внешней памяти, второе число принимается побайтно
; из порта 2 микроконтроллера. Результата умножения вывести в после-
; довательный порт (UART). Скорость и режим работы UART задается
; преподавателем. Обязательное использование подпрограмм и симво-
; лических переменных в отдельном файле проекта
start:
   CALL READ_PORT
   MOV DPTR, #NUM1
   MOVX A, @DPTR
   MOV B, A
   MOV DPTR, #NUM2
   MOVX A, @DPTR
   MUL AB
	JMP $

READ_PORT:
	MOV R3, #03H
	MOV DPTR, #NUM2
read_loop:
	MOV A, P2
	MOVX @DPTR, A
	INC DPTR
	DJNZ R3, read_loop
	RET
			
END
 





























