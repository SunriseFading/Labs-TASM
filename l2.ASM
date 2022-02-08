
d_s1 segment
b1 db 10001010b
d_s1 ends

d_s2 segment
adr dd c1
d_s2 ends

d_s3 segment
b2 db 10101010b
d_s3 ends

c_s1 segment
assume cs:c_s1
c1 label far
mov ax, d_s1
mov ds, ax
assume ds:d_s1
mov ax, 0
mov al, b1
ror al, 4 ; ??????????? ????? ??????
jmp far ptr c2
c_s1 ends

c_s2 segment
assume cs:c_s2
c2 label far
mov ax, d_s3
mov ds, ax
assume ds:d_s3
mov ax, 0
mov bx, 0
mov al, b2
rol al, 3
jmp far ptr exit
c_s2 ends

c_s3 segment
assume cs:c_s3
Begin:
mov ax, d_s1
mov ds, ax
assume ds:d_s1
mov al, b1
shl al, 1 ; ????????? ?? 2

mov ax, d_s3
mov ds, ax
assume ds:d_s3
mov ax, 0
mov al, b2
shr al, 2 ; ??????? ??4

mov ax, d_s2
mov ds, ax
assume ds:d_s2
jmp adr

exit label far
mov ah, 4ch
int 21h
c_s3 ends
END Begin