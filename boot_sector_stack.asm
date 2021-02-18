; There is only a finite number of registers to store things in.
; Memory itself can be used, but even with pointers, knowing exactly where
; things are is not always necessary.
; CPU offers push and pop instructions that allow storing and retrieving a 
; value from the top of the stack.
; When in 16-bit mode, the stack operates on 16-bit boundaries, meaning only
; 16 bits can be pushed/popped at a time (2 bytes 0x0000)
; Two CPU registers maintain the stack, bp and sp.
; bp -> base pointer -> always points to the bottom of the stack
; sp -> stack pointer -> always points to the top of the stack
; The stack grows downwards, so when a value is pushed onto the stack, sp 
; is decremented

mov ah, 0x0e ; int10/ah=0eh -> tty

mov bp, 0x8000 ; set the base of the stack a little above where BIOS loads
mov sp, bp    ; the boot sector so that it won't overwrite us

; push some charecters onto the stack
push 'A' ; because pushing works with 16-bit boundaries this is actually
         ; pushing 0x0042 instead of just 0x42
push 'B'
push 'C'

; this is what the stack looks like now after pushing 0x42, 0x43 and 0x44
;
;         bp -> 0x8000 +--------------------------+
;                      |         0x0042           |
;               0x7ffe +--------------------------+
;                      |         0x0043           |
;               0x7ffc +--------------------------+
;                      |         0x0044           |
;         sp -> 0x7ffa +--------------------------+

mov al, [0x7ffe] ; prove the above diagram
int 0x10 ; will print A because 0x77ff is 0x00

pop bx ; recover C by popping 0x0044 off of the stack into bx
mov al, bl ; move the lower (0x44) from bl to al
int 0x10 ; print C

pop bx 
mov al, bl
int 0x10 ; print B

pop bx 
mov al, bl
int 0x10 ; print A

mov al, [0x7ffe]
int 0x10 ; this will print garbage because 0x0042 has been popped


jmp $

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55