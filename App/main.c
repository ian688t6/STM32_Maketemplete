#include <stdint.h>
#include "sys.h"
#include "led.h"
#include "uart.h"
#include "print.h"

int main(void)
{
	uart_init(115200);
	sys_init();
	led_init();

	for (;;)
	{
		led_blink();	
		printlog("hello\n");	
	}
	return 0;
}


