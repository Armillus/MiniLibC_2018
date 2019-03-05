;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strncmp function (like the glibc function)                       |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global strncmp:function

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

strncmp:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    xor rax, rax                        ; set return value to 0
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return
    test rsi, rsi                       ; if rsi == NULL,
    jz .end                             ; then return

    xor rcx, rcx                        ; set the counter (rcx) to 0

.loop:
    movzx r8, byte [rsi + rcx]          ; set r8B to rsi[rcx]
    cmp byte [rdi + rcx], r8B           ; if rsi[rcx] != rdi[rcx],
    jne .set_rax                        ; then set return value and quit
    cmp rcx, rdx                        ; if counter (rcx) == n (rdx)
    je .set_rax                         ; then set return value and quit
    cmp r8B, 0                          ; if rsi[rcx] == 0,
    je .set_rax                         ; then set return value and quit
    inc ecx                             ; increment the counter
    jmp .loop                           ; back to the begin of the loop

.set_rax:
    mov al, byte [rdi + rcx]            ; set return value to rdi[rcx]
    sub rax, r8                         ; set return value to *rdi - *rsi

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
