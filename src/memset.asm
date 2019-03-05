    ;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] memset function (like the glibc function)                        |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global memset:function

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

memset:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    push rdi                            ; push the argument
    test rdi, rdi                       ; check the first argument
    jz .end                             ; return in this case
    test rdx, rdx                       ; check the number of bytes to memset
    jz .end                             ; return if rdx == 0

    mov rcx, rdx                        ; set the counter to decrement
    mov al, sil                         ; set the byte to memset
    rep stosb                           ; set rcx bytes from rdi to the sil byte

.end:
    pop rax                             ; return the first argument
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
