	.file	"lab2.c"
	.text
	.globl	multiplyByShiftAndAdd
	.type	multiplyByShiftAndAdd, @function
multiplyByShiftAndAdd:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %edx
	movl	%esi, %eax
	movw	%dx, -20(%rbp)
	movw	%ax, -24(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L5:
	movzwl	-24(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	sarl	%cl, %edx
	movl	%edx, %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L7
	movzwl	-20(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	addl	%eax, -8(%rbp)
	jmp	.L4
.L7:
	nop
.L4:
	addl	$1, -4(%rbp)
.L2:
	movzwl	-24(%rbp), %edx
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	sarl	%cl, %edx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	.L5
	movl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	multiplyByShiftAndAdd, .-multiplyByShiftAndAdd
	.section	.rodata
	.align 8
.LC0:
	.string	"Please input the two numbers to multiply: "
.LC1:
	.string	"%d"
.LC2:
	.string	"a out of range "
.LC3:
	.string	"b out of range "
.LC4:
	.string	"The product is: %u\n"
.LC5:
	.string	"Whoops! Something is wrong."
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-20(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-20(%rbp), %eax
	testl	%eax, %eax
	js	.L9
	movl	-20(%rbp), %eax
	cmpl	$65535, %eax
	jle	.L10
.L9:
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
.L10:
	movl	-16(%rbp), %eax
	testl	%eax, %eax
	js	.L11
	movl	-20(%rbp), %eax
	cmpl	$65535, %eax
	jle	.L12
.L11:
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
.L12:
	movl	-16(%rbp), %eax
	movzwl	%ax, %edx
	movl	-20(%rbp), %eax
	movzwl	%ax, %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	multiplyByShiftAndAdd
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-20(%rbp), %edx
	movl	-16(%rbp), %eax
	imull	%edx, %eax
	cmpl	%eax, -12(%rbp)
	je	.L13
	leaq	.LC5(%rip), %rdi
	call	puts@PLT
.L13:
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L15
	call	__stack_chk_fail@PLT
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-16ubuntu3) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
