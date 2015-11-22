#ifndef __FUNCTION_H
#define __FUNCTION_H

#include "common.h"
#include "HAL_GPIO.h"
#include "HAL_FTM.h"

//ȫ�ֱ���
//extern unsigned char r1[11],r2[7],r3[3],r4[3];//����
//��������
void delayMs(uint16 t); //��Լ�ӳ�t����
void delayUs(uint16 t); //��Լ�ӳ�t΢��
unsigned char scan_switch(void);  //���ذ���ֵ������ϴ�0-127
void scan_infrared(_Bool *r1, _Bool *r2, _Bool *r3, _Bool *r4); //��ȡ���⣬ֵ��������r1-r4��
_Bool scan_infront(void);
void calculate_infrared_error(_Bool *r, int r_size, int *error);
void init_gpio(void); //��ʼ��gpio����
void init_pwm(void);  //��ʼ��pwm����
//void yesbeep(void); //��������
//void nobeep(void);  //�ط�����

#define nobeep() LPLD_GPIO_Set_b(PTB, 23, OUTPUT_L)
#define yesbeep() LPLD_GPIO_Set_b(PTB, 23, OUTPUT_H)
#define abs(a) ((a) < 0 ? -(a) : (a))

#endif