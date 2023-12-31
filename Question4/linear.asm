; Linear Search with User Input

.MODEL SMALL
.STACK
.386
.DATA

ARRAY DB 9 DUP(?)
MESS01 DB 13,10,"MAX. NO. OF ELEMENTS IN ARRAY IS 9 $" 
MESS02 DB 13,10,"  $"
MESS1 DB 13,10,"ENTER THE NUMBER OF ELEMENTS: $"
MESS0 DB 13,10,"ENTER THE NUMBER: $"
MESS2 DB 13,10,"ENTER THE ELEMENT TO BE SEARCHED: $"
MESS3 DB 13,10,"VALUE FOUND AT LOCATION - $"
MESS4 DB 13,10,"VALUE NOT FOUND!!!$"
ErrMess DB 13,10,"ERROR IN INPUT DIGIT$"

DAT DB ?
number dw ?
POS DW ?

.CODE
.STARTUP

    MOV DX, OFFSET MESS01
    MOV AH, 09
    INT 21H

    MOV DX, OFFSET MESS02
    MOV AH, 09
    INT 21H

    MOV DX,OFFSET MESS1
    MOV AH, 09
    INT 21H

    MOV AH, 01
    INT 21H
    CMP al,39h
    JBE abc

    MOV DX, OFFSET ErrMess
    MOV AH, 09
    INT 21H

    JMP myexit

    abc: AND AL, 0FH

    MOV AH, 0
    MOV number, AX
    MOV CX, AX  ; SET COUNTER AL TIMES
    MOV DI, 0

; INPUT ELEMENTS IN ARRAY

    MYLOOP:     
    MOV DX, OFFSET MESS0
    MOV AH, 09
    INT 21H

    ; Tens digit

    MOV AH, 01
    INT 21H
    CMP AL, 39H
    JBE abc2

    MOV DX, OFFSET ErrMess
    MOV AH,09
    INT 21H
    JMP myexit

    abc2: AND al,0fh
    SHL AL, 4
    MOV BL, AL

    ; Units digit

    MOV AH,01
    INT 21H
    cmp al,39h
    jbe abcx

    MOV DX,OFFSET ErrMess
    MOV AH,09
    INT 21H
    jmp myexit

    abcx:
    AND al,0fh
    ADD al, bl
    MOV ARRAY[DI], AL
    INC DI
    LOOP MYLOOP

;INPUT ELEMENT TO BE SEARCHED

    MOV DX,OFFSET MESS2
    MOV AH,09
    INT 21H

    ; Tens digit

    MOV AH,01
    INT 21H
    cmp al,39h
    jbe abcl

    MOV DX,OFFSET ErrMess
    MOV AH,09
    INT 21H
    jmp myexit

    abcl:
    and al,0fh
    shl al,4
    mov bl,al

    ; Units digit

    MOV AH,01
    INT 21H
    cmp al,39h
    jbe abcm

    MOV DX,OFFSET ErrMess
    MOV AH,09
    INT 21H
    jmp myexit

    abcm:
    and al,0fh
    add al,bl
    mov DAT,AL

; SEARCH PROCESS

    MOV AX, DS
    MOV ES, AX

    MOV AL, DAT
    CLD ; Auto-Increment Mode
    MOV CX, number
    MOV DI, OFFSET ARRAY
    REPNE SCASB

    CMP CX, 0
    JE NOTFOUND

    MOV DX, OFFSET MESS02
    MOV AH, 09
    INT 21H

    MOV DX, OFFSET MESS3
    MOV AH,09
    INT 21H

    SUB NUMBER, CX
    ADD NUMBER,30H

    MOV DX, NUMBER
    MOV AH, 02
    INT 21H
    JMP myexit

    NOTFOUND:
    MOV DX,OFFSET MESS4
    MOV AH,09
    INT 21H

    myexit:
    MOV DX, OFFSET MESS02
    MOV AH, 09
    INT 21H
.EXIT
END