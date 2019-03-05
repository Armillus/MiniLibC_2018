;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strcpy function (like the glibc function)                        |
;[]-----------------------------------------------------------------[]

BITS 64

section .text
    global strcpy:function

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

strcpy:
	push rbp
	mov rbp, rsp
	xor rax, rax
	xor rbx, rbx

.loop:
	cmp byte [rsi + rbx], 0
	je .end
	movzx rcx, byte [rsi + rbx]
	mov [rdi + rbx], rcx
	inc rbx
	jmp .loop

.end:
	mov rax, rdi
	leave
	ret
