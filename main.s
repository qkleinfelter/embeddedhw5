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


	   AREA DATA, READONLY ; Define a data secion
Nums DCD 1,2,3,4,5,6,7,8,9,10 ; define an array with 10 integers
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
	; Converts between 32 bit little and big endian numbers without using REV
	; R0 = only parameter, number to convert
	; R0 = return value, number converted to little/big endian
	MOV R0, #0xABCD
	MOVT R0, #0x6789 ; r0 is our input and is 0x6789ABCD
	MOV R3, #0x0000
	MOVT R3, #0x0000 ; r3 = 0x00000000
	LSL R1, R0, #24 ; Isolate last byte to put it at the beginning of r1, r1 = 0xCD000000
	LSR R2, R0, #24 ; Isolate first byte to put at end of r2, r2 = 0x00000067
	ORR R1, R1, R2 ; r1 = 0xCD000067
	
	MOV R2, #0x00FF
	MOVT R2, #0xFFFF ; r2 = 0xFFFF00FF
	BIC R3, R0, R2 ; r3 = 0x0000AB00
	LSL R3, R3, #8 ; r3 = 0x00AB0000
	ORR R1, R1, R3 ; r1 = 0xCDAB0067
	
	MOV R2, #0xFFFF
	MOVT R2, #0xFF00 ; r2 = 0xFF00FFFF
	BIC R3, R0, R2 ; r3 = 0x00890000
	LSR R3, R3, #8 ; r3 = 0x00008900
	ORR R1, R1, R3 ; r1 = 0xCDAB8967
	MOV R0, R1 ; r0 = 0xCDAB8967
	BX LR
	
question2
	; Reads from an array defined in the data area at the top of the file
	; which contains 10 unsigned ints and calculates the mean
	; Attempts to define the array in a data array but it doesn't work
	; R0 contains the return value which is the mean of the array
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
	; Implements the function f(x) = -1 if x < 0, 0 if x = 0, 1 if x > 0
	; R0 will contain our input x
	; R0 will eventually contain the return value 
	MOV R0, #10 ; If we don't have R0 set before then we do it herre
	CMP R0, #0 ; compare it with 0, which is equivalent to R0 - 0
	BEQ zero ; if the condition flag is equal to 0, branch there
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
	; Finds the minimal value of 3 signed integers, a, b, and c stored in R0, R1, R2
	; Returns the minimum value in R0
	MOV R0, #3 ; example value a = 3
	MOV R1, #4 ; example value b = 4
	MOV R2, #5 ; example value c = 5
	CMP R0, R1 ; a - b
	BLT a_less_than_b ; Branch to a_less_than_b if a is less than b
	BGT a_not_min ; otherwise, a isn't the minimum so we branch out
	BX LR ; redundant, we shouldn't ever reach this but just in case get out
	
a_less_than_b
	CMP R0, R2 ; a - c
	BLT a_min ; Branch to a_min if a is less than c
	BGT a_not_min ; otherwise, a isn't the minimum so we branch out
	BX LR ; redundant, we shouldn't ever reach this but just in case get out
	
a_min
	; R0 is already a so we don't need to do anything except branch back to main
	BX LR
	
a_not_min
	CMP R1, R0 ; b - a
	BLT b_less_than_a ; Branch to b_less_than_a if b is less than a
	BGT b_not_min ; otherwise, b isn't the minimum so we branch out
	BX LR ; redundant, we shouldn't ever reach this but just in case get out
	
b_less_than_a
	CMP R1, R2 ; b - c
	BLT b_min ; Branch to b_min if b is less than c
	BGT b_not_min ; otherwise, b isn't the minimum so we branch out
	BX LR ; redundant, we shouldn't ever reach this but just in case get out
	
b_min
	MOV R0, R1 ; Move R1 into R0 since its the minimum
	BX LR ; go back to main
	
b_not_min
	; We only get into this if a is also not the min, so c must be the min
	MOV R0, R2 ; Move R2 into R0 since its the minimum
	BX LR ; go back to main
	
question5
	; Calculates the value of x (stored in R0) to the power of y (stored in R1)
	; The resulting exponentiated number will be in R0
	MOV R0, #2 ; x is 2
	MOV R1, #3 ; y is 3, so x^y = 8
	MOV R2, R0 ; copy x into R2 so we can multiply by it later
	CMP R0, #1 ; check if the base is 1
	BEQ one_base ; if it is branch out
	CMP R1, #0 ; check if the exponent is 0
	BLT negative_exponent ; branch here if the exponent is negative
	BEQ zero_exponent ; if it is 0 branch out here
	CMP R1, #1 ; check if the exponent is 1
	BEQ one_exponent ; if it is branch out
	B exponentiation_loop ; Loop to multiply it out
	BX LR ; redundant, we shouldn't get here but just in case go to main
	
one_base
	BX LR ; Go back to main because R0 is 1 and 1 to anything is 1
	
zero_exponent
	MOV R0, #1 ; Move 1 into R0 because if the exponent is 0 then the result is 1
	BX LR ; go back to main
	
one_exponent
	BX LR ; go back to main because R0 will contain the correct x^1 value
	
negative_exponent
	MOV R0, #0 ; anything to a negative exponent is between 0 and 1 so we truncate to 0
	BX LR ; go back to main
	
exponentiation_loop
	MUL R0, R2 ; Multiply the value in R0 by R2 (a copy of the base)
	SUBS R1, R1, #1 ; subtract 1 from the exponent and set the flags
	CMP R1, #1 ; check if the exponent is 1
	BEQ one_exponent ; branch to the one exponent case
	B exponentiation_loop ; loop again
	BX LR ; redundant, we shouldn't get here but just in case go to main
	
loop   B    loop


       ALIGN      ; make sure the end of this section is aligned
       END        ; end of file
       