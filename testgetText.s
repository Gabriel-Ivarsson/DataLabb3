.data
buf:	.space	64
.text

.global	main
main:
	pushq $0
	movq $15,%rsi
	movq $buf,%rdi
    call getText
    movq $buf, %rdi
    call puts
    movq $15,%rsi
	movq $buf,%rdi
    call getText
    movq $buf, %rdi
    call puts
    popq %rax
	ret
