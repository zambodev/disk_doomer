bits 16
; Offset
org 0x7c00


mov	[boot_disk], dl

call	clear_screen

mov	dx, 0x011c
mov	bp, welcome_msg
mov	cx, 23
call	print_string

; Print number disk message
mov	dx, 0x0300
mov	bp, ndisk_msg
mov	cx, 23
call	print_string

; Get number of drives
xor	dl, dl
mov	ah, 0x08
int	0x13

; Print number of disk
mov	al, dl
add	al, '0'
mov	dx, 0x0400
call	print_char_atc



jmp $


%include "utils.asm"

welcome_msg:	db	"Welcome in Disk Doomer!", 0
ndisk_msg:	db	"Number of disks found: ", 0
boot_disk:	db	0

; Padding
times 510 - ($ - $$) db 0x00

; Bootloader code
dw 0xaa55

