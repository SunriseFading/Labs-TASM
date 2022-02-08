d_s segment
mas dw 18 dup (?)
min dw 0
max dw 0
d_s ends

c_s segment
assume cs:c_s, ds:d_s
begin:
mov ax, d_s
mov ds, ax
mov min, 9FFFh
mov si, 0
mov mas[si], 0
add si, 2
mov mas[si], 1
add si, 2

mov cx, 16
met1:
mov ax, mas[si-4]
add ax, mas[si-2]
mov mas[si], ax
add si, 2
loop met1

mov si, 12
xor cx, cx
mov cx, 6
met2:
mov ax, mas[si]
ror ax, 1
jc nech
jmp met4
nech:
rol ax, 1
cmp ax, min
jl minimum
jmp met4
minimum:
mov min, ax
met4:
add si, 2
loop met2

xor ax, ax
xor si, si
mov si, 6
mov cx, 3
met3:
mov ax, mas[si]
ror ax, 1
jnc chet
jmp met5
chet:
rol ax, 1
cmp ax, max
jg maximum
jmp met5
maximum:
mov max, ax
met5:
add si, 12
loop met3
mov ah, 4ch
int 21h
c_s ends
end begin
