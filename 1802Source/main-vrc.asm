;HRJ A18 wants register names defined...

R0		EQU	0
R1		EQU	1
R2		EQU	2
R3		EQU	3
R4		EQU	4
R5		EQU	5
R6		EQU	6
R7		EQU	7
R8		EQU	8
R9		EQU	9
R10		EQU	10
R11		EQU	11
R12		EQU	12
R13		EQU	13
R14		EQU	14
R15		EQU	15

; Maybe use Q to invert bg?
; default pcntr: R0
; push buff pcntr: R1
; update subroutine pcntr: R2
; curr letter idx: R3.0; curr offset: R3.1
; curr letter pixels: R4, R5, R6, R7
; X: R8
; R9, R10 used for a cool effect
; R11, R12, R13, R14 used in PUSH_BUFF
; R15 used in UPDATE_DISP

fontLen          EQU 616
letterCnt        EQU 77

buffStart        EQU 34767

START		ORG 00h
			
			DIS
			db 0
			
			LDI high(34815) ; Fill memory with 0s to begin with
			PHI R4
			LDI low(34815)
			PLO R4
			SEX R4
			LDI 0
			PHI R3
			PLO R5
			PHI R5
FILL_LOOP
			GHI R3
			STXD
			INC R5
			GLO R5
			SMI low(2047)
			BNZ FILL_LOOP
			GHI R5
			SMI high(2047)
			BNZ FILL_LOOP

			LDI high(PUSH_BUFF)
			PHI R1
			LDI low(PUSH_BUFF)
			PLO R1
			SEX R8
			SEP R1 ; Push the empty buffer initially
			; Some fancy-looking stuff
			LDI 0
			PLO R9
			LDI low(FONT_ROM + 7)
			PLO R10
			LDI high(FONT_ROM + 7)
			PHI R10
INIT_LOOP
			LDI low(buffStart)
			PLO R8
			LDI high(buffStart)
			PHI R8
			LDI 0
			PLO R14
INIT_LOOP_PUT
			LDN R10
			DEC R10
			STR R8
			INC R8
			STR R8
			INC R8
			STR R8
			INC R8
			STR R8
			INC R8
			
			INC R14
			GLO R14
			SMI 8
			BNZ INIT_LOOP_PUT
			GLO R10
			ADI 16
			PLO R10
			GHI R10
			ADCI 0
			PHI R10
			
			SEP R1
			LDI 128
			PLO R14
DELAY_LOOP
			DEC R14
			GLO R14
			BNZ DELAY_LOOP
			INC R9
			GLO R9
			SMI letterCnt
			BNZ INIT_LOOP
			
			LDI 0
			LDI low(buffStart + 31)
			PLO R8
			LDI high(buffStart + 31)
			PHI R8
			LDI 8
			PLO R9
CLEAR_BUFF_LOOP
			LDI 0
			STXD
			STXD
			STXD
			STXD
			
			DEC R9
			GLO R9
			BNZ CLEAR_BUFF_LOOP
			SEP R1
			
			LDI 1
			PLO R9
			LDI 128
			PHI R10
			LDI 0
			PHI R9
			PLO R10

			; Load the first letter
			LDI 0
 			PLO R3
 			LDI 5
 			PHI R3
 			LBR LOAD_LETTER
LOOP
			NOP
UPDATE_DISP
			; Shift buffer over to the left by one pixel
			LDI 8
			PLO R14
			LDI low(buffStart)
			PLO R8
			LDI high(buffStart)
			PHI R8
