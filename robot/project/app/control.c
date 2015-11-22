#include "control.h"
#include "common.h"
#include "HAL_MCG.h"
#include "HAL_GPIO.h"
#include "HAL_PIT.h"
#include "HAL_FTM.h"
#include "HAL_LPTMR.h"
#include "HAL_UART.h"
#include "HAL_ADC.h"
#include "function.h"
//#include "variable.h"
#include "UP_UART2Parser.h"
#include "config.h"
#include "graph.h"

#define HAS_REACHED_CROSS_LINE() ((r1[9]==1&&r1[10]==1)||(r1[0]==1&&r1[1]==1))
#define IS_AT_CORNER() (r3[0]||r4[0]||r3[1]||r4[1]||r3[2]||r4[2])

static _Bool r1[INFRARED_LINE1_NUM], r2[INFRARED_LINE2_NUM], r3[INFRARED_LINE3_NUM], r4[INFRARED_LINE4_NUM]; //r1前排红外 r2后排红外 r3左排红外 r4右排红外
static int pulsecount, pulseaccu = 0; //5ms脉冲数
static enum COMMAND routechoice = C_STOP;
static _Bool is_enabled = 0; // 默认不启动
static _Bool can_interrupt = 1;
static int r1_error = 0;//, rederror1=0, rederror2=0;    //边沿跳变获得误差
static int r2_error = 0;//, red2error1=0, red2error2=0; //边沿跳变获得误差
static int goahead_distance_set = 0, goahead_distance_count = 0;
static _Bool has_began_getcorner = 0, is_turning_finished = 0;
static _Bool atcorner = 0;
static int motor_time_wait = 0;
static int turn_timecounter = 0;
static int head_passed_cross = 0;
static _Bool is_car_infront = 0;
int __adc;
long TIME_PASSED = 0;
static int letswin_distance_count = 0;
static int __start_beep = 2;

static void (*control_callbacks[CONTROL_COMMAND_COUNT])(enum COMMAND, enum EVENT);

double get_v_offset(void) {
	if (r1_error < 5 && r1_error > -5)
        return (r1_error - 0.4 * r2_error) * PID_KP;//err1_use*PID_KP 第一排误差小时候 用第二排增加反向预测 提高稳定度
	else
        return r1_error * PID_KP;//err1_use*PID_KP  第一排误差大时候不用第二排 增加转向能力
}

#define V_MAXONE(v_max_val) (int) (v_max_val - (v_max_val - 4000) / 16 * (abs(r1_error) + abs(r2_error) * 1.5))

void control_init(void)
{
  init_gpio();
  init_pwm();
  LPLD_UART_Init(UART2, 115200);  //裁判机
  LPLD_UART_RIE_Enable(UART2, uart2_recv_isr);
  while (!GetCmdAction());
  
  while(1) {
      right_set_v(V_SLOW);
      left_set_v(V_SLOW);
	  scan_infrared(r1, r2, r3, r4);
	  if(IS_AT_CORNER()) break;
  }
  
  motor_time_wait = 0;
  while (1) {
	if(motor_time_wait < 100000)//等待电机反应时间 不然直接下一步有影响 没有彻底停下来
	{
        motor_time_wait ++;
        right_set_v(0);
        left_set_v(0);
	}
	else
	{
        motor_time_wait = 0;
		break;
	}
  }
  
  can_interrupt = 1;
  //计时器寄存器每减少50过1us
  LPLD_UART_Init(UART1, 19200); //读卡器
  
  LPLD_UART_Init(UART3, 9600);  //蓝牙
  LPLD_UART_Init(UART4, 9600); 
  LPLD_UART_Init(UART5, 19200); //读卡器
  LPLD_UART_RIE_Enable(UART1, uart1_recv_isr);
  
  LPLD_UART_RIE_Enable(UART3, uart3_recv_isr);
  //LPLD_UART_RIE_Enable(UART4, uart4_recv_isr);
  LPLD_UART_RIE_Enable(UART5, uart5_recv_isr);
  LPLD_LPTMR_Init(MODE_PLACC, 0, LPTMR_ALT1, IRQ_DISABLE, NULL);
  //UP_LCD_Init();		//初始化LCD
  LPLD_ADC_Init(ADC0, MODE_16, CONV_SING);
  
  memset(control_callbacks, NULL, sizeof(control_callbacks));
  memset(r1, 0, sizeof(r1));
  memset(r2, 0, sizeof(r2));
  memset(r3, 0, sizeof(r3));
  memset(r4, 0, sizeof(r4));
  
  LPLD_PIT_Init(PIT0, 5000, pit_isr0); //电机控制
  LPLD_PIT_Init(PIT1, 100000, pit_isr1);  //计时
  TIME_PASSED = 0;
}

