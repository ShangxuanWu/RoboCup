#ifndef __INFRARE_H
#define __INFRARE_H

#include "config.h"
#include "common.h"

#define FRONT 0
#define RIGHT 1
#define LEFT  2
#define TAIL  3

void infrare_init(); //��ʼ������IO��
void infrare_update(); //ɨ����º����ֵ
unsigned char* get_infrare(int side);//��ȡ�������Ϣ


#endif

