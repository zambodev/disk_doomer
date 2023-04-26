bits 32


	section .multiboot
dd 0x1BADB002				; set magic number for bootloader
dd 0x0					; set flags
dd - (0x1BADB002 + 0x0)			; set checksum


	section .text
	global start

start:
	cli				; block interrupts

	push	ebp
	mov 	esp, stack
	mov	ebp, esp

	mov	eax, 2
	mov 	ebx, 0
	mov 	ecx, 24
	mov 	edx, message
	call	print


	hlt				; halt the CPU

print:
	push	eax
	push	ebx
	push	ecx
	push	edx

	imul	eax, eax, 80
	add	ebx, eax
	mov 	eax, [VGAADDR]
	add	eax, ebx

.L1:
	mov 	bx, WORD [edx]
	mov	bh, 0xF
	mov 	WORD [eax], bx

	add 	eax, 2
	dec 	ecx
	inc 	edx
	cmp	ecx, 1
	jg	.L1

	pop 	edx
	pop	ecx
	pop	ebx
	pop	eax

	ret


	section .data
VGAADDR:	dd	0xB8000		; VGA memory address: 25 line, 80 cols
message:	db 	"Welcome to DISK DOOMER!", 10, 0


	section .bss
resb	1024
stack:

