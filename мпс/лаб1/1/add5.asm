NAME addfive
MAIN SEGMENT CODE 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
; �������� ��������� �������� �����, ������������ �� ������ ����-
; ���� ���������� ������ ������ ��, � ������ 5. ��������� ���������
; �� ������� ������.
start: 
	MOV A, 40H
	CLR C
	ADD A, #5
	MOV DPTR, #0020H
   MOVX @DPTR, A
END
