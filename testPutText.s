	.data
headMsg:	.ascii	"Start av test!"
endMsg:	.ascii	"Slut pa test"
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
	movq $4, %rdi
	call setOutPos
	movq	$endMsg,%rdi
	call	putText
    pop %rax
    ret
