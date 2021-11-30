.text

.global	main
main:
	pushq $0
    movq $10001, %rdi
    call putInt
    movq $10201, %rdi
    call putInt
    call printOutBuffer

    popq %rax
	ret

