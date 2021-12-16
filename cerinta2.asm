.data
num: .long 0
num1: .long 0
str: .space 600
chDelim: .asciz " "
formatPrintf: .asciz "%u\n"
res: .space 4
.text
.global main

main:
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
                            
    pushl res
    call atoi
    popl %ebx

    pushl %eax

et_for:
    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx 

    cmp $0, %eax
    je exit

    movl %eax, res

    xorl %ecx, %ecx
    mov res, %edi
    movb (%edi, %ecx, 1), %dl

    pushl %edx
    pushl res
    call atoi
    popl %ebx
    popl %edx

    movl %eax, num  

    cmp $0, num
    jne numar
    cmp $97, %dl
    je addi
    cmp $100, %dl
    je divi
    cmp $109, %dl
    je muli
    cmp $115, %dl
    je subi

numar:
    pushl num
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
    xorl %edx, %edx
    popl %eax
    popl %ecx
    mull %ecx
    pushl %eax
    jmp et_for

divi:
    xorl %edx, %edx
    popl %ebx
    popl %eax
    divl %ebx
    pushl %eax
    xorl %edx, %edx
    jmp et_for

exit:
    popl %ebx
    pushl %ebx
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
