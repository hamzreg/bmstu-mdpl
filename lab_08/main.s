	.file	"main.c"
	.text
	.globl	asm_strlen
	.type	asm_strlen, @function
asm_strlen:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$0, -12(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
#APP
# 23 "main.c" 1
	.intel_syntax noprefix
mov al, 0
mov rdi, %rdx
mov ecx, -1
repne scasb
not ecx
dec ecx
mov %edx, ecx

# 0 "" 2
#NO_APP
	movl	%edx, -12(%rbp)
	movl	-12(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	asm_strlen, .-asm_strlen
	.section	.rodata
.LC0:
	.string	"\033[32mPASSED\n\033[0m"
.LC1:
	.string	"\033[31mFAIL\n\033[0m"
	.text
	.globl	compare_len
	.type	compare_len, @function
compare_len:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jne	.L4
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L6
.L4:
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L6:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	compare_len, .-compare_len
	.section	.rodata
.LC2:
	.string	"\033[32m\nSTRLEN\n\033[0m"
.LC3:
	.string	"\ntest 1.0"
.LC4:
	.string	"\033[36mDATA: \033[0m%s\n"
.LC5:
	.string	"\033[36mLEN: \033[0m%ld\n"
.LC6:
	.string	"\033[36mRESULT: \033[0m%d\n"
.LC7:
	.string	"\ntest 2.0"
	.text
	.globl	test_asm_strlen
	.type	test_asm_strlen, @function
test_asm_strlen:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	movabsq	$8583909746840200552, %rax
	movq	%rax, -38(%rbp)
	movl	$1684828783, -30(%rbp)
	movw	$33, -26(%rbp)
	leaq	-38(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-38(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-38(%rbp), %rax
	movq	%rax, %rdi
	call	asm_strlen
	movl	%eax, %esi
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-38(%rbp), %rax
	movq	%rax, %rdi
	call	asm_strlen
	movl	%eax, %ebx
	leaq	-38(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%ebx, %esi
	movl	%eax, %edi
	call	compare_len
	leaq	.LC7(%rip), %rdi
	call	puts@PLT
	movabsq	$431316168567, %rax
	movq	%rax, -48(%rbp)
	movw	$0, -40(%rbp)
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	asm_strlen
	movl	%eax, %esi
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	asm_strlen
	movl	%eax, %ebx
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movl	%ebx, %esi
	movl	%eax, %edi
	call	compare_len
	nop
	movq	-24(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	test_asm_strlen, .-test_asm_strlen
	.globl	compare_str
	.type	compare_str, @function
compare_str:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L10
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L12
.L10:
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L12:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	compare_str, .-compare_str
	.section	.rodata
.LC8:
	.string	"\033[32m\nSTRCOPY\n\033[0m"
.LC9:
	.string	"\ntest 1.0:"
.LC10:
	.string	"\033[36mSRC: \033[0m%s\n"
.LC11:
	.string	"\033[36mDST: \033[0m%s\n"
.LC12:
	.string	"\033[36mLEN: \033[0m%d\n"
.LC13:
	.string	"\033[36mANSWER: \033[0m%s\n"
.LC14:
	.string	"\033[36mRESULT: \033[0m%s\n"
.LC15:
	.string	"\ntest 2.0:"
.LC16:
	.string	"hello, world!"
.LC17:
	.string	"\ntest 3.0:"
.LC18:
	.string	"abcdefghijkl"
.LC19:
	.string	"abcdeabcdefghijkl"
.LC20:
	.string	"\ntest 4.0:"
.LC21:
	.string	"fghijkl"
.LC22:
	.string	"abcdeabcdeabcijkl"
	.text
	.globl	test_asm_strcopy
	.type	test_asm_strcopy, @function
test_asm_strcopy:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$160, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	.LC8(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movabsq	$7161393488660817256, %rax
	movabsq	$7740114806721897828, %rdx
	movq	%rax, -144(%rbp)
	movq	%rdx, -136(%rbp)
	movw	$108, -128(%rbp)
	movabsq	$8583909699595956087, %rax
	movabsq	$143418749551, %rdx
	movq	%rax, -112(%rbp)
	movq	%rdx, -104(%rbp)
	movq	$0, -96(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movl	$0, -16(%rbp)
	movl	$5, -148(%rbp)
	leaq	.LC9(%rip), %rdi
	call	puts@PLT
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC10(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC11(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-148(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC12(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-148(%rbp), %edx
	leaq	-144(%rbp), %rcx
	leaq	-144(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	asm_strcopy@PLT
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC14(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-144(%rbp), %rdx
	leaq	-144(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	compare_str
	leaq	.LC15(%rip), %rdi
	call	puts@PLT
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC10(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-112(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC11(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-148(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC12(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-148(%rbp), %edx
	leaq	-144(%rbp), %rcx
	leaq	-112(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	asm_strcopy@PLT
	leaq	.LC16(%rip), %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-112(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC14(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-112(%rbp), %rax
	leaq	.LC16(%rip), %rsi
	movq	%rax, %rdi
	call	compare_str
	leaq	.LC17(%rip), %rdi
	call	puts@PLT
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC10(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC18(%rip), %rsi
	leaq	.LC11(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-148(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC12(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-144(%rbp), %rax
	addq	$5, %rax
	movl	-148(%rbp), %edx
	leaq	-144(%rbp), %rcx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	asm_strcopy@PLT
	leaq	.LC19(%rip), %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC14(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-144(%rbp), %rax
	leaq	.LC19(%rip), %rsi
	movq	%rax, %rdi
	call	compare_str
	movl	$3, -148(%rbp)
	leaq	.LC20(%rip), %rdi
	call	puts@PLT
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC10(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC21(%rip), %rsi
	leaq	.LC11(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-148(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC12(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-144(%rbp), %rax
	addq	$10, %rax
	movl	-148(%rbp), %edx
	leaq	-144(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	asm_strcopy@PLT
	leaq	.LC22(%rip), %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-144(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC14(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-144(%rbp), %rax
	leaq	.LC22(%rip), %rsi
	movq	%rax, %rdi
	call	compare_str
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	test_asm_strcopy, .-test_asm_strcopy
	.globl	main
	.type	main, @function
main:
.LFB5:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	call	test_asm_strlen
	call	test_asm_strcopy
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
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
