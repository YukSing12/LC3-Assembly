;This program will get the input from keyboard and detect
;whether the input is balanced or not.
;Balcanced example: (hello) (world!)
;NOt balcaned example: ((hello)world

;This program primarily uses registers in the following manner:
;R0:Used to print to the monitor.
;R1:Store the character inputted from keyboard.
;R2:Used as a temporary value.
;R3:Used to check what the character is.
;R4:Store the value return from PUSH or POP
;R5:Store the result. If it's balanced, R5 is 0, else R5 is -1;
;R6:Store the top address of stack.

;This program primarily uses labels in the following manner:
;GET:The address of getting character from keyboard.
;ECHO:The address of echo the character to the monitor.
;CHECK1:The address of checking wheather the character is '('
;CHECK2:The address of checking wheather the character is ')'
;CHECK3:The address of checking wheather the character is '\r'
;FINISH:The address of finishing the input.
;STOP:The address of stopping the program.
;PUSH:The address of the push-in function.
;POP:The addrss of the pop-out function.
;EXIT:The address to exit the function.
;TOP:The address of the top of the stack.
;MAX:The address of the max address in the stack.




        .ORIG x3000

        LD R6,TOP
        NOT R6,R6      ;R6 store x5000 - 1  which is the top of the stack
        ADD R6,R6,#1
      
GET     LDI R1,KBSR    ;Start to get the character from the keyboard.
        BRzp GET
        LDI R0,KBDR

ECHO    LDI R1,DSR     ;Echo the character to the monitor.
        BRZp ECHO
        STI R0,DDR

;Recieve '('
CHECK1  LD R2,START    ;Check weather the character is '(', if it is, do push-in.
        ADD R3,R0,R2
        BRnp CHECK2
        JSR PUSH
        ADD R4,R4,#0
        BRnp STOP

;Recieve ')'           ;Check weather the character is ')', if it is, do pop-out.
CHECK2  LD R2,CLOSE
        ADD R3,R0,R2
        BRnp CHECK3
        JSR POP
        ADD R4,R4,#0
        BRnp STOP

;Recieve newline       ;Check weather the character is '\r', if it is, stop to recieve
                       ;character from keyboard.
CHECK3  LD R2,NEWLINE
        ADD R3,R0,R2
        BRz FINISH
        BRnzp GET
   
;stop                  ;Before halt and stop the program, to store the result in R5.
FINISH  LD R2,TOP
        ADD R2,R6,R2
        BRz #1
STOP    ADD R5,R5,#-1
        HALT

PUSH    LD R2,MAX      ;Push-in function
        ADD R2,R2,R6   ;detect underflow
        BRn FLOW
        STR R0,R6,#0
        ADD R6,R6,#-1
        RET

POP     LD R2,TOP      ;Pop-out function
        ADD R2,R2,R6   ;detect overflow
        BRz FLOW     
        LDR R0,R6,#0
        ADD R6,R6,#1
        RET

FLOW    ADD R4,R4,#-1
        RET 

TOP     .FILL xb000    ; - x5000
MAX     .FILL xc000    ; - x4000

KBSR    .FILL xFE00
KBDR    .FILL xFE02
DSR     .FILL xFE04
DDR     .FILL xFE06

NEWLINE .FILL xfff6    ; - 0x000a
START   .FILL xffd8    ; - '('
CLOSE   .FILL xffd7    ; - ')'

        .END
