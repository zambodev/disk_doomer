bits 16
; Offset
org 0x7c00

code_seg 	equ 	gdt_code - gdt_start
data_seg 	equ 	gdt_data - gdt_start


mov	[boot_disk], dl

; Clear screen
mov	ah, 0x06
mov	al, 0x00
mov	bh, 0x00
mov	cx, 0x0000
mov 	dh, 25
mov	dl, 80
int 	0x10

; Print string
mov	ah, 0x13
mov	al, 0x1
mov	bh, 0x0
mov	bl, 0xf
mov	cx, 24			; Lenght of message
mov	dx, 0x011c		; Write in the center of the first line
push	cs
pop	es
mov	bp, wmsg
int	0x10

cli				; Disable interrupts
lgdt	[gdt_descriptor]
mov	eax, cr0		; Change last bist of cr0 to 1
or	eax, 1
mov 	cr0, eax		; 32 bit mode
jmp	code_seg:protected_mode	; Far jump to other segment

jmp	$


%include "gdt.asm"
%include "kernel.asm"


wmsg:		db	"Welcome in Disk Boomer!" ,0
boot_disk:	db	0

; Padding
times 510 - ($ - $$) db 0x00

; Bootloader code
dw 0xaa55

