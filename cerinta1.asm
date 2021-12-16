.data
a: .long 0
n: .long 7
count: .long 0
indexSb2: .long 0
sum: .long 0
s: .space 400
s2: .space 8000
p: .space 4
f: .asciz " %d"
minus: .asciz "-"
formatScanf: .asciz "%s"
formatstring: .asciz " %s"
formatnr1: .asciz "%d"
formatstr1: .asciz "%c"
formatnum: .asciz " %d"
formatvar: .asciz " %c"
formatnew: .asciz "\n"
.text
.global main

main:
    pushl $s
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx
    xorl %ebx, %ebx
    movl $s, %edi
    movl $s2, %esi
    xorl %ecx, %ecx

et_for:
    movb (%edi, %ecx, 1), %al
    cmp $0, %al
    je part2

    cmp $48, %al
    je caz0
    cmp $49, %al
    je caz1
    cmp $50, %al
    je caz2
    cmp $51, %al
    je caz3
    cmp $52, %al
    je caz4
    cmp $53, %al
    je caz5
    cmp $54, %al
    je caz6
    cmp $55, %al
    je caz7
    cmp $56, %al
    je caz8
    cmp $57, %al
    je caz9
    cmp $65, %al
    je cazA
    cmp $66, %al
    je cazB
    cmp $67, %al
    je cazC
    cmp $68, %al
    je cazD
    cmp $69, %al
    je cazE
    cmp $70, %al
    je cazF

cont:
    inc %ecx
    jmp et_for

caz0:
    pushl %ecx

    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

caz1:
    pushl %ecx

    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

caz2:
    pushl %ecx

    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

caz3:
    pushl %ecx

    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

caz4:
    pushl %ecx

    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

caz5:
    pushl %ecx

    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

caz6:
    pushl %ecx

    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

caz7:
    pushl %ecx

    movl indexSb2, %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

caz8:
    pushl %ecx

    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

caz9:
    pushl %ecx

    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

cazA:
    pushl %ecx

    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

cazB:
    pushl %ecx

    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

cazC:
    pushl %ecx

    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

cazD:
    pushl %ecx

    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

cazE:
    pushl %ecx

    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $48, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

cazF:
    pushl %ecx

    movl indexSb2, %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx
    movb $49, (%esi, %ecx, 1)
    incl %ecx

    addl $4, indexSb2
    popl %ecx
    jmp cont

part2:
    subl $1, indexSb2
    movl $-1, %ebx
    movl $s2, %esi
    movl $1, a

for1:
    incl %ebx
    incl %ebx
    xorb %cl, %cl
    movl $0, sum
    movb (%esi, %ebx, 1), %dl
    cmp $48, %dl
    je num_var
    jne operator

num_var:
    incl %ebx
    incl a
    movb (%esi, %ebx, 1), %dl
    cmp $48, %dl
    je numar
    jne variabila

numar:
    incl %ebx
    incl a
    movb (%esi, %ebx, 1), %al
    movl $8, n
    jmp for4_11

for4_11:
    subl $1, n
    incl %ebx
    incl a
    movb (%esi, %ebx, 1), %dl
    cmp $49, %dl
    je pow2
    cmp $11, a
    jl for4_11
    je back

back:
    cmp $2, %al
    jne num
    je var

var:
    incl count
    cmp $1, count
    je var1
    jne var_else

var_else:
    movl formatvar, %eax
    movl %eax, f
    xorl %eax, %eax
    jmp printfinal

var1:
    movl formatstr1, %eax
    movl %eax, f
    xorl %eax, %eax
    jmp printfinal

num:
    incl count
    cmp $49, %al
    je negativ
    jne swipe

swipe:
    cmp $1, count
    jne num_else
    je num1

num_else:
    movl formatnum, %eax
    movl %eax, f
    xorl %eax, %eax
    jmp printfinal

num1:
    movl formatnr1, %eax
    movl %eax, f
    xorl %eax, %eax
    jmp printfinal

