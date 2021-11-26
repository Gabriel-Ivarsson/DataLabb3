.data
buf:	.space 64
.text

.global	main
main:
    pushq $0
    movq $buf,%rdi
    movq $15,%rsi
    call getText
    movq $buf,%rdi
    call puts
    movq $2, %rdi
    call setInPos
    call printBufferPosition
    call printBuffer
    movq $3, %rdi
    call setInPos
    call printBufferPosition
    call printBuffer
    movq $9, %rdi
    call setInPos
    call printBufferPosition
    call printBuffer
    movq $4, %rdi
    call setInPos
    call printBufferPosition
    call printBuffer
    movq $-4, %rdi
    call setInPos
    call printBufferPosition
    call printBuffer
    movq $11, %rdi
    call setInPos
    call printBufferPosition
    call printBuffer
    popq %rax
    ret
