#include "led.h"
#include "common.h"
#include "HAL_GPIO.h"

void led_init()
{
	LPLD_GPIO_Init(PTA, 15, DIR_OUTPUT, OUTPUT_L, IRQC_DIS);
}

void led_twinkle() //100ms中断，系统板闪灯
{
  LPLD_GPIO_Toggle_b(PTA, 15);
}
