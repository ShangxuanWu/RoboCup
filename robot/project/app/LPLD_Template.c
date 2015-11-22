/*
* --------------"��������K60�ײ��"ʾ������-----------------
*
* ����Ӳ��ƽ̨:  LPLD_K60 Card
* ��Ȩ����:      �����������µ��Ӽ������޹�˾
* ��������:      http://laplenden.taobao.com
* ��˾�Ż�:      http://www.lpld.cn
*
* ˵��:    �����̻���"��������K60�ײ��"������
*          ���п�Դ�����������"LPLD"�ļ����£�����˵�����ĵ�[#LPLD-003-N]
*
* �ļ���:  LPLD_Template.c
* ��;:    Kinetisͨ�ù���ģ�壬�û��ɸ��ݴ�ģ�幤���½��Լ��Ĺ���
*          ������Ĭ�ϰ������еײ����������԰���ü����̲���Ҫ���������Լ�С�����ļ�
*
*/

//����˵����function.h������˵����variable.h
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

//�����жϺ���

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
