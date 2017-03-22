; Constants for the multiboot header
MAGIC    equ  0x1BADB002		; magic number identifying the multiboot header
MBALIGN  equ  1<<0              	; align loaded modules on page boundaries
MEMINFO  equ  1<<1             		; provide memory map
MBFLAGS  equ  MEMINFO | MBALIGN 	; multiboot flag field
CHECKSUM equ  -(MAGIC + MBFLAGS)	; checksum for multiboot

; Declare the multiboot header.
; This header indicates to the bootloader that the kernel is multiboot compliant.
section .multiboot 
align 4
dd MAGIC
dd MBFLAGS
dd CHECKSUM


