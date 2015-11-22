#include "car.h"
#include "util.h"

#include "common.h"
#include "HAL_PIT.h"
#include "control.h"
int control_action=1; //��ǰִ�еĶ���


#define FAST_TURN_SPEED 9000	//ת��ʱ����ת�����ٶ�
#define FAST_TURN_TIME 	10	//����ת����ʱ��
#define SLOW_TURN_SPEED 5000	//����ת�����ٶ�
#define GET_CROSS_SPEED 3000 //ץ��ʱ���ٶ�
#define MAX_SPEED 8000 //ֱ�ߵ�����ٶ�

#define CALL_BACK(action,even)  if(control_call_back_function[action][even]!=NULL)control_call_back_function[action][even]();


//��չcar�е�car_*_infrare ָ��
extern unsigned char *car_front_infrare;
extern unsigned char *car_left_infrare;
extern unsigned char *car_right_infrare;
extern unsigned char *car_tail_infrare;



void (* control_call_back_function[CONTROL_ACTION_NUM][EVEN_NUM])(); 


_Bool can_interrupt=1; //��ʾ���ӵĵ�ǰ���еĶ����ɷ񱻴�� 1��ʾ���� 0 ��ʾ����

int go_ahead_time=0; //go_ahead ִ�е�ʱ��

float P=5;		//��
float I=2.5;	//׼   ����3����
float D=0;		//��

int UK=0;
int B;


_Bool bad_infrare[11];


_Bool control_set_action(int action);
void control_init();

void do_go_ahead();
void do_turn_right();
void do_turn_left();
void do_stop();
void do_get_cross();
void do_turn_back();
void do_control(); //���Ƴ���ÿ20ms����һ��




_Bool check_head_cross()// ǰ�ź����⵽�ֲ�·��
{

    //if() //����������������ⶼ��⵽��������Ϊ���ֲ�·��
   

  int count=0;
  for(int i=0;i<11;i++)
  {
    count+=car_front_infrare[i];
  }
  if(count>=7&&(car_front_infrare[0]&&car_front_infrare[1]&&car_front_infrare[2])
     ||(car_front_infrare[8]&&car_front_infrare[9]&&car_front_infrare[10])) 
    return true;
  else return false;

}

_Bool check_on_cross()//��������⵽�ֲ�·��
{
	if(car_left_infrare[1]==1||car_right_infrare[1]==1)
	{
		return true;
	}
	else
	{
		return false;
	}
}

void do_control()
{
         
	switch(control_action)
	{
        case TURN_LEFT:
			do_turn_left();
            break;
		case TURN_RIGHT:
			do_turn_right();
            break;
		case TURN_BACK:
			do_turn_back();
            break;
		case GO_AHEAD:
			do_go_ahead();
            break;
        case STOP:
			do_stop();
            break;
		case GET_CROSS:
			do_get_cross();
                        break;
		default:
			do_stop();
            break;
	}
	
	#ifdef STOP_DEBUG
	car_set_left_speed(0);
	car_set_right_speed(0);
	#endif
}
int error=0;
int last_error=0;
int last_two_error=0;
//const  int weight[11]={12,10,7,1,1,0,-1,-1,-7,-10,-12};
const  int weight[11]={-1000,-300,-150,-60,-50,0,50,60,100,300,1000};

int black_line_pos;
int eb_left=0; //�������Ե
int eb_right=11; //�����ұ�Ե
int calculate_infrare_error()
{
	
	
    int r_size=11;
    int error_temp=0;
    int count=0;
    
	for(int i=0;i<r_size;i++)
	{
            if(car_front_infrare[i]==1)
            {
              count++;
            }            
	}	  
        
        for(int i=1; i<10; i++)
        {
           if(car_front_infrare[i]==1&&car_front_infrare[i-1]==0) eb_left=i;
           if(car_front_infrare[i]==1&&car_front_infrare[i+1]==0) eb_right=i;
        }
	
	if(count>=5) //����
	{
		
	}
	
         black_line_pos = (eb_right-eb_left)/2+eb_left;
        error_temp=weight[black_line_pos];
        error=(int)P*(error_temp-last_error)+I*error_temp+D*(error_temp-2*last_error+last_two_error);    
	last_two_error=last_error;
	last_error=error;
        error=error_temp;
        return error;
}


void do_turn_back()
{
	car_set_left_speed(0);
	car_set_left_speed(0);
	delayMs(100);
	car_change_direction();
	CALL_BACK(TURN_BACK,FINISH);
}
int U=0;
int e=0;


