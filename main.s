;*******************************************************************
; main.s
; Author: Quinn Kleinfelter
; Date Created: 10/5/2020
; Last Modified: 10/5/2020
; Section Number: 001/003
; Instructor: Devinder Kaur / Suba Sah
; Homework Number: 5
;   Brief description of the program
;
;*******************************************************************



       AREA    |.text|, CODE, READONLY, ALIGN=2
       THUMB
       EXPORT  Start
Start

main
	BL question1
	BL question2
	BL question3
	BL question4
	BL question5
	B loop

question1
	MOV r0, #0xABCD
	MOVT r0, #0x6789 ; r0 is our input and is 0x6789ABCD
	MOV r3, #0x0000
	MOVT r3, #0x0000 ; r3 = 0x00000000
	LSL r1, r0, #24 ; Isolate last byte to put it at the beginning of r1, r1 = 0xCD000000
	LSR r2, r0, #24 ; Isolate first byte to put at end of r2, r2 = 0x00000067
	ORR r1, r1, r2 ; r1 = 0xCD000067
	
	MOV r2, #0x00FF
	MOVT r2, #0xFFFF ; r2 = 0xFFFF00FF
	BIC r3, r0, r2 ; r3 = 0x0000AB00
	LSL r3, r3, #8 ; r3 = 0x00AB0000
	ORR r1, r1, r3 ; r1 = 0xCDAB0067
	
	MOV r2, #0xFFFF
	MOVT r2, #0xFF00 ; r2 = 0xFF00FFFF
	BIC r3, r0, r2 ; r3 = 0x00890000
	LSR r3, r3, #8 ; r3 = 0x00008900
	ORR r1, r1, r3 ; r1 = 0xCDAB8967
	MOV r0, r1 ; r0 = 0xCDAB8967
	BX LR
	
question2
	;AREA Data
Nums DCD 1,2,3,4,5,6,7,8,9,10
	;AREA |.text|
	LDR R0, =Nums
	MOV R1, #0 ; ofs = 0
	MOV R3, #0 ; sum = 0
sumLoop LDR R2, [R0, R1] ; Nums[i]
	ADD R3, R3, R2 ; sum
	ADD R1, R1, #4 ; ofs += 4
	CMP R1, #40 ; ofs <= 40?
	BLO sumLoop
	MOV R1, #10
	UDIV R0, R3, R1
	BX LR
	
question3
	; R0 will contain our input x
	MOV R0, #-10 ; If we don't have R0 set before then we do it herre
	CBZ R0, zero
	CMP R0, #0 ; compare it with 0, which is equivalent to R0 - 0
	BLT negative ; If the condition flag indicates we are less than 0, branch there
	; if we reach this point we aren't 0 or less than 0 so set R0 to 1 and go back to main
	MOV R0, #1
	BX LR
	
zero
	BX LR ; if we branch into this section, then R0 = 0, and R0 is our result so we just go back to main
	
negative
	MOV R0, #-1 ; set R0 to -1 and go back to main
	BX LR

question4

question5
	
loop   B    loop


       ALIGN      ; make sure the end of this section is aligned
       END        ; end of file
       