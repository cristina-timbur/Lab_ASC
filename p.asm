EX. 1
a)  and $1, %eax

b)  xor %eax, %eax

c)  xor %ebx, %eax
    xor %ebx, %eax

d)  mov %eax, %ebx
    sub $1, %eax
    and %ebx, %eax

k)  sub %ecx, %ebx
    add %eax, %ebx
    mov %ebx, %ecx

l)  mov $2, %edx
    imul %edx
    mov $2, %edx
    add %ebx, %eax
    imul %edx
    add %ecx, %eax
    mov $2, %ecx
    div %ecx
    mov %eax, %ebx

m)  add %ebx, %eax
    add %ecx, %eax
    mov $16, %edx
    imul %edx

n)  mov $0, %edx
    mov $16, %ecx
    idiv %ecx
    imul %ecx, %ebx
    add %ebx, %eax
    mov %eax, %ecx

o)  and $0xFF00, %eax
    and $0x00FF, %ebx
    add %eax, %ebx
    mov %ebx, %ecx

p)  mov $0, %edx
    add %eax, %ecx
    add %ebx, %eax
    idiv %ecx

q)  mov $0, %edx
    imul %ebx, %eax
    imul %ecx, %ecx
    idiv %ecx

r)  mov %eax, %edx
    add %ebx, %eax
    mov %edx, %ebx
    mov $0, %edx
    idiv %ecx
    add $1, %eax
    imul %ebx