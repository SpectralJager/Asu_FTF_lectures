NAME main
EXTRN DATA (TMP1, TMP2, TMP3)
EXTRN XDATA (NUM1, NUM2, RES)
EXTRN CODE (READ_PORT, EVAL_NUMS, SUM_NUMS, OUT_UART)

MAIN SEGMENT CODE

CSEG AT 0
LJMP start
USING 0

RSEG MAIN 
start: 
   CALL READ_PORT
   CALL EVAL_NUMS
   CALL SUM_NUMS
   CALL OUT_UART
   
   JMP $ 
   
END
 





























































































