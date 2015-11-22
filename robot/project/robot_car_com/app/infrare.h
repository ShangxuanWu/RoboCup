#ifndef __INFRARE_H
#define __INFRARE_H

#include "config.h"
#include "common.h"

#define FRONT 0
#define RIGHT 1
#define LEFT  2
#define TAIL  3

void infrare_init(); //初始化红外IO口
void infrare_update(); //扫描更新红外的值
unsigned char* get_infrare(int side);//获取红外的信息


#endif

