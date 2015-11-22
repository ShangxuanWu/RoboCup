/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_FTM.h
 * 用途: FlexTimer底层模块相关函数
 * 最后修改日期: 20120329
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#ifndef __HAL_FTM_H__
#define __HAL_FTM_H__
/********************************************************************/


typedef void (*FTM_ISR_CALLBACK)(void);

uint8 LPLD_FTM0_PWM_Init(uint32 freq);
uint8 LPLD_FTM0_PWM_Open(uint8 channel, uint32 duty);
uint8 LPLD_FTM0_PWM_ChangeDuty(uint8 channel, uint32 duty);

uint8 LPLD_FTM1_PWM_Init(uint32 freq);
uint8 LPLD_FTM1_PWM_Open(uint8 channel, uint32 duty);
uint8 LPLD_FTM1_PWM_ChangeDuty(uint8 channel, uint32 duty);

uint8 LPLD_FTM2_PWM_Init(uint32 freq);
uint8 LPLD_FTM2_PWM_Open(uint8 channel, uint32 duty);
uint8 LPLD_FTM2_PWM_ChangeDuty(uint8 channel, uint32 duty);

uint8 LPLD_FTM0_InputCapture_Init(uint8 channel, uint8 edge, uint8 ps, FTM_ISR_CALLBACK isr_func);
uint8 LPLD_FTM1_InputCapture_Init(uint8 channel, uint8 edge, uint8 ps, FTM_ISR_CALLBACK isr_func);
uint8 LPLD_FTM2_InputCapture_Init(uint8 channel, uint8 edge, uint8 ps, FTM_ISR_CALLBACK isr_func);

void LPLD_FTM_Isr(void);

#endif /* __HAL_FTM_H__ */