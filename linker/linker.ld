ENTRY(_start)

SECTIONS
{

	/* Kernel will be loaded by the bootloader at 1Mib */
	. = 1M;
	
	/* Multiboot header is required to be placed early in the image.
	   .text section will follow the multiboot header.*/
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot)
		*(.text)
	}

	/* Read-only data */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

	/* Read-write initialized data */
	.data BLOCK(4K) : ALIGN(4K)
	{
		*(COMMON)
		*(.bss)
	}

}
