	.data
headMsg:	.asciz	"Start av testprogram. Skriv in 5 tal!"
endMsg:	.asciz	"Slut pa testprogram"
buf:	.space	64
sum:	.quad	0
count:	.quad	0
temp:	.quad	0

	.text
	.global	main
main:
	pushq	$0
	call	getInt
	movq	%rax, temp
	movq	temp, %rdx
	movq	%rdx, %rdi
	call	putInt
	popq	%rax
	ret
