d_s segment
    a db 15
    b db 3
    c db 3
    itog db 0
    scobka1 dw 0
    scobka2 db 0
d_s ends
c_s segment
    assume ds:d_s, cs:c_s
begin:
    mov ax,d_s
    mov ds, ax
    mov ah, [b]
    mov al, [a]
    sub al, ah
    mul al
    mov scobka1, ax
    mov ah, [b]
    mov al, [c]
    mul ah
    add ax, 50
    mov bl, 1
    div bl
    mov ax, scobka1
    mov bl, al
    div bl
    mov itog, al
    mov al, 001011000b
    and al, 001011000b
    or al, 00000011b
    not al
    mov ah, 4ch
    int 21h
c_s ends
end begin