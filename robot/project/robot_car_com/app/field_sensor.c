#include "field_sensor.h"
#include "util.h"
#include "common.h"
#include "HAL_PIT.h"

#define SENSOR_NUM 14
#define ULTRASONIC_NUM 2

int field_sensor[SENSOR_NUM][ULTRASONIC_NUM];

void field_sensor_init()
{
	for(int i=0;i<SENSOR_NUM;i++)
	for(int j=0;j<ULTRASONIC_NUM;j++)
	{
		field_sensor[i][j] = 0;
	}
}


void field_sensor_update() // 100ms调用一次，每次把所有的传感器减1
{
	for(int i=0;i<SENSOR_NUM;i++)
	for(int j=0;j<ULTRASONIC_NUM;j++)
	{
		field_sensor[i][j]-=20;
		if(field_sensor[i][j]<0)field_sensor[i][j]=0;
	}
}

_Bool is_available_sensor(char sensor_index,int ultrasonic_index)
{
	if(sensor_index<'A')return false;
	if(sensor_index>=('A'+SENSOR_NUM)) return false;
	if(ultrasonic_index==1)return true;
	if(ultrasonic_index==0)return true;
	return false;
}

void field_sensor_add(char sensor_index,int ultrasonic_index)
{
	if(!is_available_sensor(sensor_index,ultrasonic_index))return;
	field_sensor[sensor_index-'A'][ultrasonic_index]++;
	if(field_sensor[sensor_index-'A'][ultrasonic_index]>100)field_sensor[sensor_index-'A'][ultrasonic_index]=100;
}

int get_field_sensor(char sensor_index,int ultrasonic_index) //sensor_index 传感器模块编号 A~Z 超声波编号 0~1
{
	return field_sensor[sensor_index-'A'][ultrasonic_index];
}