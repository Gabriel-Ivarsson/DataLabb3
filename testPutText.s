	.data
headMsg:	.ascii	"start!"
endMsg:	.asciz	"end!"
buf:	.space	64
sum:	.quad	0
count:	.quad	0
temp:	.quad	0

	.text
	.global	main
main:
	pushq	$0
	movq $0, %rdi
	movq	$headMsg,%rdi
	call	putText
	movq $2, %rdi
	call setOutPos
	call printOutBufferPosition
	movq $0, %rdi
	movq	$endMsg,%rdi
	call	putText
	call printOutBufferPosition
    pop %rax
    ret
