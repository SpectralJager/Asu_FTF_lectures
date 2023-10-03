NAME addfive
MAIN SEGMENT CODE 
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
; READ FROM EXTERNAL MEMORY 3 BYTES
	MOV DPTR, #0020H
	MOVX A, @DPTR
	MOV R0, A
	INC DPTR
	MOVX A, @DPTR
	MOV R1, A
	INC DPTR
	MOVX A, @DPTR
	MOV R2, A
	INC DPTR
; READ FROM PORT2 3 BYTES
			
END
 



