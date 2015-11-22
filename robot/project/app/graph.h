#ifndef __GRAPH_H
#define __GRAPH_H

#include "utils.h"

#define GRAPH_POINT_NUM 33
#define GRAPH_EDGE_NUM 32 * 2

#define GRAPH_TURN_ADDITION_WEIGHT 20

struct Edge {
	int next_pnt;
	int next_edge;
	int weight;
};

/*
  08--07--06--05--04--03--02--01--00 (0, 0)
  |               |               |
  09              11              13
  |               |               |
  18------17------16------15------14
  |               |               |
  19              21              23
  |               |               |
  32--31--30--29--28--27--26--25--24
  
*/

int graph_get_point_number(struct Point p);
struct Point *graph_get_point(int num);
_Bool graph_is_edge_point_num(int num);
_Bool graph_is_edge_point(struct Point p);
_Bool graph_is_corner_point_num(int num);
_Bool graph_is_corner_point(struct Point p);
int graph_get_edge_weight(int a, int b);
_Bool graph_set_edge_weight(int a, int b, int weight);
_Bool graph_reset_edge_weight(int a, int b);
void graph_init(void);
int graph_spfa(int pnum_from, int pnum_to, int *path, int *path_size);

#endif
