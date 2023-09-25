NAME SWITCH
MAIN SEGMENT CODE 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN
start: 
	MOV P1,#07FH
dbnc:
	MOV R4,#5
dbnc1: 
	MOV R3,#0FFH
dbnc2:
	JB P3.2, dbnc
	DJNZ R3, dbnc2
	DJNZ R4, dbnc1
	JNB P3.2,$
	JB P1.7, switch                              
	SETB P1.7
	CLR P1.6 
	JMP dbnc 
switch: 
	CLR P1.7 
	SETB P1.6 
	JMP dbnc 
END 




