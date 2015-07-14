
ARMGNU ?= ./tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf

INCLUDEPATH ?= "./h"

COPS = -Wall -O2 -nostdlib -nostartfiles -ffreestanding -mcpu=arm1176jzf-s -I $(INCLUDEPATH)
COPS7 = -Wall -O2 -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mtune=cortex-a7 -nostartfiles -I $(INCLUDEPATH) -g

gcc : kernel7.img kernel.img 

OBJS = build/startup.o 
OBJS += build/uart.o
OBJS += build/timer.o
OBJS += build/interrupts.o
OBJS += build/OS_Cpu_a.o
OBJS += build/OS_Cpu_c.o
OBJS += build/ucos_ii.o
OBJS += build/main.o
OBJS += build/userApp.o
OBJS += build/gpio.o
OBJS += lib/libc.a
OBJS += lib/libgcc.a 

OBJS7 = build/startup.o 
OBJS7 += build/uart7.o
OBJS7 += build/timer7.o
OBJS7 += build/interrupts7.o
OBJS7 += build/OS_Cpu_a.o
OBJS7 += build/OS_Cpu_c.o
OBJS7 += build/ucos_ii.o
OBJS7 += build/main.o
OBJS7 += build/userApp7.o
OBJS7 += build/gpio7.o
OBJS7 += lib/libc.a
OBJS7 += lib/libgcc.a 

clean :
	rm -f build/*.o
	rm -f *.bin
	rm -f *.hex
	rm -f *.elf
	rm -f *.list
	rm -f *.img
	rm -f build/*.bc
	
build/%.o : port/%.s
	$(ARMGNU)-gcc $(COPS) -D__ASSEMBLY__ -c -o $@ $<
	
build/%.o : init/%.s
	$(ARMGNU)-gcc $(COPS) -D__ASSEMBLY__ -c -o $@ $<
	
build/%.o : port/%.c
	$(ARMGNU)-gcc $(COPS) -c -o $@ $<
		
build/%.o : bsp/%.c
	$(ARMGNU)-gcc $(COPS) -c -o $@ $<
	
build/%.o : usrApp/%.c
	$(ARMGNU)-gcc $(COPS) -c -o $@ $<

build/%7.o : bsp/%.c
	$(ARMGNU)-gcc $(COPS7) -DRPI2 -c -o $@ $<
	
build/%7.o : usrApp/%.c
	$(ARMGNU)-gcc $(COPS7) -DRPI2 -c -o $@ $<

build/ucos_ii.o : ucos/ucos_ii.c
	$(ARMGNU)-gcc $(COPS) ucos/ucos_ii.c -c -o build/ucos_ii.o

kernel.img : raspberrypi.ld $(OBJS)
	$(ARMGNU)-ld $(OBJS) -T raspberrypi.ld -o ucos_bcm2835.elf 
	$(ARMGNU)-objdump -D ucos_bcm2835.elf > ucos_bcm2835.list
	$(ARMGNU)-objcopy ucos_bcm2835.elf -O ihex ucos_bcm2835.hex
	$(ARMGNU)-objcopy ucos_bcm2835.elf -O binary ucos_bcm2835.bin
	$(ARMGNU)-objcopy ucos_bcm2835.elf -O binary kernel.img

kernel7.img : raspberrypi.ld $(OBJS7)
	$(ARMGNU)-ld $(OBJS7) -T raspberrypi.ld -o ucos_bcm2836.elf 
	$(ARMGNU)-objdump -D ucos_bcm2836.elf > ucos_bcm2836.list
	$(ARMGNU)-objcopy ucos_bcm2836.elf -O ihex ucos_bcm2836.hex
	$(ARMGNU)-objcopy ucos_bcm2836.elf -O binary ucos_bcm2836.bin
	$(ARMGNU)-objcopy ucos_bcm2836.elf -O binary kernel7.img
