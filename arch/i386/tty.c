#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>

#include <kernel/tty.h>

#include "vga.h"

static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;
static uint16_t* const VGA_MEMORY = (uint16_t*) 0xB8000;

static size_t terminal_row, terminal_column;
static uint8_t terminal_color;
static uint16_t *terminal_buffer;

void terminal_putentry(size_t x, size_t y, uint8_t color, unsigned char uch);
void set_terminal_color(uint8_t color);
/* initialize terminal */
void terminal_init() {
  terminal_row = 0;
  terminal_column = 0;
  terminal_color = vga_color_attr(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
  terminal_buffer = VGA_MEMORY;
  for (size_t y = 0; y < VGA_HEIGHT; y++) {
    for (size_t x = 0; x < VGA_WIDTH; x++) {
      terminal_putentry(x, y, terminal_color, ' ');
    }
  }
}

void set_terminal_color(uint8_t color) {
  terminal_color = color;
}

void terminal_putentry(size_t x, size_t y, uint8_t color, unsigned char uch) {
  size_t index = (y * VGA_WIDTH) + x;
  terminal_buffer[index] = vga_entry(uch, color);
}

void terminal_putchar(char ch) {
  unsigned char uch = ch;
  terminal_putentry(terminal_column, terminal_row, terminal_color, uch);
  if (++terminal_column == VGA_WIDTH) {
    terminal_column = 0;
    if (++terminal_row == VGA_HEIGHT)
      terminal_row = 0;
  }
}

void terminal_writedata(const char *data, size_t size) {
  for (size_t i = 0; i < size; i++)
    terminal_putchar(data[i]);
}

void terminal_writestring(const char *str) {
  terminal_writedata(str, strlen(str));
}
