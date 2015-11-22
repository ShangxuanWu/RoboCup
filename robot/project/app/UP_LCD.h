/******************************************************************/
//	Copyright (C), 2011-2012, 北京博创 
//  Author   	  	: 陈中元  
//  Reviser				: 乔潇楠
//  Update Date   : 2012/08/01
//  Version   	  : 1.3          
//  Description   : Transplant to v3.5 function library
/******************************************************************/ 
#define u8 uint8
#ifndef LCDS_H
#define LCDS_H

extern void UP_LCD_Init(void); 					 								//初始化LCD
extern void UP_LCD_ClearScreen(void);			 							//清除屏幕内容
extern void UP_LCD_ClearLine(u8 y);										 	//清除指定行内容
extern void UP_LCD_ShowLetter(u8 x, u8 y, u8 ch);				//在指定坐标显示一个字母
extern u8 UP_LCD_ShowString(u8 x, u8 y, char *pstring);	//在指定坐标显示一串字符串，返回字符串显示长度
extern u8 UP_LCD_ShowInt(u8 x, u8 y, int n);	 					//在指定坐标显示一个整形数据，返回整形数据显示长度

#endif

