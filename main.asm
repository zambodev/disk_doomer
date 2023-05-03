bits 16
; Offset
org 0x7c00


mov	[boot_disk], dl

; Setup stack
mov	bp, 0x8000
mov	sp, bp

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
mov	ax, 0x0040
mov	es, ax
mov	dx, [es:0x0075]

; Print number of drives
mov	al, dl
add	al, '0'
mov	dx, 0x0400
call	print_char_atc

; Read from disk
mov	al, 0xe0
mov	dx, 0x01f6
out 	dx, al			; Send 0xe0 to master
				; Skip sending null byte
mov	cl, 0x01		; 1 sector
mov	al, cl
mov	dx, 0x01f2
out 	dx, al			; Send sector count

mov	al, byte [lba_src]
mov	dx, 0x01f3		
out 	dx, al			; Send first 8 bit of LBA

mov	al, byte [lba_src + 1]
mov	dx, 0x01f4		
out 	dx, al			; Send next 8 bit of LBA

mov	al, byte [lba_src + 2]
mov	dx, 0x01f5		
out 	dx, al			; Send next 8 bit of LBA

mov	al, 0x30		; Write sectors command
mov 	dx, 0x01f7
out 	dx, al

.wait_data:
	in 	al, dx
	test	al, 0x08
	jz	.wait_data

mov	al, 0x11
mov	dx, 0x01f0
out	dx, al

mov	al, 0xe7
mov	dx, 0x01f7
out	dx, al


; Print done msg
mov	dx, 0x0700
mov	bp, done_msg
mov	cx, 5
call	print_string

jmp $


%include "utils.asm"

welcome_msg:	db	"Welcome in Disk Doomer!", 0x0
ndisk_msg:	db	"Number of disks found: ", 0x0
err_msg: 	db 	"Error!", 0x0
done_msg:	db	"Done!", 0x0
boot_disk:	db	0x0
lba_src:	dd 	0x0
; Padding
times 510 - ($ - $$) db 0x00

; Bootloader code
dw 0xaa55

