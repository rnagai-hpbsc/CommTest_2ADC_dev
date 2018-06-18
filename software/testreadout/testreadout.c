/*
 * testreadout.c
 *
 *  Created on: Apr 5, 2018
 *      Author: icecube
 */
#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "altera_avalon_jtag_uart_regs.h"
#include "altera_avalon_pio_regs.h"

int main()
{
	printf("Hello world!\n");

	int index = 0;
	int data, data2;

	IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE,1);

	while (1) {
		++index;
		data = IORD_ALTERA_AVALON_JTAG_UART_DATA(FIFO_0_OUT_BASE);
		data2 = IORD_ALTERA_AVALON_JTAG_UART_DATA(FIFO_1_OUT_BASE);
		printf("%d,%d, %d\n",index,data,data2);
		if (index==500) break;
	}

	IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE,0);

	printf("End of the code.\n");
	return 0;
}

