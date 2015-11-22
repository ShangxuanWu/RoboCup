#include "actor.h"

#include "control.h"
#include "graph.h"
#include "utils.h"
#include "function.h"
#include "config.h"
#include "HAL_ADC.h"
#include "UP_UART2Parser.h"

enum DIRECTION __actor_head_direction = D_NORTH;
struct Point __actor_cur_point = {0, 0};
static _Bool wait_for_corner = 0;

static CONTROL_CALLBACK_FUNC_VAR(actor_control_callbacks[CONTROL_COMMAND_COUNT], cmd, ev);
static ACTOR_CALLBACK_FUNC_VAR(actor_callback) = NULL;
static _Bool __autowin = 0;
static int __other_car_curp_num = 0;
static enum DIRECTION __other_car_head_direction = D_NORTH;

static void __call_control_callback(enum COMMAND cmd, enum EVENT ev) {
	if (actor_control_callbacks[cmd]) actor_control_callbacks[cmd](cmd, ev);
}

CONTROL_CALLBACK_FUNC(actor_turn_callback, cmd, ev) {
	if (ev == E_FINISHED) {
		__actor_head_direction = get_next_direction(cmd, __actor_head_direction);
		control_clear_distance();
	}
	__call_control_callback(cmd, ev);
}

CONTROL_CALLBACK_FUNC(actor_goahead_callback, cmd, ev) {
	if (ev == E_CROSS) {
		wait_for_corner = 1;
	}
	else if (ev == E_ONCROSS && wait_for_corner) {
		wait_for_corner = 0;
		control_clear_distance();
		__actor_cur_point = get_next_point(__actor_head_direction, __actor_cur_point);
		//yesbeep();
	}
	__call_control_callback(cmd, ev);
}

CONTROL_CALLBACK_FUNC(actor_getcorner_callback, cmd, ev) {
	if (ev == E_FINISHED) {
		control_clear_distance();
		wait_for_corner = 0;
		__actor_cur_point = get_next_point(__actor_head_direction, __actor_cur_point);
		//yesbeep();
	}
	else if (ev == E_CROSS) {
		wait_for_corner = 1;
	}
	__call_control_callback(cmd, ev);
}

static enum COMMAND __move_to(int dest_pnt_num, enum DIRECTION last_direction) {
	static int cur_pnt_num;
	static int path[GRAPH_POINT_NUM + 1], path_size;
	
	cur_pnt_num = graph_get_point_number(__actor_cur_point);
	graph_spfa(cur_pnt_num, dest_pnt_num, path, &path_size);
	
	// 已完成，把头转好
	if (path_size <= 1) {
		if (last_direction != D_NONE)
			return get_turn_command(__actor_head_direction, last_direction);
		else
			return C_STOP;
	}
	
	enum DIRECTION todir = get_adj_point_direction(__actor_cur_point, *graph_get_point(path[1]));
	if (todir == __actor_head_direction) {
		if (path_size > 2 && get_adj_point_direction(*graph_get_point(path[1]), *graph_get_point(path[2])) == todir) {
			return C_AHEAD;
		}
		else {
			return C_GETCORNER;
		}
	}
	// 两个点相同，没有方向可言，先给STOP
	else if (todir == D_NONE) { return C_STOP; }
	else {
		return get_turn_command(__actor_head_direction, todir);
	}
}

_Bool is_on_edge(void) {
	return control_get_distance() > 200 && !wait_for_corner;
}

_Bool can_interrupt() {
	return control_can_interrupt() // 可控状态		
		&& (control_get_distance() <= 20 // 没有离开边点
			|| is_on_edge()); // 已在边上
}

_Bool __is_facing_to_wall(enum DIRECTION dir, struct Point curpnt) {
	struct Point nxtpnt = get_next_point(dir, curpnt);
	return nxtpnt.x < 0 || nxtpnt.y < 0 || nxtpnt.x > 8 || nxtpnt.y > 4;
}

_Bool actor_is_car_infront(void) {
	struct Point nxtpnt = get_next_point(__actor_head_direction, __actor_cur_point);
/* 	if (__is_facing_to_wall(__actor_head_direction, __actor_cur_point)
			|| __is_facing_to_wall(__actor_head_direction, nxtpnt)) {
		threshole = SCAN_INFRONT_THRESHOLE_SMALL;
	} */
	return !__is_facing_to_wall(__actor_head_direction, __actor_cur_point) 
		&& scan_infront();
}

void actor_set_autowin(_Bool autowin) {
	__autowin = autowin;
}

