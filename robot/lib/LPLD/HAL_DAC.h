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
#ifndef __HAL_DAC_H__
#define __HAL_DAC_H__
#include "common.h"

typedef void (*DAC_ISR_CALLBACK)(void);

//定义 BUFFER 使能
#define BUFFER_DISABLE          0x00 //缓冲区读指针禁用
#define BUFFER_ENABLE           0x01 //缓冲区读指针使能
//定义 TRIGER MODE 三种模式
#define TRIGER_MODE_NONE        0x00 //无触发模式
#define TRIGER_MODE_SOFTWARE    0x01 //软件触发模式
#define TRIGER_MODE_HARDWARE    0x02 //硬件触发模式
//定义 Buffer MODE 三种模式
#define BUFFER_MODE_NORMAL      0x00 //缓冲区正常模式
#define BUFFER_MODE_SWING       0x01 //缓冲区SWING模式
#define BUFFER_MODE_ONETIMESCAN 0x02 //缓冲区ONETIMESCAN模式
//定义 WATER MARK MODE 四种模式
#define WATER_MODE_1WORD        0x00 //1个字
#define WATER_MODE_2WORD        0x01 //2个字
#define WATER_MODE_3WORD        0x02 //3个字
#define WATER_MODE_4WORD        0x03 //4个字

//定义 DAC中断选择
#define DAC_IRQ_DISABLE         0x00 //关闭中断
#define DAC_IRQ_POINTER_BOTTOM  0x01 //缓冲计数指针指向底时触发中断
#define DAC_IRQ_POINTER_TOP     0x02 //缓冲计数指针指向顶时触发中断
#define DAC_IRQ_WATER_MARK      0x03 //达到水印设置的字时触发中断

typedef struct 
{
  DACx dacx;                  //配置DAC模块号
  
  uint8 Water_Mark_Mode;      //选择水印模式的字数
  
  uint8 Buffer_Enable;        //配置buffer缓冲区使能
  
  uint8 Buffer_Mode;          //配置buffer缓冲区的模式
  
  uint8 Triger_Mode;          //配置触发模式
  
  uint8 Buffer_Init_Pos;      //配置buffer缓冲区的起始位置
  
  uint8 Buffer_Up_Limit;      //配置buffer缓冲区的最大长度
  
  uint8 DAC_irqc;             //选择DAC模块中断
  
  DAC_ISR_CALLBACK isr_func;  //设置回调函数
  
}LPLD_DAC_Cfg_t;


//DAC初始化函数，在此函数中设置默认值
uint8 LPLD_DAC_Init(LPLD_DAC_Cfg_t *);
//DAC复位寄存器函数
void LPLD_DAC_Reset_Reg(DACx);
//DAC设置缓存区数据函数
void LPLD_DAC_Set_Buffer(DACx,uint8,uint16);
//DAC软件触发函数
void LPLD_DAC_Soft_Trig(DACx);
//DAC中断服务函数
void LPLD_DAC_Isr(void);

#endif