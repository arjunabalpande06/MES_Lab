ORG 0000H

LCD_DATA EQU 0A0H   ; Port 2
RS EQU 0B5H         ; P3.5
RW EQU 0B6H         ; P3.6
EN EQU 0B7H         ; P3.7

ACALL INIT
ACALL MSG
SJMP $

INIT:
    MOV A,#38H
    ACALL CMD
    ACALL DELAY

    MOV A,#0EH
    ACALL CMD
    ACALL DELAY

    MOV A,#01H
    ACALL CMD
    ACALL DELAY
    RET

CMD:
    CLR RS
    CLR RW
    MOV LCD_DATA,A
    SETB EN
    ACALL DELAY
    CLR EN
    RET

WRITE:
    SETB RS
    CLR RW
    MOV LCD_DATA,A
    SETB EN
    ACALL DELAY
    CLR EN
    RET

MSG:
    MOV DPTR,#TEXT

NEXT:
    CLR A
    MOVC A,@A+DPTR
    JZ DONE
    ACALL WRITE
    INC DPTR
    SJMP NEXT

DONE:
    RET

DELAY:
    MOV R7,#0FFH
H1: MOV R6,#0FFH
H2: DJNZ R6,H2
    DJNZ R7,H1
    RET

TEXT: DB "MICROCONTROLLER"
      DB 00H
END