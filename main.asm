global _start
 
extern WriteFile
extern GetStdHandle

extern append
extern get
extern remove
extern get_size
 
section .data
result: dq 0
divide_number: dq 0
residue: dq 0
print_char: dq 72
division: dq 10

section .text       
_start:
    mov qword [rel divide_number], 293
    call parse_int_to_string
    call print_num
    ret

parse_int_to_string:
    cmp qword [rel divide_number], 9
    je parse_int_to_char
    js parse_int_to_char

    call parsing_cycle
    ret

parsing_cycle:
    xor rax, rax
    xor rdx, rdx

    mov rax, qword [rel divide_number]
    div qword [rel division]
    mov qword [rel residue], rdx

    xor rdx, rdx

    mov rax, qword [rel divide_number]
    div qword [rel division]
    mov qword [rel divide_number], rax

    mov rcx, qword [rel residue]
    call parse_int_to_char

    mov rcx, rax
    call append

    cmp qword [rel divide_number], 9
    je append_parse_char
    js append_parse_char

    jmp parsing_cycle
    ret

append_parse_char:
    mov rcx, qword [rel divide_number]
    call parse_int_to_char

    mov rcx, rax
    call append
    ret

parse_int_to_char:
    cmp rcx, 0
    je parse0
    cmp rcx, 1
    je parse1
    cmp rcx, 2
    je parse2
    cmp rcx, 3
    je parse3
    cmp rcx, 4
    je parse4
    cmp rcx, 5
    je parse5
    cmp rcx, 6
    je parse6
    cmp rcx, 7
    je parse7
    cmp rcx, 8
    je parse8
    cmp rcx, 9
    je parse9
    ret

parse0:
    mov rax, 48
    ret
parse1:
    mov rax, 49
    ret
parse2:
    mov rax, 50
    ret
parse3:
    mov rax, 51
    ret
parse4:
    mov rax, 52
    ret
parse5:
    mov rax, 53
    ret
parse6:
    mov rax, 54
    ret
parse7:
    mov rax, 55
    ret
parse8:
    mov rax, 56
    ret
parse9:
    mov rax, 57
    ret

print_num:
    call get_size
    mov rcx, rax
    dec rcx
    call print_cycle

    mov rcx, 0
    call get
    call print
    ret

print_cycle:
    push rcx
    call get
    pop rcx
    call print
    loop print_cycle
    ret

print:
    push rcx
    push rdx
    push r8

    mov qword [rel print_char], rax

    sub  rsp, 40
    mov  rcx, -11
    call GetStdHandle
    mov  rcx, rax
    mov  rdx, print_char
    mov  r8, 1
    xor  r9, r9
    mov  qword [rsp + 32], 0
    call WriteFile
    add  rsp, 40

    pop r8
    pop rdx
    pop rcx
    ret