void do_go_ahead()
{      
        go_ahead_time++; //��do_control������
	can_interrupt=true;
	
        if(check_head_cross()&&go_ahead_time>5)
        {
            CALL_BACK(GO_AHEAD,HEAD_CROSS);
            go_ahead_time=0;//��ֹ��ν�ȥcheck_head_cross
         }   

        if(check_on_cross()&&go_ahead_time<10)CALL_BACK(GO_AHEAD,ON_CROSS);
	e=calculate_infrare_error();
	if(e<0)//turn left    Problem!!!!
	{
        U=MAX_SPEED;
        U=U+e*80;
        if(U<100)U=100;
		car_set_left_speed(U);
		car_set_right_speed(MAX_SPEED);
	}
	else //if(e>0)  turn right
	{
        U=MAX_SPEED;
        U=U-e*80;
        if(U<100)U=100;
	    car_set_left_speed(MAX_SPEED);
		car_set_right_speed(U);
	}
}

void do_get_cross()//ֱ�������ֲ�·��ͣ��
{
	e=calculate_infrare_error();
	can_interrupt=false;
	if(check_on_cross())
	{
		car_set_left_speed(0);
		car_set_right_speed(0);
		delayMs(1000);
		can_interrupt= true;
		CALL_BACK(GET_CROSS,FINISH);
		return;
	}
	if(e<0)//turn left   
	{
        U=GET_CROSS_SPEED;
        U=U+e*300;
        car_set_left_speed(U);
		car_set_right_speed(GET_CROSS_SPEED);
	}
	else //if(e>0)  turn right
	{
        U=GET_CROSS_SPEED;
        U=U-e*300;
	    car_set_left_speed(GET_CROSS_SPEED);
		car_set_right_speed(U);
	}
}


void do_turn_left()
{
  //ģ�����ת��һ������
  if(can_interrupt)can_interrupt=false;
  static int turn_left_time=0;
  if(turn_left_time<FAST_TURN_TIME)
  {
	car_set_left_speed(-FAST_TURN_SPEED);
	car_set_right_speed(FAST_TURN_SPEED);
	turn_left_time++;
  }
  else{
   car_set_left_speed(-SLOW_TURN_SPEED);
   car_set_right_speed(SLOW_TURN_SPEED);
   if(check_on_cross())
   {
        car_set_left_speed(0);
		car_set_right_speed(0);
        delayMs(100);
		control_action = STOP;
		can_interrupt=true;
        turn_left_time = 0;
		CALL_BACK(TURN_LEFT,FINISH);
   }
  }
}

void do_turn_right()
{
  if(can_interrupt)can_interrupt=false;
  static int turn_right_time = 0;
  if(turn_right_time<FAST_TURN_TIME)
  {
	car_set_left_speed(FAST_TURN_SPEED);
	car_set_right_speed(-FAST_TURN_SPEED);
	turn_right_time++;
  }
  else
  {
	car_set_left_speed(SLOW_TURN_SPEED);
	car_set_right_speed(-SLOW_TURN_SPEED);
	if(check_on_cross())
    {
        car_set_left_speed(0);
        car_set_right_speed(0);
        control_action = STOP;
        delayMs(100);
        can_interrupt = true;
        turn_right_time=0;
		CALL_BACK(TURN_RIGHT,FINISH);
    }
  }
}

void do_stop()
{
	can_interrupt = true;
	car_set_left_speed(0);
	car_set_right_speed(0);
        CALL_BACK(STOP,FINISH);
	delayMs(100);
}


void control_init()  //��ʼ�������ٶȺʹ�����ӳ��˳��
{
      LPLD_PIT_Init(PIT0,20000,do_control); //����20ms�жϣ�ÿ20ms����һ�ε��
	  for(int i=0; i<EVEN_NUM; i++)
	  {
		for(int j=0; j<CONTROL_ACTION_NUM; j++)
		{
			control_call_back_function[j][i]=NULL;
		}
	  }
        //for(int i=0;i<10;i++) bad_infrare[i]=0;  //����𻵵ĺ��⣬�ݲ���
      //  bad_infrare[5]=1;
}

_Bool control_stop()
{
	return control_set_action(STOP);
}

_Bool control_turn_right()
{
    return control_set_action(TURN_RIGHT);
}

_Bool control_turn_left()
{
	return control_set_action(TURN_LEFT);
}

_Bool control_turn_back()
{
    return control_set_action(TURN_BACK);
}

_Bool control_go_ahead()
{
  return control_set_action(GO_AHEAD);
}

_Bool control_set_action(int action)
{
    if(!can_interrupt)return false;
    control_action = action;
    return true;
}

void control_set_call_back_function(int action, int even, void(* fun)())
{
	if(fun)control_call_back_function[action][even]=fun;
}
