s_s segment
dw 5 dup (?)
s_s ends

d_s segment
mas1 db 8, 3, 5, 2, 6, 1, 9, 7
mas2 db 8 dup (0)
d_s ends

c_s segment
assume ss:s_s, ds:d_s, cs:c_s
vos proc near
mov cx, 7
mov si, 0
mov di, si
inc di

met1:
push cx
mov al, mas1[si]

met2:
mov ah, mas1[di]
cmp al, ah
ja met3
jmp met4


met3:
mov mas1[si], ah
mov mas1[di], al
mov al, ah

met4:
inc di
loop met2

pop cx
inc si
mov di, si
inc di
loop met1
ret
vos endp

begin:
mov ax, d_s
mov ds, ax
call vos
mov ax, 4ch
int 21h
c_s ends
end begin

