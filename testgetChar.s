.data
buf:	.space 64
.text

.global	main
main:
	pushq $0

    call getChar
    movq buf, %rdi
    mov %rax, (%rdi)

    call puts
    popq %rax
	ret
