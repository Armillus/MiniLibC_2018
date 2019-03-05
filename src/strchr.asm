;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strchr function (like the glibc function)                        |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global strchr:function             ; export this function to make it useful

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

strchr:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    xor rax, rax                        ; set return value to 0
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return
    xor rcx, rcx                        ; set the loop incrementer to 0

.loop:
    cmp sil, byte [rdi + rcx]           ; check if the seek char is found
    je .mv_rax                          ; set the correct return value in this case

    cmp byte [rdi + rcx], 0             ; check if the current char is '\0'
    je .end                             ; finish the program in this case

    inc ecx                             ; increment the counter
    jmp .loop                           ; return to the beginning of the loop

.mv_rax:
    mov rax, rdi                        ; move the argument in the return value
    add rax, rcx                        ; move the pointer to the found character

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
