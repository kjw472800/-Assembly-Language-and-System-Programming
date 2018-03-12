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

menuOP BYTE "1) Show colorful frames",0dh,0ah,
		"2) Sum up signed integers",0dh,0ah,
		"3) Sum up unsigned integers",0dh,0ah,
		"4) Compute sin(x)",0dh,0ah,
		"5) Show student information",0dh,0ah,
		"6) Quit",0dh,0ah,0

selectOP 	BYTE "Please select an option......",0dh,0ah,0
wrongOP 	BYTE "Please select an option between 1 to 6",0dh,0ah,0
OP 		BYTE ?


noticeOP2 BYTE "Input the number of signed integers ...  ",0
noticeOP3 BYTE "Input the number of unsigned integers ...  ",0

inform BYTE "Student Name:Jyunan Fang",0dh,0ah,
			"Student ID:0416076",0dh,0ah,
			"Student Email:kjw472800@gmail.com",0dh,0ah,0

pressany BYTE "press ENTER to back to menu",0dh,0ah,0

inputx BYTE "input a floating number x ... ",0
inputn BYTE "input the number of terms n ... ",0

expx  REAL8 ?
factorial REAL8 ?
term  REAL8 ?
.code

;
;
;
main PROC

	mov ecx , 1
L0:
	call Clrscr
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
	call Sumofsigned
	ret
Option3: 
	cmp  al , '3'
	jnz  Option4  
	call Sumofunsigned
	ret
Option4: 
	cmp  al , '4'
	jnz  Option5 
	call Sin
	ret
Option5: 
	cmp  al , '5'
	jnz  Option6  
	call Showinform
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
	push eax
	push ecx

	push ecx
	pop eax
	ret 
Colorframe ENDP

Sumofsigned PROC
	push eax
	push ecx
	push edx 

	mov edx , OFFSET noticeOP2
	call WriteString 

	call  ReadInt
	
	mov   ecx , eax
	mov   edx , 0
Soslabel:
	call ReadInt
	add  edx , eax
	loop Soslabel
	mov  eax , edx
	call WriteInt

	mov  edx , OFFSET pressany
	call WriteString
	call ReadInt

	pop edx
	pop ecx
	pop eax
	ret 
Sumofsigned ENDP

Sumofunsigned PROC
	push eax
	push ecx
	push edx 

	mov edx , OFFSET noticeOP3
	call WriteString 

	call  ReadInt
	
	mov   ecx , eax
	mov   edx , 0
Souslabel:
	call ReadDec
	add  edx , eax
	loop Souslabel
	mov  eax , edx
	call WriteDec

	mov  edx , OFFSET pressany
	call WriteString
	call ReadInt

	pop edx
	pop ecx
	pop eax
	ret 
Sumofunsigned ENDP

Sin PROC
	push eax
	push ecx
	push edx 

	mov edx , OFFSET inputx
	call WriteString
	call ReadFloat
	mov edx , OFFSET inputn
	call WriteString
	call ReadDec
	mov  ecx , eax
	mov  ebx , 1
Sinloop:

	inc ebx
	mov eax , ebx
	call WriteDec
plus:
	
minus:

	cmp ebx , ecx
	jz Sinloop



	mov  edx , OFFSET pressany
	call WriteString
	call ReadInt


	pop edx
	pop ecx
	pop eax
	ret 
Sin ENDP

Showinform PROC
	push edx 

	mov edx , OFFSET inform
	call WriteString 
	call Crlf

	mov  edx , OFFSET pressany
	call WriteString
	call ReadInt

	pop edx
	ret 
Showinform ENDP

END main