MOV P1, #00H        ; Set Port 1 as output (LED OFF)
MOV P2, #0FFH       ; Set Port 2 as input (PIR)

MAIN: 
      JNB P2.0, NO_MOTION   ; If PIR = 0 ? No motion
      SETB P1.0             ; Motion detected ? LED ON
      SJMP MAIN

NO_MOTION:
      CLR P1.0              ; No motion ? LED OFF
      SJMP MAIN

END