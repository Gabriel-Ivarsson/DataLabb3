.data
    buf:    .asciz "1234"

.text

.global    main
main:
    pushq $0
    movq $20, %rdi
    call putInt
    movq $40, %rdi
    call putInt
    movq $50, %rdi
    call putInt
    movq $90, %rdi
    call putInt
    movq $33, %rdi
    call putInt
    call outImage


    popq %rax
    ret
