/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2_0' in SOPC Builder design 'TestRO'
 * SOPC Builder design path: ../../TestRO.sopcinfo
 *
 * Generated: Tue Jul 10 18:00:36 JST 2018
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x10008820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 100000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1e
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00000020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 100000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x1d
#define ALT_CPU_NAME "nios2_gen2_0"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x10008820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 100000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x1e
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00000020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x1d
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00000000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_FIFO
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_NIOS2_GEN2


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x10008000
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x10008000
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x10008000
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "TestRO"


/*
 * dacctrl configuration
 *
 */

#define ALT_MODULE_CLASS_dacctrl altera_avalon_pio
#define DACCTRL_BASE 0x22000000
#define DACCTRL_BIT_CLEARING_EDGE_REGISTER 0
#define DACCTRL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DACCTRL_CAPTURE 0
#define DACCTRL_DATA_WIDTH 32
#define DACCTRL_DO_TEST_BENCH_WIRING 0
#define DACCTRL_DRIVEN_SIM_VALUE 0
#define DACCTRL_EDGE_TYPE "NONE"
#define DACCTRL_FREQ 100000000
#define DACCTRL_HAS_IN 0
#define DACCTRL_HAS_OUT 1
#define DACCTRL_HAS_TRI 0
#define DACCTRL_IRQ -1
#define DACCTRL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DACCTRL_IRQ_TYPE "NONE"
#define DACCTRL_NAME "/dev/dacctrl"
#define DACCTRL_RESET_VALUE 0
#define DACCTRL_SPAN 16
#define DACCTRL_TYPE "altera_avalon_pio"


/*
 * ext_rst configuration
 *
 */

#define ALT_MODULE_CLASS_ext_rst altera_avalon_pio
#define EXT_RST_BASE 0x12000000
#define EXT_RST_BIT_CLEARING_EDGE_REGISTER 0
#define EXT_RST_BIT_MODIFYING_OUTPUT_REGISTER 0
#define EXT_RST_CAPTURE 0
#define EXT_RST_DATA_WIDTH 1
#define EXT_RST_DO_TEST_BENCH_WIRING 0
#define EXT_RST_DRIVEN_SIM_VALUE 0
#define EXT_RST_EDGE_TYPE "NONE"
#define EXT_RST_FREQ 100000000
#define EXT_RST_HAS_IN 0
#define EXT_RST_HAS_OUT 1
#define EXT_RST_HAS_TRI 0
#define EXT_RST_IRQ -1
#define EXT_RST_IRQ_INTERRUPT_CONTROLLER_ID -1
#define EXT_RST_IRQ_TYPE "NONE"
#define EXT_RST_NAME "/dev/ext_rst"
#define EXT_RST_RESET_VALUE 0
#define EXT_RST_SPAN 16
#define EXT_RST_TYPE "altera_avalon_pio"


/*
 * exttrg_0 configuration
 *
 */

#define ALT_MODULE_CLASS_exttrg_0 altera_avalon_pio
#define EXTTRG_0_BASE 0x21000000
#define EXTTRG_0_BIT_CLEARING_EDGE_REGISTER 0
#define EXTTRG_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define EXTTRG_0_CAPTURE 0
#define EXTTRG_0_DATA_WIDTH 1
#define EXTTRG_0_DO_TEST_BENCH_WIRING 0
#define EXTTRG_0_DRIVEN_SIM_VALUE 0
#define EXTTRG_0_EDGE_TYPE "NONE"
#define EXTTRG_0_FREQ 100000000
#define EXTTRG_0_HAS_IN 0
#define EXTTRG_0_HAS_OUT 1
#define EXTTRG_0_HAS_TRI 0
#define EXTTRG_0_IRQ -1
#define EXTTRG_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define EXTTRG_0_IRQ_TYPE "NONE"
#define EXTTRG_0_NAME "/dev/exttrg_0"
#define EXTTRG_0_RESET_VALUE 0
#define EXTTRG_0_SPAN 16
#define EXTTRG_0_TYPE "altera_avalon_pio"


/*
 * fifo_0_out configuration
 *
 */

#define ALT_MODULE_CLASS_fifo_0_out altera_avalon_fifo
#define FIFO_0_OUT_AVALONMM_AVALONMM_DATA_WIDTH 32
#define FIFO_0_OUT_AVALONMM_AVALONST_DATA_WIDTH 32
#define FIFO_0_OUT_BASE 0x10008100
#define FIFO_0_OUT_BITS_PER_SYMBOL 16
#define FIFO_0_OUT_CHANNEL_WIDTH 8
#define FIFO_0_OUT_ERROR_WIDTH 8
#define FIFO_0_OUT_FIFO_DEPTH 512
#define FIFO_0_OUT_IRQ -1
#define FIFO_0_OUT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FIFO_0_OUT_NAME "/dev/fifo_0_out"
#define FIFO_0_OUT_SINGLE_CLOCK_MODE 0
#define FIFO_0_OUT_SPAN 4
#define FIFO_0_OUT_SYMBOLS_PER_BEAT 2
#define FIFO_0_OUT_TYPE "altera_avalon_fifo"
#define FIFO_0_OUT_USE_AVALONMM_READ_SLAVE 1
#define FIFO_0_OUT_USE_AVALONMM_WRITE_SLAVE 1
#define FIFO_0_OUT_USE_AVALONST_SINK 0
#define FIFO_0_OUT_USE_AVALONST_SOURCE 0
#define FIFO_0_OUT_USE_BACKPRESSURE 1
#define FIFO_0_OUT_USE_IRQ 0
#define FIFO_0_OUT_USE_PACKET 1
#define FIFO_0_OUT_USE_READ_CONTROL 1
#define FIFO_0_OUT_USE_REGISTER 0
#define FIFO_0_OUT_USE_WRITE_CONTROL 0


