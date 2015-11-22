/*
 * 文件名: k60_card.h
 * 用途: K60 Card核心板运行配置
 * 最后修改日期: 20120216
 *
 * 版权所有:北京拉普兰德电子技术有限公司
 * http://laplenden.taobao.com
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 *
 * 说明:本页代码基于Freescale官方示例代码修改，源代码文件为 k60_tower.h
 */
#ifndef __K60_CARD_H__
#define __K60_CARD_H__

#include "HAL_Def.h"
#include "HAL_MCG.h"

/********************************************************************/

#if (defined(UCOS_II))
  #include "bsp_int.h"
#endif

/*
 * 是否启用串口显示调试信息
 * 如果启用，核心板会在运行时通过UART5显示器件相关信息，占用PTE8和PTE9两个端口
 * 1不显示  0显示
 */
#if (0)            
#undef DEBUG_PRINT
#endif

/* Define for the CPU on the K60 board */
#define CPU_MK60N512VMD100

/*
 * 核心时钟定义(Core Clock)
 * 可选范围:
 *        PLL_60 - 60MHz
 *        PLL_70 - 70MHz
 *        PLL_80 - 80MHz
 *        PLL_90 - 90MHz
 *        PLL_96 - 96MHz
 *        PLL_100 - 100MHz
 *        PLL_110 - 110MHz
 *        PLL_120 - 120MHz
 *        PLL_130 - 130MHz
 *        PLL_150 - 150MHz
 *        PLL_170 - 170MHz
 *        PLL_180 - 180MHz
 *        PLL_200 - 200MHz
 *        PLL_209 - 209MHz
 * bus,FlexBus,Flash等其他模块时钟请参见 HAL_MCG.c 中的 pll_setup() 函数.
 * 推荐使用的频率: 100MHz, 150MHz, 200MHz. 在此3种频率下其他模块时钟频率达到最优
 */
#define CORE_CLK_MHZ        PLL_100      /* 期望时钟频率*/



/* 
 * 选择调试信息输出所有的串口号和波特率
 */
#define OSJTAG     

#if (defined(OSJTAG))
    #define TERM_PORT           UART5_BASE_PTR
    #define TERMINAL_BAUD       115200
    #undef  HW_FLOW_CONTROL
#else
  #error "No valid serial port defined"
#endif


#endif /* __K60_CARD_H__ */
