; Toggles LED on P1.0 with timer-based delay

ORG 0000H
LJMP MAIN

ORG 0030H
MAIN:
    MOV P1, #00H       ; Initialize P1 (all pins low)
    
LOOP:
    CPL P1.0           ; Toggle P1.0 (LED connected to this pin)
    ACALL DELAY        ; Call delay subroutine
    SJMP LOOP          ; Loop forever

; Timer-based delay subroutine
DELAY:
    MOV TMOD, #01H     ; Set Timer 0 in Mode 1 (16-bit timer)
    MOV TH0, #3CH      ; Load high byte for ~50ms delay
    MOV TL0, #0B0H     ; Load low byte (3CB0H = 15536)
    SETB TR0           ; Start Timer 0
    
WAIT:
    JNB TF0, WAIT      ; Wait until timer overflow
    CLR TR0            ; Stop Timer 0
    CLR TF0            ; Clear overflow flag
    
    
    RET                ; Return from subroutine

END
