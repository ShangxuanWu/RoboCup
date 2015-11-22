/******************************************************************/
//	Copyright (C), 2011-2012, 北京博创 
//  Author   	  	: 陈中元  
//  Reviser				: 乔潇楠
//  Update Date   : 2012/08/01
//  Version   	  : 1.3          
//  Description   : Transplant to v3.5 function library
/******************************************************************/ 

#include "UP_Globle.h"

//串口1相关参数
bool g_UP_bUART1IT = FALSE;				//是否启用串口数据接收中断
u32 g_UP_UART1BaudRate = 19200;		//串口波特率
u32 g_UP_UART1ITAddress = 0;				//串口1中断入口函数

//串口2相关参数
bool g_UP_bUART2IT = FALSE;				//是否启用串口数据接收中断
u32 g_UP_UART2BaudRate = 19200;		//串口波特率
u32 g_UP_UART2ITAddress = 0;				//串口2中断入口函数

//串口5相关参数
bool g_UP_bUART5IT = FALSE;				//是否启用串口数据接收中断
u32 g_UP_UART5BaudRate = 19200;		//串口波特率
u32 g_UP_UART5ITAddress = 0;				//串口5中断入口函数

//计时器相关参数
bool g_UP_bTimerIT[4] = {FALSE,FALSE,FALSE,FALSE};		//是否启用定时器中断
u32 g_UP_TimerITAddress = 0;			//定时器中断入口函数

//外部中断相关参数
u32 g_UP_ExtiFlag = 0;						//外部中断使能的通道
u32 g_UP_ExtiITAddress = 0;				//外部中断入口函数

//其他
volatile u32 g_SysTickTimer = 0;	//1ms精确系统时钟计时器计数器（直接在中断函数里被改变值的变量需要加volatile声明）

/*************************************************
	函数: void UP_delay_us(u32 us)
	功能: 以us为单位延时
	参数: 无
	返回: 无
**************************************************/
void UP_delay_us(u32 us) 					//以us为单位延时
{
	u16 i;
	while(us)
	{
		us--;
		for(i=0;i<8;i++)__nop();
	}
}

/*************************************************
	函数: void UP_delay_ms(u32 ms)
	功能: 以ms为单位延时
	参数: 无
	返回: 无
**************************************************/
void UP_delay_ms(u32 ms)					//以ms为单位延时
{
//	g_SysTickTimer = ms;
//	while(g_SysTickTimer);
	u16 i;
	while(ms)
	{
		ms--;
		for(i=0;i<8000;i++)__nop();
	}
}

/*************************************************
	函数: u32 abs(s32 i)
	功能: 求整数绝对值
	参数: signed long型变量
	返回: 变量的绝对值
**************************************************/
u32 abs(s32 i)										//求整数绝对值
{
	return i>=0?i:-i;
}

/*************************************************
	函数: double fabs(double i)
	功能: 求浮点数绝对值
	参数: double型变量
	返回: 变量的绝对值
**************************************************/
double fabs(double i)							//求浮点数绝对值
{
	return i>=0?i:-i;
}
