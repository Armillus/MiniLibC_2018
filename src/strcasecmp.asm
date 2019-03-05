;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strcasecmp function (like the glibc function)                    |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global strcasecmp:function

;-----------------------------------------------------------------------
;
; @Name           The memset() function returns a pointer to the memory area s.
;
; @Usage          void *memset(void *s, int c, size_t n);
;
; @Prototype in   mem.h & string.h
;
; @Description    The  memset()  function  fills  the first n bytes of the
;                 memory area pointed to by s with the constant byte c.
;
; @reg[in]        rdi     Address of the destination memory area.
; @reg[in]        rsi     Byte to fill in rdi with.
; @reg[in]        rdx     Number of bytes to copy.
; @reg[out]       rax     Destination address.
;
; @Return value   The memset() function returns a pointer to the memory area s.
;
;-----------------------------------------------------------------------

strcasecmp:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    xor rax, rax                        ; set return value to 0
    test rdi, rdi                       ; check if rdi == NULL
    jz .end                             ; return in this case
    test rsi, rsi                       ; check if rsi == NULL
    jz .end                             ; return in this case

    xor rcx, rcx                        ; set counter to 0

.compare_strings:
    movzx r8, byte [rsi + rcx]          ; set the current byte of rsi in r8B
    cmp r8B, 0                          ; if r8B == 0,
    je .set_rax                         ; set return value and return
    cmp byte [rdi + rcx], r8B           ; if *rsi != *rdi
    jne .check_letter_case              ; check the case of the char

.case_bp:
    inc ecx                             ; increment the counter
    jmp .compare_strings                ; back to the begin of the loop

.check_letter_case:
    cmp r8B, 65                         ; check if *rdi >= 'A'
    jl .set_rax                         ; return if not
    cmp r8B, 90                         ; check if *rdi <= 'Z'
    jle .check_lowercase                ; lower *rdi to check the case
    cmp r8B, 97                         ; check if *rdi >= 'a'
    jl .set_rax                         ; return if not
    cmp r8B, 122                        ; check if *rdi <= 'z'
    jle .check_uppercase                ; upper *rdi to check the case

.check_lowercase:
    mov r9, r8                          ; save rsi[rcx] in a tmp register (r9)
    add r9, 32                          ; lower the current letter
    cmp byte [rdi + rcx], r9B           ; check if *rdi == (*rsi + 32)
    jne .set_rax                        ; return if not
    jmp .case_bp                        ; continue the loop otherwise

.check_uppercase:
    mov r9, r8                          ; save rsi[rcx] in a tmp register (r9)
    sub r9, 32                          ; upper the current letter
    cmp byte [rdi + rcx], r9B           ; check if rdi[rcx] == (rsi[rcx] - 32)
    jne .set_rax                        ; return if not
    jmp .case_bp                        ; continue the loop otherwise

.set_rax:
    mov al, byte [rdi + rcx]            ; set al to *rdi
    sub rax, r8                         ; set return value to (*rdi) - (*rsi)

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
