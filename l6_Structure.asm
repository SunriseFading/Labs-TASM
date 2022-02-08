.model small
.stack 256
bol struc
card_number db 2 dup (' ')
gender db 1 dup(' ')
year_of_birth db 4 dup (' ')
datein db ('  /  /    ')
dateout db ('  /  /    ')
bol ends

d_s segment
	       zap1 bol <'28','m','2001','22/11/2019','30/11/2019'>
	       zap2 bol <'12','w','1997','23/11/2019','30/11/2019'>
	       zap3 bol <'57','m','1968','17/11/2019','30/11/2019'>
	date1  db   '22/11/2019'
	date2  db   '30/11/2019'
	number db   '12'
	year   db   '2001'
	d8     db   0Dh, 0Ah, '$'
d_s ends
c_s segment
	        assume ds:d_s, cs:c_s
	begin:  
	        mov    ax, d_s
	        mov    ds, ax
	        mov    es, ax
	        xor    ax, ax
	task1:  
	        mov    di, offset date1
	        mov    si, offset zap1.datein
	        call   p1
	        mov    di, offset date1
	        mov    si, offset zap2.datein
	        call   p1
	        mov    di, offset date1
	        mov    si, offset zap3.datein
	        call   p1
	        mov    ax, bx
	        call   s4
	        call   s5
          
	task2:  
	        xor    ax,ax
	        xor    bx,bx
	        xor    dx,dx
	        mov    dl,'w'
	        mov    al, zap1.gender
	        mov    di, offset date2
	        mov    si, offset zap1.dateout
	        call   p3
	        mov    dl,'w'
	        mov    al, zap2.gender
	        mov    di, offset date2
	        mov    si, offset zap2.dateout
	        call   p3
	        mov    dl,'w'
	        mov    al, zap3.gender
	        mov    di, offset date2
	        mov    si, offset zap3.dateout
	        call   p3
	        mov    ax,bx
	        call   s4
	        call   s5

	task3:  
	        xor    ax, ax
	        xor    bx,bx
	        xor    dx,dx
	        mov    di, offset number
	        mov    si, offset zap1.card_number
	        call   p4
	        cmp    bx,1
	        je     met1
	        jmp    met2
	met1:   
	        mov    ah, 40h
	        mov    bx, 1
	        mov    dx, offset zap1.year_of_birth
	        mov    cx, 4
	        int    21h
	        jmp    task4
	met2:   
	        mov    di, offset number
	        mov    si, offset zap2.card_number
	        call   p4
	        cmp    bx,1
	        je     met3
	        jmp    met4
	met3:   
	        mov    ah, 40h
	        mov    bx, 1
	        mov    dx, offset zap2.year_of_birth
	        mov    cx, 4
	        int    21h
	        jmp    task4
	met4:   
	        mov    di, offset number
	        mov    si, offset zap3.card_number
	        call   p4
	        cmp    bx,1
	        je     met5
	        jmp    task4
	met5:   
	        mov    ah, 40h
	        mov    bx, 1
	        mov    dx, offset zap3.year_of_birth
	        mov    cx, 4
	        int    21h
	task4:  
	        call   s5
	        xor    ax,ax
	        xor    bx,bx
	        xor    dx,dx
	        mov    dl,'m'
	        mov    al, zap1.gender
	        mov    di, offset year
	        mov    si, offset zap1.year_of_birth
	        call   p6
	        mov    dl,'m'
	        mov    al, zap2.gender
	        mov    di, offset year
	        mov    si, offset zap2.year_of_birth
	        call   p6
	        mov    dl,'m'
	        mov    al, zap3.gender
	        mov    di, offset year
	        mov    si, offset zap3.year_of_birth
	        call   p6
	        mov    ax,bx
	        call   s4
	        mov    ah,4Ch
	        int    21h
p1 proc near
	        cld
	        mov    cx,10
	        repe   cmpsb
	        jne    m1
	        inc    bx
	m1:     
	        retn
p1 endp

p3 proc	near
	        cld
	        mov    cx,10
	        repe   cmpsb
	        jne    m3
	        cmp    dl,al
	        je     m2
	        jmp    m3
	m2:     
	        inc    bx
	m3:     
	        retn
p3 endp

p4 proc	near
	        cld
	        mov    cx,1
	        repe   cmpsb
	        jne    m4
	        inc    bx
	m4:     
	        retn
p4 endp

p6 proc	near
	        cld
	        mov    cx,3
	        repe   cmpsb
	        jne    m6
	        cmp    dl,al
	        je     m5
	        jmp    m6
	m5:     
	        inc    bx
	m6:     
	        retn
p6 endp

s4 proc	near
	        mov    bx,0Ah
	        xor    cx,cx
	        or     ax,ax
	l10:    
	        xor    dx,dx
	        div    bx
	        add    dl,30h
	        push   dx
	        inc    cx
	        or     ax,ax
	        jnz    l10

	loop_11:
	        pop    ax
	        int    29h
	        loop   loop_11

	        retn
s4 endp

s5 proc	near
	        mov    ah,9
	        mov    dx,offset d8
	        int    21h
	        retn
s5 endp


c_s ends
end begin
