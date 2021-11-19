.data
<<<<<<< HEAD:testprogram.s
message:    .asciz "9"
isEqual:    .asciz "is Equal\n"
=======
message:    .asciz ""
>>>>>>> 21d0a4d610d31b60c7ae77b317a51c2c7f20da10:testprogram1.s

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