/*
 * fifo_0_out_csr configuration
 *
 */

#define ALT_MODULE_CLASS_fifo_0_out_csr altera_avalon_fifo
#define FIFO_0_OUT_CSR_AVALONMM_AVALONMM_DATA_WIDTH 32
#define FIFO_0_OUT_CSR_AVALONMM_AVALONST_DATA_WIDTH 32
#define FIFO_0_OUT_CSR_BASE 0x10008200
#define FIFO_0_OUT_CSR_BITS_PER_SYMBOL 16
#define FIFO_0_OUT_CSR_CHANNEL_WIDTH 8
#define FIFO_0_OUT_CSR_ERROR_WIDTH 8
#define FIFO_0_OUT_CSR_FIFO_DEPTH 512
#define FIFO_0_OUT_CSR_IRQ -1
#define FIFO_0_OUT_CSR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FIFO_0_OUT_CSR_NAME "/dev/fifo_0_out_csr"
#define FIFO_0_OUT_CSR_SINGLE_CLOCK_MODE 0
#define FIFO_0_OUT_CSR_SPAN 32
#define FIFO_0_OUT_CSR_SYMBOLS_PER_BEAT 2
#define FIFO_0_OUT_CSR_TYPE "altera_avalon_fifo"
#define FIFO_0_OUT_CSR_USE_AVALONMM_READ_SLAVE 1
#define FIFO_0_OUT_CSR_USE_AVALONMM_WRITE_SLAVE 1
#define FIFO_0_OUT_CSR_USE_AVALONST_SINK 0
#define FIFO_0_OUT_CSR_USE_AVALONST_SOURCE 0
#define FIFO_0_OUT_CSR_USE_BACKPRESSURE 1
#define FIFO_0_OUT_CSR_USE_IRQ 0
#define FIFO_0_OUT_CSR_USE_PACKET 1
#define FIFO_0_OUT_CSR_USE_READ_CONTROL 1
#define FIFO_0_OUT_CSR_USE_REGISTER 0
#define FIFO_0_OUT_CSR_USE_WRITE_CONTROL 0


/*
 * fifo_1_out configuration
 *
 */

#define ALT_MODULE_CLASS_fifo_1_out altera_avalon_fifo
#define FIFO_1_OUT_AVALONMM_AVALONMM_DATA_WIDTH 32
#define FIFO_1_OUT_AVALONMM_AVALONST_DATA_WIDTH 32
#define FIFO_1_OUT_BASE 0x10009100
#define FIFO_1_OUT_BITS_PER_SYMBOL 16
#define FIFO_1_OUT_CHANNEL_WIDTH 8
#define FIFO_1_OUT_ERROR_WIDTH 8
#define FIFO_1_OUT_FIFO_DEPTH 512
#define FIFO_1_OUT_IRQ -1
#define FIFO_1_OUT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FIFO_1_OUT_NAME "/dev/fifo_1_out"
#define FIFO_1_OUT_SINGLE_CLOCK_MODE 0
#define FIFO_1_OUT_SPAN 4
#define FIFO_1_OUT_SYMBOLS_PER_BEAT 2
#define FIFO_1_OUT_TYPE "altera_avalon_fifo"
#define FIFO_1_OUT_USE_AVALONMM_READ_SLAVE 1
#define FIFO_1_OUT_USE_AVALONMM_WRITE_SLAVE 1
#define FIFO_1_OUT_USE_AVALONST_SINK 0
#define FIFO_1_OUT_USE_AVALONST_SOURCE 0
#define FIFO_1_OUT_USE_BACKPRESSURE 1
#define FIFO_1_OUT_USE_IRQ 0
#define FIFO_1_OUT_USE_PACKET 1
#define FIFO_1_OUT_USE_READ_CONTROL 1
#define FIFO_1_OUT_USE_REGISTER 0
#define FIFO_1_OUT_USE_WRITE_CONTROL 0


/*
 * fifo_1_out_csr configuration
 *
 */

