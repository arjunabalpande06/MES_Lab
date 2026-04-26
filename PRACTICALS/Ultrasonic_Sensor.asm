MOV TMOD, #01H    ; Timer0 Mode1
CLR TR0

TRIGGER:
    SETB P2.0     ; Trigger HIGH
    ACALL DELAY10
    CLR P2.0      ; Trigger LOW

WAIT_ECHO:
    JNB P2.1, WAIT_ECHO   ; Wait for ECHO HIGH

    SETB TR0              ; Start Timer

STOP:
    JB P2.1, STOP         ; Wait until ECHO goes LOW
    CLR TR0               ; Stop timer

    MOV A, TL0            ; Read timer value
    MOV B, #58
    DIV AB                ; Distance = Time/58 approx

    
    SJMP TRIGGER

DELAY10:
    MOV R7, #30           ; ~10 us delay
D1: DJNZ R7, D1
    RET
END
