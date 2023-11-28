NAME addfive
MAIN SEGMENT CODE 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
start:
	MOV DPTR, #0020H ; заносим адрес внешней памяти в регистр DPTR
	MOVX A, @DPTR ; записываем из внешеней памяти значение в регистр А
	CLR C ; отчищаем бит переноса
	SUBB A, #5H ; вычитаем из регистра А число 0х5
	MOV R0, #40H ; заносим адрес внутренней памяти в регистр R0
	MOV @R0, A ; с помощью косвенной адресации записываем число регистра А во внутренную память
	JMP start
END











