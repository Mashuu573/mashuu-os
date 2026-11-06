#Bootloader Makefile
#Defino las herramientas a utilizar
#Se define los nombres del ensamblador, el emulador y el depurador
# Estas variables se colocan al inicio para facilitar su modificacion a futuro. Por ejemplo, si se
#desea utilizar un emulador diferente, solo se cambia la variable QEMU

NASM = nasm
QEMU = qemu-system-x86_64
DEBUGGER = gdb


#Defino los archivos de origen y los de destino

BOOT_SRC = bootloader.asm
BOOT_BIN = $(BUILD_DIR)/bootloader.bin
BOOT_IMG = $(BUILD_DIR)/boot.img

#Defino el directorio de compilacion
BUILD_DIR = ../build

#punto  predeterminado

.PHONY: all
all: $(BOOT_IMG)

#Creo la compilacion del bootloader
$(BOOT_BIN): $(BOOT_SRC)
	@echo "--> Creando bootloader.."
	@mkdir -p $(BUILD_DIR)
	$(NASM) -f bin $< -o $@
	@echo "--> completado: $@"

#Creo una imagen de disco (disquete de 1,44 mb)
$(BOOT_IMG): $(BOOT_BIN)
	@echo "--> creando imagen del disco"
	dd if=/dev/zero of=$@ bs=512 count=2880 status=none
	dd if=$< of=$@ bs=512 conv=notrunc status=none
	@echo "--> Creacion de imagen del disco: $@"

#Iniciar QEMU
.PHONY: run
run: $(BOOT_IMG)
	$(QEMU) -drive format=raw,file=$(BOOT_IMG),if=floppy -nographic

#Limpieza
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	@echo "--> limpieza terminada"

