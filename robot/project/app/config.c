#include "config.h"
#include "function.h"

int CAR_NUMBER = 0;
int BEGIN_POINT = 0;
int V_BREAK = 7000;
int TURNLEFT_TIMECOUNT = 70, TURNRIGHT_TIMECOUNT = 70, TURNAROUND_TIMECOUNT = 140;
int V_TURNLEFT = 3000, V_TURNRIGHT = 3000, V_TURNAROUND = 3000;
int TURNLEFT_R_MOTOR_WEAKEN = 0, TURNLEFT_L_MOTOR_WEAKEN = 0;
int TURNRIGHT_R_MOTOR_WEAKEN = 0, TURNRIGHT_L_MOTOR_WEAKEN = 0;
int TURNAROUND_R_MOTOR_WEAKEN = 0, TURNAROUND_L_MOTOR_WEAKEN = 0;
int V_MAX = 6000;
int LETSWIN_GOHEAD_DISTANCE = 70, LETSWIN_BACK_TIME = 50;
int LETSWIN_V_L_FIRST_STEP = 5000, LETSWIN_V_R_FIRST_STEP = -1500;
int LETSWIN_V_L_SECOND_STEP = 1000, LETSWIN_V_R_SECOND_STEP = -4000;

int SCAN_INFRONT_THRESHOLE_SMALL = 14000;
int SCAN_INFRONT_THRESHOLE_BIG = 12000;

// 第六七位
static void config_init_car(unsigned char code) {
	// 一号车
	CAR_NUMBER = code = (code & 0x60) >> 5;
	if (code == 0) {
		V_BREAK = 4000;
		
		V_TURNLEFT = 8000;
		TURNLEFT_TIMECOUNT = 40;
		TURNLEFT_R_MOTOR_WEAKEN = 2000;
		TURNLEFT_L_MOTOR_WEAKEN = 0;
		
		V_TURNRIGHT = 8000;
		TURNRIGHT_TIMECOUNT = 40;
		TURNRIGHT_R_MOTOR_WEAKEN = 0;
		TURNRIGHT_L_MOTOR_WEAKEN = 1000;
		
		V_TURNAROUND = 7000;
		TURNAROUND_TIMECOUNT = 90;
		TURNAROUND_R_MOTOR_WEAKEN = 0;
		TURNAROUND_L_MOTOR_WEAKEN = 500;
		
		SCAN_INFRONT_THRESHOLE_SMALL = 15500;
		SCAN_INFRONT_THRESHOLE_BIG = 13000;
	}
	// 二号车
	else if (code == 1) {
		V_BREAK = 0;
		
		V_TURNLEFT = 8000;
		TURNLEFT_TIMECOUNT = 40;
		TURNLEFT_R_MOTOR_WEAKEN = 0;
		TURNLEFT_L_MOTOR_WEAKEN = 90;
		
		V_TURNRIGHT = 8000;
		TURNRIGHT_TIMECOUNT = 40;
		TURNRIGHT_R_MOTOR_WEAKEN = 0;
		TURNRIGHT_L_MOTOR_WEAKEN = 0;
		
		V_TURNAROUND = 7000;
		TURNAROUND_TIMECOUNT = 90;
		TURNAROUND_R_MOTOR_WEAKEN = 0;
		TURNAROUND_L_MOTOR_WEAKEN = 600;
		
		SCAN_INFRONT_THRESHOLE_SMALL = 25000;
		SCAN_INFRONT_THRESHOLE_BIG = 21000;
	}
	// 三号车
	else if (code == 2) {
		V_BREAK = 0;
		
		V_TURNLEFT = 8000;
		TURNLEFT_TIMECOUNT = 40;
		TURNLEFT_R_MOTOR_WEAKEN = 600;
		TURNLEFT_L_MOTOR_WEAKEN = 0;
		
		V_TURNRIGHT = 8000;
		TURNRIGHT_TIMECOUNT = 40;
		TURNRIGHT_R_MOTOR_WEAKEN = 0;
		TURNRIGHT_L_MOTOR_WEAKEN = 0;
		
		V_TURNAROUND = 7000;
		TURNAROUND_TIMECOUNT = 90;
		TURNAROUND_R_MOTOR_WEAKEN = 0;
		TURNAROUND_L_MOTOR_WEAKEN = 600;
		
		SCAN_INFRONT_THRESHOLE_SMALL = 20000;
		SCAN_INFRONT_THRESHOLE_BIG = 13000;
	}
	// 四号车
	else if (code == 3) {
		V_BREAK = 0;
		
		V_TURNLEFT = 8000;
		TURNLEFT_TIMECOUNT = 40;
		TURNLEFT_R_MOTOR_WEAKEN = 1100;
		TURNLEFT_L_MOTOR_WEAKEN = 0;
		
		V_TURNRIGHT = 8000;
		TURNRIGHT_TIMECOUNT = 40;
		TURNRIGHT_R_MOTOR_WEAKEN = 0;
		TURNRIGHT_L_MOTOR_WEAKEN = 0;
		
		V_TURNAROUND = 7000;
		TURNAROUND_TIMECOUNT = 90;
		TURNAROUND_R_MOTOR_WEAKEN = 0;
		TURNAROUND_L_MOTOR_WEAKEN = 600;
		
		SCAN_INFRONT_THRESHOLE_SMALL = 15000;
		SCAN_INFRONT_THRESHOLE_BIG = 13000;
	}
}

// 第四五位
static void config_init_startpnt(unsigned char code) {
	code = (code & 0x18) >> 3;
	switch (code) {
		case 0: BEGIN_POINT = 0; break;
		case 1: BEGIN_POINT = 8; break;
		case 2: BEGIN_POINT = 24; break;
		case 3: BEGIN_POINT = 32; break;
		default: BEGIN_POINT = 0; break;
	}
}

void config_init(void) {
	unsigned char code = scan_switch();
	config_init_car(code);
	config_init_startpnt(code);
}