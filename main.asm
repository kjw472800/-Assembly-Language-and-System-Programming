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

ONE	REAL8 1.1
S	REAL8 1.0, 1.0, 100 DUP (?)
 
.code

;
;
;
main PROC
	call GenerateNumbers	; generate numbers
	call PrintResult		; print the result
	call ReadInt			; block the program
	exit
main ENDP

GenerateNumbers PROC
	finit				; initialize the floating point unit (FPU)				
	mov edi, 0			; offset of the first element, 
						; i.e., offset of S(1). Here, n = 1
	mov ecx, 18		; loop counter
L0:
	finit
	fld S[edi]			; load S(n) to FPU
	fld S[edi+8]		; load S(n+1) to FPU
	fadd ST(0), ST(1)	; ST(0) <- S(n+1) + S(n)
	fst S[edi+16]		; S(n+2) <- S(n+1) + S(n)
	add edi, 8			; set edi to the offset of the next element
	loop L0				; ecx <- ecx -1; if ecx !=0, goto L0
	ret					; return to the caller
GenerateNumbers ENDP

PrintResult PROC
	mov edi, 0			; set edi to the offset of the first element
	mov ecx, 18			; print 10 elements
L0:
	finit				; initialize the floating point unit
	fld S[edi]			; load S[edi] (8 bytes) to FPU
	call WriteFloat		; write ST(0)
	call Crlf			; call line feed
	add edi, 8			; set edi to the offset of the next element
	loop L0				; ecx <- ecx -1; if ecx > 0, goto L0
	ret					; return to the caller
PrintResult ENDP

END main