.text

.global	main
main:
	pushq $0
    movq $12345678949494944949, %rdi
    call putInt
    movq $10201, %rdi
    call putInt
    call outImage

    popq %rax
	ret
