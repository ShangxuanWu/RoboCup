#ifndef __CONTROL_H
#define __CONTROL_H 

// control_action 的取值
#define GO_AHEAD 0
#define STOP 1
#define TURN_RIGHT 2  	        
#define TURN_LEFT 3		
#define TURN_BACK 4
#define GET_CROSS 5
#define GET_END 6
#define CONTROL_ACTION_NUM 7

#define EVEN_NUM 3 
#define FINISH 0
#define ON_CROSS 1
#define HEAD_CROSS 2 

_Bool control_set_action(int action); //设置控制指令
_Bool control_go_ahead();//到分岔口直走
_Bool control_turn_left();  //在分岔口左转
_Bool control_turn_right(); //在分岔口右转
_Bool control_turn_break(); //改变前进方向
_Bool control_stop(); //直接停车

void  control_set_call_back_function(int action_command,int even,void(* fun)());

void control_init();

void do_control();//控制函数

#endif