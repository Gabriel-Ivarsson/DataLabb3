.text

.global	main
main:
	pushq $0
    movq $1234567890, %rdi
    call putInt
    call outImage
    call printOutBuffer

    popq %rax
	ret