SHIFT_LOOP
			LDN R8
			SHR
			STR R8
			INC R8
			
			LDN R8
			SHRC
			STR R8
			INC R8
			
			LDN R8
			SHRC
			STR R8
			INC R8
			
			LDN R8
			SHRC
			STR R8
			INC R8
			
			DEC R14
			GLO R14
			BNZ SHIFT_LOOP
			
			; Put next column from current letter
			LDI low(buffStart + 28)
			PLO R8
			
			GLO R4
			SHR
			PLO R4
			SHRC
			ANI 128
			OR
			STR R8
			GLO R8
			SMI 4
			PLO R8
			
			GHI R4
			SHR
			PHI R4
			SHRC
			ANI 128
			OR
			STR R8
			GLO R8
			SMI 4
			PLO R8
			
			GLO R5
			SHR
			PLO R5
			SHRC
			ANI 128
			OR
			STR R8
			GLO R8
			SMI 4
			PLO R8
			
			GHI R5
			SHR
			PHI R5
			SHRC
			ANI 128
			OR
			STR R8
			GLO R8
			SMI 4
			PLO R8
			
			GLO R6
			SHR
			PLO R6
			SHRC
			ANI 128
			OR
			STR R8
			GLO R8
			SMI 4
			PLO R8
			
			GHI R6
			SHR
			PHI R6
			SHRC
			ANI 128
			OR
			STR R8
			GLO R8
			SMI 4
			PLO R8
			
			GLO R7
			SHR
			PLO R7
			SHRC
			ANI 128
			OR
			STR R8
			GLO R8
			SMI 4
			PLO R8
			
			GHI R7
			SHR
			PHI R7
			SHRC
			ANI 128
			OR
			STR R8
			
			; Mess with these registers. Has no purpose other then look cool in a register value visualizer.
			GLO R2
			LBZ REG_D_2
			GLO R9
			SHL
			PLO R9
			GHI R9
			SHLC
			PHI R9
			LDI 0
			ADCI 0

			GHI R10
			SHR
			PHI R10
			GLO R10
			SHRC
			PLO R10
			LDI 0
			ADCI 0
			BZ LOAD_LETTER
			LDI 64
			PHI R9
			LDI 2
			PLO R10
			LDI 0
			PLO R2
			BR LOAD_LETTER
REG_D_2
			GLO R10
			SHL
			PLO R10
			GHI R10
			SHLC
			PHI R10
			LDI 0
			ADCI 0

			GHI R9
			SHR
			PHI R9
			GLO R9
			SHRC
			PLO R9
			LDI 0
			ADCI 0
			BZ LOAD_LETTER
			LDI 64
			PHI R10
			LDI 2
			PLO R9
			PLO R2
LOAD_LETTER
			; Check if next letter needs to be loaded
			GHI R3
			ADI 1
			PHI R3
			SMI 6
			LBNZ SKIP_LOAD
			LDI 0
			PHI R3
			
			; Also check if the text needs to be wrapped
			INC R3
			GLO R3
			PLO R8
			LDI high(SIGN_TEXT)
			PHI R8
			LDN R8
			SMI 128
			BNZ NO_TEXT_WRAP
			PLO R3
			BNQ Q_NOT_SET
			REQ
			SKP
Q_NOT_SET
			SEQ
Q_ENDIF
NO_TEXT_WRAP
			; Actually load the next letter
			LDN R8
			; Set letter index to 0 if it is out of range
			SDI (letterCnt - 1)
			LDN R8
			LSDF
			LDI 0
			NOP
			; Multiply by 8 to get actual index
			; Use leftshifts for this
			SHL
			SHL
			PLO R15
			LDI 0
			SHLC
			PHI R15
			GLO R15
			SHL
			PLO R15
			GHI R15
			SHLC
			PHI R15
			
			; Add index onto address of font array
			GLO R15
			ADI low(FONT_ROM)
			PLO R15
			GHI R15
			ADCI high(FONT_ROM)
			PHI R15
			; Load letter pixel data from address
			SEX R15
			LDXA
			PLO R4
			LDXA
			PHI R4
			LDXA
			PLO R5
			LDXA
			PHI R5
			LDXA
			PLO R6
			LDXA
			PHI R6
			LDXA
			PLO R7
			LDXA
			PHI R7
			SEX R8
SKIP_LOAD
			SEP R1
			LBR LOOP
			
PUSH_BUFF
			LDI 8
			PHI R13
			LDI 0
			PLO R12
			
			LDI 1
			PLO R11
			LDI high(buffStart + 31)
			PHI R14
			LDI low(buffStart + 31)
			PLO R14
ROW_LOOP
			; Clear row select
			LDI 8
			PHI R12
			LDI 0
			STR R12
			PLO R13
DRAW_LOOP
			GHI R12
			ADI 8
			PHI R12
			
			LDN R14
			SDI 255
			STR R12
			DEC R14
			
			INC R13
			GLO R13
			SDI 4
			BNZ DRAW_LOOP
			
			LDI 8                        ; Enable drawn row
			PHI R12
			GLO R11
			STR R12
			SHL
			PLO R11
			
			INC R12
			GHI R13
			SMI 1
			PHI R13
			BNZ ROW_LOOP
			
			SEP R0
			LBR PUSH_BUFF

			ORG 0200h
