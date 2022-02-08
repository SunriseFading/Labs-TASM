.model small
.stack 20h

d_s segment
z1 dw 20h
z2 dw 20h
res1 dw ?
res2 dw ?
d_s ends

c_s segment
assume ds:d_s, cs:c_s

bv proc near
push bp
mov bp, sp
mov cx, [bp+4]
mov ax, cx
mul bx
mov bx, ax
dec cx
jcxz met
push cx
call bv

met:
mov sp, bp
pop bp
ret
bv endp

begin:
mov ax, d_s
mov ds, ax
xor ax, ax
mov bx, 1
mov ax, z1
push ax
xor ax, ax
call bv
mov res1, ax
mov bx, offset z2
mov ax, word ptr [bx]
push ax
mov bx, 1
xor ax, ax
call bv
mov res2, ax
mov ah, 4ch
int 21h
c_s ends
end begin

