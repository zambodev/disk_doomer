bits 16


clear_screen:
	mov	al, 0x00
	mov	bh, 0x00
	mov	cx, 0x00
	mov 	dh, 25
	mov	dl, 80
	mov	ah, 0x06
	int 	0x10	
	
	ret

; dx: row:col, bp: msg, cx: len
print_string:
	mov	al, 0x01
	xor	bh, bh
	mov	bl, 0x0f
	push	cs
	pop	es
	mov	ah, 0x13
	int	0x10
	
	ret

; dx: row:col, al: char
print_char_setc:
	; Set cursor position
	xor	bh, bh
	mov	ah, 0x02
	int 	0x10
	
	mov	cx, 0x01
	xor	bh, bh
	mov	bl, 0x0f
	mov	ah, 0x09
	int 	0x10

	ret

; dx: al: char
print_char_atc:
	mov	cx, 0x01
	xor	bh, bh
	mov	bl, 0x0f
	mov	ah, 0x09
	int 	0x10

	ret


