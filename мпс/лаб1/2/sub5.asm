NAME addfive
MAIN SEGMENT CODE 
CSEG AT 0
LJMP start
USING 0
RSEG MAIN 
start:
    MOV DPTR, #0020H 
    MOVX A, @DPTR 
    CLR C 
    SUBB A, #5H 
    MOV R0, #40H 
    MOV @R0, A 
    MOV A, #00H
    SUBB A, #00H
    INC R0
    MOV @R0, A
    JMP start
END


















