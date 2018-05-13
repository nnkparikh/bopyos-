#!/bin/sh
mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/yamos.kernel isodir/boot/yamos.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "yam-os" {
	  multiboot /boot/yamos.kernel
}
EOF
grub-mkrescue -o yamos.iso isodir
