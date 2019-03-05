;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strcspn function (like the glibc function)                       |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global strcspn:function

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

strcspn:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    xor rax, rax                        ; set return value to 0
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return
    test rsi, rsi                       ; if rsi == NULL,
    jz .end                             ; then return

    xor rcx, rcx                        ; set the counter (rcx) to 0
    mov r8, rsi                         ; save rsi in r8

.count_accepted_bytes:
    lodsb                               ; load *rsi++ into al
    cmp byte [rdi + rcx], 0             ; if rdi[rcx] == 0,
    je .end                             ; then return
    cmp al, byte [rdi + rcx]            ; if al (*rsi - 1) == rdi[rcx]
    je .end                             ; then return
    cmp al, 0                           ; if al != 0,
    jne .count_accepted_bytes           ; then back to the begin of the loop
    inc rcx                             ; increment the counter
    mov rsi, r8                         ; reset rsi to its original value
    jmp .count_accepted_bytes           ; back to the begin of the loop

.end:
    mov rax, rcx                        ; set the return value to the counter
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
