#include "utils.h"
#include "config.h"
#include "UP_UART2Parser.h"

//                     N  E  W   S
static int mov_x[4] = {0, 1, 0, -1};
static int mov_y[4] = {1, 0, -1, 0};

enum COMMAND __command_map(enum COMMAND cmd) {
	if (BEGIN_POINT == 8 || BEGIN_POINT == 24) {
		if (cmd == C_LEFT) return C_RIGHT;
		else if (cmd == C_RIGHT) return C_LEFT;
	}
	return cmd;
}

enum DIRECTION get_next_direction(enum COMMAND cmd, enum DIRECTION direction) {
	switch (__command_map(cmd)) {
		case C_LEFT:
			return (enum DIRECTION) ((direction - 1) % 4);
		case C_RIGHT:
			return (enum DIRECTION) ((direction + 1) % 4);
		case C_AROUND:
			return (enum DIRECTION) ((direction + 2) % 4);
		default:
			return direction;
	}
}

struct Point get_next_point(enum DIRECTION direction, struct Point current_pnt) {
	struct Point result;
	if (direction == D_NONE) return current_pnt;
	if (current_pnt.y == 2)
		current_pnt.x += mov_x[direction];
	result.x = current_pnt.x + mov_x[direction];
	result.y = current_pnt.y + mov_y[direction];
	return result;
}

struct Point point_map_to_standard(struct Point p) {
	if (BEGIN_POINT == 8) {
		p.x = 8 - p.x;
		return p;
	}
	else if (BEGIN_POINT == 24) {
		p.y = 4 - p.y;
		return p;
	}
	else if (BEGIN_POINT == 32) {
		p.x = 8 - p.x;
		p.y = 4 - p.y;
		return p;
	}
	return p;
}

struct Point point_map_from_standard(struct Point p) {
	return point_map_to_standard(p);
}

enum DIRECTION direction_map_to_standard(enum DIRECTION dir) {
	if (BEGIN_POINT == 8) {
		if (dir == D_EAST) return D_WEST;
		else if (dir == D_WEST) return D_EAST;
		return dir;
	}
	else if (BEGIN_POINT == 24) {
		if (dir == D_NORTH) return D_SOUTH;
		else if (dir == D_SOUTH) return D_NORTH;
		return dir;
	}
	else if (BEGIN_POINT == 32) {
		return (dir + 2) % 4;
	}
	return dir;
}

enum DIRECTION direction_map_from_standard(enum DIRECTION dir) {
	return direction_map_to_standard(dir);
}

enum DIRECTION get_adj_point_direction(struct Point f, struct Point t) {
	if (t.x > f.x) return D_EAST;
	else if (t.x < f.x) return D_WEST;
	else if (t.y > f.y) return D_NORTH;
	else if (t.y < f.y) return D_SOUTH;
	else return D_NONE;
}

static enum COMMAND __dir2cmd[4][4] = {
	{C_STOP, C_RIGHT, C_AROUND, C_LEFT}, // NORTH
	{C_LEFT, C_STOP, C_RIGHT, C_AROUND}, // EAST
	{C_AROUND, C_LEFT, C_STOP, C_RIGHT}, // WEST
	{C_RIGHT, C_AROUND, C_LEFT, C_STOP}  // SOUTH
};

enum COMMAND get_turn_command(enum DIRECTION cur, enum DIRECTION dest) {
	return __command_map(__dir2cmd[cur][dest]);
}

int execute_command(enum COMMAND cmd) {
	switch (cmd) {
		case C_AHEAD:		return control_goahead(4000);
		case C_GETCORNER:	return control_getcorner();
		case C_LEFT:		return control_turnleft();
		case C_RIGHT:		return control_turnright();
		case C_AROUND: 		return control_turnaround();
		case C_BREAK:		return control_break();
		case C_START:		return control_start();
		case C_LETSWIN:		return control_letswin();
		case C_STOP:
		default:			return control_stop();
	}
}

void swap_uint8(uint8 *a, uint8 *b) {
	(*a) ^= (*b) ^= (*a) ^= (*b);
}

void __field_sensors_vertical_mirror(uint8 field_sensors[10]) {
	swap_uint8(&field_sensors[0], &field_sensors[7]);
	swap_uint8(&field_sensors[1], &field_sensors[8]);
	swap_uint8(&field_sensors[4], &field_sensors[5]);
	swap_uint8(&field_sensors[2], &field_sensors[9]);
}

void __field_sensors_horizontal_mirror(uint8 field_sensors[10]) {
	swap_uint8(&field_sensors[0], &field_sensors[2]);
	swap_uint8(&field_sensors[3], &field_sensors[6]);
	swap_uint8(&field_sensors[7], &field_sensors[9]);
}

void get_field_sensors(uint8 field_sensors[10]) {
	GetFieldSensors(field_sensors);
	
	switch (BEGIN_POINT) {
		case 8:
			__field_sensors_horizontal_mirror(field_sensors);
			break;
		case 24:
			__field_sensors_vertical_mirror(field_sensors);
			break;
		case 32:
			__field_sensors_horizontal_mirror(field_sensors);
			__field_sensors_vertical_mirror(field_sensors);
			break;
	}
}
