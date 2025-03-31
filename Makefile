PROJECT=foo
CPU ?= cortex-m3
BOARD ?= stm32vldiscovery

qemu:
	arm-none-eabi-gcc -mthumb -mcpu=$(CPU) -ggdb -c main.c -o main.o
	arm-none-eabi-gcc -mthumb -mcpu=$(CPU) -ggdb -c nmi.c -o nmi.o
	arm-none-eabi-ld -Tmap.ld main.o nmi.o -o $(PROJECT).elf -Map=$(PROJECT).map
	arm-none-eabi-objdump -D -S $(PROJECT).elf > $(PROJECT).elf.lst
	arm-none-eabi-readelf -a $(PROJECT).elf > $(PROJECT).elf.debug
	qemu-system-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJECT).elf -gdb tcp::1234

gdb:
	gdb-multiarch $(PROJECT).elf -ex "target remote localhost:1234"

clean:
	rm -rf *.out *.elf .gdb_history *.bin *.map *.lst *.debug *.o