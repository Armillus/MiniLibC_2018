;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strncmp function (like the glibc function)                       |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global my_strncmp:function

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

my_strncmp:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    xor rax, rax                        ; set return value to 0
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return
    test rsi, rsi                       ; if rsi == NULL,
    jz .end                             ; then return

    mov r8, rdi                         ; save rdi in r8
    mov r9, rsi                         ; save rsi in r9
    mov rcx, rdx                        ; set the counter to n (rdx)
    rep cmpsb                           ; compare rcx bytes of rdi and rsi
    je .end                             ; if rdi == rsi, return

    mov r10, rdx                        ; set r10 to n (rdx)
    sub r10, rcx                        ; set r10 to n (rdx) - counter (rcx)
    dec r10                             ; r10 -= 1
    mov al, byte [r8 + r10]             ; set return value to rdi[r10]
    movzx r8, byte [r9 + r10]           ; set r8 to rsi[r10]
    sub rax, r8                         ; set return value to rdi[r10] - rsi[r10]

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
