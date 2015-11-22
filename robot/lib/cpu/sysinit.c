/*
 * File:        sysinit.c
 * Purpose:     Kinetis Configuration
 *              Initializes processor to a default state
 *
 * Notes:
 *
 */

#include "common.h"
#include "sysinit.h"
#include "uart.h"

/********************************************************************/

/* 实际系统时钟频率 */
int core_clk_khz;
int core_clk_mhz;
int periph_clk_khz;

/********************************************************************/
void sysinit (void)
{
        /*
         * 使能所有端口的时钟. 为了配置引脚复用则必须使能这里, 所以大多数代码需要配置这些.
         */
        SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK
                      | SIM_SCGC5_PORTB_MASK
                      | SIM_SCGC5_PORTC_MASK
                      | SIM_SCGC5_PORTD_MASK
                      | SIM_SCGC5_PORTE_MASK );

 	/* 配置系统时钟 */
	core_clk_mhz = LPLD_PLL_Setup(CORE_CLK_MHZ);

	/*
         * 用pll_init函数的返回值来定义变量:core_clk_khz和periph_clk_khz(以kHz为单位)
	 * 这些变量将在其他功能上
	 */
	core_clk_khz = core_clk_mhz * 1000;
  	periph_clk_khz = core_clk_khz / (((SIM_CLKDIV1 & SIM_CLKDIV1_OUTDIV2_MASK) >> 24)+ 1);

  	/* 
         *出于仿真的目的, 使能追踪时钟和FlexBus时钟来
  	 */
	trace_clk_init();
  	fb_clk_init();

  	/* 使能选中的 UART */

  	if (TERM_PORT == UART3_BASE_PTR)
  	{
                 /* 使能 PTC17 引脚的 UART3_TXD 功能  */
  		PORTC_PCR17 = PORT_PCR_MUX(0x3); // 该引脚的 功能3 是 UART

  		/* 使能 PTC16 引脚的 UART3_RXD 功能 */
  		PORTC_PCR16 = PORT_PCR_MUX(0x3); // 该引脚的 功能3 是 UART
  	}

  	if (TERM_PORT == UART5_BASE_PTR)
  	{
                 /* 使能 PTE8 引脚的 UART5_TXD 功能  */
  		PORTE_PCR8 = PORT_PCR_MUX(0x3); // 该引脚的 功能3 是 UART

  		/* 使能 PTE9 引脚的 UART5_RXD 功能  */
  		PORTE_PCR9 = PORT_PCR_MUX(0x3); // 该引脚的 功能3 是 UART
  	}
  	/* UART0 and UART1 由 core clock 提供时钟源, 但是其他所有 UARTs 由
         * peripheral clock 提供时钟源. 所以要在这里决定用哪个时钟作为 uart_init 的参数.
         */
        if ((TERM_PORT == UART0_BASE_PTR) | (TERM_PORT == UART1_BASE_PTR))
           uart_init (TERM_PORT, core_clk_khz, TERMINAL_BAUD);
        else
  	   uart_init (TERM_PORT, periph_clk_khz, TERMINAL_BAUD);
        
#if(defined(DEBUG_PRINT))  
        // 打印系统频率
        printf("Core Clock:%dMHz!\r\n", core_clk_mhz);
        printf("Bus Clock:%dkHz!\r\n", periph_clk_khz);
#endif
}
/********************************************************************/
void trace_clk_init(void)
{
	/* Set the trace clock to the core clock frequency */
	SIM_SOPT2 |= SIM_SOPT2_TRACECLKSEL_MASK;

	/* Enable the TRACE_CLKOUT pin function on PTA6 (alt7 function) */
	PORTA_PCR6 = ( PORT_PCR_MUX(0x7));
}
/********************************************************************/
void fb_clk_init(void)
{
	/* Enable the clock to the FlexBus module */
        SIM_SCGC7 |= SIM_SCGC7_FLEXBUS_MASK;

 	/* Enable the FB_CLKOUT function on PTC3 (alt5 function) */
	PORTC_PCR3 = ( PORT_PCR_MUX(0x5));
}
/********************************************************************/
