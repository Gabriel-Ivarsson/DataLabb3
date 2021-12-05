    .data
headMsg:	.asciz	"Skriv in till in uffern"
outMsg:     .asciz  "output"
buf:	.space 64
.text

.global	main
main:
	pushq $0
    movq $headMsg, %rdi
    call puts
    call getChar
    movq %rax, %rdi
    call putChar
    movq $outMsg, %rdi
    call puts
    call outImage
    popq %rax
	ret
