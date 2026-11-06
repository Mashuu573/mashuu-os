;bootloader - programa de prueba

;Este es el primer acercamiento al bootloader, su funcion es simple: imprimir un caracter en pantalla
;luego entrar en un bucle infinito. esto nos permite verificar si la configuracion de entorno es correcta

section .mbr
	org 0x7c00 ;La bios carga el MBR en esta direccion
	bits 16 ;Comenzamos desde el modo real de 16 bits

start:
; deshabilitamos las interrupciones, para configurar los registros de segmento
	cli ;limpiamos interrupciones - por ahora no se necesitan
	xor ax, ax ;ax = 0
	mov ds, ax ;data segment = 0
	mov es, ax ;extra segment = 0
	mov ss, ax ; stack segment = 0
	mov sp, 0x7c00 ;Stack pointer = direccion de inicio del MBR
	sti ;habilitamos interrupciones


	;imprimimos un caracter "a" en pantalla
	mov al, 'A' ;caracter
	mov ah, 0x0e ;funcion de visualizacion de la bios
	mov bh, 0 ;numero de pagina
	mov bl, 0x07 ;atributo(caracter blanco)
	int 0x10 ;llamar a la interrupcion de la bios

.hang:
	hlt ;halt CPU
	jmp .hang ;bucle infinito

;rellenar hasta los 510 bits
times 510-($-$$) db 0

;firma del MBR (Obligatorio)
dw 0xaa55
