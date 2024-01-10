DAT SEGMENT DATA
RSEG DAT
Speed equ 50h ;����������
Zero equ 51h; ������������ ���������
Red equ 52h ; ���������� ���������
AutoMode equ 53h ;������������ ������
BITD SEGMENT BIT
RSEG BITD
Direction equ 20h
GreenSleep equ 22h
bAutoMode equ 23h
doubleSleep equ 24h
 
MAIN SEGMENT CODE
RSEG MAIN
LJMP MAIN
CSEG AT 00BH
MOV TH0,#3
MOV TL0,#2
DEC R5 ;��������� �������� �� ��������
JNB P3.7,Skip0
JNB doubleSleep,Skip ;������� �������� ����������
CLR P3.7 ;��� �������� ����������
MOV R6,#10 ; 
CLR doubleSleep
 
Skip0:
DEC R6
CJNE R6,#0,Skip
SETB P3.7
 
Skip:
DEC R1
CJNE R1,#0,InterruptEnd
MOV R1,Speed
MOV A,P1
JB Direction,Reverse ;��� �����
RL A
MOV P1,A
CJNE R3,#0,one
CJNE R4,#0,two
    MOV R3,Zero
    MOV R4,Red
    
one:
DEC R3
CLR P1.0
JMP InterruptEnd
two:
DEC R4
SETB P1.0
JMP InterruptEnd
 
Reverse: ;��� ������
RR A
MOV P1,A
CJNE R3,#0,three
CJNE R4,#0,four
    MOV R3,Zero
    MOV R4,Red
    
three:
DEC R3
CLR P1.7
JMP InterruptEnd
four:
DEC R4
SETB P1.7
 
InterruptEnd:
JNB bAutoMode,returne ;������� �������� ����������������
INC R7
CJNE R7,#200,returne
MOV R7,#0
DEC AutoMode
 
returne:
RETI
SpeedChangeDown: ;���������� ��������
INC Speed ;���������� �������� ����� �������������
MOV A,Speed
CJNE A,#17,SpeedEndD
DEC Speed
 
SpeedSleepD:
    MOV R6,#20
    CLR P3.7
    
SpeedEndD:
    MOV AutoMode,#2
    MOV R7,#0
    SETB bAutoMode
RET
 
SpeedChangeUp: ;���������� ��������
    DEC Speed ;���������� �������� ����� �������������
    MOV A,Speed
    CJNE A,#0,SpeedEndD
    INC Speed
    
SpeedSleepU:
    MOV R6,#20
    CLR P3.7
    
SpeedEndU:
    MOV AutoMode,#2
    MOV R7,#0   
    SETB bAutoMode
RET
 
ModeChange: ;������������ ��������� ������ 
    MOV A,Red
    CJNE A,#8,Change
    JB Direction,ModeUp
    CPL Direction
    JMP ModeEnd
    
Change:
    JB Direction,ModeUp
    CLR C
    SUBB A, Zero
    JNZ PlusZero
    INC Red ;���������� ���������� ����������� �� 1
    JMP ModeEnd
    
PlusZero:
    INC Zero ;���������� ������������ ����������� �� 1
    JMP ModeEnd
    
ModeUp:
    MOV A,Red
    CJNE A,#1,subbing
    JMP SleepMode
    
subbing:
    CLR C
    SUBB A,Zero
    JNZ MinusZero
    DEC Zero ;���������� ������������ ����������� �� 1
    JMP ModeEnd
    
MinusZero:
    DEC Red ;���������� ���������� �����������(�������) �� 1
    MOV A,Red
    CJNE A,#1,ModeEnd
    
SleepMode:
    ;�������� ��� �������� �������� ����������
    MOV R6,#10;
    CLR P3.7
    SETB doubleSleep ;��������� �������� �������� ����������
 
    CLR bAutoMode
    MOV R5,#2
    CJNE R5,#0,$
    LCALL ModeChange ;��������� ������
 
ModeEnd:
    MOV AutoMode,#2 ;��������� �������� ����������������
    MOV R7,#0
    SETB bAutoMode ;������ �������� ���������������� RET
    RET
 
MAIN: ;�������� ���������
SETB P3.7
MOV Speed,#6
MOV Zero,#1
MOV Red,#1
MOV R3,#1
MOV R4,#1
MOV AutoMode,#2
MOV R7,#0
SETB bAutoMode
MOV R1,#2 ;�������� � 50�� ����� ��� ��� ����������
MOV TMOD,#00000001b ;��������� 0 �������(16 ���)
MOV TH0,#21 ; 61
MOV TL0,#26  ;66
MOV IE,#10000010b ;���������� ���������� ��� ������� 0
SETB TR0 ;������ �������
 
BACKE:
    JB P3.2,sd ;���� ������ �3,2
    CLR bAutoMode
    MOV R5,#2
    CJNE R5,#0,$
    JNB P3.2,$
    LCALL SpeedChangeDown ;��������� ��������
 
sd:
    JB P3.3, su ;���� ������ �3,3
    CLR bAutoMode
    MOV R5,#2
    CJNE R5,#0,$
    JNB P3.3,$
    LCALL SpeedChangeUp ;��������� ��������
 
su:
    JB P3.4,md ;���� ������ �3,4
    CLR bAutoMode
    MOV R5,#2
    CJNE R5,#0,$
    JNB P3.4,$
    CPL Direction ;��������� �����������
    LCALL ModeChange ;��������� ������
    CPL Direction
md:
    JB P3.5,mu ;���� ������ �3,5
    CLR bAutoMode
    MOV R5,#2
    CJNE R5,#0,$
    JNB P3.5,$
    LCALL ModeChange ;��������� ������
 
mu:
    MOV A, AutoMode ;���������������� ������
    JNZ BACKE
    CLR bAutoMode
    LCALL ModeChange
    INC AutoMode
JMP BACKE
 
END 

