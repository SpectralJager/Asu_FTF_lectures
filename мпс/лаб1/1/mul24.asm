NAME addfive
MAIN SEGMENT CODE 
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
 



