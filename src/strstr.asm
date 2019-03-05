;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strstr function (like the glibc function)                        |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global strstr:function

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

strstr:
    push rbp                            ; this part can be replaced
    mov rbp, rsp                        ; with enter keyword

    xor rax, rax                        ; set return value to 0
    test rdi, rdi                       ; if rdi == NULL,
    jz .end                             ; then return
    test rsi, rsi                       ; if rsi == NULL,
    jz .end                             ; then return
    xor rcx, rcx                        ; set the counter (rcx) to 0
    mov r8, rsi                         ; save rsi in r8
    mov r10, rdi                        ; save rdi in r10

.look_for_needle:
    lodsb                               ; load *rsi++ in al
    movzx r9, byte [rdi + rcx]          ; set r9 to rdi[rcx]

.loop_bp:
    cmp al, 0                           ; if (*rsi - 1) == 0,
    je .needle_found                    ; set return value and quit
    cmp r9B, 0                          ; if rdi[rcx] == 0,
    je .needle_not_found                ; set return value to 0 and quit
    cmp al, r9B                         ; if (*rsi - 1) == rdi[rcx],
    je .inc_counter                     ; increment the counter (rcx) and
                                        ; back to the beginning of the loop

    xor rdx, rdx                        ; set rdx to 0
    inc rcx                             ; counter (rcx) += 1
    mov rsi, r8                         ; reset rsi to its original value
    mov rdi, r10                        ; reset rdi to its original value
    jmp .look_for_needle                ; back to the beginning of the loop

.inc_counter:
    inc rdi                             ; counter (rcx) += 1
    jmp .look_for_needle                ; back to the beginning of the loop

.needle_found:
    lea rax, [r10 + rcx]                ; set return value to rdi[rcx]
    jmp .end                            ; return

.needle_not_found:
    xor rax, rax                        ; set return value to 0

.end:
    leave                               ; leave the program (reverse of enter)
    ret                                 ; return and quit
