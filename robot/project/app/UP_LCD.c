/******************************************************************/
//	Copyright (C), 2011-2012, 北京博创 
//  Author   	  	: 陈中元  
//  Reviser				: 乔潇楠
//  Update Date   : 2012/08/01
//  Version   	  : 1.3          
//  Description   : Transplant to v3.5 function library
/******************************************************************/ 

#include "UP_LCD.h"
#include "UP_Letters.h"

#define L_DELAY	0

#define A0_H		(GPIOD->BSRR = GPIO_Pin_14)
#define A0_L		(GPIOD->BRR = GPIO_Pin_14) 

#define CSLCDS_H
#define CSLCDS_L 

#define RSTLCDS_H	(GPIOC->BSRR = GPIO_Pin_9)
#define RSTLCDS_L	(GPIOC->BRR = GPIO_Pin_9)

#define SCL_H		(GPIOD->BSRR = GPIO_Pin_11)
#define SCL_L		(GPIOD->BRR = GPIO_Pin_11)

#define LCD_MOSI_H		(GPIOD->BSRR = GPIO_Pin_9)
#define LCD_MOSI_L		(GPIOD->BRR = GPIO_Pin_9)

u8 g_LCD_X = 0;
u8 g_LCD_Y = 0;

/*************************************************/
//管脚初始化
/*************************************************/
void Lcds_Config(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;

	//使能端口时钟
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE);
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOD, ENABLE);

	CSLCDS_H;
	//GPIO设置
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;		//推挽输出
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_10MHz;		//10M时钟速度
	//PC9输出 
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;						//选择PC9
	GPIO_Init(GPIOC, &GPIO_InitStructure);							//配置PC9为推挽输出，最高输出速率为10MHz
	//PD9,11,14输出
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9|
																GPIO_Pin_11|
																GPIO_Pin_14;					//选择PD9、11、14
	GPIO_Init(GPIOD, &GPIO_InitStructure);							//配置PD9、11、14为推挽输出，最高输出速率为10MHz
}

/*************************************************/
//SPI发送单字节数据
/*************************************************/
void SPIByte(u8 byte)
{
	u8 i;
//	u8 j;
	u8 temp = byte;
	SCL_L;
	for(i=0;i<8;i++)
	{
		if(temp&0x80)
			LCD_MOSI_H;
		else
			LCD_MOSI_L;
//		for(j=0; j<L_DELAY; j++)__nop();
		SCL_H;
//		for(j=0; j<L_DELAY; j++)__nop();
		SCL_L;
//		for(j=0; j<L_DELAY; j++)__nop();
		temp<<=1;
	}
}


/*************************************************/
//写命令
/*************************************************/
void LCD_WriteCmd(u8 cmd)
{
	CSLCDS_L;
	A0_L;
//	__nop();
//	__nop();
	SPIByte(cmd);
//	__nop();
//	__nop();
	CSLCDS_H;
}
	
/*************************************************/
//写数据
/*************************************************/
void LCD_WriteData(u8 dat)
{	
	CSLCDS_L;
	A0_H;
//	__nop();
//	__nop();
	SPIByte(dat);
//	__nop();
//	__nop();
	CSLCDS_H;
}

/*************************************************/
//函数名:UP_LCD_Init(void)
//功能:初始化LCD,初始化后需要用LCD_WriteCmd(0xaf)命令打开显示
/*************************************************/
const u8 LCD_Tab[] = {		//0x26改0x27可增加对比度
	0xa2,0xa0,0xc8,0xf8,0x00,0x27,0x2f,0x81,0x05,0xa4,0xa6,0xac,0x00,0xee,0x40
};

void UP_LCD_Init(void)
{
	u16 i;
	Lcds_Config();			//初始化LCD管脚
	RSTLCDS_L;
	for(i=0;i<65530;i++);
	RSTLCDS_H;
	
	for(i=0;i<15;i++)
		LCD_WriteCmd(LCD_Tab[i]);
	UP_LCD_ClearScreen();	  //清屏
	LCD_WriteCmd(0xaf);       //开显示
}

/*************************************************/
//设置坐标**
//注意事项:这里设置的坐标不是X,Y,而是X,PAGE.因为黑白屏一次写入的数据为8个点,而且为竖 
//			式写入,故纵坐标是以页为单位,64个点共8页 
/*************************************************/
void LCD_SetXP(u8 x,u8 page)
{
	LCD_WriteCmd((page&0x07)+0xb0);	//设置页指针
    LCD_WriteCmd((x>>4)|0x10);		//x高四位
    LCD_WriteCmd(x&0x0f);			//x低四位
}

/*************************************************/
//填充LCD
/*************************************************/
void LCD_Fill(u8 dat)
{
    u8 i,j;
    for(i=0;i<8;i++)		//页指针
    {
		LCD_SetXP(0,i);		//列指针
		for(j=0;j < 128;j++)
			LCD_WriteData(dat);
    }
}

