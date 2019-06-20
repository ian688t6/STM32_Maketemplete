#include <stdint.h>
#include "delay.h"
#include "led.h"

int main(void)
{
	led_init();
	for (;;)
	{
		led_blink();	
	}
	return 0;
}


