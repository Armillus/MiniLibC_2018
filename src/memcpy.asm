;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] memmove function (like the glibc function)                       |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
   global memcpy:function

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

memcpy:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    mov rax, rdi                        ; set the return value to *dest (rdi)
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return

    cmp rdi, rsi                        ; if dest (rdi) == src (rsi),
    je .end                             ; then return
    test rdi, rdi                       ; if dest (rdi) == NULL,
    jz .end                             ; then return
    test rsi, rsi                       ; if src (rsi) == NULL,
    jz .end                             ; then return
    test rdx, rdx                       ; if n (rdx) == 0,
    jz .end                             ; then return (there is nothing to copy)

    mov rcx, rdx                        ; set to n (rdx) the counter (rcx)
    rep movsb                           ; copy n (rcx) bytes
                                        ; from src (rsi) to dest (rdi)

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
