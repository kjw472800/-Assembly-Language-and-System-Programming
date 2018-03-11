;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; National Chiao Tung University
; Department Of Computer Science
; 
; Assembly Language and System Programming
; Midterm
; Date: 2015/11/10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Write programs in the Release mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $Student Name:方君安
; $Student ID:0416076
; $Student Email:kjw472800@gmail.com
;
; Instructor Name: Sai-Keung Wong 
;
TITLE Assignment one

include Irvine32.inc
include Macros.inc

.data

menuOP BYTE "1) Show colorful frames",0dh,0ah
		BYTE "2) Sum up signed integers",0dh,0ah
		BYTE "3) Sum up unsigned integers",0dh,0ah
		BYTE "4) Compute sin(x)",0dh,0ah
		BYTE "5) Show student information",0dh,0ah
		BYTE "6) Quit",0dh,0ah,0

selectOP 	BYTE "Please select an option......",0dh,0ah,0
wrongOP 	BYTE "Please select an option between 1 to 6",0dh,0ah,0
OP 		BYTE ?

.code

;
;
;
main PROC

	mov ecx , 1
L0:
	;call Clrscr
	call Crlf
	call Showmenu	 
	call Select
    jmp L0			

main ENDP


Showmenu PROC
	mov edx , OFFSET menuOP
	call WriteString 
	ret 
Showmenu ENDP


Select PROC
	mov edx , OFFSET selectOP
	call WriteString
LookForKey:
	mov  eax,50
	call Delay
	call ReadKey
	jz   LookForKey
	call WriteChar
	

	cmp  al , '1'
	jnz  Option2
	call WriteChar
	call Crlf
	ret
Option2: 
	cmp  al , '2'
	jnz  Option3
	call WriteChar
	call Crlf
	ret
Option3: 
	cmp  al , '3'
	jnz  Option4  
	call WriteChar
	call Crlf
	ret
Option4: 
	cmp  al , '4'
	jnz  Option5 
	call WriteChar
	call Crlf
	ret
Option5: 
	cmp  al , '5'
	jnz  Option6  
	call WriteChar
	call Crlf
	ret
Option6: 
	cmp  al , '6'
	exit
Optiondefault:
	
	mov edx , OFFSET wrongOP
	call WriteString
	call Crlf
	ret
Select ENDP

Colorframe PROC

	ret 
Colorframe ENDP

Sumofsigned PROC

	ret 
Sumofsigned ENDP

Sumofunsigned PROC

	ret 
Sumofunsigned ENDP

Sin PROC

	ret 
Sin ENDP

Showinform PROC

	ret 
Showinform ENDP

Quit PROC

	ret 
Quit ENDP

END main