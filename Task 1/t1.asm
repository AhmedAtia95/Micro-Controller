$NOMOD51 ;to suppress the pre-defined addresses by keil
$include (C8051F020.h) ; to declare the device peripherals with it's addresses
ORG 0H ; to start writing the code from the base 0
MOV WDTCN,#11011110B ;0DEH
MOV WDTCN,#10101101B ;0ADH
; config of clock
; we configure the clock to the minimum frequency to make it easer to reach the 2Hz frequency.
MOV OSCICN , #14H ; 2MHz clock
;config cross bar
MOV XBR0 , #00H
MOV XBR1 , #00H
MOV XBR2 , #040H ; Cross bar enabled , weak Pull-up enabled
;config for port P5 the upper half to be push-pull to light the leds
MOV A , P74OUT
ORL A , #00001000B ; you can also write this directly without and operation, as you do not make any thing else.
MOV P74OUT , A
MOV P5,#83H
BLINK:
	READSW: MOV A,P5
	RRC A
	JC NXT
	ORL P5,#10000000
	LCALL DELAY
	ANL P5,#01111111
	LCALL DELAY
	ORL P5,#10000000
	SJMP READSW
	NXT: RRC A
	JC READSW
	ORL P5,#10000000
	LCALL DELAY1
	ANL P5,#01111111
	LCALL DELAY1
	ORL P5,#10000000
//	SJMP READSW
	SJMP BLINK
RET
 // first push button delay (1 Sec)
DELAY :
	MOV R2,#4
	LOOP3:MOV R1,#250
	LOOP2:MOV R0,#250 ;
	LOOP1:DJNZ R0,LOOP1
	DJNZ R1,LOOP2
	DJNZ R2,LOOP3
	RET

 // Second push button delay (4 Sec)

DELAY1: MOV R0,#250D //8seconds
LABEL: ACALL DELAY
       ACALL DELAY
ACALL DELAY
       ACALL DELAY
       RET