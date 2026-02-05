;Q 4 )

ORG 0000H
LJMP START

ORG 0030H
START:
    
    MOV 40H, #08H       ; Digit 1: 8
    MOV 41H, #00H       ; Digit 2: 0
    MOV 42H, #01H       ; Digit 3: 1
    MOV 43H, #00H       ; Digit 4: 0
    MOV 44H, #08H       ; Digit 5: 8
    MOV 45H, #07H       ; Digit 6: 7
    MOV 46H, #01H       ; Digit 7: 1
    MOV 47H, #09H       ; Digit 8: 9
    MOV 48H, #04H       ; Digit 9: 4
    MOV 49H, #01H       ; Digit 10: 1
    
    MOV A, #0FFH        ; A = 11111111b (255)
    
    
    ANL A, #09FH        ; A = 11111111b AND 10011111b = 10011111b (9FH)
    
    ; Step 2: Clear bit 3
    ANL A, #0F7H        ; A = 10011111b AND 11110111b = 10010111b (97H)
    
    ; Step 3: Clear bit 1
    ANL A, #0FDH        ; A = 10010111b AND 11111101b = 10010101b (95H)
    
    ; Verify: A = 95H (149 decimal) - This is the low byte
    MOV R2, A           ; Save low byte in R2
    MOV 50H, A          ; Store in RAM for inspection
    
    CLR A               ; A = 00000000b (0)
    
    ; Build 07H by setting bits 0, 1, 2
    ORL A, #01H         ; A = 00000000b OR 00000001b = 00000001b (01H)
    ORL A, #02H         ; A = 00000001b OR 00000010b = 00000011b (03H)
    ORL A, #04H         ; A = 00000011b OR 00000100b = 00000111b (07H)
    
    ; Verify: A = 07H (7 decimal) - This is the high byte
    MOV R3, A           ; Save high byte in R3
    MOV 51H, A          ; Store in RAM for inspection
    
    MOV 60H, R3         ; High byte: 07H
    MOV 61H, R2         ; Low byte: 95H
    
    ; For visual verification on EDSim51, also store individual digits
    MOV 62H, #01H       ; Thousands digit: 1
    MOV 63H, #09H       ; Hundreds digit: 9
    MOV 64H, #04H       ; Tens digit: 4
    MOV 65H, #01H       ; Ones digit: 1
    
    MOV A, R2           ; A = 95H (low byte of 1941)
    
    ; Store final accumulator value
    MOV 70H, A          ; Final result at 70H
    
    MOV A, 46H          ; A = 1 (thousands)
    MOV B, #10          ; B = 10
    MUL AB              ; A = 10, B = 0
    MOV R4, A           ; R4 = 10
    
    MOV A, 47H          ; A = 9 (hundreds)
    ADD A, R4           ; A = 19
    MOV R4, A           ; R4 = 19
    
    MOV A, R4           ; A = 19
    MOV B, #10          ; B = 10
    MUL AB              ; A = 190 (low byte), B = 0 (high byte)
    MOV R4, A           ; R4 = 190 (BEH)
    
    MOV A, 48H          ; A = 4 (tens)
    ADD A, R4           ; A = 194 (C2H)
    MOV R4, A           ; R4 = 194
    
    MOV A, R4           ; A = 194
    MOV B, #10          ; B = 10
    MUL AB              ; A = 1940 low = 94H, B = 07H (high)
    
    ; A now contains low byte of 1940
    MOV R5, A           ; Save low byte
    MOV R6, B           ; Save high byte
    
    MOV A, 49H          ; A = 1 (ones)
    ADD A, R5           ; A = 1940_low + 1 = 95H
    MOV R7, A           ; Final low byte = 95H
    
    ; Handle carry to high byte if needed
    MOV A, R6           ; A = high byte
    ADDC A, #00H        ; Add carry (if any)
    MOV R6, A           ; Final high byte = 07H
    
    ; Store complete calculated result
    MOV 71H, R7         ; Low byte at 71H (95H = 149)
    MOV 72H, R6         ; High byte at 72H (07H = 7)
   
    MOV A, R7           ; A = 95H (low byte)
    
HALT:
    SJMP HALT           ; Infinite loop

END

; ========================================================================
; EDSim51 VIEWING INSTRUCTIONS:
; ========================================================================
; 1. Load this program into EDSim51
; 2. Run/Step through the program
; 3. View the following memory locations:
;
; PHONE NUMBER STORAGE (40H-49H):
;    40H = 08 (digit 8)
;    41H = 00 (digit 0)
;    42H = 01 (digit 1)
;    43H = 00 (digit 0)
;    44H = 08 (digit 8)
;    45H = 07 (digit 7)
;    46H = 01 (digit 1) ? Last 4 digits start here
;    47H = 09 (digit 9)
;    48H = 04 (digit 4)
;    49H = 01 (digit 1)
;
; CONSTRUCTED VALUE (60H-61H):
;    60H = 07 (high byte)
;    61H = 95 (low byte)
;    16-bit value = 0795H = 1941 decimal ?
;
; INDIVIDUAL DIGITS (62H-65H):
;    62H = 01 (thousands)
;    63H = 09 (hundreds)
;    64H = 04 (tens)
;    65H = 01 (ones)
;
; CALCULATED VALUE (71H-72H):
;    71H = 95 (low byte calculated)
;    72H = 07 (high byte calculated)
;
; ACCUMULATOR (A):
;    A = 95H (149 decimal) - Low byte of 1941
;
; REGISTERS:
;    R2 = 95H (low byte from logical operations)
;    R3 = 07H (high byte from logical operations)
;    R7 = 95H (low byte from calculation)
;    R6 = 07H (high byte from calculation)
; ========================================================================

; ========================================================================
; VERIFICATION:
; ========================================================================
; Decimal: 1941
; Hexadecimal: 0795H
; Binary: 0000 0111 1001 0101
; 
; Breakdown:
; - High byte: 07H = 7 decimal
; - Low byte: 95H = 149 decimal
; - Complete: (7 × 256) + 149 = 1792 + 149 = 1941 ?
;
; Logical Instructions Used:
; - ANL (3 times) - To clear specific bits
; - ORL (3 times) - To set specific bits
; - CLR (1 time)  - To clear accumulator
; Total: 7 logical operations ?
; ========================================================================