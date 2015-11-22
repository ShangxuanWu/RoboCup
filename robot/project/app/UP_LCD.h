/******************************************************************/
//	Copyright (C), 2011-2012, �������� 
//  Author   	  	: ����Ԫ  
//  Reviser				: �����
//  Update Date   : 2012/08/01
//  Version   	  : 1.3          
//  Description   : Transplant to v3.5 function library
/******************************************************************/ 
#define u8 uint8
#ifndef LCDS_H
#define LCDS_H

extern void UP_LCD_Init(void); 					 								//��ʼ��LCD
extern void UP_LCD_ClearScreen(void);			 							//�����Ļ����
extern void UP_LCD_ClearLine(u8 y);										 	//���ָ��������
extern void UP_LCD_ShowLetter(u8 x, u8 y, u8 ch);				//��ָ��������ʾһ����ĸ
extern u8 UP_LCD_ShowString(u8 x, u8 y, char *pstring);	//��ָ��������ʾһ���ַ����������ַ�����ʾ����
extern u8 UP_LCD_ShowInt(u8 x, u8 y, int n);	 					//��ָ��������ʾһ���������ݣ���������������ʾ����

#endif

