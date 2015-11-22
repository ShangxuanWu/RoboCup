/******************************************************************/
//	Copyright (C), 2011-2012, �������� 
//  Author   	  	: ����Ԫ  
//  Reviser				: �����
//  Update Date   : 2012/08/01
//  Version   	  : 1.3          
//  Description   : Transplant to v3.5 function library
/******************************************************************/

#ifndef GLOBLE_H
#define GLOBLE_H

#include "STM32Lib\\stm32f10x.h"

//����1��ز���
extern bool g_UP_bUART1IT;					//�Ƿ����ô������ݽ����ж�
extern u32 g_UP_UART1BaudRate;			//���ڲ�����
extern u32 g_UP_UART1ITAddress;		//�����ж���ں���

//����2��ز���
extern bool g_UP_bUART2IT;					//�Ƿ����ô������ݽ����ж�
extern u32 g_UP_UART2BaudRate;			//���ڲ�����
extern u32 g_UP_UART2ITAddress;		//�����ж���ں���

//����5��ز���
extern bool g_UP_bUART5IT;					//�Ƿ����ô������ݽ����ж�
extern u32 g_UP_UART5BaudRate;			//���ڲ�����
extern u32 g_UP_UART5ITAddress;		//�����ж���ں���

//��ʱ����ز���
extern bool g_UP_bTimerIT[4];			//�Ƿ����ô������ݽ����ж�
extern u32 g_UP_iTimerTime[4];		//��ʱ����
extern u32 g_UP_TimerITAddress;		//�����ж���ں���

//������ز���
extern bool g_UP_bBluetoothIT;		//�Ƿ������������ݽ����ж�
extern u32 g_UP_BluetoothITAddress;	//�����ж���ں���

//�ⲿ�ж���ز���
extern u32 g_UP_ExtiFlag;					//�ⲿ�ж�ʹ�ܵ�ͨ��
extern u32 g_UP_ExtiITAddress;		//�ⲿ�ж���ں���

//����
extern volatile u32 g_SysTickTimer;			//1ms��ȷϵͳʱ�Ӽ�ʱ�����������û������޸ģ�

//���ȫ�ֺ�������	
extern void UP_delay_us(u32 us);	//��usΪ��λ��ʱ
extern void UP_delay_ms(u32 ms);	//��msΪ��λ��ʱ
extern u32 abs(s32 i);						//����������ֵ
extern double fabs(double i);			//�󸡵�������ֵ

#endif

