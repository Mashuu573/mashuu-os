#Bootloader Makefile
#Defino las herramientas a utilizar
#Se define los nombres del ensamblador, el emulador y el depurador
# Estas variables se colocan al inicio para facilitar su modificacion a futuro. Por ejemplo, si se
#desea utilizar un emulador diferente, solo se cambia la variable QEMU

NASM = nasm
QEMU = qemu-system-x86_64
DEBUGGER = gdb


#Defino los archivos de origen y los de destino

BOOT_SRC = bootloader.asm #Es el nombre del archivo fuente
BOOT_BIN = $(BUILD_DIR)/bootloader.bin #Es el nombre del archivo binario compilado
BOOT_IMG = $(BUILD_DIR)/boot.img #Es el nombre del archivo de imagen del disco final

#Defino el directorio de compilacion
BUILD_DIR = ../build #Creo el directorio para quetodos los artefactos de compilacion se coloquen aqui
		     #para mantener limpio el directorio raiz del proyecto


#punto  default
#Aqui se establecen las reglas
.PHONY: all		# Es el objetivo predeterminado y depende de $(BOOT_IMG). .PHONE: hace que
all: $(BOOT_IMG)	#Make detecte que es un objetivo ficticio y que no corresponde a un archivo real


#Creo la compilacion del bootloader
#$(BOOT_BIN) compila los archivos fuente segun las reglas
$(BOOT_BIN): $(BOOT_SRC)
	@echo "--> Creando bootloader.." #Echo es simplemente un print en pantalla
	@mkdir -p $(BUILD_DIR) #crea el directorio y no provocara ningun error si ya existe
	$(NASM) -f bin $< -0 $@ # compila los archivos fuentes, $< es un archivo dependencia(archivo fuente). $Q es el archivo de destino (archivo binario)
	@echo "--> completado: $@"

#Creo una imagen de disco (disquete de 1,44 mb)
$(BOOT_IMG): $(BOOT_BIN) #La regla crea una imagen del disco. (primera regla)
	@echo "--> creando imagen del disco"
	dd if=/dev/zero of=$@ bs=512 count=2880 status=note #dd el comando crea una imagen vacia. uf=/dev/zero esto indica que se esta leyendo desde un dispositivo cero (es decir, todo cero). 
							    #of=$@ es el archivo de salida. bs=512 tiene el tamaño de un bloque. count=2880 es la cantidad de bloques, 
				                            #por lo que el total es 512x2880 = 1474560 bytes que es exactamente 1,44 mb
	dd if=$< of=$@ bs=512 conv=notrunc status=none #dd escribe el gestor de arranque al principio de la imagen. conv=notrunc es importante porque le indica a dd que no trunque el archivo de salida.
	@echo "--> Creacion de imagen del disco: $@"

#Iniciar QEMU
.PHONY: run #run inicia QEMU con reglas
run: $(BOOT_IMG)
	$(QEMU) -drive format=raw,file=$(BOOT_IMG),if=floppy -nographic #indica a QEMU que cargue nuestra imagen utilizando la interfaz de disquete. -nographic indica que no se utilizara una interfaz grafica y que toda la salida se mostrara en terminal(se puede desmarcar si se desea utilizar)

#Limpieza
.PHONY: clean #clean elimina el directorio de compilacion 
	      #elimina forzosamente el directorio y su contenido. -rf esto indifca una eliminacion recursiva sin solicitud de confirmacion.
clean:
	rm -rf $(BUILD_DIR) 
	@echo "--> limpieza terminada"