printfinal:
    pushl %edx
    pushl %eax
    pushl %ebx
    pushl sum
    pushl $f
    call printf
    popl %ecx
    popl %ecx
    popl %ebx
    popl %eax
    popl %edx
    pushl $0
    call fflush
    popl %ecx
    jmp reset

reset:
    movl $0, sum
    cmp indexSb2, %ebx
    je exit
    movl $1, a
    jmp for1

pow2:
    pushl %ebx
    pushl %eax
    xorb %cl, %cl
    movl $1, %eax
    movb n, %cl
    shl %cl, %eax
    addl %eax, sum
    popl %eax
    popl %ebx
    cmp $11, a
    jl for4_11
    je back

negativ:
    cmp $1, count
    jne neg2
    je neg1

neg2:
    pushl $minus
    pushl $formatstring
    call printf
    popl %ecx
    popl %ecx
    pushl %edx
    pushl %eax
    pushl %ebx
    pushl sum
    pushl $formatnr1
    call printf
    popl %ecx
    popl %ecx
    popl %ebx
    popl %eax
    popl %edx
    pushl $0
    call fflush
    popl %ecx
    jmp reset

neg1:
    pushl $minus
    pushl $formatScanf
    call printf
    popl %ecx
    popl %ecx
    pushl %edx
    pushl %eax
    pushl %ebx
    pushl sum
    pushl $formatnr1
    call printf
    popl %ecx
    popl %ecx
    popl %ebx
    popl %eax
    popl %edx
    pushl $0
    call fflush
    popl %ecx
    jmp reset

variabila:
    xorl %eax, %eax
    xorl %ecx, %ecx
    movb $2, %al
    incl %ebx
    incl a
    movl $8, n
    jmp for4_11

operator:
    movl $p, %edi
    xorl %eax, %eax
    addl $8, %ebx
    movb (%esi, %ebx, 1), %al
    cmp $49, %al
    je divi
    incl %ebx
    movb (%esi, %ebx, 1), %al
    cmp $49, %al
    je sub_mul
    jne let_add

sub_mul:
    incl %ebx
    movb (%esi, %ebx, 1), %al
    cmp $48, %al
    je subi
    jne muli

let_add:
    incl %ebx
    movb (%esi, %ebx, 1), %al
    cmp $48, %al
    je leti
    jne addi

divi:
    movl $p, %edi
    addl $2, %ebx
    xorl %ecx, %ecx
    movb $100, (%edi, %ecx, 1)
    incl %ecx
    movb $105, (%edi, %ecx, 1)
    incl %ecx
    movb $118, (%edi, %ecx, 1)
    jmp printstring

leti:
    movl $p, %edi
    movb $108, (%edi, %ecx, 1)
    incl %ecx
    movb $101, (%edi, %ecx, 1)
    incl %ecx
    movb $116, (%edi, %ecx, 1)
    jmp printstring

addi:
    movl $p, %edi
    movb $97, (%edi, %ecx, 1)
    incl %ecx
    movb $100, (%edi, %ecx, 1)
    incl %ecx
    movb $100, (%edi, %ecx, 1)
    jmp printstring

subi:
    movl $p, %edi
    movb $115, (%edi, %ecx, 1)
    incl %ecx
    movb $117, (%edi, %ecx, 1)
    incl %ecx
    movb $98, (%edi, %ecx, 1)
    jmp printstring

muli:
    movl $p, %edi
    movb $109, (%edi, %ecx, 1)
    incl %ecx
    movb $117, (%edi, %ecx, 1)
    incl %ecx
    movb $108, (%edi, %ecx, 1)
    jmp printstring

printstring:
    xorl %ecx, %ecx
    pushl %edx
    pushl %eax
    pushl %ebx
    pushl $p
    pushl $formatstring
    call printf
    popl %ecx
    popl %ecx
    popl %ebx
    popl %eax
    popl %edx
    pushl $0
    call fflush
    popl %ecx
    xorl %ecx, %ecx
    jmp reset

exit:
    pushl $formatnew
    call printf
    popl %ebx

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