#define ALT_MODULE_CLASS_fifo_1_out_csr altera_avalon_fifo
#define FIFO_1_OUT_CSR_AVALONMM_AVALONMM_DATA_WIDTH 32
#define FIFO_1_OUT_CSR_AVALONMM_AVALONST_DATA_WIDTH 32
#define FIFO_1_OUT_CSR_BASE 0x10009200
#define FIFO_1_OUT_CSR_BITS_PER_SYMBOL 16
#define FIFO_1_OUT_CSR_CHANNEL_WIDTH 8
#define FIFO_1_OUT_CSR_ERROR_WIDTH 8
#define FIFO_1_OUT_CSR_FIFO_DEPTH 512
#define FIFO_1_OUT_CSR_IRQ -1
#define FIFO_1_OUT_CSR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FIFO_1_OUT_CSR_NAME "/dev/fifo_1_out_csr"
#define FIFO_1_OUT_CSR_SINGLE_CLOCK_MODE 0
#define FIFO_1_OUT_CSR_SPAN 32
#define FIFO_1_OUT_CSR_SYMBOLS_PER_BEAT 2
#define FIFO_1_OUT_CSR_TYPE "altera_avalon_fifo"
#define FIFO_1_OUT_CSR_USE_AVALONMM_READ_SLAVE 1
#define FIFO_1_OUT_CSR_USE_AVALONMM_WRITE_SLAVE 1
#define FIFO_1_OUT_CSR_USE_AVALONST_SINK 0
#define FIFO_1_OUT_CSR_USE_AVALONST_SOURCE 0
#define FIFO_1_OUT_CSR_USE_BACKPRESSURE 1
#define FIFO_1_OUT_CSR_USE_IRQ 0
#define FIFO_1_OUT_CSR_USE_PACKET 1
#define FIFO_1_OUT_CSR_USE_READ_CONTROL 1
#define FIFO_1_OUT_CSR_USE_REGISTER 0
#define FIFO_1_OUT_CSR_USE_WRITE_CONTROL 0


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x10008000
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * onchip_memory2_0 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_0 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_0_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_0_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_0_BASE 0x0
#define ONCHIP_MEMORY2_0_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_0_DUAL_PORT 0
#define ONCHIP_MEMORY2_0_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_INIT_CONTENTS_FILE "TestRO_onchip_memory2_0"
#define ONCHIP_MEMORY2_0_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_0_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_0_IRQ -1
#define ONCHIP_MEMORY2_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_0_NAME "/dev/onchip_memory2_0"
#define ONCHIP_MEMORY2_0_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_0_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_0_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_0_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_0_SIZE_VALUE 300000
#define ONCHIP_MEMORY2_0_SPAN 300000
#define ONCHIP_MEMORY2_0_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_0_WRITABLE 1


/*
 * version_info configuration
 *
 */

#define ALT_MODULE_CLASS_version_info altera_avalon_pio
#define VERSION_INFO_BASE 0x11000000
#define VERSION_INFO_BIT_CLEARING_EDGE_REGISTER 0
#define VERSION_INFO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define VERSION_INFO_CAPTURE 0
#define VERSION_INFO_DATA_WIDTH 32
#define VERSION_INFO_DO_TEST_BENCH_WIRING 0
#define VERSION_INFO_DRIVEN_SIM_VALUE 0
#define VERSION_INFO_EDGE_TYPE "NONE"
#define VERSION_INFO_FREQ 100000000
#define VERSION_INFO_HAS_IN 1
#define VERSION_INFO_HAS_OUT 0
#define VERSION_INFO_HAS_TRI 0
#define VERSION_INFO_IRQ -1
#define VERSION_INFO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define VERSION_INFO_IRQ_TYPE "NONE"
#define VERSION_INFO_NAME "/dev/version_info"
#define VERSION_INFO_RESET_VALUE 0
#define VERSION_INFO_SPAN 16
#define VERSION_INFO_TYPE "altera_avalon_pio"


/*
 * write_en_pio configuration
 *
 */

#define ALT_MODULE_CLASS_write_en_pio altera_avalon_pio
#define WRITE_EN_PIO_BASE 0x20000000
#define WRITE_EN_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define WRITE_EN_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define WRITE_EN_PIO_CAPTURE 0
#define WRITE_EN_PIO_DATA_WIDTH 1
#define WRITE_EN_PIO_DO_TEST_BENCH_WIRING 0
#define WRITE_EN_PIO_DRIVEN_SIM_VALUE 0
#define WRITE_EN_PIO_EDGE_TYPE "NONE"
#define WRITE_EN_PIO_FREQ 100000000
#define WRITE_EN_PIO_HAS_IN 0
#define WRITE_EN_PIO_HAS_OUT 1
#define WRITE_EN_PIO_HAS_TRI 0
#define WRITE_EN_PIO_IRQ -1
#define WRITE_EN_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define WRITE_EN_PIO_IRQ_TYPE "NONE"
#define WRITE_EN_PIO_NAME "/dev/write_en_pio"
#define WRITE_EN_PIO_RESET_VALUE 0
#define WRITE_EN_PIO_SPAN 16
#define WRITE_EN_PIO_TYPE "altera_avalon_pio"

#endif /* __SYSTEM_H_ */
