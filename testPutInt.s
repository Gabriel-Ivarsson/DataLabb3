.data
    buf:    .asciz "Hello"

.text

.global	main
main:
	pushq $0
    movq $buf, %rdi
    call putText
    movq $2, %rdi
    call setOutPos
    call getOutPos
    movq %rax, %rdi
    call putInt
    call outImage

    popq %rax
	ret
