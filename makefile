HOST = i686-elf
HOSTARCH = i386
ARCHDIR = arch/$(HOSTARCH)
SYSROOT = $(PWD)/sysroot
DEST_DIR = $(SYSROOT)
BOOT_DIR = /boot
LIB_DIR = /usr/lib
INCLUDE_DIR = /usr/include

CC = $(HOST)-gcc --sysroot=$(SYSROOT) -isystem=$(INCLUDE_DIR)
CFLAGS = -ffreestanding -Wall -Wextra
LIBS = -nostdlib -lgcc

BOOT_OBJS = $(ARCHDIR)/boot/boot.o
KERNEL_OBJS = kernel/kernel.o
LIB_OBJS = lib/string/strlen.o
DISPLAY_OBJS = $(ARCHDIR)/tty.c
OBJS = $(BOOT_OBJS) $(KERNEL_OBJS) $(LIB_OBJS) $(DISPLAY_OBJS)
LINK_LIST = $(OBJS) $(LIBS)

all: install-headers install-kernel

dopyos.kernel: $(OBJS) $(ARCHDIR)/linker/linker.ld
	$(CC) -T $(ARCHDIR)/linker/linker.ld -o $@ $(CFLAGS) $(LINK_LIST)

%.o: %.c
	$(CC)  -c $< -o $@ -std=gnu11 $(CFLAGS)

install-headers:
	mkdir -p $(DEST_DIR)$(INCLUDE_DIR)
	cp -R --preserve=timestamp include/kernel $(DEST_DIR)$(INCLUDE_DIR)/.
	cp -R --preserve=timestamp include/lib/. $(DEST_DIR)$(INCLUDE_DIR)/.

install-kernel: dopyos.kernel
	mkdir -p $(DEST_DIR)$(BOOT_DIR)
	cp dopyos.kernel $(DEST_DIR)$(BOOT_DIR)/
clean:
	rm -rf sysroot/
	rm *.o dopyos.kernel
