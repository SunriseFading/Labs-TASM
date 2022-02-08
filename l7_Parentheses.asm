.model small
.stack 100h
s_s segment
dw 20 dup ('$')
s_s ends

d_s segment
mas db '(({{[1+2]}}))[(()}]', '$'
res db 0
d_s ends

c_s segment
assume ss:s_s, ds:d_s, cs:c_s
begin:
mov ax, d_s
mov ds, ax
xor ax, ax
lea si, mas

met1:
lodsb
or al, al
jz met
cmp al, '('
je met2
cmp al, '{'
je met2
cmp al, '['
je met2

cmp al, ')'
je met3
cmp al, '}'
je met3
cmp al, ']'
je met3
jmp met1

met2:
inc cx
push ax
jmp met1

met3:
cmp cx, 0
jne met4
mov res, 3
jmp met

met4:
dec cx
pop bx
cmp bl, '('
jne m1
cmp al, ')'
je met1
m1:
cmp bl, '{'
jne m2
cmp al, '}'
je met1
m2:
cmp bl, '['
jne m3
cmp al, ']'
je met1
m3:
cmp bl, '$'
je met6

met5:
mov res, 1
cmp cx, 0
je met
jmp met7
mt:
cmp ah, '$'
jne met
jmp met6

met7:
pop ax
loop met7
jmp mt

met6:
mov res, 2

met:
cmp res, 1
jne k1
mov dl, bl
jmp k2

k1:
mov res, 0

k2:
mov ah, 4ch
int 21h



c_s ends
end begin

