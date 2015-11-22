#include "variable.h"
//硬件信息
//正跑 左pwm4=+ pwm5=0
//     右pwm6=0 pwm7=+

//例程原有变量
 unsigned char tmpUID[4] ={0,0,0,0};
 unsigned char resGetUID=0;
 unsigned char Card[4];

//接收的信息
 unsigned char r1[11],r2[7],r3[3],r4[3]; //r1前排红外 r2后排红外 r3左排红外 r4右排红外
 unsigned char keyCode;  //拨码开关值0-127
 unsigned char cmd;  //从裁判接收的命令

//控制
 unsigned char black_total1=0,black_total2=0;  //r1，r2黑点计数
 int err1=0,err2=0,err1_use=0,err2_use=0;  //err1前排偏差，err2后排偏差，err1_use和err2_use为判断偏差合理后用作控制的偏差
 double v_output=0,v_offset=0; //电压值偏离标准量v_offset，电压值输出量v_output
 int v_max=6500,v_maxone=0,v_getcorner=7000,turnleft_time_count=0,turnleft_time_set=70,turnright_time_count=0,turnright_time_set=70,motor_time_wait=0,motor_time_wait_set=30,turnaround_time_count=0,turnaround_time_set=140; //最大电压占空比  //6500能够刹住车
 //double kp=1000;
 int weight[11]={-7,-5,-3,-2,-1,0,1,2,3,5,7};  //前排红外偏差权值

 int pulsecount=0; //5ms脉冲数
 unsigned int pulsetotal=0;  //总脉冲数

 char send_value[16]={0}; //zigbee发送数据(不使用)

///////////////////////////////hao///////////////////////
 //int rederror=0,rederror1=0,rederror2=0;//边沿跳变获得误差
 //int red2error=0,red2error1=0,red2error2=0;//边沿跳变获得误差
 int testvalue0=0,testvalue1=0,testvalue2=0,testvalue3=0,testvalue4=0,testvalue5=0,haoswitch=0,identityset=0,redatah=0;
// int routechoice=0;
// int goahead_finish=0,goahead_distance_set=0,goahead_distance_count=0,getcorner_finish=0,robot_controlable=1,robot_controlable_downgrade=0,atcorner=0,turnleft_finish=0,turnright_finish=0,turnaround_finish=0,break_finish=0;

