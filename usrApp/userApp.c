#include "uart.h"
#include "ucos/includes.h"
#include "regs.h"
#include "gpio.h"

void userApp2(void * args)
{
	while(1)
	{
		SetGpio(47, 1);
		uart_string("in userApp2");
		OSTimeDly(200);
	}
}

void userApp1(void * args)
{
	while(1)
	{
		OSTimeDly(100);
		SetGpio(47, 0);
		uart_string("in userApp1");
		OSTimeDly(100);
	}
}
