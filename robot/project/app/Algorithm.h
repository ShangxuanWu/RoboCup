#ifndef __ALGORITHM_H
#define __ALGORITHM_H
#include "variable.h"
typedef struct {
        int infrared[10]; // ����
        int direction; // ����
        int distance; // ����
        char can_control; // �Ƿ���Կ���
        char is_cross; // �Ƿ���·��
        char is_start; // �������ڽ���
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