void control_set_callback(enum COMMAND command, CONTROL_CALLBACK_FUNC(func, cmd, event)) {
	control_callbacks[command] = func;
}

void control_call_callback(enum COMMAND command, enum EVENT event) {
	if (control_callbacks[command]) control_callbacks[command](command, event);
}

void control_enable(void) {
  is_enabled = 1;
}

void control_disable(void) {
  is_enabled = 0;
}

int control_get_distance(void) {
	return pulseaccu;
}
void control_clear_distance(void) {
	pulseaccu = 0;
}

_Bool control_can_interrupt(void) {
	return can_interrupt;
}

int control_get_r1error(void) {
	return r1_error;
}

int control_get_r2error(void) {
	return r2_error;
}

int control_goahead(int maxlength) {
	if (!can_interrupt) return -1;
	routechoice = C_AHEAD;
	goahead_distance_set = maxlength;
	goahead_distance_count = 0;
	return 0;
}

int control_turnaround(void) {
	if (!can_interrupt) return -1;
	can_interrupt = 0;
	routechoice = C_AROUND;
	return 0;
}

int control_turnleft(void) {
	if (!can_interrupt) return -1;
	can_interrupt = 0;
	routechoice = C_LEFT;
	return 0;
}

int control_turnright(void) {
	if (!can_interrupt) return -1;
	can_interrupt = 0;
	routechoice = C_RIGHT;
	return 0;
}

int control_stop(void) {
	if (!can_interrupt) return -1;
	routechoice = C_STOP;
	return 0;
}

int control_getcorner(void) {
	if (!can_interrupt) return -1;
	routechoice = C_GETCORNER;
	return 0;
}

int control_break(void) {
	if (!can_interrupt) return -1;
	can_interrupt = 0;
	routechoice = C_BREAK;
	return 0;
}

int control_start(void) {
	if (!can_interrupt) return -1;
	can_interrupt = 0;
	routechoice = C_START;
	return 0;
}

int control_letswin(void) {
	if (!can_interrupt) return -1;
	can_interrupt = 0;
	letswin_distance_count = 0;
	routechoice = C_LETSWIN;
	return 0;
}

_Bool control_get_carinfront(void) {
	return is_car_infront;
}

void pit_isr0() //电机控制5ms
{  
  //读脉冲
	pulsecount = LPLD_LPTMR_GetPulseAcc();
	pulseaccu += pulsecount;
  //pulsetotal+=pulsecount;
	LPLD_LPTMR_Reset();       
	LPLD_LPTMR_Init(MODE_PLACC, 0, LPTMR_ALT1, IRQ_DISABLE, NULL);
  
  
  //分析
  //  analyse();
  //控制
	scan_infrared(r1, r2, r3, r4);
  //fisrthongwaierror();
  //secondhongwaierror();//边沿跳变获得误差
	calculate_infrared_error(r1, INFRARED_LINE1_NUM, &r1_error);
	calculate_infrared_error(r2, INFRARED_LINE2_NUM, &r2_error);
  
	if (is_enabled) do_control();
	else do_stop();
  
	static int __scan_infront_counter = 0;
	
	if (__adc > SCAN_INFRONT_THRESHOLE_SMALL 
		&& abs(r1_error - r2_error) < 2) __scan_infront_counter ++;
	else {
		__scan_infront_counter = 0;
	}
	is_car_infront = __scan_infront_counter > 5;
}

