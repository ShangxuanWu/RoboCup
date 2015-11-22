#include "common.h"
#include "HAL_GPIO.h"
#include "HAL_FTM.h"
#include "function.h"
#include "config.h"
#include "HAL_ADC.h"
#include "control.h"

void init_gpio()
{
  //拨码开关
  LPLD_GPIO_Init(PTE, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTE, 1, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTE, 2, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTE, 3, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTE, 4, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTE, 5, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTE, 6, DIR_INPUT, INPUT_PUP, IRQC_DIS);

  //核心板指示灯
  LPLD_GPIO_Init(PTA, 15, DIR_OUTPUT, OUTPUT_L, IRQC_DIS);
  
  //蜂鸣器
  LPLD_GPIO_Init(PTB, 23, DIR_OUTPUT, OUTPUT_L, IRQC_DIS);
  
  //前排红外r1
  LPLD_GPIO_Init(PTB, 9, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTB, 10, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTB, 11, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTB, 18, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTB, 19, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTB, 20, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTB, 21, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTB, 22, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTC, 6, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTC, 7, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTC, 8, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  //后排红外r2
  LPLD_GPIO_Init(PTD, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTA, 5, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTA, 12, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTA, 13, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTA, 14, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTA, 16, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTA, 17, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  //左侧红外r3
  LPLD_GPIO_Init(PTE, 24, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTE, 25, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTE, 26, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  //右侧红外r4
  LPLD_GPIO_Init(PTC, 9, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTC, 12, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  LPLD_GPIO_Init(PTC, 13, DIR_INPUT, INPUT_PUP, IRQC_DIS);
  
  // 接近开关
  //LPLD_GPIO_Init(PTB, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
}

void init_pwm()
{
  //设置FTM0模块PWM频率为10kHz
  LPLD_FTM0_PWM_Init(10000);
  LPLD_FTM0_PWM_Open(4, 0);
  LPLD_FTM0_PWM_Open(5, 0);
  LPLD_FTM0_PWM_Open(6, 0);
  LPLD_FTM0_PWM_Open(7, 0);
}

_Bool scan_infront(void) {
	return control_get_carinfront();
}

void scan_infrared(_Bool *r1, _Bool *r2, _Bool *r3, _Bool *r4)
{
  r1[0]=LPLD_GPIO_Get_b(PTB, 9);
  r1[1]=LPLD_GPIO_Get_b(PTB, 10);
  r1[2]=LPLD_GPIO_Get_b(PTB, 11);
  r1[3]=LPLD_GPIO_Get_b(PTB, 18);
  r1[4]=LPLD_GPIO_Get_b(PTB, 19);
  r1[5]=LPLD_GPIO_Get_b(PTB, 20);
  r1[6]=LPLD_GPIO_Get_b(PTB, 21);
  r1[7]=LPLD_GPIO_Get_b(PTB, 22);
  r1[8]=LPLD_GPIO_Get_b(PTC, 6);
  r1[9]=LPLD_GPIO_Get_b(PTC, 7);
  r1[10]=LPLD_GPIO_Get_b(PTC, 8);
  
  r2[0]=LPLD_GPIO_Get_b(PTD, 0);
  r2[1]=LPLD_GPIO_Get_b(PTA, 5);
  r2[2]=LPLD_GPIO_Get_b(PTA, 12);
  r2[3]=LPLD_GPIO_Get_b(PTA, 13);
  r2[4]=LPLD_GPIO_Get_b(PTA, 14);
  r2[5]=LPLD_GPIO_Get_b(PTA, 16);
  r2[6]=LPLD_GPIO_Get_b(PTA, 17);
  
  r3[0]=LPLD_GPIO_Get_b(PTE, 24);
  r3[1]=LPLD_GPIO_Get_b(PTE, 25);
  r3[2]=LPLD_GPIO_Get_b(PTE, 26);
  
  r4[0]=LPLD_GPIO_Get_b(PTC, 13);
  r4[1]=LPLD_GPIO_Get_b(PTC, 12);
  r4[2]=LPLD_GPIO_Get_b(PTC, 9);
}

void calculate_infrared_error(_Bool *r, int r_size, int *error) {
	if (r == NULL || error == NULL) return;
	int eb1[12] = {0}, eb2[12] = {0};
	int j = 0, k = 0;
	for (int i = 1; i < r_size; ++ i) {
		if (r[i - 1] == 0 && r[i] == 1) eb1[j ++] = i;
		else if (r[i - 1] == 1 && r[i] == 0) eb2[k ++] = i;
	}
	
  if(j == 1 && k == 1)
  {
    if(eb2[0] - eb1[0] < BLACKLINE_WIDTH)//黑线应该小于等于3个红外
      *error = eb1[0] + eb2[0] - r_size - 1;
    //else
    // *error = r1_error;//超过4个说明是错误或者是十字等情况 暂且保持误差
  }
  else if(j == 1 && k == 0)
  {
	if (r[r_size - 1]) *error = r_size - 1;
	else *error = r_size;
  }	
  else if(j == 0 && k == 1)
  {
	if (r[1]) *error = 1 - r_size;
	//if (r[0]) *error = 1 - r_size;
	else *error = -r_size;
  }
  else if (j == 0 && k == 0 && r_size == INFRARED_LINE2_NUM) {
	*error = 0;
  }
  else	
  {
    //红外完全看不见，误差保持
  }		
}

void delayMs(uint16 t)  //粗略定时
{
  uint32 i=t*20000;
  while(i--);
}

void delayUs(uint16 t)  //粗略定时
{
  uint32 i=t*20;
  while(i--);
}

unsigned char scan_switch()
{
  unsigned char code = 0;
  for (char i = 0; i < 7; ++ i) {
	code |= !LPLD_GPIO_Get_b(PTE, i) ? (1 << i) : 0;
  }
  return code;
}
/*
void yesbeep()
{
  LPLD_GPIO_Set_b(PTB, 23, OUTPUT_H);
}

void nobeep()
{
  LPLD_GPIO_Set_b(PTB, 23, OUTPUT_L);
}
*/

/*
int abs(int a) {
   return a < 0 ? -a : a;
}
*/