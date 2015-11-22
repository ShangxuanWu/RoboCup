#ifndef __MOVE_H
#define __MOVE_H
#include "control.h"


_Bool move_by_path(int length,int* path); //设置路径
int get_target_direction(); //返回当前的目标方向 ？？？有用否？？
void set_tarjer_direction(int x); //设置目的点的方向
int get_direction(); //返回当前的方向
int get_now_point(); //返回当前的点
int get_rest_step(); //返回剩下的步数

void move_init();

#endif