void pit_isr1() //100ms中断，系统板闪灯
{
	TIME_PASSED ++;
	if (__start_beep >= 0) {
		yesbeep();
		__start_beep --;
	}
	else nobeep();
	//if (!GetCmdAction()) is_enabled = 0;
	//unsigned char keyCode=scan_switch();
	LPLD_GPIO_Toggle_b(PTA, 15);
	
	// Send cur_point and direction to other car
	static char __bluetooth_buf[3] = {0};
	extern enum DIRECTION __actor_head_direction;
	extern struct Point __actor_cur_point;
	__bluetooth_buf[0] = 0xff; // Package header
	__bluetooth_buf[1] = (char) graph_get_point_number(point_map_to_standard(__actor_cur_point));
	__bluetooth_buf[2] = (char) direction_map_to_standard(__actor_head_direction);
	LPLD_UART_PutCharArr(UART4, __bluetooth_buf, sizeof(__bluetooth_buf));
}


void uart1_recv_isr(void) //读卡器中断
{
	static char RFID_count = 0;
	char data;
	data = LPLD_UART_GetChar(UART1);
	BufRFID(data);
	RFID_count ++;
	if (RFID_count > 4) {
		static uint8 cardid[4] = {0};
		ParseRFIDData();
		GetCardUID(cardid);
		LPLD_UART_RIE_Disable(UART1);
		UART2_SendCardUID(0, cardid);
		LPLD_UART_RIE_Enable(UART1, uart1_recv_isr);
		RFID_count = 0;
	}
}


void uart2_recv_isr(void) //裁判机中断
{
  char data;
  data=LPLD_UART_GetChar(UART2);
  UART2_ParseData(data);
}

void uart3_recv_isr(void) //蓝牙接收中断 这个口有问题呢
{
  //char data;
  //data=LPLD_UART_GetChar(UART2);
  // bluetooth();
}

//void uart4_recv_isr(void) //蓝牙接收中断
//{
//  //char data;
//  //data=LPLD_UART_GetChar(UART4);
//  bluetooth();
//}
void uart5_recv_isr(void) //读卡器中断
{
  char data;
  data=LPLD_UART_GetChar(UART5);
  BufRFID(data);
}

/********************************************************************/
//控制函数实现

void left_set_v(int v)
{
  if(v>=0)
  {
    LPLD_FTM0_PWM_ChangeDuty(4,v);
    LPLD_FTM0_PWM_ChangeDuty(5,0);
  }
  else
  {
    LPLD_FTM0_PWM_ChangeDuty(4,0);
    LPLD_FTM0_PWM_ChangeDuty(5,-v);
  }
}

