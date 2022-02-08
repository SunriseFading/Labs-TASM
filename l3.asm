d_s segment
a db 5Ah
b db 9Fh
res_NOD db 0
d_s ends
c_s segment
assume ds:d_s, cs:c_s
begin:
mov ax, d_s
mov ds, ax
mov ah, a
mov al, b
met:
mov bh, ah
mov bl, al
sub bh, bl
jz met1
cmp ah, al
ja met2
mov ch, al
mov cl, ah
sub ch, cl
mov ah, ch
mov al, cl
jmp met3
met2:
sub ah, al
met3:
jmp met
met1:
mov res_NOD, ah
mov dl, 0
mov cx, 4
met4:
ror ah, 1
jnc met5
inc dl
met5:
loop met4
mov ah, 4ch
int 21h
c_s ends
end begin