.data
message:    .asciz ""

.text
.global main

main:
    movq $message, %rdi
    movq $6, %rsi
    movq stdin, %rdx
    call fgets
    movq $message, %rdi
    call puts
    ret
