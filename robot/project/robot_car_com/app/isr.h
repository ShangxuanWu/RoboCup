/*
 * 测试硬件平台:  LPLD_K60 Card
 * 版权所有:      北京拉普兰德电子技术有限公司
 * 网络销售:      http://laplenden.taobao.com
 * 公司门户:      http://www.lpld.cn
 *
 * 说明:    本工程基于Kintis K60开源底层开发包开发，
 *          所有开源驱动代码均在"LPLD"文件夹下，调用说明见文档[#LPLD-003-N]
 *
 * 文件名:  isr.h
 * 用途:    声明中断服务子程序，该头文件中所声明的中断函数均为底层中断函数，
 *	    向量号及函数名请参考文档[#LPLD-003-N]，或各底层模块".h"头文件。
 * 注意:   该头文件只能被"vectors.c"所包含。
 *
 */


#ifndef __ISR_H
#define __ISR_H 1

/* 声明底层中断服务子程序 */
//PIT模块中断服务定义
#undef  VECTOR_084
#define VECTOR_084 LPLD_PIT_Isr
#undef  VECTOR_085
#define VECTOR_085 LPLD_PIT_Isr
#undef  VECTOR_086
#define VECTOR_086 LPLD_PIT_Isr
#undef  VECTOR_087
#define VECTOR_087 LPLD_PIT_Isr
#undef  VECTOR_101
#define VECTOR_101 LPLD_LPTMR_Isr
#undef  VECTOR_061
#define VECTOR_061 LPLD_UART_Isr
#undef  VECTOR_063
#define VECTOR_063 LPLD_UART_Isr
#undef  VECTOR_065
#define VECTOR_065 LPLD_UART_Isr
#undef  VECTOR_067
#define VECTOR_067 LPLD_UART_Isr
#undef  VECTOR_069
#define VECTOR_069 LPLD_UART_Isr
#undef  VECTOR_071
#define VECTOR_071 LPLD_UART_Isr

// GPIO 模块中断服务定义 
#undef    VECTOR_103 
#define VECTOR_103 LPLD_GPIO_Isr 
#undef   VECTOR_104 
#define VECTOR_104 LPLD_GPIO_Isr 
#undef   VECTOR_105 
#define VECTOR_105 LPLD_GPIO_Isr 
#undef   VECTOR_106 
#define VECTOR_106 LPLD_GPIO_Isr 
#undef   VECTOR_107 
#define VECTOR_107 LPLD_GPIO_Isr 
//以下函数在 LPLD_Kinetis 底层包，不必修改 
extern void LPLD_GPIO_Isr(void);

//以下函数在LPLD_OSKinetis底层包，不必修改
extern void LPLD_PIT_Isr(void);
extern void LPLD_LPTMR_Isr(void);
extern void LPLD_UART_Isr(void);

#endif  //__ISR_H

/* End of "isr.h" */
