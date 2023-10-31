NAME mul24
MAIN SEGMENT CODE
XVARS SEGMENT XDATA
VARS SEGMENT DATA

RSEG VARS
TMP1: DS 4
TMP2: DS 4
TMP3: DS 4

RSEG XVARS
NUM1: DS 3
NUM2: DS 3
RES: DS 3
 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
; �������� ��������� ��������� ���� ����������� �����. ������ ���-
; �� ��������� �� ������� ������, ������ ����� ����������� ��������
; �� ����� 2 ����������������. ���������� ��������� ������� � �����-
; ����������� ���� (UART). �������� � ����� ������ UART ��������
; ��������������. ������������ ������������� ����������� � �����-
; �������� ���������� � ��������� ����� �������
start:
   CALL READ_PORT
   CALL EVAL_NUMS
   
   MOV P2, #00H
   MOV R0, #RES
   MOV A, TMP1
   MOVX @R0, A
   INC R0
   MOV B, TMP1 + 1
   MOV A, TMP2
   ADD A, B
   MOVX @R0, A
   MOV A, TMP
   
   JMP $
   
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
 





































