/*************************************************
	函数: void UP_LCD_ClearScreen(void)
	功能: 清除屏幕内容
	参数: 无
	返回: 无
**************************************************/
void UP_LCD_ClearScreen(void)
{
	LCD_Fill(0);
	g_LCD_X = g_LCD_Y = 0;
}

/*************************************************
	函数: void UP_LCD_ClearLine(u8 y)
	功能: 清除指定行内容
	参数: 无
	返回: 无
**************************************************/
void UP_LCD_ClearLine(u8 y)
{
	u8 i;
	u8 seg;
	u8 page;
	if (y > 3)
		return;
	for(i=0; i<2; i++)		//写页地址，一行有2页
	{
		page = 0xb0 + (y<<1) + i;
		LCD_WriteCmd(page);
		LCD_WriteCmd(0x10); //列地址，高低字节两次写入，从第0 列开始
		LCD_WriteCmd(0x00);
		for(seg=0; seg<128; seg++)//写128 列
		{ 
			LCD_WriteData(0x00); 
		}
	}
}// */

/*************************************************
	函数: void UP_LCD_ShowLetter(u8 x, u8 y, u8 ch)
	功能: 显示单个字符
	参数: 无
	返回: 无
**************************************************/
void UP_LCD_ShowLetter(u8 x, u8 y, u8 ch)
{
	u8 i;
	if(y > 3 || x > 16)
		return;
	x <<=3;
	if(ch >= 32 && ch <= 125)
	{
		LCD_WriteCmd(0xb0+(y<<1)); 	  	  //page地址
		LCD_WriteCmd(0x10+(x>>4)); //列地址，高低字节两次写入，从第0列开始
		LCD_WriteCmd(0x00+(x&0x0f));
		for(i=0; i<8; i++)	  //上八列
		{
			LCD_WriteData(LCD_Letters[((ch-32)<<4)+i]); 
		}
		LCD_WriteCmd(0xb1+(y<<1)); 	  	  //page地址
		LCD_WriteCmd(0x10+(x>>4)); //列地址，高低字节两次写入，从第0列开始
		LCD_WriteCmd(0x00+(x&0x0f));
		for(i=0; i<8; i++)	  //下八列
		{
			LCD_WriteData(LCD_Letters[((ch-32)<<4)+8+i]); 
		}
	}
}

/*************************************************
	函数: u8 UP_LCD_ShowString(u8 x, u8 y, char *pstring)
	功能: 显示字符串，返回字符串显示长度
	参数: 字符串
	返回: 字符串的显示长度
**************************************************/
u8 UP_LCD_ShowString(u8 x, u8 y, char *pstring)
{
	u8 result = 0;
	if(y > 3 || x > 16)
		return 0;
	while(*pstring != 0)
	{
		if (*pstring < 127)		//英文
		{
			if(x < 16)
				UP_LCD_ShowLetter(x++,y,*pstring);
			else if((++y) < 4)
			{
				x  = 0;
				UP_LCD_ShowLetter(x++,y,*pstring);
			}
			else
				break;
			pstring++;
			result++;
		}
		else					//中文
		{
		}
	}
	return result;
}

/*************************************************
	函数: u8 UP_LCD_ShowInt(u8 x, u8 y, int n)
	功能: 显示整形数，返回整形数显示长度
	参数: 整型数
	返回: 整型数的显示长度
**************************************************/
u8 UP_LCD_ShowInt(u8 x, u8 y, int n)
{
	s8 i; 
	u8 bf = 0;
	char display_buffer[8] = {0};
	
	if(n < 0)
	{
		n = -n;
		bf = 1;
	}
	
	for(i=6; i>=0; i--)
	{
		display_buffer[i] = '0'+n%10;
		n = n/10;
		if(n == 0)
		break;
	}
	if(bf)
	{
		i--;
		display_buffer[i] = '-';
	}
	UP_LCD_ShowString(x,y,&display_buffer[i]);// */
	return 7-i;
}

/*************************************************/
//定义 fputc 此函数为printf所用
/*************************************************/
int fputc(int ch) 
{ 
	static u8 s_bClearScreen = 0;
	if(s_bClearScreen)
	{
		s_bClearScreen = 0;
		UP_LCD_ClearScreen();
	}
	if(ch == '\n')
	{
		g_LCD_Y++;
		g_LCD_X = 0;
	}
    if(g_LCD_X > 15)
	{	
		g_LCD_Y++;
		g_LCD_X = 0;
	}
	if(g_LCD_Y > 3)
	{
		s_bClearScreen = 1;
	}
	if(ch != '\r' && ch != '\n')
	{
		UP_LCD_ShowLetter(g_LCD_X,g_LCD_Y,(u8)ch);
		g_LCD_X++;
	}
    return ch; 
} 


