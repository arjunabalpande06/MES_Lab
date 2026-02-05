;Q 5 )

ORG 0000H

START:
    MOV R0, #40H        ; Source pointer
    MOV R1, #40H        ; Destination pointer

SCAN_LOOP:
    MOV A, @R0          ; Read current byte
    CJNE A, #0FFH, VALID_DATA  ; Check if A != FFH
    SJMP SKIP_STORE      ; If FFH, skip storing

VALID_DATA:
    MOV @R1, A           ; Store valid byte
    INC R1               ; Move destination pointer

SKIP_STORE:
    INC R0                ; Move to next source byte
    CJNE R0, #60H, SCAN_LOOP ; Stop when R0 = 60H

; After compaction, fill remaining with 00H
FILL_ZERO:
    CJNE R1, #60H, FILL_CONT
    SJMP DONE

FILL_CONT:
    MOV @R1, #00H
    INC R1
    SJMP FILL_ZERO

DONE:
    SJMP $

END