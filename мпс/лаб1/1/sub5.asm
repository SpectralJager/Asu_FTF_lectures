NAME addfive
MAIN SEGMENT CODE 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
; �������� ��������� ��������� �� �����, ������������ �� �������
; ������ ������ ��, ����� 5. ��������� ��������� �� ���������� ��-
; ���� ������, ��������� ��������� ���������.start: 
start:
	MOV DPTR, #0020H
	MOVX A, @DPTR
	CLR C
	SUBB A, #5H
	MOV 40H, A
END



