ORG 0000H


MAIN:
    ACALL READ_ADC
    MOV B, #2
    DIV AB             ; Convert to °C (approx)
    MOV A, B
    ACALL DISPLAY
    SJMP MAIN

;--------- READ ADC -------------
READ_ADC:
    CLR P3.6           ; WR = 0
    SETB P3.6          ; WR = 1 ? Start conversion
WAIT: JB P3.7, WAIT    ; INTR = 0?
    MOV A, P1          ; Read ADC value
    RET

;--------- LCD + Display Routines (Same as Exp 8) ----------
; Display A register value on LCD
DISPLAY:
    MOV R0, A
    MOV A, R0
    ADD A, #30H
    
    RET
END