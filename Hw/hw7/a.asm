.Orig x3000
INIT_CODE
LEA R6, #-1
ADD R5, R6, #0
ADD R6, R6, R6
ADD R6, R6, R6
ADD R6, R6, R5
ADD R6, R6, #-1
ADD R5, R5, R5
ADD R5, R6, #0
LD R4, GLOBAL_DATA_POINTER
LD R7, GLOBAL_MAIN_POINTER
jsrr R7
HALT

GLOBAL_DATA_POINTER .FILL GLOBAL_DATA_START
GLOBAL_MAIN_POINTER .FILL main
;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main
ADD R6, R6, #-2
STR R7, R6, #0
ADD R6, R6, #-1
STR R5, R6, #0
ADD R5, R6, #-1

ADD R6, R6, #-3
ADD R7, R4, #7
ldr R7, R7, #0
str R7, R5, #-1
ADD R7, R4, #7
ldr R7, R7, #0
str R7, R5, #-2
lc3_L3_main
ADD R7, R4, #7
ldr R7, R7, #0
str R7, R5, #0
lc3_L7_main
ldr R7, R5, #-1
ADD R3, R4, #6
ldr R3, R3, #0
add R7, R7, R3
str R7, R5, #-1
lc3_L8_main
ldr R7, R5, #0
ADD R3, R4, #6
ldr R3, R3, #0
add R7, R7, R3
str R7, R5, #0
ldr R7, R5, #0
ADD R3, R4, #5
ldr R3, R3, #0
NOT R7, R7
ADD R7, R7, #1
ADD R7, R7, R3
BRnz L13
ADD R7, R4, #1
LDR R7, R7, #0
jmp R7
L13
lc3_L4_main
ldr R7, R5, #-2
ADD R3, R4, #6
ldr R3, R3, #0
add R7, R7, R3
str R7, R5, #-2
ldr R7, R5, #-2
ADD R3, R4, #5
ldr R3, R3, #0
NOT R7, R7
ADD R7, R7, #1
ADD R7, R7, R3
BRnz L14
ADD R7, R4, #0
LDR R7, R7, #0
jmp R7
L14
ADD R7, R4, #7
ldr R7, R7, #0
lc3_L1_main
STR R7, R5, #3
ADD R6, R5, #1
LDR R5, R6, #0
ADD R6, R6, #1
LDR R7, R6, #0
ADD R6, R6, #1
RET


GLOBAL_DATA_START
L3_main .FILL lc3_L3_main
L7_main .FILL lc3_L7_main
L8_main .FILL lc3_L8_main
L4_main .FILL lc3_L4_main
L1_main .FILL lc3_L1_main
L12_main .FILL #16
L11_main .FILL #1
L2_main .FILL #0
.END
