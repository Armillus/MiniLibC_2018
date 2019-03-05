;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] memset function (like the glibc memset)                          |
;[]-----------------------------------------------------------------[]

;[]-----------------------------------------------------------------[]
;|   MEMMOVE.ASM --  copy a block of n bytes from src to dst         |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global strlen:function

;-----------------------------------------------------------------------
;
; @Name           memmove - copy a block of n bytes from src to dst
;
; @Usage          void *memmove(void *dest, const void *src, size_t n);
;
; @Prototype in   mem.h & string.h
;
; @Description    memmove copies  a block of n  bytes from src to dest. Even
;                 when the source and destination blocks overlap, bytes in
;                 the overlapping locations are copied correctly.
;
; @reg[in]        rdi     Address of the destination memory area.
; @reg[in]        rsi     Address of the source memory area.
; @reg[in]        rdx     Number of bytes to copy.
; @reg[out]       rax     Destination address.
;
; @Return value   memmove returns dest
;
;-----------------------------------------------------------------------

strlen:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    xor rax, rax                        ; set return value to 0
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return

.loop:
  	cmp byte [rdi + rax], 0             ; if *rdi == '\0' (end of string),
  	je .end                             ; then return
  	inc eax                             ; increment the return value (counter)
  	jmp .loop                           ; back to the begin of the loop

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
