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
	
question2
	
question3

question4

question5
	
loop   B    loop


       ALIGN      ; make sure the end of this section is aligned
       END        ; end of file
       