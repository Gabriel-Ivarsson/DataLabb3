.data
message:    .asciz ""
isEqual:    .asciz "is Equal\n"
isnotEqual: .asciz "Is not equal\n"

.text
.global main

main:
    movq $message, %rdi
    movq $message, %rsi
    cmpb $0, (%rdi)
    je print1
    jne print2
    ret

print1:
    movq $isEqual, %rdi
    call puts
    ret
print2:
    movq $isnotEqual, %rdi
    call puts
    ret
