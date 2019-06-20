#include <stdint.h>
#include "stm32f10x.h"
#include "sys.h"

static uint8_t  guc_fac_us = 0;			   
static uint16_t gus_fac_ms = 0;			   

void sys_init(void)
{
	SysTick_CLKSourceConfig(SysTick_CLKSource_HCLK_Div8);
	guc_fac_us = SystemCoreClock / 8000000;
	gus_fac_ms = (uint16_t)guc_fac_us * 1000;
	return;
}

void delay_us(uint32_t ui_us)
{
	uint32_t ui_temp = 0;	    	 
	
	SysTick->LOAD 	= ui_us * guc_fac_us;
	SysTick->VAL	= 0x00;
	SysTick->CTRL	|=SysTick_CTRL_ENABLE_Msk;
	do
	{
		ui_temp = SysTick->CTRL;
	}while((ui_temp&0x01) && !(ui_temp&(1<<16)));
	SysTick->CTRL &= ~SysTick_CTRL_ENABLE_Msk;
	SysTick->VAL = 0X00; 
	
	return;
}

void delay_ms(uint32_t ui_ms)
{
	uint32_t ui_temp = 0;

	SysTick->LOAD = (uint32_t)ui_ms * gus_fac_ms;
	SysTick->VAL = 0x00;
	SysTick->CTRL |= SysTick_CTRL_ENABLE_Msk;
	do
	{
		ui_temp = SysTick->CTRL;
	}while((ui_temp & 0x01) && !(ui_temp & (1<<16)));
	SysTick->CTRL &= ~SysTick_CTRL_ENABLE_Msk;
	SysTick->VAL = 0X00;

	return;		
}

