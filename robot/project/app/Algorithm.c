#include "Algorithm.h"


void set_sensor_callback(void (*callback(const SensorData *))) {
    sensor_callback = callback; // sensor_callback是一个全局变量
}  // 设置回调函数
/*
int control_goahead(int go_distance_temp)
{
  if (!robot_controlable)
    return -1;
   routechoice=goahead;
   goahead_distance_set=go_distance_temp;
   robot_controlable=0;
   return 0;
}
int control_turnaround()
{
  if (!robot_controlable)
    return -1;
   routechoice=turnaround;
   robot_controlable=0;
   return 0;
}
int control_turnleft()
{
  if (!robot_controlable)
    return -1;
  routechoice=turnleft;
   robot_controlable=0;
   return 0;
}
int control_turnright()
{
  if (!robot_controlable)
    return -1;
  routechoice=turnright;
   robot_controlable=0;
   return 0;
}
int control_stop()
{
  if (!robot_controlable&& !robot_controlable_downgrade)
    return -1;
  routechoice=stop;
   robot_controlable=1;
   robot_controlable_downgrade=0;
   return 0;
}
int control_getcorner()
{
  if (!robot_controlable)
    return -1;
  routechoice=corner;
  robot_controlable=0;
  return 0;
}

int control_goback()
{
  if (!robot_controlable)
    return -1;
   routechoice=goback;
   robot_controlable=0;
   return 0;
}
*/