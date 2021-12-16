.data
m: .long -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
str: .space 2000
chDelim: .asciz " "
lin: .long 0
col: .long 0
nr: .long 0
n: .long 0
nmax: .long 0
spatiu: .asciz "\n"
format: .asciz "%d "
indice: .long 0

.text
.global main
main:

    movl $m, %esi

    pushl $str
    call gets
    popl %ebx

    pushl $chDelim
    pushl $str
    call strtok 
    popl %ebx
    popl %ebx

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx 

    pushl %eax
    call atoi
    popl %ebx

    movl %eax, lin

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx 

    pushl %eax
    call atoi
    popl %ebx

    xorl %edx, %edx
    movl %eax, col
    mull lin
    movl %eax, nmax
    subl $1, nmax

    movl $-1, %ecx

for:
    incl %ecx

    pushl %ecx

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx 

    pushl %eax
    call atoi
    popl %ebx

    popl %ecx

    movl %eax, (%esi, %ecx, 4)
    movl (%esi, %ecx, 4), %edx
    cmp nmax, %ecx
    jl for
    je doi

doi:
    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx 

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    pushl %eax
    call atoi
    popl %ebx

    cmp $0, %eax
    je rot
    jne op

op:
    movl %eax, nr

    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx

    xorl %ebx, %ebx
    xorl %edx, %edx
    movb (%eax, %ebx, 1), %dl 

    movl $-1, %ecx

    cmp $97, %dl
    je addi
    cmp $100, %dl
    je divi
    cmp $109, %dl
    je muli
    cmp $115, %dl
    je subi

addi:
    incl %ecx

    movl nr, %ebx
    addl %ebx, (%esi, %ecx, 4)

    cmp nmax, %ecx
    jl addi
    je printt

subi:
    incl %ecx

    movl nr, %ebx
    subl %ebx, (%esi, %ecx, 4)

    cmp nmax, %ecx
    jl subi
    je printt

muli:
    incl %ecx
    xorl %edx, %edx
    movl nr, %ebx

    movl (%esi, %ecx, 4), %eax
    imull %ebx
    movl %eax, (%esi, %ecx, 4)

    cmp nmax, %ecx
    jl muli
    je printt

divi:
    incl %ecx
    movl nr, %ebx

    movl (%esi, %ecx, 4), %eax
    cmp $0, %eax
    jl negativ
    jge pozitiv

negativ:
    movl $-1, %edx
    jmp cont

pozitiv:
    xorl %edx, %edx

cont:
    idivl %ebx
    movl %eax, (%esi, %ecx, 4)
    movl (%esi, %ecx, 4), %ebx

    cmp nmax, %ecx
    jl divi
    je printt

rot:
    pushl col
    pushl $format
    call printf
    popl %ebx
    popl %ebx

    pushl lin
    pushl $format
    call printf
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

    movl lin, %eax
    subl $1, %eax
    mull col
    movl %eax, %ecx
    movl %ecx, %edx

    addl col, %eax
    subl $1, %eax
    movl %eax, indice

for3:
    movl (%esi, %ecx, 4), %ebx

    pushl %ecx
    pushl %edx
    pushl %ebx
    pushl $format
    call printf
    popl %eax
    popl %eax

    pushl $0
    call fflush
    popl %eax
    popl %edx
    popl %ecx

    subl col, %ecx

    cmp $0, %ecx
    jl hai
    jge for3

hai:
    incl %edx
    movl %edx, %ecx

    cmp indice, %edx
    jle for3
    jg exit

printt:
    pushl lin
    pushl $format
    call printf
    popl %ebx
    popl %ebx

    pushl col
    pushl $format
    call printf
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

    movl $-1, %ecx

print:
    incl %ecx
    xorl %edx, %edx
    movl (%esi, %ecx, 4), %edx
    pushl %ecx
    pushl %edx
    pushl $format
    call printf
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx  
    popl %ecx
    cmp nmax, %ecx
    jl print
    je exit

exit:
    pushl $spatiu
    call printf
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