SIGN_TEXT
			db 0, 20, 34, 41, 38, 35, 40, 0, 66, 0, 19, 41, 32, 46, 49, 27, 44, 31, 0, 30, 31, 48, 31, 38, 41, 42, 31, 44, 64, 0, 19, 42, 27, 29, 31, 0, 14, 31, 44, 30, 64, 0, 22, 18, 3, 0, 23, 41, 44, 38, 30, 0, 4, 31, 48, 0, 0, 0, 0, 34, 46, 46, 42, 45, 70, 71, 71, 46, 34, 41, 38, 35, 40, 63, 30, 31, 48, 71, 0, 0, 0, 0, 20, 34, 41, 38, 35, 40, 76, 60, 58, 58, 62, 0, 0, 0, 128
			ORG 0300h
FONT_ROM
;  
			db 0
			db 0
			db 0
			db 0
			db 0
			db 0
			db 0
			db 0
; A
			db 14
			db 17
			db 17
			db 17
			db 31
			db 17
			db 17
			db 17
; B
			db 15
			db 17
			db 17
			db 15
			db 17
			db 17
			db 17
			db 15
; C
			db 14
			db 1
			db 1
			db 1
			db 1
			db 1
			db 1
			db 14
; D
			db 15
			db 17
			db 17
			db 17
			db 17
			db 17
			db 17
			db 15
; E
			db 31
			db 1
			db 1
			db 31
			db 1
			db 1
			db 1
			db 31
; F
			db 31
			db 1
			db 1
			db 31
			db 1
			db 1
			db 1
			db 1
; G
			db 14
			db 17
			db 17
			db 1
			db 29
			db 17
			db 17
			db 14
; H
			db 17
			db 17
			db 17
			db 31
			db 17
			db 17
			db 17
			db 17
; I
			db 4
			db 4
			db 4
			db 4
			db 4
			db 4
			db 4
			db 4
; J
			db 8
			db 8
			db 8
			db 8
			db 8
			db 8
			db 10
			db 4
; K
			db 17
			db 9
			db 5
			db 3
			db 3
			db 5
			db 9
			db 17
; L
			db 1
			db 1
			db 1
			db 1
			db 1
			db 1
			db 1
			db 15
; M
			db 17
			db 27
			db 21
			db 17
			db 17
			db 17
			db 17
			db 17
; N
			db 17
			db 17
			db 19
			db 21
			db 25
			db 17
			db 17
			db 17
; O
			db 14
			db 17
			db 17
			db 17
			db 17
			db 17
			db 17
			db 14
; P
			db 15
			db 17
			db 17
			db 15
			db 1
			db 1
			db 1
			db 1
; Q
			db 14
			db 17
			db 17
			db 17
			db 17
			db 21
			db 25
			db 30
; R
			db 15
			db 17
			db 17
			db 15
			db 17
			db 17
			db 17
			db 17
; S
			db 14
			db 17
			db 1
			db 14
			db 16
			db 16
			db 17
			db 14
; T
			db 31
			db 4
			db 4
			db 4
			db 4
			db 4
			db 4
			db 4
; U
			db 17
			db 17
			db 17
			db 17
			db 17
			db 17
			db 17
			db 14
; V
			db 17
			db 17
			db 17
			db 17
			db 17
			db 17
			db 10
			db 4
; W
			db 17
			db 17
			db 17
			db 17
			db 17
			db 21
			db 27
			db 17
; X
			db 17
			db 17
			db 17
			db 10
			db 4
			db 10
			db 17
			db 17
; Y
			db 17
			db 17
			db 17
			db 10
			db 4
			db 4
			db 4
			db 4
; Z
			db 31
			db 16
			db 8
			db 4
			db 4
			db 2
			db 1
			db 31
; a
			db 0
			db 0
			db 0
			db 14
			db 16
			db 30
			db 17
			db 30
; b
			db 1
			db 1
			db 1
			db 1
			db 13
			db 19
			db 17
			db 15
; c
			db 0
			db 0
			db 0
			db 14
			db 1
			db 1
			db 1
			db 14
; d
			db 16
			db 16
			db 16
			db 22
			db 25
			db 17
			db 17
			db 30
; e
			db 0
			db 0
			db 0
			db 14
			db 17
			db 31
			db 1
			db 14
; f
			db 12
			db 18
			db 2
			db 2
			db 7
			db 2
			db 2
			db 2
; g
			db 0
			db 0
			db 0
			db 30
			db 17
			db 30
			db 16
			db 14
; h
			db 0
			db 1
			db 1
			db 1
			db 13
			db 19
			db 17
			db 17
; i
			db 0
			db 4
			db 0
			db 6
			db 4
			db 4
			db 4
			db 14