static void __actor_bluetooth_recv_from_other_car(void) {
	static int __recv_buf_index = 0;
	unsigned char data = LPLD_UART_GetChar(UART4);
	
	if (data == 0xff) __recv_buf_index = 0;
	else if (__recv_buf_index == 0) {
		struct Point p = *graph_get_point((int) data);
		__other_car_curp_num = graph_get_point_number(point_map_from_standard(p));
		__recv_buf_index ++;
	}
	else if (__recv_buf_index == 1) {
		__other_car_head_direction = direction_map_from_standard((enum DIRECTION) data);
		__recv_buf_index ++;
	}
}

int actor_get_other_car_current_point_num(void) {
	return __other_car_curp_num;
}
struct Point actor_get_other_car_current_point(void) {
	return *graph_get_point(__other_car_curp_num);
}

enum DIRECTION actor_get_other_car_head_direction(void) {
	return __other_car_head_direction;
}

void actor_init(void) {
	control_set_callback(C_LEFT, actor_turn_callback);
	control_set_callback(C_RIGHT, actor_turn_callback);
	control_set_callback(C_AROUND, actor_turn_callback);
	control_set_callback(C_AHEAD, actor_goahead_callback);
	control_set_callback(C_GETCORNER, actor_getcorner_callback);
	
	LPLD_UART_RIE_Enable(UART4, __actor_bluetooth_recv_from_other_car);
	
	memset(actor_control_callbacks, 0, sizeof(actor_control_callbacks));
	actor_callback = NULL;
}

void actor_set_control_callback(enum COMMAND cmd, CONTROL_CALLBACK_FUNC_VAR(func, cmd, ev)) {
	actor_control_callbacks[cmd] = func;
}

struct Point actor_get_current_point(void) {
	return __actor_cur_point;
}

int actor_get_current_point_num(void) {
	return graph_get_point_number(__actor_cur_point);
}

enum DIRECTION actor_get_head_direction(void) {
	return __actor_head_direction;
}

void actor_set_callback_func(ACTOR_CALLBACK_FUNC_VAR(func)) {
	actor_callback = func;
}

void actor_run(void) {
	static int dest_pnt = 0;
	static int last_dest_pnt = 0;
	static enum DIRECTION last_direction = D_NONE;
	static enum COMMAND curcmd = C_STOP, lastcmd = C_STOP;
	extern int __adc;
	
	/*
	control_disable();
	while (!GetCmdAction());
	control_enable();
	execute_command(C_START);
	while (!is_on_position);
	*/
	control_enable();
	
	static _Bool __is_started_letswin = 0;
	while (1) {
		if (!GetCmdAction()) {
			execute_command(C_STOP);
			control_disable();
			continue;
		}
	
		__adc = LPLD_ADC_SE_Get(ADC0, 8);
		if (!can_interrupt()) continue; // 正在转弯抓角就不用再走下去了，反正控不了
		if (__autowin) {
			int curp = graph_get_point_number(__actor_cur_point);
			switch (curp) {
				case 26:
				case 30:
					__is_started_letswin = 1;
					if (__actor_head_direction != D_NORTH) {
						execute_command(get_turn_command(__actor_head_direction, D_NORTH));
					}
					else {
						execute_command(C_LETSWIN);
					}
					continue;
					break;
			}
		}
		
		if (__is_started_letswin) continue;
		
		// 更新边点号
        if (!graph_is_edge_point(__actor_cur_point) 
				&& is_on_edge()) {
			__actor_cur_point = get_next_point(__actor_head_direction, __actor_cur_point);
			//nobeep();
		}
		
		if (actor_callback) {
			actor_callback(&dest_pnt, &last_direction);
		}
			
		// 先看看前面有没有人，有就停着 (要改)
		/*
		if (scan_infront() 
			&& !graph_is_corner_point(__actor_cur_point)) {
			yesbeep(); // beep!!
			execute_command(C_BREAK);
			continue;
		}
		else {
			nobeep();
		}
		*/
		
		curcmd = __move_to(dest_pnt, last_direction);
		if (last_dest_pnt != dest_pnt) {
			// 要变换目标点，可能要刹车
			if (curcmd != C_AHEAD && curcmd != C_GETCORNER // 当前需要转弯或者停
					&& (lastcmd == C_AHEAD || lastcmd == C_GETCORNER)) // 上一条指令是直走
				execute_command(C_BREAK);
			last_dest_pnt = dest_pnt;
			lastcmd = C_BREAK;
			while (!can_interrupt());
		}
		execute_command(curcmd);
		lastcmd = curcmd;
	}
}