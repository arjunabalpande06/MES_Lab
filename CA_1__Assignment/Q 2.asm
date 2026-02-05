;Q 2 )


ORG 0000H           ; Program starts at address 0000H
LJMP MAIN           ; Jump to main program

ORG 0030H           ; Main program starts at 0030H
MAIN:
    ; Initialize result register
    MOV R0, #00H    ; Result register (will store comparison result)
    
    ; Load the two numbers into working registers
    MOV A, 50H      ; Load first number from memory
    MOV R2, A       ; Store in R2 (working copy of first number)
    MOV A, 51H      ; Load second number from memory
    MOV R3, A       ; Store in R3 (working copy of second number)
        
COMPARE_LOOP:
    ; Check if R2 (first number) is zero
    MOV A, R2       ; Load first number into accumulator
    JZ A_IS_ZERO    ; If zero flag set, A reached zero first
    
    ; Check if R3 (second number) is zero
    MOV A, R3       ; Load second number into accumulator
    JZ B_IS_ZERO    ; If zero flag set, B reached zero first
    
    ; Both are non-zero, decrement both
    DEC R2          ; Decrement first number
    DEC R3          ; Decrement second number
    LJMP COMPARE_LOOP ; Continue loop
    
A_IS_ZERO:
    ; A reached zero - check if B is also zero
    MOV A, R3       ; Load second number
    JZ EQUAL        ; If B = 0, numbers are equal
    ; B is not zero, so B > A (A < B)
    MOV R0, #0FFH   ; Result = FFH (A < B)
    LJMP END_PROGRAM
    
B_IS_ZERO:
    
    MOV R0, #01H    ; Result = 01H (A > B)
    LJMP END_PROGRAM
    
EQUAL:
    ; Both numbers are zero - they were equal
    MOV R0, #00H    ; Result = 00H (A = B)
    
END_PROGRAM:
    SJMP $          ; Halt (infinite loop)

END