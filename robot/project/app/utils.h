#ifndef __UTILS_H
#define __UTILS_H

#include "control.h"
#include "utils.h"
#include "common.h"

enum DIRECTION {
	D_NORTH = 0, D_EAST, D_SOUTH, D_WEST, D_NONE = 0xffffffff
};

struct Point {
	int x, y;
};

enum DIRECTION get_next_direction(enum COMMAND cmd, enum DIRECTION direction);
struct Point get_next_point(enum DIRECTION direction, struct Point current_pnt);
enum DIRECTION get_adj_point_direction(struct Point f, struct Point t);
enum COMMAND get_turn_command(enum DIRECTION cur, enum DIRECTION dest);
struct Point point_map_to_standard(struct Point p);
struct Point point_map_from_standard(struct Point p);
enum DIRECTION direction_map_to_standard(enum DIRECTION dir);
enum DIRECTION direction_map_from_standard(enum DIRECTION dir);

void get_field_sensors(uint8 field_sensors[10]);

int execute_command(enum COMMAND cmd);

#endif