/*
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: bsp.c
 * 用途: 包括UCOS系统的BSP（板级支持包）函数
 * 最后修改日期: 20120715
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */


#include "bsp.h"
#include "bsp_int.h"
#include "common.h"
#include "includes.h"

/*获得系统当前的频率*/
extern int core_clk_khz;
static void LPLD_uCOS_Clk_Init(void);
static void LPLD_uCOS_InitIsrTable(void);
/*
 * LPLD_uCOS_Clk_Init
 * 设置UCOS的系统时钟，系统时钟取自内核时钟，但UCOS的系统时钟应设定在10--100Hz内
 * 
 * 参数:
 *    无
 * 输出:
 *    无
 *
*/
static void LPLD_uCOS_Clk_Init(void)
{
  CPU_INT32U  cpu_clk_freq;
  CPU_INT32U  cnts;
  //UCOS的系统时钟频率可以在10--100Hz之间设置
  cpu_clk_freq = core_clk_khz*1000;
  cnts         = cpu_clk_freq / (CPU_INT32U)OS_TICKS_PER_SEC; 
  if(cnts > 100000) //如果系统时钟频率大于100hz，将系统时钟稳定在100hz
    cnts=100000;
  //systick计数到cnts次产生一次中断 
  OS_CPU_SysTickInit(cnts);                                   
}

/*
 * LPLD_uCOS_InitIsrTable
 * 此函数用于初始化UCOS处理中断ISR表，
 * 在此函数中调用LPLD_uCOS_Register_K60Int函数，
 * 将LPLD底层驱动包中的xx_isr函数注册到UCOS处理中断ISR表中即可
 * 
 * 参数:
 *    无
 * 输出:
 *    无
 *
*/
static void LPLD_uCOS_InitIsrTable(void)
{
  //注册IOE中断
  //LPLD_uCOS_Register_K60Int(LPLD_GPIO_Isr,BSP_INT_ID_PORTE);
  //注册IOB中断
  //LPLD_uCOS_Register_K60Int(LPLD_GPIO_Isr,BSP_INT_ID_PORTB);
  //注册UART0中断
  //LPLD_uCOS_Register_K60Int(LPLD_UART_Isr,BSP_INT_ID_UART0_RX_TX);
  //注册UART1中断
  //LPLD_uCOS_Register_K60Int(LPLD_UART_Isr,BSP_INT_ID_UART1_RX_TX);
  //注册UART2中断
  //LPLD_uCOS_Register_K60Int(LPLD_UART_Isr,BSP_INT_ID_UART4_RX_TX);
  //注册UART5中断
  //LPLD_uCOS_Register_K60Int(LPLD_UART_Isr,BSP_INT_ID_UART5_RX_TX);
  //注册RTC中断
  //LPLD_uCOS_Register_K60Int(LPLD_RTC_Isr,BSP_INT_ID_RTC);
  //注册CAN中断
  //LPLD_uCOS_Register_K60Int(LPLD_CAN_Isr,BSP_INT_ID_CAN0_ORED_MESSAGE_BUFFER);
  //注册PIT中断
  //LPLD_uCOS_Register_K60Int(LPLD_PIT_Isr,BSP_INT_ID_PIT0);
  //注册DMA中断
  //LPLD_uCOS_Register_K60Int(LPLD_DMA_Isr,BSP_INT_ID_DMA1);
  //注册DMA中断
  //LPLD_uCOS_Register_K60Int(LPLD_DMA_Isr,BSP_INT_ID_DMA0);
}


/*
 * LPLD_uCOS_InitIsrTable
 * 此函数用于初始化UCOS处理中断ISR表，
 * 在此函数中调用LPLD_uCOS_Register_K60Int函数，
 * 将LPLD底层驱动包中的xx_isr函数注册到UCOS处理中断ISR表中即可
 * 
 * 参数:
 *    无
 * 输出:
 *    无
 *
*/
void LPLD_uCOS_bsp_Init(void)
{
  LPLD_uCOS_Clk_Init();
  LPLD_uCOS_InitIsrTable();
}