NAME addfive
MAIN SEGMENT CODE 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
start: 
	MOV A, 40H ; �d��������� �������� �� ������ 0�40 ���������� ������ � ������� �
	ADD A, #05H ; ���������� � ������� � �������� 0�5
	MOV DPTR, #0020H ; ������� �������� ������ ������� ������ � ������� DPTR
   MOVX @DPTR, A ; ���������� ������� � �� ������� ������ �� ������ � �������� DPTR
   CLR A ; �������� �
   ADDC A, 0H ; ���������� ��������� �������� � ������� �
   INC DPTR ; ����������� �������� ���. DPTR
   MOVX @DPTR, A ; ���������� ���. � �� ������� ������ �� ������ � �������� DPTR
   JMP start
END




