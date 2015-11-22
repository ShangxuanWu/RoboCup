#ifndef __FUNCTION_H
#define __FUNCTION_H

#include "common.h"
#include "HAL_GPIO.h"
#include "HAL_FTM.h"

//全局变量
//extern unsigned char r1[11],r2[7],r3[3],r4[3];//红外
//函数声明
void delayMs(uint16 t); //大约延迟t毫秒
void delayUs(uint16 t); //大约延迟t微秒
unsigned char scan_switch(void);  //返回按键值，按组合从0-127
void scan_infrared(_Bool *r1, _Bool *r2, _Bool *r3, _Bool *r4); //读取红外，值放入数组r1-r4中
_Bool scan_infront(void);
void calculate_infrared_error(_Bool *r, int r_size, int *error);
void init_gpio(void); //初始化gpio调用
void init_pwm(void);  //初始化pwm调用
//void yesbeep(void); //开蜂鸣器
//void nobeep(void);  //关蜂鸣器

#define nobeep() LPLD_GPIO_Set_b(PTB, 23, OUTPUT_L)
#define yesbeep() LPLD_GPIO_Set_b(PTB, 23, OUTPUT_H)
#define abs(a) ((a) < 0 ? -(a) : (a))

#endif