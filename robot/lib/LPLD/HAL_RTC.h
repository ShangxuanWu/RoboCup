/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_RTC.h
 * 用途: RTC底层模块相关函数
 * 最后修改日期: 20120621
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#ifndef __HAL_RTC_H__
#define __HAL_RTC_H__


#define RTC_INT_DIS           0
#define RTC_INT_INVALID       1
#define RTC_INT_OVERFLOW      2
#define RTC_INT_ALARM         4


typedef void (*RTC_ISR_CALLBACK)(void);

//RTC初始化函数
uint8 LPLD_RTC_Init(uint32, uint32,uint8, RTC_ISR_CALLBACK);
//RTC获得实时秒计数函数
uint32 LPLD_RTC_GetRealTime(void);
//RTC关闭函数
void LPLD_RTC_Stop(void);
//RTC重新设置报警寄存器函数
void LPLD_RTC_Alarm(uint32);
//RTC重新设置秒计数器函数
void LPLD_RTC_Seconds(uint32);
//RTC中断服务函数
void LPLD_RTC_Isr(void);

#endif