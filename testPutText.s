	.data
headMsg:	.ascii	"AB!"
endMsg:	.ascii	"CD!"
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
	call printOutBufferPosition
	movq $55, %rdi
	call setOutPos
	call printOutBufferPosition
	movq	$endMsg,%rdi
	call	putText
	call printOutBufferPosition
    pop %rax
    ret
