.text

.global	main
main:
	pushq $0
    movq $10, %rdi
    call putInt

    popq %rax
	ret
    