#include "uart.h"
#include "ucos/includes.h"

#define GPFSEL0     0x20200000
#define GPFSEL1     0x20200004
#define GPFSEL2     0x20200008
#define GPFSEL3     0x2020000C
#define GPFSEL4     0x20200010
#define GPSET0      0x2020001C
#define GPSET1      0x20200020
#define GPCLR0      0x20200028
#define GPCLR1      0x2020002C

extern void PUT32 ( unsigned int, unsigned int );
extern unsigned int GET32 ( unsigned int );

void userApp2(void * args)
{
	unsigned int ra;
       	ra=GET32(GPFSEL4);
        ra&=~(7<<21);
        ra|=1<<21;
        PUT32(GPFSEL4,ra);

	while(1)
	{
		PUT32(GPSET1,1<<15);
		uart_string("in userApp2");
		OSTimeDly(1000);
	}
}

void userApp1(void * args)
{
	unsigned int ra;
       	ra=GET32(GPFSEL4);
        ra&=~(7<<21);
        ra|=1<<21;
        PUT32(GPFSEL4,ra);

	while(1)
	{
		PUT32(GPCLR1,1<<15);
		uart_string("in userApp1");
		OSTimeDly(500);
	}
}
