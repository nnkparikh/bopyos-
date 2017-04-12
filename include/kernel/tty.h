#ifndef _TTY_H_
#define _TTY_H_
#include <stddef.h>

void terminal_init();
void terminal_putchar(char c);
void terminal_writedata(const char *data, size_t size);
void terminal_writestring(const char* data);

#endif
