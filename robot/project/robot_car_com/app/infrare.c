#include "infrare.h"d
#include "common.h"
#include "HAL_GPIO.h"
#include "HAL_FTM.h"
#include "HAL_PIT.h"

/*
	front
	_______
	|       |
	|  zb   |
left |       | right
	|  K60  | 
	|_______|   
		tail
*/

#define FRONT_INFRARE_NUM 11
#define TAIL_INFRARE_NUM 11 
#define LEFT_INFRARE_NUM 3
#define RIGHT_INFRARE_NUM 3

unsigned char front_infrare[FRONT_INFRARE_NUM];
unsigned char tail_infrare[TAIL_INFRARE_NUM];
unsigned char left_infrare[LEFT_INFRARE_NUM];
unsigned char right_infrare[RIGHT_INFRARE_NUM];

void infrare_init()
{
	//前排红外front_infrare
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
	//后排红外tail_infrare
	LPLD_GPIO_Init(PTB, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTA, 5, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTA, 12, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTA, 13, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTA, 14, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTA, 16, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTA, 17, DIR_INPUT, INPUT_PUP, IRQC_DIS);

	LPLD_GPIO_Init(PTD, 1, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTD, 2, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTD, 3, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTB, 1, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	//左侧红外left_infrare
	LPLD_GPIO_Init(PTE, 24, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTE, 25, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTE, 26, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	//右侧红外right_infrare
	LPLD_GPIO_Init(PTC, 9, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTC, 12, DIR_INPUT, INPUT_PUP, IRQC_DIS);
	LPLD_GPIO_Init(PTC, 13, DIR_INPUT, INPUT_PUP, IRQC_DIS);  

	LPLD_PIT_Init(PIT1,5000,infrare_update);
}

void infrare_update()
{
	front_infrare[0]=LPLD_GPIO_Get_b(PTB, 9);
	front_infrare[1]=LPLD_GPIO_Get_b(PTB, 10);
	front_infrare[2]=LPLD_GPIO_Get_b(PTB, 11);
	front_infrare[3]=LPLD_GPIO_Get_b(PTB, 18);
	front_infrare[4]=LPLD_GPIO_Get_b(PTB, 19);
	front_infrare[5]=LPLD_GPIO_Get_b(PTB, 20);
	front_infrare[6]=LPLD_GPIO_Get_b(PTB, 21);
	front_infrare[7]=LPLD_GPIO_Get_b(PTB, 22);
	front_infrare[8]=LPLD_GPIO_Get_b(PTC, 6);
	front_infrare[9]=LPLD_GPIO_Get_b(PTC, 7);
	front_infrare[10]=LPLD_GPIO_Get_b(PTC, 8);

	tail_infrare[0]=LPLD_GPIO_Get_b(PTA, 17);
	tail_infrare[1]=LPLD_GPIO_Get_b(PTA, 16);
	tail_infrare[2]=LPLD_GPIO_Get_b(PTA, 14); 
	tail_infrare[3]=LPLD_GPIO_Get_b(PTA, 13); 
	tail_infrare[4]=LPLD_GPIO_Get_b(PTA, 12);
	tail_infrare[5]=LPLD_GPIO_Get_b(PTA, 5);
	tail_infrare[6]=LPLD_GPIO_Get_b(PTB, 0);
	tail_infrare[7]=LPLD_GPIO_Get_b(PTB, 1);
	tail_infrare[8]=LPLD_GPIO_Get_b(PTD, 3);
	tail_infrare[9]=LPLD_GPIO_Get_b(PTD, 2);
	tail_infrare[10]=LPLD_GPIO_Get_b(PTD,1);

	left_infrare[0]=LPLD_GPIO_Get_b(PTE, 24);
	left_infrare[1]=LPLD_GPIO_Get_b(PTE, 25);
	left_infrare[2]=LPLD_GPIO_Get_b(PTE, 26);

	right_infrare[0]=LPLD_GPIO_Get_b(PTC, 13);
	right_infrare[1]=LPLD_GPIO_Get_b(PTC, 12);
	right_infrare[2]=LPLD_GPIO_Get_b(PTC, 9);
}


unsigned char *get_infrare(int side)
{
	switch(side)
	{
	case FRONT:
		return front_infrare;
	case RIGHT:
		return right_infrare;
	case LEFT:
		return left_infrare;
	case TAIL:
		return tail_infrare;
	}
  return NULL;
}