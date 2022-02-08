d_s segment
    a db 3
    b db 2
    c db 4
    itog dw 0
    scobka1 dw 0
d_s ends
c_s segment
    assume ds:d_s, cs:c_s
begin:
    mov ax,d_s
    mov ds, ax
    mov ah, c
    mov al, b
    mul ah
    mov bl, a
    div bl
    mov al, 1
    mul ah
    mov scobka1, ax
    mov ah, a
    mov al, b
    mul ah
    mov bx, scobka1
    sub ax, bx
    add ax, 12
    mov ax, itog
    mov al, 11111111b
    not al
    xor al, al
    or al, 10000010b
    mov ah, 4ch
    int 21h
c_s ends
end begin