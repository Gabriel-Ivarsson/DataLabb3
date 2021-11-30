.text

.global	main
main:
	pushq $0
    movq $1000, %rdi
    call putInt

    popq %rax
	ret

