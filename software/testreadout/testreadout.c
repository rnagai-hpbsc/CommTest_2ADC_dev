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
	//usleep(1000000);
	IOWR_ALTERA_AVALON_PIO_DATA(EXT_RST_BASE,0);
	//usleep(1000000);
	printf("\n");

	int initvalue =4293918720; // 0xFFF00000;

	int addr, value, sendvalue, sentvalue, baseline_1, baseline_2;

	printf("Address : ");
	//scanf("%d",&addr);
	addr = 0;
	printf("%d\n",addr);
	printf("Input value : ");
	//scanf("%d",&value);
	value = 32768;
	printf("%d\n",value);
	sendvalue = initvalue + addr*256*256 + value;
	IOWR_ALTERA_AVALON_PIO_DATA(DACCTRL_BASE,sendvalue);
	printf("writing DACCTRL_BASE : %x\n",sendvalue);
	usleep(1000000);
	sentvalue = IORD_ALTERA_AVALON_PIO_DATA(DACCTRL_BASE);
	printf("Wrote value is %x\n",sentvalue);
	usleep(1000000);
	baseline_1 = IORD_ALTERA_AVALON_PIO_DATA(BS_1_BASE);
	printf("Actual Baseline value is : %d.\n",baseline_1);

	printf("\n");

	printf("Address : ");
	//scanf("%d",&addr);
	addr = 4;
	printf("%d\n",addr);
	printf("Input value : ");
	//scanf("%d",&value);
	value = 32768;
	printf("%d\n",value);
	sendvalue = initvalue + addr*256*256 + value;
	IOWR_ALTERA_AVALON_PIO_DATA(DACCTRL_BASE,sendvalue);
	printf("writing DACCTRL_BASE : %x\n",sendvalue);
	usleep(1000000);
	sentvalue = IORD_ALTERA_AVALON_PIO_DATA(DACCTRL_BASE);
	printf("Wrote value is %x\n",sentvalue);
	usleep(1000000);
	baseline_2 = IORD_ALTERA_AVALON_PIO_DATA(BS_2_BASE);
	printf("Actual Baseline value is : %d.\n",baseline_2);

	printf("\nIf want to start data-taking, press enter...\n");

	printf("\n *** Start data-taking *** \n\n");

	IOWR_ALTERA_AVALON_PIO_DATA(WRITE_EN_PIO_BASE,1);

	int eventnumber = 0;
	printf("Event#0\n");
	while (1) {
		++index;
		data = IORD_ALTERA_AVALON_FIFO_DATA(FIFO_0_OUT_BASE);
		data2 = IORD_ALTERA_AVALON_FIFO_DATA(FIFO_1_OUT_BASE);
		baseline_1 = IORD_ALTERA_AVALON_PIO_DATA(BS_1_BASE);
		baseline_2 = IORD_ALTERA_AVALON_PIO_DATA(BS_2_BASE);
		printf("%d,%d,%d,%d",index,data,data2,baseline_1);
		if (baseline_1+50<data) printf("*");
		printf(",%d",baseline_2);
		if (baseline_2+50<data2) printf("*");
		printf("\n");
		if (altera_avalon_fifo_read_level(FIFO_0_OUT_CSR_BASE)==0) {
			//break;
			index=0;
			++eventnumber;
			printf("\nEvent#%d\n",eventnumber);
			IOWR_ALTERA_AVALON_PIO_DATA(WRITE_EN_PIO_BASE,1);
		}
		if (index==1000) {
			IOWR_ALTERA_AVALON_PIO_DATA(WRITE_EN_PIO_BASE,0);
		}
		if (eventnumber==10) break;
	}
	IOWR_ALTERA_AVALON_PIO_DATA(WRITE_EN_PIO_BASE,0);

	printf("End of the code. %c\n",0x04); // exit
	return 0;
}

