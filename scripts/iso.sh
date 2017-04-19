#!/bin/sh
mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/dopyos.kernel isodir/boot/dopyos.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "dopyos" {
	  multiboot /boot/dopyos.kernel
}
EOF
grub-mkrescue -o dopyos.iso isodir
