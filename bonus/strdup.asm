;[]-----------------------------------------------------------------[]
;[] EPITECH PROJECT, 2018                                            |
;[] ASM_minilibc                                                     |
;[] File description:                                                |
;[] strcasecmp function (like the glibc function)                    |
;[]-----------------------------------------------------------------[]

BITS 64

extern malloc, strlen

section .text
    global strdup:function

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

strdup:
	push rbp
	mov rbp, rsp
	xor rax, rax
	cmp rdi, 0
	je .fail_exit
	push rdi
	call strlen wrt ..plt
	inc rax
	mov rdi, rax
	xor rax, rax
	call malloc wrt ..plt
	cmp rax, 0
	je .fail_exit
	pop rsi
	xor rcx, rcx

.loop:
	cmp byte [rsi + rcx], 0
	je .end
	mov dl, byte [rsi + rcx]
	mov byte [rax + rcx], dl
	inc rcx
	jmp .loop

.fail_exit:
	leave
	ret

.end:
	mov byte [rax + rcx], 0
	leave
	ret
