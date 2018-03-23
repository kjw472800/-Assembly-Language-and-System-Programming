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


noticeOP2 BYTE 0dh,0ah,"Input the number of signed integers ...  ",0
noticeOP3 BYTE 0dh,0ah,"Input the number of unsigned integers ...  ",0

inform BYTE "Student Name:Jyunan Fang",0dh,0ah,
			"Student ID:0416076",0dh,0ah,
			"Student Email:kjw472800@gmail.com",0dh,0ah,0

pressany BYTE 0dh,0ah,"press ENTER to back to menu",0dh,0ah,0

inputx BYTE 0dh,0ah,"input a floating number x ... ",0
inputn BYTE 0dh,0ah,"input the number of terms n ... ",0
sumis  BYTE "sum is ",0
sinxis  BYTE "sin(x) is ",0


n     REAL8 1.0
x     REAL8 ?
powx  REAL8 ?
factorial REAL8 1.0
term  REAL8 ?
signed SDWORD -1


row  WORD ?
col  WORD ?
len SDWORD ?
color DWORD black
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
	mov edx , OFFSET selectOP
	call WriteString 
	ret 
Showmenu ENDP


Select PROC

LookForKey:
	mov  eax,50			;sleep, to allow OS to time slice
	call Delay			
	call ReadKey		
	jz   LookForKey		;no key pressed

	cmp  al , '1'		
	jnz  Option2
	call Colorframe		
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;goal: draw color frames
;parm: nothing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Colorframe PROC
	push eax
	push ebx
	push ecx
	push edx
	call Clrscr
	mov eax , 80		;length of height
	mov ebx , 23		;length of width
	mov dh , 0			;the position y to start
	mov dl , 0 			;the position x to start
	mov ch , 0 			;as vector y
	mov cl , 0 			;as vector x
	
drawframe:


	
	call choosecolor
    mov len , eax		
	mov ch , 0
	mov cl , 1
	call drawline
	mov len , ebx
	mov ch , 1
	mov cl , 0
	call drawline
	mov len , eax
	mov ch , 0
	mov cl , -1
	call drawline
	mov len , ebx
	mov ch , -1
	mov cl , 0
	call drawline

	inc dl				;(0,0) -> (1,1) -> ....
	inc dh				;from outside to inside
	sub eax , 2			;how long to draw is decrease by 2
	sub ebx , 2			;
	cmp ebx , -1		;
	jnz drawframe
	

	
	
	mov eax , white + black*16
	call SetTextColor
	call ReadInt		;block
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret 
Colorframe ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;goal: to choose random color and avoid the same color 
;parm: nothing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

choosecolor PROC
	push eax
	push ebx
	push ecx
	push edx

again:
	mov eax ,16
	call RandomRange
	cmp eax , black			;can't be black
	jz again
	cmp eax , color			;can't be same as the last one
	jz again
	mov color , eax			;store for the next frame
	shl al , 4
	call SetTextColor

	mov  eax , 500
	call Delay

	pop edx
	pop ecx
	pop ebx
	pop eax
	ret	
choosecolor ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;goal: to draw one line based on its length ,vector from orignal position 
;parm: (dl,dh) ->postion to start
;      (cl,ch) ->vector
;      len     ->length to draw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
drawline PROC
	push eax
	push ebx
	
	;call Clrscr
	;mov  eax , white+yellow*16
	;call SetTextColor

	mov  ebx , len
draw:
	dec  ebx
	cmp  ebx , 0
	jz  drawout 
	call Gotoxy
	mov  al , ' '
	call WriteChar

	add dh ,ch
	add dl ,cl
	jmp draw
drawout:
	
	pop  ebx
	pop  eax
	ret
drawline ENDP



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;goal: to sum up the specific number of integer
;parm: nothing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	mov  edx , OFFSET sumis
	call WriteString
	call WriteInt

	mov  edx , OFFSET pressany
	call WriteString
	call ReadInt

	pop edx
	pop ecx
	pop eax
	ret 
Sumofsigned ENDP



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;goal: to sum up the specific number of unsigned integer
;parm: nothing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	mov  edx , OFFSET sumis
	call WriteString
	call WriteDec

	mov  edx , OFFSET pressany
	call WriteString
	call ReadInt

	pop edx
	pop ecx
	pop eax
	ret 
Sumofunsigned ENDP




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;goal: to calculate sin(x)
;parm: nothing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Sin PROC
	finit
	push eax
	push ecx
	push edx 

	mov edx , OFFSET inputx
	call WriteString
	call ReadFloat
	fst  x
	fst  powx

	mov edx , OFFSET inputn
	call WriteString
	call ReadDec

	mov  ecx , eax
	mov  ebx , 1

								; ecx as object 
								; ebx as iterative

Sinloop:

	
	fld  powx					;push powx to stack
	fld  x						;push x to stack
	fmul st(1) , st(0)			;x -> x^3 -> x^5 ......
	fmulp st(1) , st(0)			;pop x
	fst  powx					
	fld  factorial				;push n!
	fld  n										
	fld1						
	fadd						;n+1
	fmul st(1) ,st(0)			;n!*n+1 = (n+1)!
	fld1						;
	fadd						;n+2
	fmul st(1) ,st(0)			;(n+1)!*(n+2)=(n+2)!
	fstp n						;update n
	fst factorial				;1! -> 3! -> 5! .....
	fdiv 					
	fimul signed 				
	fadd
	neg signed					;-1^n -1 1 -1 1


	inc ebx
	cmp ebx , ecx
	jnz Sinloop


	mov  edx , OFFSET sinxis
	call WriteString
	call WriteFloat
	call Crlf

	fld1						;to initial variable
	fstp  factorial
	fld1						;to initial variable
	fstp  n
	mov  signed , -1			;to initial variable

	mov  edx , OFFSET pressany
	call WriteString
	call ReadInt


	pop edx
	pop ecx
	pop eax
	ret 
Sin ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;goal: to Showinform
;parm: nothing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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