void right_set_v(int v)
{
  if(v>=0)
  {
    LPLD_FTM0_PWM_ChangeDuty(7,v);
    LPLD_FTM0_PWM_ChangeDuty(6,0);
  }
  else
  {
    LPLD_FTM0_PWM_ChangeDuty(7,0);
    LPLD_FTM0_PWM_ChangeDuty(6,-v);
  }
}
/*
void control()
{
  v_offset=err1_use*PID_KP;
  if(v_offset>0)
  {
    v_output=v_max-(int)v_offset;
    if(v_output<0)v_output=0;
    //right_set_v((int)v_output);
    //left_set_v((int)v_max);
  }
  else
  {
    v_output=v_max+(int)v_offset;
    if(v_output<0)v_output=0;
    //right_set_v((int)v_max);
    //left_set_v((int)v_output);
  }
}
*/
/*
void analyse()
{
  int i;
  black_total1=0;black_total2=0;
  for(i=5;i<=10;i++)
  {
    if(r1[i]==1)
    {
      err1=weight[i];
      black_total1++;
    }
  }
  for(i=3;i<=6;i++)
  {
    if(r2[i]==1)
    {
      err2=i-3;
      black_total2++;
    }
  }
  for(i=4;i>=0;i--)
  {
    if(r1[i]==1)
    {
      err1=weight[i];
      black_total1++;
    }
  }
  for(i=2;i>=0;i--)
  {
    if(r2[i]==1)
    {
      err2=i-3;
      black_total2++;
    }
  }
  if(black_total1<=3)
  {
    err1_use=err1;
  }
  if(black_total2<=3)
  {
    err2_use=err2;
  }
}
*/
///////////////////////////////hao///////////////////////
/*
void fisrthongwaierror(void){//边沿跳变获得误差
  int i=0,j=0,k=0;
  int ej[12],ek[12];
  //rederror2=rederror1;
  //rederror1=r1_error;
  for(i=0;i<10;i++) 
  {
    if( r1[i]==0 && r1[i+1]==1) //从0跳变到1      白变黑
    {
      ej[j]=i; 
      j++;
    }
    if( r1[i]==1 && r1[i+1]==0) //从1跳变到0        黑变白
    {					
      ek[k]=i;
      k++;
    }
  }
  if(j==1&&k==1)
  {
    if(ek[0]-ej[0]<4)//黑线应该小于等于3个红外
      r1_error=ej[0]+ek[0]-9;
    else
      r1_error=r1_error;//超过4个说明是错误或者是十字等情况 暂且保持误差
  }
  else if(j==1&&k==0)
  {
    if(r1[9]==0)
      r1_error=10;
    else
      r1_error=9;
  }	
  else if(j==0&&k==1)
  {
    if(r1[1]==0)
      r1_error=-10;
    else
      r1_error=-9;
  }	
  //else if(j==0&&k==0)	
  //{	
  //if(r1_error>0)
  //r1_error=8;
  //else if (r1_error<0)
  //r1_error=-8;
  //else 
  //r1_error=0;
  //r1_error=r1_error;
}	
  else	
  {
    r1_error=r1_error;
  }		
  
  //if(r1_error-rederror1>2||r1_error-rederror1<-2)//不可能会有大的跳变 如果有 因为特殊情况 用之前的误差保持先 可是开始阶段怎么办？？？
  //{
  //r1_error=rederror1;
  //}
  
}
void secondhongwaierror(void){//边沿跳变获得误差
  int i=0,j=0,k=0;
  int ej[12],ek[12];
  red2error2=red2error1;
  red2error1=r2_error;
  for(i=0;i<6;i++) 
  {
    if( r2[i]==0&& r2[i+1]==1) //从0跳变到1      白变黑
    {
      ej[j]=i; 
      j++;
    }
    if( r2[i]==1&& r2[i+1]==0) //从1跳变到0        黑变白
    {					
      ek[k]=i;
      k++;
    }
  }
  if(j==1&&k==1)
  {
    if(ek[0]-ej[0]<4)//黑线应该小于等于3个红外
      r2_error=ej[0]+ek[0]-5;
    else
      r2_error=r2_error;//超过4个说明是错误或者是十字等情况 暂且保持误差
  }
  else if(j==1&&k==0)
  {
    if(r2[5]==0)
      r2_error=6;
    else
      r2_error=5;
  }	
  else if(j==0&&k==1)
  {
    if(r2[1]==0)
      r2_error=-6;
    else
      r2_error=-5;
  }	
  else if(j==0&&k==0)	
  {	
    
    r2_error=0;
    //r2_error=r2_error;
  }	
  else	
  {
    r2_error=r2_error;
  }		
  
}
*/
/*
void bluetooth(void) {
  unsigned int redata,Ddata,choice;
  if(identityset==1)
  {
    redatah=LPLD_UART_GetChar(UART4);
    if(redatah==255)
    {
      identityset=0;
    }
  }
  
  if(identityset==2)
  {
    identityset=0;
    redata=LPLD_UART_GetChar(UART4)+redatah*256;
    choice=redata/4096;
    redata=redata%4096;
    Ddata=redata/256*100+redata/16%16*10+redata%16;
    
    switch(choice)
    {        
    case 0:  turnleft_time_set=Ddata*10;break;
    case 1:  testvalue1=Ddata;break;//将想要实时修改的全局变量替换掉null 在串口调试助手中  
    case 2:  PID_KP=Ddata;break;//输入四位的十六进制字符串 当做十进制的输入就可以了
    case 3:  testvalue3=Ddata;break;//第一个数位你想要改变的变量对应编号
    case 4:  testvalue4=Ddata;break;
    case 5:  testvalue5=Ddata;break;
    case 6:  haoswitch=Ddata;break;
    //case 7:  kd1=Ddata;break;
    //case 8:  kd2=Ddata;break;
    //case 9:  kd3=Ddata;break;
    //case 10:  kd4=Ddata;break;
    //case 11:  kd5=Ddata;break;
    //case 12:  kd6=Ddata;break;
    //case 13:  jiuzheng=Ddata;break;
    //case 14:  null=Ddata;break;
    //case 15:  null=Ddata;break;
    default : break;
    }
    
  }
  identityset++;
}

void sendblue(int a,int b)
{
  char sendbluedata[2];
  
  sendbluedata[0]=a*16+b/256;
  
  sendbluedata[1]=b%256;  
  LPLD_UART_PutCharArr(UART4,(char*)sendbluedata,2);
}

*/
void do_control(void)
{
	switch (routechoice) {
	case C_AHEAD:
		do_goahead();		break;
	case C_GETCORNER:
		do_getcorner();		break;
	case C_LEFT:
		do_turnleft();		break;
	case C_RIGHT:
		do_turnright();		break;
	case C_STOP:
		do_stop();			break;
	case C_AROUND:
		do_turnaround();	break;
	case C_BREAK:
		do_break();			break;
	case C_START:
		do_start(); 		break;
	case C_LETSWIN:
		do_letswin(); 		break;
	default:
		do_stop();
  }
}

