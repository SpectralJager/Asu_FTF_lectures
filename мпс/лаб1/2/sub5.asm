NAME addfive
MAIN SEGMENT CODE 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
start:
	MOV DPTR, #0020H ; ������� ����� ������� ������ � ������� DPTR
	MOVX A, @DPTR ; ���������� �� �������� ������ �������� � ������� �
	CLR C ; �������� ��� ��������
	SUBB A, #5H ; �������� �� �������� � ����� 0�5
	MOV R0, #40H ; ������� ����� ���������� ������ � ������� R0
	MOV @R0, A ; � ������� ��������� ��������� ���������� ����� �������� � �� ���������� ������
	JMP start
END











