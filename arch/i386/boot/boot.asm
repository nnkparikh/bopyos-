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

; Kernel must provide its own stack as the multiboot standard does not define the stack
; pointer register. The stack on x86 must be 16 byte aligned according to the System V
; ABI standard and the stack grows downwards.
section .bss
align 16
stack_bottom:
resb 16384
stack_top:

section .text
global _kstart:function
_kstart:
	; point esp register to the top of the stack
	mov esp, stack_top
	extern kernel_main
	call kernel_main

	; disable interrupts and halt
	cli
.loop:  hlt
	; in case processor wakes up ue to a non-maskable interrupt
	jmp .loop
.kend:
	
