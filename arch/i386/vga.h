#ifndef _ARCH_I386_VGA_H_
#define _ARCH_I386_VGA_H_

#include <stdint.h>

enum vga_color {
  VGA_COLOR_BLACK = 0,
  VGA_COLOR_BLUE = 1,
  VGA_COLOR_GREEN = 2,
  VGA_COLOR_CYAN = 3,
  VGA_COLOR_RED = 4,
  VGA_COLOR_MAGENTA = 5,
  VGA_COLOR_BROWN = 6,
  VGA_COLOR_LIGHT_GREY = 7,
  VGA_COLOR_DARK_GREY = 8,
  VGA_COLOR_LIGHT_BLUE = 9,
  VGA_COLOR_LIGHT_GREEN = 10,
  VGA_COLOR_WHITE = 15
};

static inline uint8_t vga_color_attr(enum vga_color foreg, enum vga_color backg) {
  return foreg | (backg << 4);
}
 
static inline uint16_t vga_entry(unsigned char character, uint8_t color) {
  return (uint16_t) color << 8 | (uint16_t) character;
}
 
#endif
