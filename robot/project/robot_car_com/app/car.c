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


void car_change_direction() //改变方向时映射传感器的位置
{
	//TODO：两侧红外的顺序没有映射，还有前后红外的左右方向不对
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

void car_set_right_speed(int speed) //设置车子当前方向的右侧轮子速度 负数为反转
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

void car_set_left_speed(int speed) //设置车子当前方向的左侧轮子速度 负数为反转
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