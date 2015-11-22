#include "car.h"
#include "infrare.h"
#include "motor.h"
int car_direction=1; //1 K60  0 zigbee
int car_speed=0;


unsigned char *car_front_infrare;
unsigned char *car_left_infrare;
unsigned char *car_right_infrare;
unsigned char *car_tail_infrare;

void car_init()
{
	car_speed = 0;
	car_direction =1;
	car_front_infrare = get_infrare(FRONT);
	car_left_infrare = get_infrare(LEFT);
	car_right_infrare = get_infrare(RIGHT);
	car_tail_infrare = get_infrare(TAIL);
}


void car_change_direction() //�ı䷽��ʱӳ�䴫������λ��
{
	//TODO����������˳��û��ӳ�䣬����ǰ���������ҷ��򲻶�
	car_direction=1-car_direction;
	car_speed=-car_speed;
	if(car_direction)
	{
		car_front_infrare = get_infrare(FRONT);
		car_left_infrare  = get_infrare(LEFT);
		car_right_infrare = get_infrare(RIGHT);
		car_tail_infrare  = get_infrare(TAIL);
	}
	else
	{
		car_front_infrare = get_infrare(TAIL);
		car_tail_infrare  = get_infrare(FRONT);
		car_left_infrare  = get_infrare(LEFT);
		car_right_infrare = get_infrare(RIGHT);
	}
}

void car_set_right_speed(int speed) //���ó��ӵ�ǰ������Ҳ������ٶ� ����Ϊ��ת
{

	if(car_direction)
	{
		motor_set_right_speed(speed);
	}
	else
	{
		motor_set_left_speed(speed);
	}
}

void car_set_left_speed(int speed) //���ó��ӵ�ǰ�������������ٶ� ����Ϊ��ת
{
	if(car_direction)
	{
		motor_set_left_speed(speed);
	}
	else
	{
		motor_set_right_speed(speed);
	}
}