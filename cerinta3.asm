.data
m: .long -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
str: .space 600
chDelim: .asciz " "
res: .space 4
res1: .space 4
num: .long 0
format: .asciz "%u\n"

.text
.global main
main:

    movl $m, %esi

    pushl $str
    call gets
    popl %ebx

    xorl %ebx, %ebx

    pushl $chDelim
    pushl $str
    call strtok 
    popl %ebx
    popl %ebx

    movl %eax, res
    movl %eax, res1

    pushl res
    call atoi
    popl %ebx

    cmp $0, %eax
    je var_1
    jne num_1

var_1:
    movl res1, %ecx
    xorl %edx, %edx 

    movb (%ecx, %edx, 1), %al
    xorl %edx, %edx
    movl %eax, %edx
                                
    subl $97, %eax

    movl (%esi, %eax, 4), %ebx
    cmp $-1, %ebx
    je vary
    jne varn

vary:
    pushl %edx
    jmp et_for

varn:
    pushl %ebx
    jmp et_for

num_1:
    pushl %eax
    jmp et_for

et_for:
    xorl %eax, %eax
    xorl %ecx, %ecx

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    cmp $0, %eax
    je exit

    movl %eax, res
    movl %eax, res1

    xorl %edx, %edx
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    movl res, %edi

    movb (%edi, %ecx, 1), %dl
    incl %ecx

    movb (%edi, %ecx, 1), %bl

    pushl %ebx
    pushl %edx
    pushl res
    call atoi
    popl %ecx
    popl %edx
    popl %ebx

    movl %eax, num 

    cmp $0, num
    jne numar
    cmp $0, %bl
    je var_2

    cmp $108, %dl
    je leti
    cmp $97, %dl
    je addi
    cmp $100, %dl
    je divi
    cmp $109, %dl
    je muli
    cmp $115, %dl
    je subi

var_2:
    movl res1, %ecx
    xorl %edx, %edx

    movb (%ecx, %edx, 1), %al
    xorl %edx, %edx
    movl %eax, %edx
                                
    subl $97, %eax

    movl (%esi, %eax, 4), %ebx

    cmp $-1, %ebx
    je vary1
    jne varn1

vary1:
    pushl %edx
    jmp et_for

varn1:
    pushl %ebx
    jmp et_for

numar:
    pushl num
    jmp et_for

leti:
    xorl %eax, %eax
    xorl %ecx, %ecx

    popl %ebx
    popl %ecx  
    xorl %edx, %edx

    movl %ecx, %eax

    subl $97, %eax

    movl %ebx, (%esi, %eax, 4)
    movl $0, %ebx
    movl (%esi, %eax, 4), %ebx

    jmp et_for

addi:
    popl %ebx
    popl %ecx
    addl %ecx, %ebx
    pushl %ebx
    jmp et_for

subi:
    popl %ebx
    popl %ecx
    subl %ebx, %ecx
    pushl %ecx
    jmp et_for
 
muli:
    xorl %eax, %eax
    xorl %edx, %edx
    popl %ebx
    popl %eax
    mull %ebx
    pushl %eax
    jmp et_for

divi:
    xorl %edx, %edx
    xorl %eax, %eax
    popl %ebx
    popl %eax
    divl %ebx
    pushl %eax
    xorl %edx, %edx
    jmp et_for

exit:
    popl %ebx
    pushl %ebx
    pushl $format
    call printf
    popl %ebx
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
