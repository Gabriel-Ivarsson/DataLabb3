.text

.global	main
main:
	pushq $0
    movq $1234567890, %rdi
    call putInt
    movq $0, %rdi
    call setOutPos
    call outImage
    movq $10201, %rdi
    call putInt
    call outImage

    popq %rax
	ret
