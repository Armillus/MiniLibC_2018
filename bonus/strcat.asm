;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strcat function (like the glibc function)                       |
;[]-----------------------------------------------------------------[]

[BITS 64]

extern strlen, printf

section .text
    global strcat:function

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

strcat:
    push rbp
    mov rbp, rsp
    test rdi, rdi
    jz .end
    test rsi, rsi
    jz .end
    call strlen wrt ..plt
    mov rdx, rax
    xor rcx, rcx
    mov rax, rdi

.loop:
    cmp byte [rsi + rcx], 0
    je .end
    movzx r8, byte [rdx + rcx]
    movzx rbx, byte [rsi + r8]
    mov [rax + r8], rbx
    inc rcx
    jmp .loop

.end:
    leave
    ret
