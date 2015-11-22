#ifndef __MOTOR_H
#define __MOTOR_H 

#include "config.h"

void motor_init();
void motor_set_left_speed(int speed);
void motor_set_right_speed(int speed);
int motor_get_right_speed();
int motor_get_left_speed();
#endif