#include <stdint.h>
#include <limits.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdarg.h>
#include "uart.h"

#define MAX_LOG_LENGTH		150
#define PRINT_BUF_LEN		10
static int gi_log_idx = 0;
static char gac_log_array[MAX_LOG_LENGTH];

#define putchar(x)	(gac_log_array[gi_log_idx++] = x)

static void prints(const char *string, int width, int pad_zero)
{
	char padchar = (pad_zero) ? '0' : ' ';
	int len;

	if (width > 0) {
		len = strlen(string);

		if (len >= width)
			width = 0;
		else
			width -= len;
	}

	for ( ; width > 0; --width) {
		putchar(padchar);
	}

	for ( ; *string; ++string) {
		putchar(*string);
	}

}

static void printi(int i, int b, int sg, int width, int pad_zero, int base)
{
	char print_buf[PRINT_BUF_LEN];
	register char *s;
	register int t, neg = 0;
	register unsigned int u = i;

	if (i == 0) {
		print_buf[0] = '0';
		print_buf[1] = '\0';
		prints(print_buf, width, pad_zero);
		return;
	}

	if (sg && b == 10 && i < 0) {
		neg = 1;
		u = -i;
	}

	s = print_buf + PRINT_BUF_LEN - 1;
	*s = '\0';

	while (u) {
		t = u % b;
		if (t >= 10)
			t += base - '0' - 10;
		*--s = t + '0';
		u /= b;
	}

	if (neg) {
		if (width && (pad_zero)) {
			putchar('-');
			--width;
		} else {
			*--s = '-';
		}
	}

	prints(s, width, pad_zero);
}

static void print(const char *format, va_list args)
{
	int width, pad;

	for (; *format != 0; ++format) {
		if (*format != '%') {
			putchar(*format);
		} else {
			++format;
			width = pad = 0;

			if (*format == '%') {
				putchar('%');
				continue;
			}

			if (*format == '0') {
				++format;
				pad = true;
			}

			if (*format >= '0' && *format <= '9') {
				width += *(format++) - '0';
			}

			switch (*format) {
			case 'd':
				printi(va_arg(args, int), 10, 1, width, pad, 'a');
				break;
			case 'x':
				printi(va_arg(args, int), 16, 0, width, pad, 'a');
				break;
			case 'X':
				printi(va_arg(args, int), 16, 0, width, pad, 'A');
				break;
			case 'u':
				printi(va_arg(args, int), 10, 0, width, pad, 'a');
				break;
			case 's':
				prints(va_arg(args, char *), 0, 0);
				break;
			case 'c':
				putchar(va_arg(args, int));
				break;
			default:
				break;
			}
		}
	}
}

void printlog(const char *format, ...)
{
	va_list args;
	int i;

//	__disable_irq();

	gi_log_idx = 0;

	va_start(args, format);
	print(format, args);
	va_end(args);

	putchar('\0');

	for (i = 0; i < gi_log_idx; i++) {
		uart_putc(gac_log_array[i]);
	}

//	__enable_irq();
}

