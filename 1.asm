.data
doi: .long 2
x: .space 4
sum: .long 1 
formats1: .asciz "Numarul %d este perfect\n"
formats2: .asciz "Numarul %d nu este perfect\n"
formatscanf: .asciz "%d"
.text

perfect:

	pushl %ebp
	movl %esp, %ebp

	movl 8(%esp), %ebx 

	movl $2, %ecx

	xorl %edx, %edx
	movl %ebx, %eax
	divl doi

	movl 12(%ebp), %edx

for:
	cmp %eax, %ecx
	jg exit

	pushl %eax
	pushl %edx

	movl %ebx, %eax
	xorl %edx, %edx
	divl %ecx
	cmp $0, %edx
	je divizor

	popl %edx
	popl %eax
	incl %ecx
	jmp for


divizor:
	popl %edx
	addl %ecx, 0(%edx)
	popl %eax

	incl %ecx
	jmp for


exit:

	cmp %ebx, 0(%edx)
	je perf
	xorl %eax, %eax
	
	popl %ebp
	ret


perf:
	cmp $1, %ebx
	je unu

	movl $1, %eax
	popl %ebp
	ret

unu:	
	xorl %eax, %eax
	popl %ebp
	ret


.globl main
main:

	pushl $x
	pushl $formatscanf
	call scanf
	popl %ebx
	popl %ebx

	xorl %eax, %eax
	xorl %ecx, %ecx
	xorl %edx, %edx

	pushl $sum
	pushl x
	call perfect
	popl %edx
	popl %edx

	cmp $1, %eax
	je printperf

	pushl x
	pushl $formats2
	call printf
	popl %ebx
	popl %ebx

	jmp exit_t

printperf:

	pushl x
	pushl $formats1
	call printf
	popl %ebx
	popl %ebx


exit_t:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80


