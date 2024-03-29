#include "move.h"
#include "control.h"
#include "util.h"
#define PATH_MAX_LENGTH 40
int move_direction =0;
int move_last_point=23;
int move_now_point=23;
int move_next_point=23;
int move_path[PATH_MAX_LENGTH];
int move_path_length=0;
int move_now_point_path_index=0;

int move_next_action;

					// 	 0,  1,   2,   3
int next_point[10][4]={ 27, -1,  -1,  -1,  	//23
						-1, -1,  28,  -1,  	//24
						-1, -1,  29,  -1,  	//25
						30, -1,  -1,  -1,  	//26
						32, 30,  23,  28,  	//27
						24, 27,  32,  29,  	//28
						25, 28,  31,  30,  	//29
						31, 29,  26,  27,  	//30
						29, -1,  30,  32,  	//31
						28, 31,  27,  -1  	//32
						};

int point2index(int x)
{
	if(x-23>=0&&x-23<=10)
	return x-23;
        return -1;
}

						
void update_point()
{
        beep();
	int last_point_index = point2index(move_last_point);
	if(next_point[last_point_index][move_direction]>0)
	{
		
		move_now_point=next_point[last_point_index][move_direction];
		move_last_point=move_now_point;
		move_now_point_path_index++;
		if(move_now_point_path_index+1<move_path_length)
			move_next_point=move_path[move_now_point_path_index+1];
		else
			move_next_point=move_now_point;
	}
	else
	{
		//TODO:错误处理
	}
}
						
void update_direction(int action)
{
	if(action==TURN_LEFT)
	{
		if(move_now_point==27||move_now_point==30||move_now_point==31||move_now_point==32)
		{
			move_direction=(move_direction+4-1)%4;
		}
		if(move_now_point==28||move_now_point==29)
		{
			move_direction=(move_direction+1)%4;
		}
	}
	
	if(action==TURN_RIGHT)
	{
		if(move_now_point==27||move_now_point==30||move_now_point==31||move_now_point==32)
		{
			move_direction=(move_direction+1)%4;
		}
		if(move_now_point==28||move_now_point==29)
		{
			move_direction=(move_direction+4-1)%4;
		}
	}
	
	if(action==TURN_BACK)
	{
		move_direction=(move_direction+2)%4;
	}
}

int now_point_index;
int move_get_next_action()
{
	if(move_next_point==move_now_point)return STOP;
<<<<<<< .mine
	int now_point_index=point2index(move_now_point);
=======
	 now_point_index=point2index(move_now_point);
>>>>>>> .r18
	if(move_next_point==next_point[now_point_index][move_direction])
	{
		//if(move_next_point>=23&&move_next_point<=26) return GET_END;
		return GO_AHEAD;
	}
	else
	{
		for(int i=0;i<4;i++)
		{
			if(next_point[now_point_index][i]==move_next_point)
			{
				int mode = i-move_direction;
				switch(mode)
				{
					case 2:
					case -2:
						return TURN_BACK;
						break;
					case 1:
					case -3:
						if(move_now_point==28||move_now_point==29)return TURN_LEFT;
						if(move_now_point==31||move_now_point==32||
						   move_now_point==27||move_now_point==30)return TURN_RIGHT;
						break;
					case -1:
					case 3:
						if(move_now_point==28||move_now_point==29)return TURN_RIGHT;
						if(move_now_point==31||move_now_point==32||
						   move_now_point==27||move_now_point==30)return TURN_LEFT;
						break;
				}
			}
		}
	}
        return STOP;
}

void turn_right_call_back()
{

	update_direction(TURN_RIGHT);
	move_next_action=move_get_next_action();
	control_set_action(move_next_action);
}

void turn_left_call_back()
{
	update_direction(TURN_LEFT);
	move_next_action = move_get_next_action();
	control_set_action(move_next_action);
}

void turn_back_call_back()
{
	update_direction(TURN_BACK);
	move_next_action = move_get_next_action();
	control_set_action(move_next_action);
}

void get_cross_call_back()
{
	move_next_action = move_get_next_action();
	control_set_action(move_next_action);
}

void go_ahead_on_cross_call_back()
{
	//update_point();
	//move_next_action = move_get_next_action();
	//control_set_action(move_next_action);
}

void go_ahead_head_cross_call_back()
{
	update_point();
	move_next_action = move_get_next_action();
	if(move_next_action!=GO_AHEAD)
		control_set_action(GET_CROSS);
}


void stop_call_back()
{
	move_next_action = move_get_next_action();
	control_set_action(move_next_action);
}


void move_init()
{
   control_set_call_back_function(GO_AHEAD,ON_CROSS,go_ahead_on_cross_call_back);
   control_set_call_back_function(GO_AHEAD,HEAD_CROSS,go_ahead_head_cross_call_back);
   control_set_call_back_function(GET_CROSS,FINISH,get_cross_call_back);
   control_set_call_back_function(TURN_RIGHT,FINISH,turn_right_call_back);
   control_set_call_back_function(TURN_LEFT,FINISH,turn_left_call_back);
   control_set_call_back_function(TURN_BACK,FINISH,turn_back_call_back); 
   control_set_call_back_function(STOP,FINISH,stop_call_back);
}



<<<<<<< .mine
_Bool move_by_path(int length,int* path)
=======

_Bool move_by_path(int length,int* path)
>>>>>>> .r18
{

	// TODO : 加锁防止被打断
	for(int i=0;i<length;i++)
	{
		move_path[i]=path[i];
		if(move_now_point==path[i])
		{
			move_now_point_path_index=i;
			if(i<length-1)move_next_point=path[i+1];
			else move_next_point=move_now_point;
			
		}
	}
	move_path_length=length;
	
}





<<<<<<< .mine

=======
>>>>>>> .r18