void do_goahead(void)
{
	double v_offset; //电压值偏离标准量v_offset，电压值输出量v_output
	int v_maxone, v_output;
	static int r1_confirm_count = 0;
	if (HAS_REACHED_CROSS_LINE() || head_passed_cross) {
		r1_confirm_count ++;
		if (r1_confirm_count > 2) {
			can_interrupt = 0; // 一到十字就锁住
			head_passed_cross = 1;
			control_call_callback(C_AHEAD, E_CROSS);
		}
	}
	else {
		r1_confirm_count = 0;
	}
	static int r3r4_confirm_count = 0;
	if(IS_AT_CORNER() && head_passed_cross) {
		r3r4_confirm_count ++;
		if (r3r4_confirm_count > 2) {
			can_interrupt = 1;
			control_call_callback(C_AHEAD, E_ONCROSS);
			head_passed_cross = 0;
		}
	}
	else {
		r3r4_confirm_count = 0;
	}
    if(goahead_distance_set > goahead_distance_count)
    {    
      goahead_distance_count += pulsecount;
      v_offset = get_v_offset();
      
      v_maxone = V_MAXONE(V_MAX);
      
      if(v_offset > 0)
      {
        v_output = v_maxone - (int) v_offset;
        if(v_output < 0) v_output = 0;
        right_set_v((int) v_output);
        left_set_v((int) v_maxone);
      }
      else
      {
        v_output = v_maxone + (int) v_offset;
        if(v_output < 0) v_output = 0;
        right_set_v((int) v_maxone);
        left_set_v((int) v_output);
      }
    }
    else
    {
	  // 完成，重置
      goahead_distance_count = 0;
      goahead_distance_set = 0;
	  routechoice = C_STOP;
	  can_interrupt = 1;
	  control_call_callback(C_AHEAD, E_FINISHED);
    }
}
void do_stop(void)
{
  LPLD_FTM0_PWM_ChangeDuty(7,0);
  LPLD_FTM0_PWM_ChangeDuty(6,0);
  LPLD_FTM0_PWM_ChangeDuty(5,0);
  LPLD_FTM0_PWM_ChangeDuty(4,0);
  control_call_callback(C_STOP, E_FINISHED);
  can_interrupt = 1;
}

