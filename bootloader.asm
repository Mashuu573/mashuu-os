; Bootloader - MBR
; En esta etapa la funcion de este codigo es imprimir un mensaje de bienvenida en pantalla

section .mbr
	org 0x7c00 ;La bios carga el MBR en esta direccion
	bits 16 ;Modo real de 16 bits

;Inicializacion del entorno
start:
	cli 		;desactivamos interrupciones
	xor ax, ax	;AX = 0
	mov ds, ax	;data segment = 0
	mov es, ax	;extra segment = 0
	mov ss, ax	;stack segment = 0
	mov sp, 0x7c00	;stack pointer
	sti 		;activamos interrupciones

;limpiamos la pantalla

	mov ah, 0x00	;funcion de visualizacion de la bios: establecer modo de video
	mov al, 0x03	;modo 3: modo texto 80x25
	int 0x10

;imprimir mensaje de bienvenida
	mov si, welcome_msg	;SI apunta al mensaje
	call print_string	;llama a la funcion de impresion

	;bucle infinito
.hang:
	hlt		;halt cpu
	jmp .hang	;bucle infinito

;print_string - imprime una cadena terminada en null
;entrada: SI = direccion de la cadena
;modifica: AX, SI
print_string:
	pusha		;modifica todos los registros

.loop:
	lodsb 		;cargar [SI] en AL, SI++
	test al, al 	;comprobar si AL es 0 (fin de la cadena)
	jz .done	;si es 0 terminar

	mov ah, 0x0e	;funcion de visualizacion de la bios: mostrar caracter
	mov bh, 0	;numero de pagina
	mov bl, 0x07	;atributo: caracter blanco, fondo negro
	int 0x10

	jmp .loop 	;continuar con el siguiente caracter

.done:
	popa
	ret

welcome_msg:
	db "Hello from Mashuu Bootloader!", 0x0d, 0x0a, 0

times 510-($-$$) db 0 	;Rellenar hasta los 510 Bytes
dw 0xaa55		;Firma del MBR (little-endian: 55 AA
