/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_ADC.h
 * 用途: ADC底层模块相关函数
 * 最后修改日期: 20120323
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#ifndef __HAL_ADC_H__
#define __HAL_ADC_H__
/********************************************************************/

typedef void (*ADC_ISR_CALLBACK)(void);


#include "adc16.h"     //需要调用官方例程中的adc相关函数
#define CONV_SING       0
#define CONV_DIFF       1  

//设置ADC事件
enum
{
  ADC_INT_DISABLE = 0x01, //ADC中断禁止
  ADC_INT_ENABLE  = 0x02,  //ADC中断使能
  ADC_DMA_DISABLE = 0x04, //ADC DMA请求禁止
  ADC_DMA_ENABLE  = 0x08 //ADC DMA请求使能
};

uint8 LPLD_ADC_Init(ADCx, uint8, uint8);
uint16 LPLD_ADC_SE_Get(ADCx, uint8);
void LPLD_ADC_SetHWTrg(ADCx);
uint8_t LPLD_ADC_Channel_Init(ADCx,uint8_t,uint8_t,ADC_ISR_CALLBACK);
#endif /* __HAL_ADC_H__ */