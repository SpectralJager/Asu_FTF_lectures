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
; �������� ��������� ��������� ���� ����������� �����. ������ ���-
; �� ��������� �� ������� ������, ������ ����� ����������� ��������
; �� ����� 2 ����������������. ���������� ��������� ������� � �����-
; ����������� ���� (UART). �������� � ����� ������ UART ��������
; ��������������. ������������ ������������� ����������� � �����-
; �������� ���������� � ��������� ����� �������
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
 





























