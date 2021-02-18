; Assembly jump instructions that can come after a comparison
;   je target  = jump if equal ( i.e. x == y)
;   jne target = jump if not equal ( i.e. x != y)
;   jl target  = jump if less than ( i.e. x < y)
;   jle target = jump if less than or equal ( i.e. x <= y)
;   jg target  = jump if greater than ( i.e. x > y)
;   jge target = jump if greater than or equal ( i.e. x >= y)

mov bx, 50

;                     if (bx <= 4) {
;                         mov al , ’A ’
;                     } else if (bx < 40) {
;                         mov al , ’B ’
;                     } else {
;                         mov al , ’C ’
;                     }

; the high level if/elif/else statement above can be written as seen
; below with cmp and jumps upon condition
cmp bx, 4
jle if_block
cmp bx, 40
jl else_if_block
mov al, 'C'
jmp end ; we need a jmp here otherwise we would continue onto the
        ; if_block label below

if_block:
    mov al, 'A'
    jmp end ; we need to jmp here otherwise if we ever hit this label
            ; we could continue onto the label below and print B 
            ; instead of A as intended

else_if_block:
    mov al, 'B' ; we do not need a jmp here because we will continue
                ; onto the end label

end:

mov ah, 0x0e ; int10/ah0eh -> tty
int 0x10 ; print the character in al    

jmp $

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55