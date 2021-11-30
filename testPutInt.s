.text

.global	main
main:
	pushq $0
    movq $123456, %rdi
    call putInt

    popq %rax
	ret