; j
			db 0
			db 8
			db 0
			db 12
			db 8
			db 8
			db 10
			db 4
; k
			db 0
			db 1
			db 1
			db 9
			db 5
			db 3
			db 5
			db 9
; l
			db 0
			db 6
			db 4
			db 4
			db 4
			db 4
			db 4
			db 14
; m
			db 0
			db 0
			db 0
			db 0
			db 11
			db 21
			db 21
			db 17
; n
			db 0
			db 0
			db 0
			db 13
			db 19
			db 17
			db 17
			db 17
; o
			db 0
			db 0
			db 0
			db 14
			db 17
			db 17
			db 17
			db 14
; p
			db 0
			db 0
			db 0
			db 15
			db 17
			db 15
			db 1
			db 1
; q
			db 0
			db 0
			db 0
			db 22
			db 25
			db 22
			db 16
			db 16
; r
			db 0
			db 0
			db 0
			db 13
			db 19
			db 1
			db 1
			db 1
; s
			db 0
			db 0
			db 0
			db 14
			db 1
			db 14
			db 16
			db 15
; t
			db 0
			db 2
			db 2
			db 7
			db 2
			db 2
			db 18
			db 12
; u
			db 0
			db 0
			db 0
			db 17
			db 17
			db 17
			db 25
			db 22
; v
			db 0
			db 0
			db 0
			db 17
			db 17
			db 17
			db 10
			db 4
; w
			db 0
			db 0
			db 0
			db 17
			db 17
			db 21
			db 21
			db 10
; x
			db 0
			db 0
			db 0
			db 17
			db 10
			db 4
			db 10
			db 17
; y
			db 0
			db 0
			db 0
			db 17
			db 17
			db 30
			db 16
			db 14
; z
			db 0
			db 0
			db 0
			db 31
			db 8
			db 4
			db 2
			db 31
; 0
			db 14
			db 17
			db 25
			db 21
			db 21
			db 19
			db 17
			db 14
; 1
			db 24
			db 20
			db 16
			db 16
			db 16
			db 16
			db 16
			db 16
; 2
			db 14
			db 17
			db 16
			db 8
			db 4
			db 2
			db 1
			db 31
; 3
			db 14
			db 17
			db 16
			db 14
			db 16
			db 16
			db 17
			db 14
; 4
			db 24
			db 20
			db 18
			db 17
			db 31
			db 16
			db 16
			db 16
; 5
			db 31
			db 1
			db 1
			db 14
			db 16
			db 16
			db 17
			db 14
; 6
			db 14
			db 17
			db 1
			db 15
			db 17
			db 17
			db 17
			db 14
; 7
			db 31
			db 16
			db 16
			db 8
			db 4
			db 4
			db 4
			db 4
; 8
			db 14
			db 17
			db 17
			db 14
			db 17
			db 17
			db 17
			db 14
; 9
			db 14
			db 17
			db 17
			db 30
			db 16
			db 16
			db 17
			db 14
; .
			db 0
			db 0
			db 0
			db 0
			db 0
			db 0
			db 0
			db 4
; ,
			db 0
			db 0
			db 0
			db 0
			db 0
			db 4
			db 4
			db 4
; +
			db 0
			db 4
			db 4
			db 31
			db 4
			db 4
			db 0
			db 0
; -
			db 0
			db 0
			db 0
			db 14
			db 0
			db 0
			db 0
			db 0
; ?
			db 14
			db 17
			db 16
			db 8
			db 4
			db 4
			db 0
			db 4
; !
			db 4
			db 4
			db 4
			db 4
			db 4
			db 4
			db 0
			db 4
; @
			db 14
			db 17
			db 16
			db 16
			db 22
			db 21
			db 21
			db 14
; :
			db 0
			db 4
			db 0
			db 0
			db 0
			db 0
			db 4
			db 0
; /
			db 0
			db 0
			db 16
			db 8
			db 4
			db 2
			db 1
			db 0
; _
			db 0
			db 0
			db 0
			db 0
			db 0
			db 0
			db 0
			db 31
; *
			db 0
			db 4
			db 21
			db 14
			db 21
			db 4
			db 0
			db 0
; (
			db 4
			db 2
			db 1
			db 1
			db 1
			db 1
			db 2
			db 4
; )
			db 4
			db 8
			db 16
			db 16
			db 16
			db 16
			db 8
			db 4
; #
			db 10
			db 10
			db 31
			db 10
			db 10
			db 31
			db 10
			db 10
			END
