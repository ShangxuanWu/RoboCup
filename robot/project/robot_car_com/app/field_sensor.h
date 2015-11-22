#ifndef __FIELD_SENSOR_H
#define __FIELD_SENSOR_H

void field_sensor_init();
void field_sensor_update();

void field_sensor_add(char sensor_index,int ultrasonic_index);
int get_field_sensor(char sensor_index,int ultrasonic_index);

#endif