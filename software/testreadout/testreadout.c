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
#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"

int main()
{
	printf("Hello world!\n");

	int index = 0;
	int data, data2;

	int version = IORD_ALTERA_AVALON_JTAG_UART_DATA(VERSION_INFO_BASE);
	printf ("\n ** Version: %x ** \n\n",version);

	printf("Resetting...\n");
	IOWR_ALTERA_AVALON_PIO_DATA(EXT_RST_BASE,1);
	usleep(1000000);
	IOWR_ALTERA_AVALON_PIO_DATA(EXT_RST_BASE,0);
	usleep(1000000);
	printf("\n");

	int initvalue =4293918720; // 0xFFF00000;

	int addr, value;
	printf("Address : ");
	scanf("%d",&addr);
	printf("%d\n",addr);
	printf("Input value : ");
	scanf("%d",&value);
	printf("%d\n",value);
	int sendvalue = initvalue + addr*16 + value;
	IOWR_ALTERA_AVALON_PIO_DATA(DACCTRL_BASE,sendvalue);

	printf("writing DACCTRL_BASE : %x\n",sendvalue);

	printf("waiting...\n");
	usleep(1000000);

	int sentvalue = IORD_ALTERA_AVALON_PIO_DATA(DACCTRL_BASE);
	printf("Wrote value is %x\n",sentvalue);

	getchar();
	getchar();

	IOWR_ALTERA_AVALON_PIO_DATA(WRITE_EN_PIO_BASE,1);

	while (1) {
		++index;
		data = IORD_ALTERA_AVALON_JTAG_UART_DATA(FIFO_0_OUT_BASE);
		data2 = IORD_ALTERA_AVALON_JTAG_UART_DATA(FIFO_1_OUT_BASE);
		printf("%d,%d,%d\n",index,data,data2);
		if (altera_avalon_fifo_read_level(FIFO_0_OUT_CSR_BASE)==0) break;
		if (index==100) {
			IOWR_ALTERA_AVALON_PIO_DATA(WRITE_EN_PIO_BASE,0);
		}
	}

	printf("End of the code. %c\n",0x04); // exit
	return 0;
}

