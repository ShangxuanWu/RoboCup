#include "defend.h"
#include "utils.h"
#include "UP_UART2Parser.h"
#include "graph.h"
#include "function.h"
#include "control.h"
#include "actor.h"

static uint8 field_sensors[10] = {0};
static enum DEFEND_TYPE cur_defend_type = DEFEND_NONE;

static _Bool is_running_to_initplace = 1; // 一开始跑向初始位置

CONTROL_CALLBACK_FUNC(defend_getcorner_callback, cmd, ev) {
	if (ev == E_FINISHED) {
		if (is_running_to_initplace) is_running_to_initplace = 0;
	}
}

/**
	2----1----0
	|    |    |
	|    4    |
	|    |    |
	6---------3
	|    |    |
	|    5    |
	|    |    |
	9----8----7
*/
enum DEFEND_TYPE analyse_field_sensors(uint8 fs[10]) {
	if (fs[0] || fs[7]) {
		yesbeep();
		return DEFEND_TO_2;
	}
	else if (fs[2] || fs[9]) {
		yesbeep();
		return DEFEND_TO_6;
	}
	else if (fs[4] || fs[5] || fs[8]) {
		yesbeep();
		return DEFEND_TO_4;
	}
	else if (fs[6]) {
		yesbeep();
		return DEFEND_PATROL_4_6;
	}
	else if (fs[3]) {
		yesbeep();
		return DEFEND_PATROL_2_4;
	}
	else { // 什么都没看到，保持
		nobeep();
		return DEFEND_NONE;
	}
}

void do_defend_to_2(int *dest_pnt, enum DIRECTION *last_dir) {
	*dest_pnt = 2;
	*last_dir = D_WEST;
}

void do_defend_to_4(int *dest_pnt, enum DIRECTION *last_dir) {
	*dest_pnt = 4;
	*last_dir = D_NORTH;
}

void do_defend_to_6(int *dest_pnt, enum DIRECTION *last_dir) {
	*dest_pnt = 6;
	*last_dir = D_EAST;
}

void do_defend_patrol_2_4(int *dest_pnt, enum DIRECTION *last_dir) {
	int curp = actor_get_current_point_num();
	static int __patrol_stay_counter = 0;
	if (curp == 4) {
		if (__patrol_stay_counter < 1500) __patrol_stay_counter ++;
		else {
			*dest_pnt = 2;
			*last_dir = D_WEST;
			__patrol_stay_counter = 0;
		}
	}
	else if (curp == 3) {
		if (actor_get_head_direction() == D_EAST) {
			*dest_pnt = 4;
			*last_dir = D_EAST;
		}
		else {
			*dest_pnt = 2;
			*last_dir = D_WEST;
		}
	}
	else if (curp == 2) {
		if (__patrol_stay_counter < 1500) __patrol_stay_counter ++;
		else {
			*dest_pnt = 4;
			*last_dir = D_EAST;
			__patrol_stay_counter = 0;
		}
	}
	else {
		*dest_pnt = 4;
		*last_dir = D_EAST;
	}
}

void do_defend_patrol_4_6(int *dest_pnt, enum DIRECTION *last_dir) {
	int curp = actor_get_current_point_num();
	static int __patrol_stay_counter = 0;
	if (curp == 6) {
		if (__patrol_stay_counter < 1500) __patrol_stay_counter ++;
		else {
			*dest_pnt = 4;
			*last_dir = D_WEST;
			__patrol_stay_counter = 0;
		}
	}
	else if (curp == 5) {
		if (actor_get_head_direction() == D_EAST) {
			*dest_pnt = 6;
			*last_dir = D_EAST;
		}
		else {
			*dest_pnt = 4;
			*last_dir = D_WEST;
		}
	}
	else if (curp == 4) {
		if (__patrol_stay_counter < 1500) __patrol_stay_counter ++;
		else {
			*dest_pnt = 6;
			*last_dir = D_EAST;
			__patrol_stay_counter = 0;
		}
	}
	else {
		*dest_pnt = 6;
		*last_dir = D_EAST;
	}
}

void do_defend_init(int *dest_pnt, enum DIRECTION *last_dir) {
	do_defend_patrol_4_6(dest_pnt, last_dir);
}

ACTOR_CALLBACK_FUNC(defend_actor_callback, p, d) {
	// 获取场地红外
	get_field_sensors(field_sensors);
	
	enum DEFEND_TYPE tmptype = analyse_field_sensors(field_sensors);
	if (tmptype != DEFEND_NONE) cur_defend_type = tmptype;
	
	extern long TIME_PASSED;
	
	if (TIME_PASSED > 1150) {
		cur_defend_type = DEFEND_TO_CENTER;
	}
	
	if (is_running_to_initplace) {
		cur_defend_type = DEFEND_INIT;
	}
	
	if (actor_is_car_infront()) {
		yesbeep(); // beep!!
		*p = actor_get_current_point_num();
		return;
	}
	else {
		nobeep();
	}
	
	switch (cur_defend_type) {
		case DEFEND_INIT: do_defend_init(p, d); break;
		case DEFEND_PATROL_2_4: do_defend_patrol_2_4(p, d); break;
		case DEFEND_PATROL_4_6: do_defend_patrol_4_6(p, d); break;
		case DEFEND_TO_2: do_defend_to_2(p, d); break;
		case DEFEND_TO_4: do_defend_to_4(p, d); break;
		case DEFEND_TO_6: do_defend_to_6(p, d); break;
		case DEFEND_TO_CENTER: *p = 16; *d = D_NONE; break;
		default:
			// 什么也不干
			break;
	}
}

void defend_init(void) {
	cur_defend_type = DEFEND_INIT;
	actor_set_callback_func(defend_actor_callback);
	actor_set_control_callback(C_GETCORNER, defend_getcorner_callback);
}
