s_s segment stack
rez db 20 dup(0)
s_s ends

d_s1 segment
a db 10001010b
d_s1 ends

d_s2 segment
    adr dd c1
d_s2 ends

d_s3 segment
b db 10101010b
d_s3 ends

c_s1 segment
assume cs:c_s1, ds:d_s1
c1 label far 
mov ax, d_s1
mov ds, ax
mov ah, a
ror ah, 4
jc zn1
mov bl, 0
zn1: mov cl, 1
jmp far ptr met2
c_s1 ends

c_s2 segment
assume cs:c_s2, ds:d_s3
met2:
mov ax, d_s3
mov ds, ax
mov ah, b
rol ah, 3
jc zn2
mov bh, 0
zn2: mov ch, 1
jmp far ptr metK
c_s2 ends

c_s3 segment
assume cs:c_s3, ds:d_s1
begin:
mov ax, d_s1
mov ds, ax
mov ah, a
shl ah, 1
assume cs:c_s3, ds:d_s3
mov ax, d_s3
mov ds, ax
mov ah, b 
shr ah, 2
assume ds:d_s2
jmp adr
exit label far 
metK: mov ah,4ch
int 21h
c_s3 ends
end begin