void do_getcorner(void)
{
	double v_offset = 0.0;
	int v_maxone, v_output = 0;
	static int r1_confirm_count = 0;
  if(HAS_REACHED_CROSS_LINE() || head_passed_cross)
  {
	r1_confirm_count ++;
	if (r1_confirm_count > 2) {
		//getcorner_finish=1;
		//robot_controlable_downgrade=0;
		has_began_getcorner = 1;
		head_passed_cross = 1;
		can_interrupt = 0;
		control_call_callback(C_GETCORNER, E_CROSS);
	}
  }
  else {
	r1_confirm_count = 0;
  }
  
  if(!has_began_getcorner)//前排检测到十字没有
  {
    //robot_controlable_downgrade=1;
	//can_interrupt = 1; // 未到十字，可被打断
	
	v_offset = get_v_offset();
    
    v_maxone = V_MAXONE(V_GETCORNER_MAX);
    
    if(v_offset > 0)
    {
      v_output = v_maxone - (int) v_offset;
      if(v_output < 0) v_output = 0;
      right_set_v((int) v_output);
      left_set_v((int) v_maxone);
    }
    else
    {
      v_output = v_maxone + (int) v_offset;
      if(v_output < 0) v_output = 0;
      right_set_v((int) v_maxone);
      left_set_v((int) v_output);
      
    }
  }
  else//检测到十字
  {
	static int r3r4_confirm_count = 0;
	if(IS_AT_CORNER()) {
		r3r4_confirm_count ++;
		if (r3r4_confirm_count > 2) {
			atcorner = 1;
			head_passed_cross = 0;
		}
	}
	else {
		r3r4_confirm_count = 0;
	}
    if(atcorner == 0)//是否停在正下方
    {
      //do_stop();//暂时用停止代替 等会换成反刹
      if(pulsecount <= 4)//减速到编码器值为4 刹车结束//有反退的危险啊2的话
      {
		//v_offset = get_v_offset();
        
        //v_maxone=2000;//以低速到达十字正下方
        right_set_v(V_SLOW);
        left_set_v(V_SLOW);
      }
      else
      {
	    // 刹车
        right_set_v(-V_BREAK);
        left_set_v(-V_BREAK);
      }
    }
    else
    {
      if(motor_time_wait < MOTOR_RESPONSE_WAIT)//等待电机反应时间 不然直接下一步有影响 没有彻底停下来
      {
        motor_time_wait ++;
        right_set_v(0);
        left_set_v(0);
      }
      else
      {
        atcorner = 0;
        motor_time_wait = 0;
        has_began_getcorner = 0;//重置状态
        can_interrupt = 1;
		routechoice = C_STOP;
		control_call_callback(C_GETCORNER, E_FINISHED);
      }
    }
  }
}

void do_turnleft(void)
{
  if(!is_turning_finished)
  {
    if(turn_timecounter < TURNLEFT_TIMECOUNT) //先转固定的一个时间
    {
      turn_timecounter ++;
      right_set_v(V_TURNLEFT - TURNLEFT_R_MOTOR_WEAKEN);
      left_set_v(-V_TURNLEFT + TURNLEFT_L_MOTOR_WEAKEN);
      r1_error = -10;//初始化红外保持的数据
      //rederror1=-10;
      //rederror2=-10;
    }
    else
    {
      if(r1_error > 8) r1_error = -10;//排除没有转出原来那条线的悲剧
      if(r1_error < -3)//转完固定时间后 用第一排红外转 
      {
        right_set_v(3000 - TURNLEFT_R_MOTOR_WEAKEN);
        left_set_v(-3000 + TURNLEFT_L_MOTOR_WEAKEN);
      }
      else
      {
        is_turning_finished = 1;
      }
    }
  }
  if (is_turning_finished)
  {
    turn_timecounter = 0;
    routechoice = C_STOP;
    is_turning_finished = 0;
    can_interrupt = 1;
	head_passed_cross = 0;
	control_call_callback(C_LEFT, E_FINISHED);
  }
}

