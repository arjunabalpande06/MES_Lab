;Q3
;---------------------------------------
; Program 1: Direct Addressing Mode (Visible Output)
;---------------------------------------
ORG 0000H

MOV A, #40H      ; Initialize for demonstration
MOV 30H, A       ; Store 40H at RAM location 30H
MOV 40H, #55H    ; (Optional) another data point

MOV A, 30H       ; Directly load contents of 30H into Accumulator
MOV P1, A        ; Output to Port 1 (for visibility)
MOV 50H, A       ; Also store result in RAM 50H

HERE: SJMP HERE  ; Infinite loop to hold result

END