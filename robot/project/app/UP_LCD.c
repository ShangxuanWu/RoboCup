/******************************************************************/
//	Copyright (C), 2011-2012, �������� 
//  Author   	  	: ����Ԫ  
//  Reviser				: �����
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
//�ܽų�ʼ��
/*************************************************/
void Lcds_Config(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;

	//ʹ�ܶ˿�ʱ��
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE);
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOD, ENABLE);

	CSLCDS_H;
	//GPIO����
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;		//�������
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_10MHz;		//10Mʱ���ٶ�
	//PC9��� 
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;						//ѡ��PC9
	GPIO_Init(GPIOC, &GPIO_InitStructure);							//����PC9Ϊ�������������������Ϊ10MHz
	//PD9,11,14���
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9|
																GPIO_Pin_11|
																GPIO_Pin_14;					//ѡ��PD9��11��14
	GPIO_Init(GPIOD, &GPIO_InitStructure);							//����PD9��11��14Ϊ�������������������Ϊ10MHz
}

/*************************************************/
//SPI���͵��ֽ�����
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
//д����
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
//д����
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
//������:UP_LCD_Init(void)
//����:��ʼ��LCD,��ʼ������Ҫ��LCD_WriteCmd(0xaf)�������ʾ
/*************************************************/
const u8 LCD_Tab[] = {		//0x26��0x27�����ӶԱȶ�
	0xa2,0xa0,0xc8,0xf8,0x00,0x27,0x2f,0x81,0x05,0xa4,0xa6,0xac,0x00,0xee,0x40
};

void UP_LCD_Init(void)
{
	u16 i;
	Lcds_Config();			//��ʼ��LCD�ܽ�
	RSTLCDS_L;
	for(i=0;i<65530;i++);
	RSTLCDS_H;
	
	for(i=0;i<15;i++)
		LCD_WriteCmd(LCD_Tab[i]);
	UP_LCD_ClearScreen();	  //����
	LCD_WriteCmd(0xaf);       //����ʾ
}

/*************************************************/
//��������**
//ע������:�������õ����겻��X,Y,����X,PAGE.��Ϊ�ڰ���һ��д�������Ϊ8����,����Ϊ�� 
//			ʽд��,������������ҳΪ��λ,64���㹲8ҳ 
/*************************************************/
void LCD_SetXP(u8 x,u8 page)
{
	LCD_WriteCmd((page&0x07)+0xb0);	//����ҳָ��
    LCD_WriteCmd((x>>4)|0x10);		//x����λ
    LCD_WriteCmd(x&0x0f);			//x����λ
}

/*************************************************/
//���LCD
/*************************************************/
void LCD_Fill(u8 dat)
{
    u8 i,j;
    for(i=0;i<8;i++)		//ҳָ��
    {
		LCD_SetXP(0,i);		//��ָ��
		for(j=0;j < 128;j++)
			LCD_WriteData(dat);
    }
}

/*************************************************
	����: void UP_LCD_ClearScreen(void)
	����: �����Ļ����
	����: ��
	����: ��
**************************************************/
void UP_LCD_ClearScreen(void)
{
	LCD_Fill(0);
	g_LCD_X = g_LCD_Y = 0;
}

/*************************************************
	����: void UP_LCD_ClearLine(u8 y)
	����: ���ָ��������
	����: ��
	����: ��
**************************************************/
void UP_LCD_ClearLine(u8 y)
{
	u8 i;
	u8 seg;
	u8 page;
	if (y > 3)
		return;
	for(i=0; i<2; i++)		//дҳ��ַ��һ����2ҳ
	{
		page = 0xb0 + (y<<1) + i;
		LCD_WriteCmd(page);
		LCD_WriteCmd(0x10); //�е�ַ���ߵ��ֽ�����д�룬�ӵ�0 �п�ʼ
		LCD_WriteCmd(0x00);
		for(seg=0; seg<128; seg++)//д128 ��
		{ 
			LCD_WriteData(0x00); 
		}
	}
}// */

/*************************************************
	����: void UP_LCD_ShowLetter(u8 x, u8 y, u8 ch)
	����: ��ʾ�����ַ�
	����: ��
	����: ��
**************************************************/
void UP_LCD_ShowLetter(u8 x, u8 y, u8 ch)
{
	u8 i;
	if(y > 3 || x > 16)
		return;
	x <<=3;
	if(ch >= 32 && ch <= 125)
	{
		LCD_WriteCmd(0xb0+(y<<1)); 	  	  //page��ַ
		LCD_WriteCmd(0x10+(x>>4)); //�е�ַ���ߵ��ֽ�����д�룬�ӵ�0�п�ʼ
		LCD_WriteCmd(0x00+(x&0x0f));
		for(i=0; i<8; i++)	  //�ϰ���
		{
			LCD_WriteData(LCD_Letters[((ch-32)<<4)+i]); 
		}
		LCD_WriteCmd(0xb1+(y<<1)); 	  	  //page��ַ
		LCD_WriteCmd(0x10+(x>>4)); //�е�ַ���ߵ��ֽ�����д�룬�ӵ�0�п�ʼ
		LCD_WriteCmd(0x00+(x&0x0f));
		for(i=0; i<8; i++)	  //�°���
		{
			LCD_WriteData(LCD_Letters[((ch-32)<<4)+8+i]); 
		}
	}
}

/*************************************************
	����: u8 UP_LCD_ShowString(u8 x, u8 y, char *pstring)
	����: ��ʾ�ַ����������ַ�����ʾ����
	����: �ַ���
	����: �ַ�������ʾ����
**************************************************/
u8 UP_LCD_ShowString(u8 x, u8 y, char *pstring)
{
	u8 result = 0;
	if(y > 3 || x > 16)
		return 0;
	while(*pstring != 0)
	{
		if (*pstring < 127)		//Ӣ��
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
		else					//����
		{
		}
	}
	return result;
}

/*************************************************
	����: u8 UP_LCD_ShowInt(u8 x, u8 y, int n)
	����: ��ʾ��������������������ʾ����
	����: ������
	����: ����������ʾ����
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
//���� fputc �˺���Ϊprintf����
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


