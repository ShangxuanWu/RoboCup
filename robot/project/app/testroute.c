#include "testroute.h"
#include "control.h"
#include "graph.h"
#include "utils.h"
#include "function.h"

static enum DIRECTION head_direction = D_NORTH;
static struct Point cur_point = {0, 0};
static _Bool wait_for_corner = 0;
enum COMMAND curcmd = C_STOP;

CONTROL_CALLBACK_FUNC(testroute_turn_callback, cmd, ev) {
	if (ev == E_FINISHED) {
		head_direction = get_next_direction(cmd, head_direction);
		control_clear_distance();
	}
	
}

CONTROL_CALLBACK_FUNC(testroute_goahead_callback, cmd, ev) {
	if (ev == E_CROSS) {
		wait_for_corner = 1;
	}
	else if (ev == E_ONCROSS && wait_for_corner) {
		wait_for_corner = 0;
		control_clear_distance();
		cur_point = get_next_point(head_direction, cur_point);
		curcmd = C_STOP;
		yesbeep();
	}
	
}

CONTROL_CALLBACK_FUNC(testroute_getcorner_callback, cmd, ev) {
	if (ev == E_FINISHED) {
		control_clear_distance();
		wait_for_corner = 0;
		cur_point = get_next_point(head_direction, cur_point);
		curcmd = C_STOP;
		yesbeep();
	}
	else if (ev == E_CROSS) {
		wait_for_corner = 1;
	}
	
}

enum COMMAND __move_to(int dest_pnt_num, enum DIRECTION last_direction) {
	static int cur_pnt_num;
	static int path[GRAPH_POINT_NUM + 1], path_size;
	
	cur_pnt_num = graph_get_point_number(cur_point);
	graph_spfa(cur_pnt_num, dest_pnt_num, path, &path_size);
	
	// 已完成，把头转好
	if (path_size <= 1) {
		if (last_direction != D_NONE)
			return get_turn_command(head_direction, last_direction);
		else
			return C_STOP;
	}
	
	enum DIRECTION todir = get_adj_point_direction(cur_point, *graph_get_point(path[1]));
	if (todir == head_direction) {
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
		return get_turn_command(head_direction, todir);
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

void testroute_init(void) {
	control_set_callback(C_LEFT, testroute_turn_callback);
	control_set_callback(C_RIGHT, testroute_turn_callback);
	control_set_callback(C_AROUND, testroute_turn_callback);
	control_set_callback(C_AHEAD, testroute_goahead_callback);
	control_set_callback(C_GETCORNER, testroute_getcorner_callback);
}

void testroute_run(void) {
	static int dest_pnt_list[] = {24, 0};//{24, 32, 8, 0, 8, 32, 24, 0, 
									//14, 16, 18, 8, 4, 16, 28, 32, 18, 14, 0, 4, 16, 28, 24, 0};
	static int dest_pnt_index = 0;
	while (1) {
	
		if (!control_can_interrupt()) continue; // 正在转弯抓角就不用再走下去了，反正控不了
		// 更新边点号
        if (!graph_is_edge_point(cur_point) 
				&& is_on_edge()) {
			cur_point = get_next_point(head_direction, cur_point);
			nobeep();
		}
		
		_Bool interrupt = xxx(&dian, &last_, &xxx);
		// 先看看前面有没有人，有就停着
		if (scan_infront() 
			&& !graph_is_corner_point(cur_point)) {
			yesbeep(); // beep!!
			execute_command(C_BREAK);
			continue;
		}
		else {
			//nobeep();
		}
		
		if (graph_get_point_number(cur_point) == dest_pnt_list[dest_pnt_index]) {
			dest_pnt_index = (dest_pnt_index + 1) % 2;
		}
		
		curcmd = __move_to(dest_pnt_list[dest_pnt_index], D_NONE);
		execute_command(curcmd);
	}
}