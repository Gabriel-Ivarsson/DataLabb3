.data
buf:	.space 64
.text

.global	main
main:
    pushq $0
    movq $buf,%rdi
    movq $12,%rsi
    call getText
    movq $buf,%rdi
    call puts
    call printBuffer
    movq $2, %rdi
    call setInPos
    call printBuffer
    call printBufferPosition
    movq $3, %rdi
    call setInPos
    call printBuffer
    call printBufferPosition
    movq $10, %rdi
    call setInPos
    call printBuffer
    call printBufferPosition
    movq $4, %rdi
    call setInPos
    call printBuffer
    call printBufferPosition
    popq %rax
    ret
