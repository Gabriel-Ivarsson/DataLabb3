    .data
buf:	.space 64
.text

.global	main
main:
	pushq $0
	movq $15,%rsi
	movq $buf,%rdi
    call getText
    call printBufferPosition
    call printBufferPosition
    movq $1, %rsi
    call setInPos
    popq %rax
	ret
