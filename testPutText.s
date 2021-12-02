	.data
headMsg:	.asciz	"start!"
endMsg:	.asciz	"end!"
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
	movq $123, %rdi
	call putInt
	movq $2, %rdi
	call setOutPos
	call printOutBufferPosition
	movq	$endMsg,%rdi
	call	putText
	call getOutPos
	call outImage
	movq %rax, %rdi
	call putInt
	call outImage
    pop %rax
    ret
