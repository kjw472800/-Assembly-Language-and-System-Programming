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

 
.code

;
;
;
main PROC
	call Showmenu	 
	call Select
	call ReadInt			; block the program
	exit
main ENDP


Showmenu PROC
	mov edx , OFFSET menuOP
	call WriteString 
	ret 
Showmenu ENDP

Select PROC
	mov edx , OFFSET selectOP
	call WriteString
	call Readkey
	call Write
	ret
Select ENDP


END main