.data
buf:	.space	64
.text

.global	main
main:
	pushq $0
	movq $12,%rsi
	movq $buf,%rdi
    call getText
    movq %rax,%rdi
    call puts
    popq %rax
	ret
