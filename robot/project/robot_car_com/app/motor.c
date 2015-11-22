#include "motor.h"
#include "common.h"
#include "HAL_GPIO.h"
#include "HAL_FTM.h"





int motor_left_speed = 0;
int motor_right_speed =0;

void motor_init()
{
	 //设置FTM0模块PWM频率为10kHz
  LPLD_FTM0_PWM_Init(10000);
  
  LPLD_FTM0_PWM_Open(4, 0);  //PTD4 左侧马达前进
  LPLD_FTM0_PWM_Open(5, 0);  //PTD5 左侧马达后退

  LPLD_FTM0_PWM_Open(7, 0);  //PTD6 右侧马达前进
  LPLD_FTM0_PWM_Open(6, 0);  //PTD7 右侧马达后退
}

void motor_set_left_speed(int speed)
{
  motor_left_speed=speed;
  if((int)speed>=0)
  {
    LPLD_FTM0_PWM_ChangeDuty(4,speed);
    LPLD_FTM0_PWM_ChangeDuty(5,0);
  }
  else
  {
    LPLD_FTM0_PWM_ChangeDuty(4,0);
    LPLD_FTM0_PWM_ChangeDuty(5,-speed);
  }
}


void motor_set_right_speed(int speed)
{
  motor_right_speed=speed;
  if((int)speed>=0)
  {
    LPLD_FTM0_PWM_ChangeDuty(7,speed);
    LPLD_FTM0_PWM_ChangeDuty(6,0);
  }
  else
  {
    LPLD_FTM0_PWM_ChangeDuty(7,0);
    LPLD_FTM0_PWM_ChangeDuty(6,-speed);
  }
}

int motor_get_right_speed()
{
	return motor_right_speed;
}

int motor_get_left_speed()
{
	return motor_left_speed;
}