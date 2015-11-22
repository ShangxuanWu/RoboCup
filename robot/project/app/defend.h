#ifndef __DEFEND_H
#define __DEFEND_H

#include "control.h"

enum DEFEND_TYPE {
	DEFEND_NONE = 0, DEFEND_INIT, 
	DEFEND_PATROL_2_4, DEFEND_PATROL_4_6, DEFEND_TO_2, DEFEND_TO_4, DEFEND_TO_6, DEFEND_TO_CENTER
};

void defend_init(void);

void defend_run(void);

#endif
