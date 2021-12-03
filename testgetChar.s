    .data
buf:	.space 64
.text

.global	main
main:
	pushq $0
    call getChar
    movq %rax, %rdi
    call putChar
    call outImage
    popq %rax
	ret
