	.data
msg1:	.asciz	"!ABC!"
msg2:	.asciz	"!DEF!\n"
buf:	.space	64
sum:	.quad	0
count:	.quad	0
temp:	.quad	0

	.text
	.global	main
main:
	pushq	$0
	movq	$msg1,%rdi
	call	putText
	movq	$msg1,%rdi
	call	putText
	movq	$msg2,%rdi
	call	putText
	movq	$msg2,%rdi
	call	putText
    pop %rax
    ret
