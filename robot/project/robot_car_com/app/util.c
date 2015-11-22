#include "common.h"
#include "HAL_GPIO.h"
void delayMs(uint16 t)
{
  uint32 i=t*20000;
  while(i--);
}

void delayUs(uint16 t)
{
  uint32 i=t*20;
  while(i--);
}

int abs(int x)
{
	if(x>0) return x;
	else return -x;
}

void beep()
{
  LPLD_GPIO_Set_b(PTB, 23, OUTPUT_H);
  delayMs(10);
   LPLD_GPIO_Set_b(PTB, 23, OUTPUT_L);
}
