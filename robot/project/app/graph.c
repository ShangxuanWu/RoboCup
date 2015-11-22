#include "graph.h"
#include <stdlib.h>
#include "common.h"
#include "utils.h"

#ifndef INT_MAX
#define INT_MAX 0x7fffffff
#endif

#define GRAPH_QUEUE_SIZE (GRAPH_POINT_NUM + 1)
struct GraphQueue {
	int head, tail, size;
	int data[GRAPH_QUEUE_SIZE];
};

void graph_queue_init(struct GraphQueue *q) {
	q->head = q->tail = q->size = 0;
}

int graph_queue_push(struct GraphQueue *q, int d) {
	if (q->size == GRAPH_QUEUE_SIZE) return -1;
	q->data[q->tail] = d;
	q->tail = (q->tail + 1) % GRAPH_QUEUE_SIZE;
	q->size ++;
	return 0;
}

int graph_queue_front(struct GraphQueue *q) {
	return q->data[q->head];
}

int graph_queue_pop(struct GraphQueue *q) {
	if (q->size == 0) return -1;
	q->head = (q->head + 1) % GRAPH_QUEUE_SIZE;
	q->size --;
	return 0;
}

static int graph_points[GRAPH_POINT_NUM + 1]; // the index of the first edge of point i
static struct Edge graph_edges[GRAPH_EDGE_NUM + 1];
static int last_edge = 0;

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

static int point2num[5][9] = {
	{0, 1, 2, 3, 4, 5, 6, 7, 8},
	{13, -1, -1, -1, 11, -1, -1, -1, 9},
	{14, -1, 15, -1, 16, -1, 17, -1, 18},
	{23, -1, -1, -1, 21, -1, -1, -1, 19},
	{24, 25, 26, 27, 28, 29, 30, 31, 32}
};
static struct Point num2point[GRAPH_POINT_NUM] = {
	{0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}, {6, 0}, {7, 0}, {8, 0}, 
	{8, 1}, {-1, -1}, {4, 1}, {-1, -1}, {0, 1},
	{0, 2}, {2, 2}, {4, 2}, {6, 2}, {8, 2},
	{8, 3}, {-1, -1}, {4, 3}, {-1, -1}, {0, 3},
	{0, 4}, {1, 4}, {2, 4}, {3, 4}, {4, 4}, {5, 4}, {6, 4}, {7, 4}, {8, 4}
};

int graph_get_point_number(struct Point p) {
	if (p.x < 0 || p.x >= 9 || p.y < 0 || p.y >= 5) return -1;
	return point2num[p.y][p.x];
}

struct Point *graph_get_point(int num) {
	if (num >= GRAPH_POINT_NUM || num < 0) return NULL;
	return &num2point[num];
}

_Bool graph_is_edge_point_num(int num) {
	return (num >= 0 && num < GRAPH_POINT_NUM) && (num & 1);
}

_Bool graph_is_edge_point(struct Point p) {
	return graph_is_edge_point_num(graph_get_point_number(p));
}

_Bool graph_is_corner_point_num(int num) {
	switch (num) {
		case 0:
		case 4:
		case 8:
		case 28:
		case 24:
		case 32:
		case 14:
		case 18:
			return 1;
		default:
			return 0;
	}
}

_Bool graph_is_corner_point(struct Point p) {
	return graph_is_corner_point_num(graph_get_point_number(p));
}

_Bool graph_set_edge_weight(int a, int b, int weight) {
	if (a < 0 || b > GRAPH_POINT_NUM || weight < 0) {
		return 0;
	}
	
	_Bool is_found = 0;
	for (int e = graph_points[a]; e != -1; e = graph_edges[e].next_edge) {
		if (graph_edges[e].next_pnt == b) {
			is_found = 1;
			graph_edges[e].weight = weight;
		}
	}
	for (int e = graph_points[b]; e != -1; e = graph_edges[e].next_edge) {
		if (graph_edges[e].next_pnt == a) {
			is_found = 1;
			graph_edges[e].weight = weight;
		}
	}
	
	return is_found;
}

int graph_get_edge_weight(int a, int b) {
	if (a < 0 || b > GRAPH_POINT_NUM) return -1;
	int res = -1;
	for (int e = graph_points[a]; e != -1; e = graph_edges[e].next_edge) {
		if (graph_edges[e].next_pnt == b) {
			res = graph_edges[e].weight;
			break;
		}
	}
	return res;
}

static int edge_init_weights[GRAPH_EDGE_NUM + 1];
_Bool graph_reset_edge_weight(int a, int b) {
	_Bool __is_found = 0;
	for (int e = graph_points[a]; e != -1; e = graph_edges[e].next_edge) {
		if (graph_edges[e].next_pnt == b) {
			graph_edges[e].weight = edge_init_weights[e];
			__is_found = 1;
		}
	}
	for (int e = graph_points[b]; e != -1; e = graph_edges[e].next_edge) {
		if (graph_edges[e].next_pnt == a) {
			graph_edges[e].weight = edge_init_weights[e];
			__is_found = 1;
		}
	}
	return __is_found;
}

