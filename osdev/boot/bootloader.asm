section .mbr
	org 0x7c00
	bits 16

start: 

	cli
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7c00
	sti



	mov al, 'A'
	mov ah, 0x0e
	mov bh, 0
	mov bl, 0x07
	int 0x10

.hang:
	hlt
	jmp .hang

times 510-($-$$) db 0

dw 0xaa55
