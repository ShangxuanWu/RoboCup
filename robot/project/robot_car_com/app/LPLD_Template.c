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



#include "control.h"
#include "motor.h"
#include "infrare.h"
#include "util.h"
#include "car.h"
<<<<<<< .mine
#include "move.h"


=======
#include "move.h"
>>>>>>> .r18
//�����жϺ���
void init_all()
{
  LPLD_GPIO_Init(PTB, 23, DIR_OUTPUT, OUTPUT_L, IRQC_DIS);
  infrare_init();
  motor_init();
  car_init();
<<<<<<< .mine
  move_init(); //Ӧ����control_initǰ��ִ��
  control_init();
=======

 control_init();
   move_init();
  
>>>>>>> .r18
}

int path[20]={23,27,28,29,30,
              31,32,28,27,30,
              29,31,32,27,28,
              29,30,27,28,29};

void main (void)
{
  init_all();
<<<<<<< .mine
  
=======
  move_by_path(20,path);
//do_turn_left();
>>>>>>> .r18
  while(1)
  {
<<<<<<< .mine
    
=======
     
>>>>>>> .r18
  }
  
 }
/********************************************************************/
