.data
n: .space 4
m: .space 4
array: .space 5000
freq: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
str: .space 3000
chDelim: .asciz " "
len: .long 0
trei: .long 3
poz: .long 0
index: .long 0
printat: .long 0
formatprintf: .asciz "%d "
format2: .asciz "%d\n"
new: .asciz "\n"
formatnew: .asciz "%s"

.text
backtracking:
pushl %ebp
movl %esp, %ebp
pushl $0

xorl %ecx, %ecx
movl 8(%ebp), %ecx

cmp $1, printat
je final_back

cmp len, %ecx
jge final_back3

movl (%esi, %ecx, 4), %ebx
cmp $0, %ebx
jne back2

movl $1, %edx

for1:
cmp n, %edx
jg final_back

cmp $0, printat
jne final_back

movl (%edi, %edx, 4), %eax
cmp $3, %eax
je cont1

for3a:
movl %ecx, %ebx
subl m, %ebx
cmp $0, %ebx
jge for3
movl $0, %ebx

for3:
cmp %ecx, %ebx
je for4a

movl (%esi, %ebx, 4), %eax
cmp %edx, %eax
je cont1

incl %ebx
jmp for3

for4a:
movl %ecx, %eax
addl m, %eax
incl %eax
movl %eax, -4(%ebp)

movl %ecx, %ebx
incl %ebx

for4:
movl -4(%ebp), %eax
cmp %eax, %ebx
je check2

movl (%esi, %ebx, 4), %eax
cmp %edx, %eax
je cont1

incl %ebx
jmp for4

check2:
addl $1, (%edi, %edx, 4)
movl %edx, (%esi, %ecx, 4)

pushl %ecx
incl %ecx

pushl %edx
pushl %ecx
call backtracking
popl %ecx
popl %edx
popl %ecx

subl $1, (%edi, %edx, 4)
movl $0, (%esi, %ecx, 4)
jmp cont1

cont1:
incl %edx
jmp for1

back2:
pushl %ecx
incl %ecx

pushl %ecx
call backtracking
popl %ecx
popl %ecx
jmp final_back

final_back3:
xorl %ecx, %ecx
movl $1, printat

for_print:
cmp len, %ecx
je inter

movl (%esi, %ecx, 4), %ebx
pushl %ecx

pushl %ebx
pushl $formatprintf
call printf
popl %ebx
popl %ebx

popl %ecx

incl %ecx
jmp for_print

inter:
pushl $new
pushl $formatnew
call printf
popl %ebx
popl %ebx

final_back:
popl %ebx
popl %ebp
ret


.global main
main:
movl $freq, %edi
movl $array, %esi

pushl $str
call gets
popl %ebx
popl %ebx

xorl %ebx, %ebx

pushl $chDelim
pushl $str
call strtok 
popl %ebx
popl %ebx

pushl %eax
call atoi
popl %ebx

movl %eax, n
mull trei
movl %eax, len

pushl $chDelim
pushl $0
call strtok
popl %ebx
popl %ebx

pushl %eax
call atoi
popl %ebx

movl %eax, m

decl len
cmp len, %eax
jge print_1

incl len
xorl %ecx, %ecx

for_ii:
xorl %eax, %eax
pushl %ecx

pushl $chDelim
pushl $0
call strtok
popl %ebx
popl %ebx

cmp $0, %eax
je intermediar

pushl %eax
call atoi
popl %ebx

popl %ecx

cmp $0, %eax
jne unu

cmp $0, poz
jne unu

movl %ecx, index
incl poz

unu:
movl %eax, (%esi, %ecx, 4)
addl $1, (%edi, %eax, 4)

incl %ecx
jmp for_ii

intermediar:
popl %ebx
pushl $0
call backtracking
popl %ebx

cmp $0, printat
jne exit2

print_1:
pushl $-1
pushl $format2
call printf
popl %ebx
popl %ebx

exit2:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
