/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_LPTMR.h
 * 用途: LPTMR底层模块相关函数
 * 最后修改日期: 20120326
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#ifndef __HAL_LPTMR_H__
#define __HAL_LPTMR_H__
/********************************************************************/

#define LPTMR_ALT1    1
#define LPTMR_ALT2    2

#define MODE_LPTMR    0 
#define MODE_PLACC    1

#define IRQ_DISABLE   0
#define IRQ_ENABLE    1

typedef void (*LPTMR_ISR_CALLBACK)(void);

uint8 LPLD_LPTMR_Init(uint8 mode, uint16 period_ms, uint8 channel, uint8 irqc, LPTMR_ISR_CALLBACK func);
uint16 LPLD_LPTMR_GetPulseAcc(void);
void LPLD_LPTMR_DelayMs(uint16 period_ms);
void LPLD_LPTMR_Reset(void);
void LPLD_LPTMR_Isr(void);

#endif /* __HAL_LPTMR_H__ */
