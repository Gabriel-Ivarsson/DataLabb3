.data
    buf:    .asciz "Hello"

.text

.global	main
main:
pushq $0
    call getInt
popq %rax
	ret
