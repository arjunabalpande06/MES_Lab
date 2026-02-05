;Q 1 )

ORG 0000H           ; Start at address 0000H
LJMP MAIN           ; Jump to main program

ORG 0030H           ; Start main program after interrupt vectors

MAIN:
    ; ========================================
    ; Method: Build 1074 as (107 × 10) + 4
    ; Where 107 = (10 × 10) + 7
    ; ========================================
    
    ; Step 1: Generate 10
    MOV A, #5           ; Load 5 into A
    ADD A, #5           ; A = 5 + 5 = 10
    
    ; Step 2: Calculate 10 × 10 = 100
    MOV B, A            ; B = 10
    MUL AB              ; A × B = 10 × 10 = 100
                        ; Result: A = 64h (100)
    
    ; Step 3: Add 7 to get 107
    ADD A, #7           ; A = 100 + 7 = 107 (6Bh)
    MOV R2, A           ; Save 107 in R2
    
    ; Step 4: Multiply 107 × 10 = 1070
    MOV B, #10          ; B = 10
    MUL AB              ; A × B = 107 × 10 = 1070
                        ; Result: A = 2Eh (46), B = 04h (4)
                        ; Combined: 042Eh = 1070 decimal
    
    ; Step 5: Save 1070 in registers
    MOV R1, A           ; R1 = Lower byte (2Eh = 46)
    MOV R0, B           ; R0 = Higher byte (04h = 4)
    
    ; Step 6: Add 4 to get 1074
    MOV A, R1           ; A = 2Eh (46)
    ADD A, #4           ; A = 46 + 4 = 50 (32h)
    MOV R1, A           ; Store result in R1
    
    MOV A, R0           ; Load higher byte
    ADDC A, #0          ; Add carry bit (if any)
    MOV R0, A           ; R0 = 04h
    
    ; Final Result: R0:R1 = 0432h = 1074 decimal
    MOV A, R1           ; Load final result into Accumulator
    
    ; Display result on LED bank (optional for EDSim51)
    MOV P1, A           ; Send lower byte to Port 1 (LEDs)
    
DONE:
    SJMP DONE           ; Infinite loop

END                     