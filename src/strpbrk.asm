;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strpbrk function (like the glibc function)                       |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global strpbrk:function

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

strpbrk:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    xor rax, rax                        ; set return value to 0
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return
    test rsi, rsi                       ; if rsi == NULL,
    jz .end                             ; then return
    xor rcx, rcx                        ; set the counter (rcx) to 0
    mov r9, rsi                         ; save rsi in r9

.look_for_one_byte:
    lodsb                               ; load *rsi++ in al
    movzx r8, byte [rdi + rcx]          ; set r8 to rdi[rcx]

    cmp r8B, 0                          ; if rdi[rcx] == 0,
    je .not_found                       ; then set return value to 0 and quit
    cmp r8B, al                         ; if rdi[rcx] == rsi[rcx],
    je .found                           ; set return value and quit
    cmp al, 0                           ; if rsi[rcx] != 0,
    jne .look_for_one_byte              ; then back to the beginning of the loop

    mov rsi, r9                         ; reset rsi to its original value
    inc rcx                             ; increment the counter
    jmp .look_for_one_byte              ; back to the beginning of the loop

.not_found:
    xor rax, rax                        ; set return value to 0
    jmp .end                            ; return

.found:
    lea rax, [rdi + rcx]                ; set return value to &rdi[rcx]

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
