; The BIOS always loads the boot sector at the adress 0x7c00.
;
;                                         XXXXXXXXXXXX
;                                      XXXX          XXXX
;                         XXX     XXXXXX                XXX
;                         | XXXXXXX                       |
;                         |             Free              |
;                         |                               |
;                0x100000 +-------------------------------+
;                         |          BIOS (256KB)         |
;                 0xC0000 +-------------------------------+
;                         |      Video Memory (128KB)     |
;                 0xA0000 +-------------------------------+
;                         |       Extended BIOS Data      |
;                         |          Area (639KB)         |
;                 0x9fc00 +-------------------------------+
;                         |                               |
;                         |          Free (638KB)         |
;                         |                               |
;                  0x7e00 +- - - - - - - - - - - - - - - -+
;                         |   Loaded Boot Sector (512B)   |
;                  0x7c00 +- - - - - - - - - - - - - - - -+
;                         |                               |
;                   0x500 +-------------------------------+
;                         |     BIOS Data Area (256B)     |
;                   0x400 +-------------------------------+
;                         | Interrupt Vector Table (1KB)  |
;                     0x0 +-------------------------------+


mov ah, 0x0e ; int10/ah=0eh -> tty

; The label at the bottom contains a character 'X', the following four attempts
; to access that label will demonstrate how memory access works

; this attempt fails because it tries to print a pointer
; this will print '-' which is the chr value of 0x2d which is the value of
; the pointer becasue 'X' is at the position 0x2d into the binary
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; this attempt tries to print what is at the memory address of 'the_secret',
; but the label is pointers location is relative to the beginning of this 
; binary file, padding is required because the BIOS has loaded us at 0x7c00
; not 0x0
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; this attempt will work because we print what is at the memory address of 
; the pointer + the offset we have been loaded at in memory
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; this attempt also works because we have manually added the values together,
; but this isn't practical
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10

; to resolve the issue of having to manually add the offset of the boot sector
; we can use the org directive to tell the assember that we are expecting to be
; loaded at a specific memory address, so it will automatically add the padding
; this can be done by adding [org 0x7c00] to the top of the file

jmp $

the_secret:
    db "X"

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55