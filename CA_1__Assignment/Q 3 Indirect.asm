;Q 3 )
;---------------------------------------
; Program 2: Indirect Addressing Mode
;---------------------------------------
ORG 0000H
MOV R0, #30H    ; Load base address 30H into R0
MOV A, @R0      ; A = contents of address stored in R0 (i.e., contents of 30H)
MOV R1, A       ; R1 = 40H (contents of 30H)
MOV A, @R1      ; A = contents of address 40H (i.e., 55H)
MOV 50H, A      ; Store final result in 50H
END
