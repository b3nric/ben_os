
mov al, 'H' 
jmp rubbish_print_function

rubbish_print_function:
    mov ah, 0x0e
    int 0x10
    jmp return_here ; we explicitly return to a label, but this is not
                    ; convenient and does not offer good re-use

return_here:

mov al, 'e'
call good_print_function ; when using call, the CPU pushes the return 
                         ; address to the stack
mov al, 'l'
call good_print_function
call good_print_function
mov al, 'o'
call good_print_function
mov al, ','
call good_print_function
mov al, ' '
call good_print_function
mov al, 'W'
call good_print_function
mov al, 'o'
call good_print_function
mov al, 'r'
call good_print_function
mov al, 'l'
call good_print_function
mov al, 'd'
call good_print_function
jmp end

good_print_function:
    mov ah, 0x0e
    int 0x10
    ret ; when using ret the CPU will pop the return address off of the
        ; stack and then jump to it so we don't have to define labels
        ; like the example above

end:

jmp $

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55
