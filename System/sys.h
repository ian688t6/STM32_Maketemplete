#ifndef __SYS_H__
#define __SYS_H__

extern void sys_init(void);

extern void delay_us(uint32_t ui_us);

extern void delay_ms(uint32_t ui_ms);

static inline void girq_enable(void)
{
	__asm volatile(
		" cpsie i			\n"
		" nop				\n"
	);
	return;	
}

static inline void girq_disable(void)
{
	__asm volatile(
		" cpsid i			\n"
		" nop				\n"
	);
	return;
	return;	
}

#endif

