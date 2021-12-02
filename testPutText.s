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
	call outImage
	movq	$headMsg,%rdi
	call	putText
	call outImage
    pop %rax
    ret
