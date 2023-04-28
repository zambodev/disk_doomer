bits 32


protected_mode:
	mov	ax, data_seg		; Sata seg setup
	mov	ds, ax
	mov	ss, ax
	mov	es, ax
	mov 	fs, ax
	mov	gs, ax
	mov	ebp, 0x90000		; Stack setup
	mov	esp, ebp
	sti				; Enable interrupts


	jmp $

