	.file	"testC.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Enter first word(max %d long):\n"
.LC1:
	.string	"Compared number1 was: %d\n"
.LC2:
	.string	"Word1: %s\n"
	.align 8
.LC3:
	.string	"Enter second word(max %d long):\n"
.LC4:
	.string	"Compared number2 was: %d\n"
.LC5:
	.string	"Word2: %s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -22(%rbp)
	movl	$0, -14(%rbp)
	movw	$0, -10(%rbp)
	movl	$12, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-22(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	getText@PLT
	movl	%eax, -44(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-22(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$3, %edi
	movl	$0, %eax
	call	setInPos@PLT
	movl	$10, %esi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	$0, -34(%rbp)
	movl	$0, -26(%rbp)
	leaq	-34(%rbp), %rax
	movl	$10, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	getText@PLT
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-34(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L3
	call	__stack_chk_fail@PLT
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 10.3.0-1ubuntu1) 10.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