void do_turnright(void)
{
  if(!is_turning_finished)
  {
    if(turn_timecounter < TURNRIGHT_TIMECOUNT)//先转固定的一个时间
    {
      turn_timecounter ++;
      right_set_v(-V_TURNRIGHT + TURNRIGHT_R_MOTOR_WEAKEN);
      left_set_v(V_TURNRIGHT - TURNRIGHT_L_MOTOR_WEAKEN);
      r1_error = 10;//初始化红外保持的数据
      //rederror1=10;
      //rederror2=10;
    }
    else
    {
      if(r1_error < -8) r1_error=10;//排除没有转出原来那条线的悲剧
      if(r1_error > 3)//转完固定时间后 用第一排红外转 
      {
        right_set_v(-3000 + TURNRIGHT_R_MOTOR_WEAKEN);
        left_set_v(3000 - TURNRIGHT_L_MOTOR_WEAKEN);
      }
      else
      {
        is_turning_finished=1;
        
      }
    }
  }
  if (is_turning_finished)
  {
    turn_timecounter = 0;
    routechoice = C_STOP;
    is_turning_finished = 0;
    can_interrupt = 1;
	head_passed_cross = 0;
    control_call_callback(C_RIGHT, E_FINISHED);
  }
}

void do_turnaround(void)
{
  if(!is_turning_finished)
  {
    if(turn_timecounter < TURNAROUND_TIMECOUNT)//先转固定的一个时间
    {
      turn_timecounter ++;
      right_set_v(V_TURNAROUND - TURNAROUND_R_MOTOR_WEAKEN);
      left_set_v(-V_TURNAROUND + TURNAROUND_L_MOTOR_WEAKEN);
      r1_error = -10;//初始化红外保持的数据
      //rederror1=-10;
      //rederror2=-10;
    }
    else
    {
      if(r1_error > 0) r1_error=-10;//排除没有转出原来那条线的悲剧
      if(r1_error<-3)//转完固定时间后 用第一排红外转 
      {
        right_set_v(3000 - TURNAROUND_R_MOTOR_WEAKEN);
        left_set_v(-3000 + TURNAROUND_L_MOTOR_WEAKEN);
      }
      else
      {
        is_turning_finished = 1;
        
      }
    }
  }
  else
  {
    turn_timecounter = 0;
    routechoice = C_STOP;
    is_turning_finished = 0;
    can_interrupt = 1;
	head_passed_cross = 0;
    control_call_callback(C_AROUND, E_FINISHED);
  }
}

static _Bool break_finished = 0;
void do_break(void)
{
	static int r1_confirm_count = 0;
	if (HAS_REACHED_CROSS_LINE() || head_passed_cross) {
		r1_confirm_count ++;
		if (r1_confirm_count > 2) {
			head_passed_cross = 1;
			control_call_callback(C_BREAK, E_CROSS);
		}
	}
	else {
		r1_confirm_count = 0;
	}
	static int r3r4_confirm_count = 0;
	if(IS_AT_CORNER() && head_passed_cross) {
		r3r4_confirm_count ++;
		if (r3r4_confirm_count > 2) {
			head_passed_cross = 0;
			control_call_callback(C_BREAK, E_ONCROSS);
		}
	}
	else {
		r3r4_confirm_count = 0;
	}
  if(!break_finished)
  {
    if(pulsecount > 4)
    {
		right_set_v(-V_BREAK);
        left_set_v(-V_BREAK);
    }
    else
    {
      break_finished = 1;
    }
  }
  if(break_finished)
  {
    if(motor_time_wait < MOTOR_RESPONSE_WAIT)//等待电机反应时间 不然直接下一步有影响 没有彻底停下来
      {
        motor_time_wait ++;
        right_set_v(0);
        left_set_v(0);
      }
      else
      {
        atcorner = 0;
        motor_time_wait = 0;
		break_finished = 0;
        can_interrupt = 1;
		routechoice = C_STOP;
		control_call_callback(C_BREAK, E_FINISHED);
      }
  }
}