static void graph_add_directed_edge(int from, int to, int weight) {
	graph_edges[last_edge].next_pnt = to;
	graph_edges[last_edge].next_edge = graph_points[from];
	edge_init_weights[last_edge] = graph_edges[last_edge].weight = weight;
	
	graph_points[from] = last_edge ++;
}

static void graph_add_undirected_edge(int p1, int p2, int weight) {
	graph_add_directed_edge(p1, p2, weight);
	graph_add_directed_edge(p2, p1, weight);
}

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

#define U_EDGE(a, b, w) graph_add_undirected_edge(a, b, w)
void graph_init(void) {
	last_edge = 0;
	memset(graph_points, -1, sizeof(graph_points));
	U_EDGE(0, 1, 1); U_EDGE(1, 2, 1); U_EDGE(2, 3, 1); U_EDGE(3, 4, 1); U_EDGE(4, 5, 1); U_EDGE(5, 6, 1); U_EDGE(6, 7, 1); U_EDGE(7, 8, 1);
	U_EDGE(8, 9, 2); U_EDGE(4, 11, 2); U_EDGE(0, 13, 2);
	U_EDGE(9, 18, 2); U_EDGE(11, 16, 2); U_EDGE(13, 14, 2);
	U_EDGE(14, 15, 2); U_EDGE(15, 16, 2); U_EDGE(16, 17, 2); U_EDGE(17, 18, 2);
	U_EDGE(18, 19, 2); U_EDGE(16, 21, 2); U_EDGE(14, 23, 2);
	U_EDGE(19, 32, 2); U_EDGE(21, 28, 2); U_EDGE(23, 24, 2);
	U_EDGE(24, 25, 1); U_EDGE(25, 26, 1); U_EDGE(26, 27, 1); U_EDGE(27, 28, 1); U_EDGE(28, 29, 1); U_EDGE(29, 30, 1); U_EDGE(30, 31, 1); U_EDGE(31, 32, 1);
}

void swap_int(int *a, int *b) {
	(*a) ^= (*b) ^= (*a) ^= (*b);
}

void __reverset_path(int *path, int path_size) {
	for (int i = 0, j = path_size - 1; i < j; ++ i, -- j) {
		swap_int(&path[i], &path[j]);
	}
}

extern enum DIRECTION actor_get_head_direction(void);
int graph_spfa(int pnum_from, int pnum_to, int *path, int *path_size) {
	if (pnum_from < 0 || pnum_from >= GRAPH_POINT_NUM 
		|| pnum_to < 0 || pnum_to >= GRAPH_POINT_NUM) return -1;
	static struct GraphQueue queue;
	static int pre[GRAPH_POINT_NUM + 1];
	static int dist[GRAPH_POINT_NUM + 1];
	static _Bool visited[GRAPH_POINT_NUM + 1];
	
	memset(pre, -1, sizeof(pre));
	graph_queue_init(&queue);
	memset(visited, 0, sizeof(visited));
	for (int i = 0; i < GRAPH_POINT_NUM + 1; ++ i) dist[i] = INT_MAX;
	visited[pnum_from] = 1;
	dist[pnum_from] = 0;
	graph_queue_push(&queue, pnum_from);
	while (queue.size != 0) {
		int cur = graph_queue_front(&queue);
		graph_queue_pop(&queue);
		for (int e = graph_points[cur]; e != -1; e = graph_edges[e].next_edge) {
			int new_weight = dist[cur] + graph_edges[e].weight;
			enum DIRECTION pre_dir;
			if (pre[cur] != -1) {
				pre_dir = 
					get_adj_point_direction(*graph_get_point(pre[cur]), *graph_get_point(cur));
			}
			// 起始点
			else {
				pre_dir = actor_get_head_direction();
			}
			enum DIRECTION cur_dir = 
				get_adj_point_direction(*graph_get_point(cur), *graph_get_point(graph_edges[e].next_pnt));
			if (pre_dir != cur_dir) // 如果要转弯，要加权
				new_weight += GRAPH_TURN_ADDITION_WEIGHT;

			if (dist[graph_edges[e].next_pnt] > new_weight) {
				dist[graph_edges[e].next_pnt] = new_weight;
				pre[graph_edges[e].next_pnt] = cur;
				if (!visited[graph_edges[e].next_pnt]) {
					visited[graph_edges[e].next_pnt] = 1;
					graph_queue_push(&queue, graph_edges[e].next_pnt);
				}
			}
		}
		visited[cur] = 0;
	}
	
	if (path_size != NULL && path != NULL) {
		*path_size = 0;
		int cur = pnum_to;
		while (cur != -1) {
			path[(*path_size) ++] = cur;
			cur = pre[cur];
		}
		__reverset_path(path, *path_size);
	}
    return dist[pnum_to];
}
