;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] memmove function (like the glibc function)                       |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global memmove:function

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

memmove:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    mov rax, rdi                        ; set return value to dest (rdi)
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return
    test rsi, rsi                       ; if rsi == NULL,
    jz .end                             ; then return
    test rdx, rdx                       ; if n (rdi) == NULL,
    jz .end                             ; then return

    cmp rdi, rsi                        ; if dest (rdi) == src (rsi),
    je .end                             ; then return
    mov rcx, rdx                        ; set the counter (rcx) to n (rdx)
    jl .copy_fast                       ; if dest (rdi) < src (rsi), copy fast

    mov r8, rsi                         ; set r8 to src (rsi)
    add r8, rdx                         ; set r8 to src + rdx (rdi[rdx])
    cmp rdi, r8                         ; if dest >= src + n
    jge .copy_fast                      ; then copy fast

    std                                 ; set the direction flag to 1
    dec rdx                             ; rdx -= 1
    add rsi, rdx                        ; src (rsi) += n (rdx)
    add rdi, rdx                        ; dest (rdi) += n (rdx)
    rep movsb                           ; copy n (rcx) bytes from src to dest
                                        ; (copy from end to beginning)
    cld                                 ; set the direction flag to 0
    jmp .end                            ; return

.copy_fast:
    rep movsb                           ; copy n (rcx) bytes from src (rsi)
                                        ; to dest (rdi)

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
