;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] rindex function (like the glibc function)                       |
;[]-----------------------------------------------------------------[]

BITS 64

extern strlen

section .text
    global rindex:function

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

rindex:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    xor rax, rax                        ; set return value to 0
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return
    push rdi                            ; give an argument to strlen (rdi)
    call strlen wrt ..plt               ; call strlen function


; loop to find a byte in a string from right to left
.find_last_chr:
    cmp sil, byte [rdi + rax]           ; if *rdi == sil (searched byte),
    je .set_rax                         ; set the return value and return
    cmp rax, 0                          ; if the counter == 0,
    je .end                             ; return
    dec rax                             ; decrement the counter
    jmp .find_last_chr                  ; back to the begin of the loop

; set the return value
.set_rax:
    lea rax, [rdi + rax]                ; set return value to rdi + rax
                                        ; (it shift the pointer)

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