void do_start(void) {
	static int r3r4_confirm_count = 0;
	if(IS_AT_CORNER()) {
		r3r4_confirm_count ++;
		if (r3r4_confirm_count > 2) {
			atcorner = 1;
		}
	}
	else {
		r3r4_confirm_count = 0;
	}
    if(atcorner == 0)//是否停在正下方
    {
      //do_stop();//暂时用停止代替 等会换成反刹
      if(pulsecount <= 2)//减速到编码器值为4 刹车结束//有反退的危险啊2的话
      {
		//v_offset = get_v_offset();
        
        //v_maxone=2000;//以低速到达十字正下方
        right_set_v(V_SLOW);
        left_set_v(V_SLOW);
      }
      else
      {
	    // 刹车
        right_set_v(-V_BREAK);
        left_set_v(-V_BREAK);
      }
    }
    else
    {
      if(motor_time_wait < MOTOR_RESPONSE_WAIT)//等待电机反应时间 不然直接下一步有影响 没有彻底停下来
      {
        motor_time_wait ++;
        right_set_v(0);
        left_set_v(0);
      }
      else
      {
        atcorner = 0;
        motor_time_wait = 0;
        can_interrupt = 1;
		routechoice = C_STOP;
		control_call_callback(C_START, E_FINISHED);
      }
    }
}

void do_letswin(void) {
	double v_offset; //电压值偏离标准量v_offset，电压值输出量v_output
	int v_maxone, v_output;
	static int letwin_back_time=0;
	
	if(LETSWIN_BACK_TIME > letwin_back_time)
	{
		letwin_back_time++;
		right_set_v(-3000);
		left_set_v(-3000);
	}
	else
	{
	
	
		if(LETSWIN_GOHEAD_DISTANCE > letswin_distance_count)
		{   
			__start_beep=2;
			letswin_distance_count += 1;//pulsecount;
			v_offset = get_v_offset();

			v_maxone = 3000;

			if(v_offset > 0)
			{
				v_output = v_maxone - (int) v_offset;
				if(v_output < 0) v_output = 0;
						right_set_v((int) v_output);
						left_set_v((int) v_maxone);
			}
			else
			{
				v_output = v_maxone + (int) v_offset;
				if(v_output < 0) v_output = 0;
				right_set_v((int) v_maxone);
				left_set_v((int) v_output);
			}
		}
		 else
		{
			static int __r3_confirm = 0;
			static char have_past_black=0;
			static unsigned int __letswin_shake_count=0;
			if ( !r3[2]||(r4[1]||r4[2]||r4[0]))
			{
				__r3_confirm = 0;
			}
			else 
			{
					__r3_confirm ++;
			}
	
			if (__r3_confirm > 2) {
				have_past_black=1;
		
			}
			if(have_past_black)//&&!__r3_confirm
			{
				__letswin_shake_count++;
			   if(__letswin_shake_count/200%2)
				{
				right_set_v(3000);
				left_set_v(-1000);
				}
				else
				{
				right_set_v(LETSWIN_V_R_SECOND_STEP);
				left_set_v(LETSWIN_V_L_SECOND_STEP);
				
				}
				
			}
			else {
				right_set_v(LETSWIN_V_R_FIRST_STEP);
				left_set_v(LETSWIN_V_L_FIRST_STEP);
			}
	
			static int __letswin_time_count = 0;
			if (__letswin_time_count < 600) __letswin_time_count ++;
			else 
			{
				routechoice = C_STOP;
				can_interrupt = 1;
				letswin_distance_count = 0;
				letwin_back_time=0;
			}
		}
	}
}