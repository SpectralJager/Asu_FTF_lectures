PUBLIC READ_PORT, EVAL_NUMS, SUM_NUMS, OUT_UART
EXTRN DATA (TMP1, TMP2, TMP3)
EXTRN XDATA (NUM1, NUM2, RES)

FNS SEGMENT CODE

RSEG FNS

READ_PORT:
	MOV R3, #03H
	MOV DPTR, #NUM2
read_loop:
	MOV A, P2
	MOVX @DPTR, A
	INC DPTR
	DJNZ R3, read_loop
	RET
	
EVAL_NUMS:
	POP ACC
	MOV R4, A
	POP ACC
	MOV R5, A
	MOV P2, #00H
	MOV R0, #NUM1-1
	MOV R6, #03H
o_loop:
	INC R0
	MOV R1, #NUM2
	MOVX A, @R1
	MOV B, A
	MOVX A, @R0
	MUL AB
	PUSH ACC   
	MOV A, B
	PUSH ACC
	MOV R7, #02h
s_loop:	
	INC R1
	MOVX A, @R1
	MOV B, A
	MOVX A, @R0
	MUL AB
	MOV R3, B
	MOV B, A
	POP ACC
	ADD A, B
	PUSH ACC
	MOV A, R3
	ADDC A, #00H
	PUSH ACC
	DJNZ R7, S_LOOP
	DJNZ R6, O_LOOP
	MOV A, R5
	PUSH ACC
	MOV A, R4
	PUSH ACC
	RET
	
SUM_NUMS:
   MOV P2, #00H
   MOV R0, #RES
   MOV A, TMP1
   MOVX @R0, A
   INC R0
   MOV B, TMP1 + 1
   MOV A, TMP2
   ADD A, B
   MOVX @R0, A
   INC R0
   MOV B, TMP1 + 2
   MOV A, TMP2 + 1
   ADDC A, B
   MOV B, A
   MOV A, TMP1 + 3
   ADDC A, #0
   MOV TMP1 + 3, A
   MOV A, TMP3
   ADDC A, B
   MOVX @R0, A
   INC R0
   MOV B, TMP1 + 3
   MOV A, TMP2 + 2
   ADDC A, B
   MOV B, A
   MOV A, TMP2 + 3
   ADDC A, #0
   MOV TMP2 + 3, A
   MOV A, TMP3 + 1
   ADDC A, B
   MOVX @R0, A
   INC R0
   MOV B, TMP2 + 3
   MOV A, TMP3 + 2
   ADDC A, B
   MOVX @R0, A
   INC R0
   MOV A, TMP3 + 3
   ADDC A, #0
   MOVX @R0, A
   RET
   
    
OUT_UART:
   MOV SCON, #0d0h
   MOV PCON, #080h
   MOV TMOD, #020h
   MOV TH1, #0feh
   MOV TL1, #0feh
   SETB TR1
   MOV P2, #00H
   MOV R0, #RES
   MOV R4, #06H
uart_loop:
	MOVX A, @R0
	INC R0
   MOV SBUF, A
   DJNZ R4, UART_LOOP
   RET
END




























