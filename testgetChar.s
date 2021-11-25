.data
buf:	.space 64
.text

.global	main
main:
	pushq $0

    call getInPos
    movq %rax, %rdi

    popq %rax
	ret
