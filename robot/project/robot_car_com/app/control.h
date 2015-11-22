#ifndef __CONTROL_H
#define __CONTROL_H 

// control_action ��ȡֵ
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

_Bool control_set_action(int action); //���ÿ���ָ��
_Bool control_go_ahead();//���ֲ��ֱ��
_Bool control_turn_left();  //�ڷֲ����ת
_Bool control_turn_right(); //�ڷֲ����ת
_Bool control_turn_break(); //�ı�ǰ������
_Bool control_stop(); //ֱ��ͣ��

void  control_set_call_back_function(int action_command,int even,void(* fun)());

void control_init();

void do_control();//���ƺ���

#endif