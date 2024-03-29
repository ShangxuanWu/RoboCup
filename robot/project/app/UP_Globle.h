/******************************************************************/
//	Copyright (C), 2011-2012, 北京博创 
//  Author   	  	: 陈中元  
//  Reviser				: 乔潇楠
//  Update Date   : 2012/08/01
//  Version   	  : 1.3          
//  Description   : Transplant to v3.5 function library
/******************************************************************/

#ifndef GLOBLE_H
#define GLOBLE_H

#include "STM32Lib\\stm32f10x.h"

//串口1相关参数
extern bool g_UP_bUART1IT;					//是否启用串口数据接收中断
extern u32 g_UP_UART1BaudRate;			//串口波特率
extern u32 g_UP_UART1ITAddress;		//串口中断入口函数

//串口2相关参数
extern bool g_UP_bUART2IT;					//是否启用串口数据接收中断
extern u32 g_UP_UART2BaudRate;			//串口波特率
extern u32 g_UP_UART2ITAddress;		//串口中断入口函数

//串口5相关参数
extern bool g_UP_bUART5IT;					//是否启用串口数据接收中断
extern u32 g_UP_UART5BaudRate;			//串口波特率
extern u32 g_UP_UART5ITAddress;		//串口中断入口函数

//计时器相关参数
extern bool g_UP_bTimerIT[4];			//是否启用串口数据接收中断
extern u32 g_UP_iTimerTime[4];		//计时周期
extern u32 g_UP_TimerITAddress;		//串口中断入口函数

//蓝牙相关参数
extern bool g_UP_bBluetoothIT;		//是否启用蓝牙数据接收中断
extern u32 g_UP_BluetoothITAddress;	//蓝牙中断入口函数

//外部中断相关参数
extern u32 g_UP_ExtiFlag;					//外部中断使能的通道
extern u32 g_UP_ExtiITAddress;		//外部中断入口函数

//其他
extern volatile u32 g_SysTickTimer;			//1ms精确系统时钟计时器计数器（用户不可修改）

//相关全局函数定义	
extern void UP_delay_us(u32 us);	//以us为单位延时
extern void UP_delay_ms(u32 ms);	//以ms为单位延时
extern u32 abs(s32 i);						//求整数绝对值
extern double fabs(double i);			//求浮点数绝对值

#endif

