.data
    buf:    .asciz "1234"

.text

.global	main
main:
	pushq $0
    call inImage
    call getInt


    popq %rax
	ret
