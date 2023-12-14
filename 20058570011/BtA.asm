.model small            ;model small tells the assembler that you intend to use the small memory model - one 
    ;code segment, one data segment and one stack segment
.data                                  ;Start of the data segment
    INPUT DB 10,13 , 'ENTER BINARY NO: $'        ;  $ -> end of string, 10 -> Line Feed, ;13 -> Carriage Return
OUTPUT DB 10,13, 'THE ASCII CHARACTER IS:$'
ARR DB ?            ;Define a variable ARR with an uncertain default value
.code                           ;Defines start of Code Segment
.startup                            ;Indicates startup code. Startup Code is a small block of assembly language code that 
;prepares the way for the execution of software written in a high-level language
MOV AH,09                       ;Display a character string
MOV DX,OFFSET INPUT        ;Puts the offset of ?INPUT' to DX  register. Why DX? DX can address memory data 
;and thus has the memory address of the character string
INT 21H                         ;DOS Interrupt
MOV BL, 00H         ;Clears BL to 00H
MOV CL,08H          ;Set CL to 08H INPUT1: MOV AH,01H  ;reads the   input from keyboard
INT 21H         ;DOS interrupt
SUB AL,30H          ;The ASCII values of numbers and actual number has difference of 30.
SHL BL,1            ;Performs a logical left shift on BL
ADD BL,AL           ;Adds the content of AL to BL
LOOP INPUT1         ;Loops INPUT1
MOV AH,09H          ; Display a character string
LEA DX,OUTPUT ;Load the effective address,  offset of OUTPUT in DX                 
INT 21H         ;DOS Interrupt
MOV AH,02H      ;display a single character
MOV DL,BL           ;Copies the content of BL to DL
INT 21H         ;DOS Interrupt
.EXIT               ;exits to DOS
END             ;ends the program
