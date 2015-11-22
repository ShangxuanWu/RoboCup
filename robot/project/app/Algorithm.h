#ifndef __ALGORITHM_H
#define __ALGORITHM_H
#include "variable.h"
typedef struct {
        int infrared[10]; // 红外
        int direction; // 方向
        int distance; // 距离
        char can_control; // 是否可以控制
        char is_cross; // 是否在路口
        char is_start; // 比赛正在进行
    }SensorData;
extern void *(*sensor_callback)(const SensorData *);


void set_sensor_callback(void (*callback(const SensorData *)));
/*
int control_goahead(int);
int control_turnaround(void); 
int control_turnleft(void);       
int control_turnright(void);  
int control_stop(void);
int control_getcorner(void);
int control_goback(void);
*/
#endif