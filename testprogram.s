.data
message:    .asciz ""
isEqual:    .asciz "is Equal\n"

.text
.global main

main:
    movq $message, %rdi
    movq $message, %rsi
    cmpb $0, (%rdi)
    je print
    ret

print:
    movq $isEqual, %rdi
    call puts
    ret
