/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_UART.c
 * 用途: UART底层模块相关函数
 * 最后修改日期: 20120330
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
*/


#ifndef __HAL_UART_H__
#define __HAL_UART_H__

//UART模块中断回调函数类型
typedef void (*UART_ISR_CALLBACK)(void);

//UART初始化
void LPLD_UART_Init(UARTx, int);
//UART获取一个字符
char LPLD_UART_GetChar(UARTx);
//UART发送一个字符
void LPLD_UART_PutChar(UARTx, char );
//UART发送字符数组
void LPLD_UART_PutCharArr(UARTx, char*, int);
//UART接收中断使能
void LPLD_UART_RIE_Enable(UARTx, UART_ISR_CALLBACK);
//UART接收中断禁用
void LPLD_UART_RIE_Disable(UARTx uartx);
//UART中断服务
void LPLD_UART_Isr(void);

#endif