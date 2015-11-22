/*
* --------------"拉普兰德K60底层库"示例工程-----------------
*
* 测试硬件平台:  LPLD_K60 Card
* 版权所有:      北京拉普兰德电子技术有限公司
* 网络销售:      http://laplenden.taobao.com
* 公司门户:      http://www.lpld.cn
*
* 说明:    本工程基于"拉普兰德K60底层库"开发，
*          所有开源驱动代码均在"LPLD"文件夹下，调用说明见文档[#LPLD-003-N]
*
* 文件名:  LPLD_Template.c
* 用途:    Kinetis通用工程模板，用户可根据此模板工程新建自己的工程
*          本功能默认包含所有底层驱动，可以按需裁剪工程不需要的驱动，以减小生成文件
*
*/

//函数说明见function.h，变量说明见variable.h
#include "common.h"
#include "HAL_MCG.h"
#include "HAL_GPIO.h"
#include "HAL_PIT.h"
#include "HAL_FTM.h"
#include "HAL_LPTMR.h"
#include "HAL_UART.h"
#include "function.h"
//#include "variable.h"
#include "UP_UART2Parser.h"
#include "Algorithm.h"
#include "control.h"
#include "utils.h"
#include "graph.h"
#include "config.h"
//#include "testroute.h"
#include "defend.h"
#include "actor.h"
#include "attack.h"
#include "test.h"

//声明中断函数

void main (void)
{
  control_init();
  config_init();
  //LPLD_UART_RIE_Enable(UART4, uart4_recv_isr);
  graph_init();
  actor_init();
  unsigned char code = scan_switch() & 0x07;
  switch (code) {
	case 0:
		defend_init();
		V_MAX = 6000;
		break;
	case 1:
		attack_init();
		break;
  }
  //attack_init();
  //test_func_init();
  /*
  extern int __adc;
  while (1) {
	__adc = LPLD_ADC_SE_Get(ADC0, 8);
	if (actor_is_car_infront()) yesbeep();
	else nobeep();
  }
  */
  //actor_set_callback_func(actor_callback);
  
  //control_enable();
  actor_run();
}
