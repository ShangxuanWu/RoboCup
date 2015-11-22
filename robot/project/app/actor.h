#ifndef __ACTOR_H
#define __ACTOR_H

#include "control.h"

void actor_set_control_callback(enum COMMAND cmd, CONTROL_CALLBACK_FUNC_VAR(func, cmd, ev));
struct Point actor_get_current_point(void);
int actor_get_current_point_num(void);
enum DIRECTION actor_get_head_direction(void);
_Bool actor_is_car_infront(void);
void actor_set_autowin(_Bool);

int actor_get_other_car_current_point_num(void);
struct Point actor_get_other_car_current_point(void);

enum DIRECTION actor_get_other_car_head_direction(void);

#define ACTOR_CALLBACK_FUNC(func, p, d) void func(int * p, enum DIRECTION * d)
#define ACTOR_CALLBACK_FUNC_VAR(func) void (*func)(int *, enum DIRECTION *)
void actor_set_callback_func(ACTOR_CALLBACK_FUNC_VAR(func));

void actor_init(void);
void actor_run(void);

#endif
