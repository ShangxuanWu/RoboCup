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
#ifndef __HAL_PDB_H__
#define __HAL_PDB_H__
#include "common.h"


//PDB 用到的宏定义
#define PDB0       (0)
#define PDB1       (1)
//定义触发模式
#define TRIGER_IN0      (0)
#define TRIGER_IN1      (1)
#define TRIGER_IN2      (2)
#define TRIGER_IN3      (3)
#define TRIGER_IN4      (4)
#define TRIGER_IN5      (5)
#define TRIGER_IN6      (6)
#define TRIGER_IN7      (7)
#define TRIGER_IN8      (8)
#define TRIGER_IN9      (9)
#define TRIGER_IN10     (10)
#define TRIGER_IN11     (11)
#define TRIGER_IN12     (12)
#define TRIGER_IN13     (13)
#define TRIGER_IN14     (14)
#define SOFTWARE_TRIGER (15)
//定义LDMOD加载模式
#define LDMOD0       (0)
#define LDMOD1       (1)
#define LDMOD2       (2)
#define LDMOD3       (3)
//定义Work_mode PDB工作模式
#define PDB_ONESHOT  (0)
#define PDB_CONTINUE (1)
//定义PDB是否开启DMA功能
#define PDB_DMA_OFF  (0)
#define PDB_DMA_ON   (1)
//定义PDB开启状态
#define PDB_STOP      (0)
#define PDB_OPERATION (1)

#define PDB_PRESC_1       (0)
#define PDB_PRESC_2       (1)
#define PDB_PRESC_4       (2)
#define PDB_PRESC_8       (3)
#define PDB_PRESC_16      (4)
#define PDB_PRESC_32      (5)
#define PDB_PRESC_64      (6)
#define PDB_PRESC_128     (7)

#define PDB_MULT_1        (0)
#define PDB_MULT_10       (1)
#define PDB_MULT_20       (2)
#define PDB_MULT_40       (3)

#define PDB_PRECH_DIS     (0)
#define PDB_PRECH_EN0     (1)
#define PDB_PRECH_EN1     (2)

#define PDB_PREBB_DIS     (0)
#define PDB_PREBB_EN0     (1)
#define PDB_PREBB_EN1     (2)

#define PDB_EXTRG_DIS     (0)
#define PDB_EXTRG_EN      (1)

//PDB模块中断回调函数类型
typedef void (*PDB_ISR_CALLBACK)(void);

//PDB模块开启计数函数
void LPLD_PDB_SetUp(uint8 isPDB_Operate);
//PDB模块初始化函数
uint8 LPLD_PDB_Init(uint8,uint8,uint16 ,uint8,uint8,uint8,uint8);
//PDB DAC周期触发设置函数
void LPLD_PDB_DAC_Interval_Congfig(DACx,uint16,uint8);
//PDB ADC周期触发设置函数
void LPLD_PDB_ADC_Trigger_Congfig(ADCx, uint16*, uint8, uint8);
//PDB 延时中断函数
void LPLD_PDB_SetDelayIsr(uint16,PDB_ISR_CALLBACK);
//PDB 延时函数
void LPLD_PDB_Delay(uint16);
//PDB中断服务函数
void LPLD_PDB_Isr(void);
#endif