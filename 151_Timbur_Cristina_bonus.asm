.data
x: .long 0
n: .long 9
array: .space 5000
read_mode: .asciz "r"
write_mode: .asciz "w"
input_file: .asciz "sudokuin.txt"
output_file: .asciz "sudokuout.txt"
formatscanf: .asciz "%d"
formatprintf: .asciz "%d "
new: .asciz "\n"
total: .long 81

.text

possible:
pushl %ebp
movl %esp, %ebp

pushl $0
pushl $0
pushl $3

movl 8(%ebp), %ecx
movl 12(%ebp), %edx
movl 16(%ebp), %ebx

xorl %eax, %eax

forj1:
cmp $9, %eax
je fori2a
pushl %eax
pushl %ebx

movl %eax, %ebx
movl $9, %eax

pushl %edx
xorl %edx, %edx
mull %ecx
popl %edx

addl %ebx, %eax

movl %eax, %ebx
movl (%edi, %ebx, 4), %eax

popl %ebx

cmp %ebx, %eax
je returnfalse1

popl %eax

contj1:
incl %eax
jmp forj1


fori2a:
xorl %eax, %eax

fori2:
cmp $9, %eax
je check

pushl %eax
pushl %ebx

movl $9, %ebx
pushl %edx
xorl %edx, %edx
mull %ebx
popl %edx
addl %edx, %eax

movl %eax, %ebx
movl (%edi, %ebx, 4), %eax
popl %ebx

cmp %ebx, %eax
je returnfalse1

popl %eax

conti2:
incl %eax
jmp fori2

check:
movl $3, -12(%ebp) 
movl %ecx, %eax
pushl %edx
xorl %edx, %edx
divl -12(%ebp)
xorl %edx, %edx
mull -12(%ebp)
popl %edx
movl $0, -4(%ebp)
movl %eax, -4(%ebp)

movl %edx, %eax
pushl %edx
xorl %edx, %edx
divl -12(%ebp)
xorl %edx, %edx
mull -12(%ebp)
popl %edx
movl $0, -8(%ebp)
movl %eax, -8(%ebp)

xorl %ecx, %ecx
xorl %edx, %edx
for1:
cmp $3, %ecx
je returntrue

xorl %edx, %edx
for2:

cmp $3, %edx
je cont1

movl -4(%ebp), %eax
addl %ecx, %eax
pushl %edx
xorl %edx, %edx
mull -12(%ebp)
mull -12(%ebp)
popl %edx
addl -8(%ebp), %eax
addl %edx, %eax
pushl %ebx
movl %eax, %ebx
movl (%edi, %ebx, 4), %eax

popl %ebx

cmp %ebx, %eax
je returnfalse

cont2:
incl %edx
jmp for2

cont1:
incl %ecx
jmp for1

returntrue:
movl $1, %eax
jmp final_posibil

returnfalse:
movl $0, %eax
jmp final_posibil

returnfalse1:
popl %ebx
movl $0, %eax
jmp final_posibil

final_posibil:
popl %ebx
popl %ebx
popl %ebx
popl %ebp
ret


solve:
pushl %ebp
movl %esp, %ebp

xorl %edx, %edx
xorl %ecx, %ecx
fori:
cmp $9, %ecx
je print
xorl %edx, %edx
forj:
cmp $9, %edx
je conti

movl $9, %eax
pushl %edx
xorl %edx, %edx
mull %ecx
popl %edx
addl %edx, %eax

movl (%edi, %eax, 4), %ebx
cmp $0, %ebx
jne contj

movl $1, %ebx
for3:

cmp $10, %ebx
je final_solve

pushl %ebx
pushl %edx
pushl %ecx
call possible 
popl %ecx
popl %edx
popl %ebx

cmp $1, %eax
jne cont3

movl $9, %eax
pushl %edx
xorl %edx, %edx
mull %ecx
popl %edx
addl %edx, %eax
movl %ebx, (%edi, %eax, 4)

pushl %ebx
pushl %ecx
pushl %edx
call solve
popl %edx
popl %ecx
popl %ebx

movl $9, %eax
pushl %edx
xorl %edx, %edx
mull %ecx
popl %edx
addl %edx, %eax
movl $0, (%edi, %eax, 4)

cont3:
incl %ebx
jmp for3

contj:
incl %edx
jmp forj

conti:
incl %ecx
jmp fori

final_solve:
popl %ebp
ret

print:
pushl $write_mode
pushl $output_file
call fopen
popl %ebx
popl %ebx

xorl %ecx, %ecx
for_afisare:
cmp total, %ecx
je end_for_afisare

movl (%edi, %ecx, 4), %ebx
pushl %ecx
pushl %ebx
pushl $formatprintf
pushl %eax
call fprintf
popl %eax 
popl %ebx
popl %ebx 
popl %ecx

pushl %eax
pushl %ecx

xorl %edx, %edx
movl %ecx, %eax
incl %eax
divl n 
cmp $0, %edx
je print_new_line
jmp continue
print_new_line:
movl 4(%esp), %eax
pushl $new
pushl %eax
call fprintf
popl %eax 
popl %ebx
int $0x80

continue:
popl %ecx
popl %eax
incl %ecx
jmp for_afisare

end_for_afisare:
pushl %eax
call fclose
popl %ebx

popl %ebp
ret


.global main
main:

pushl $read_mode
pushl $input_file
call fopen
popl %ebx
popl %ebx

lea array, %edi
xorl %ecx, %ecx

for_citire:
cmp total, %ecx
je end_for_citire

pushl %ecx
pushl $x 
pushl $formatscanf
pushl %eax
call fscanf 
popl %eax
popl %ebx
popl %ebx
popl %ecx

movl x, %ebx
movl %ebx, (%edi, %ecx, 4)

incl %ecx
jmp for_citire

end_for_citire:
pushl %eax
call fclose
popl %ebx

call solve

exit2:
movl $1, %eax
xorl %ebx, %ebx
int $0x80
