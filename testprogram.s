.data
message:    .asciz "98"
isEqual:    .asciz "is Equal\n"
isnotEqual: .asciz "Is not equal\n"

.text
.global main

main:
    call getInt
    movq $40, %rsi
    addq %rsi, %rax
    movq %rax, %rdi

    call puts
    ret

print1:
    movq $isEqual, %rdi
    call puts
    ret
print2:
    movq $isnotEqual, %rdi
    call puts
    ret
