.data
message:    .asciz "9"
isEqual:    .asciz "is Equal\n"

.text
.global main

main:
    movq $message, %rsi
    cmpb $'9', (%rsi)
    je print
    ret

print:
    movq $isEqual, %rdi
    call puts
    ret
