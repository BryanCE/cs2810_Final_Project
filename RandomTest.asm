.ORIG x3000
        AND     R0, R0, #0
	AND 	R1, R1, #0     	; clear registers
        AND 	R2, R2, #0
        AND 	R3, R3, #0
        AND 	R4, R4, #0
        AND 	R5, R5, #0
        AND 	R6, R6, #0
        AND 	R7, R7, #0
                
START   
        LEA R0, WELCOME
        PUTS
        GETC
        OUT

        ST r0, TEMP   	; storing the result of the input to TEMP label
						; from r0 
        
        LEA R0, NEWLINE
        PUTS

        LD R1, TEMP
        LD R4, ASCII_E
        NOT R1, R1
        ADD R1, R1 #1
        ADD R1, R1, R4
        BRz EXIT

        LD R1, TEMP
        LD R4, ASCII_S
        NOT R1, R1
        ADD R1, R1 #1
        ADD R1, R1, R4
        BRz RANDOMOUT
        BRnp START



RANDOMOUT   
        AND R4, R4, #0
        LEA r0, USERINPUT
        PUTS
        BR RANDOMIN

RANDOMZERO
        AND R4, R4, #0
        BR RANDOMIN

RANDOMIN 
        AND R1, R1, #0
        AND R3, R1, #0
        ADD R4, R4, #1
        LD R1, KBSRVAL
        LDI R3, KBSRSTORE
        AND R3, R3, R1
        ADD	R3,	R3,	#-1
        NOT	R3,	R3
        ADD R3, R3, R1
        BRnp RESULT
        ADD R5, R4, #0
        ADD R5, R5, #-4
        BRp RANDOMZERO
            
            

RESULT  AND R0, R0, #0
        LD R6, ASCII
        ADD R0, R4, R6
        PUTS
        LEA R0, NEWLINE
        PUTS
        BR START





EXIT    LEA R0, QUIT
        PUTS
        HALT

WELCOME .STRINGZ "Press s to start RNG or e to exit\n"
USERINPUT .STRINGZ	"Press r for random number\n"
QUIT .STRINGZ	"Goodbye"
ZERO .STRINGZ	"0\n" 
ONE .STRINGZ	"1\n" 
TWO .STRINGZ	"2\n" 
THREE .STRINGZ	"3\n" 
FOUR .STRINGZ	"4\n" 
FIVE .STRINGZ	"5\n" 
TEMP .FILL	x0000
ASCII .FILL x0030
ASCII_E .FILL x0065
ASCII_R .FILL x0072
ASCII_S .FILL x0073
KBSRVAL .FILL x8000
KBSRSTORE .FILL xFE00
NEWLINE .STRINGZ "\n"

.END