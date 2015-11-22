/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_GPIO.h
 * 用途: GPIO底层模块相关函数
 * 最后修改日期: 20120321
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#ifndef __HAL_GPIO_H__
#define __HAL_GPIO_H__
/********************************************************************/


#define DIR_INPUT       0
#define DIR_OUTPUT      1

#define OUTPUT_L        0
#define OUTPUT_H        1
#define INPUT_PDOWN     0
#define INPUT_PUP       1

#define IRQC_DIS        0x00
#define IRQC_DMARI      0x01
#define IRQC_DMAFA      0x02
#define IRQC_DMAET      0x03
#define IRQC_L          0x08
#define IRQC_RI         0x09
#define IRQC_FA         0x0A
#define IRQC_ET         0x0B
#define IRQC_H          0x0C


typedef void (*GPIO_ISR_CALLBACK)(void);

uint8 LPLD_GPIO_Init(PTx, uint8, uint8, uint8, uint8);
uint8 LPLD_GPIO_SetIsr(PTx, GPIO_ISR_CALLBACK);
uint8 LPLD_GPIO_ClearIsr(PTx);
void LPLD_GPIO_Set(PTx, uint32);
void LPLD_GPIO_Set_b(PTx, uint8, uint8);
void LPLD_GPIO_Toggle(PTx, uint32);
void LPLD_GPIO_Toggle_b(PTx, uint8);
uint32 LPLD_GPIO_Get(PTx);
uint8 LPLD_GPIO_Get_b(PTx, uint8);
void LPLD_GPIO_Isr(void);

#endif /* __HAL_GPIO_H__ */
