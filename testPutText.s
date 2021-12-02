	.data
headMsg:	.asciz	"1234"
endMsg:	.asciz	"5678"
buf:	.space	64
sum:	.quad	0
count:	.quad	0
temp:	.quad	0

	.text
	.global	main
main:
	pushq	$0
	movq	$headMsg,%rdi
	call	putText
	movq $2, %rdi
	call setOutPos
	call printOutBufferPosition
	movq	$endMsg,%rdi
	call	putText
	call getOutPos
	call outImage
    pop %rax
    ret
