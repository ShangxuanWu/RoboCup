#ifndef __VARIABLE_H
#define __VARIABLE_H

#define stop  0
#define goahead 1
#define goback 2
#define turnleft 3
#define turnright 4
#define turnaround 5
#define breakdown 6
#define testpoint 7
#define corner 8

//硬件信息
//正跑 左pwm4=+ pwm5
//     右pwm6 pwm7=+

//例程原有变量
extern unsigned char tmpUID[4];
extern unsigned char resGetUID;
extern unsigned char Card[4];

//接收的信息
//extern unsigned char r1[11],r2[7],r3[3],r4[3]; //r1前排红外 r2后排红外 r3左排红外 r4右排红外
extern unsigned char keyCode;  //拨码开关值0-127
extern unsigned char cmd;  //从裁判接收的命令

//控制
extern unsigned char black_total1,black_total2;  //r1，r2黑点计数
extern int err1,err2,err1_use,err2_use;  //err1前排偏差，err2后排偏差，err1_use和err2_use为判断偏差合理后用作控制的偏差
extern double v_output,v_offset; //电压值偏离标准量v_offset，电压值输出量v_output
extern int v_max,v_maxone,v_getcorner,turnleft_time_count,turnleft_time_set,turnright_time_count,turnright_time_set,motor_time_wait,motor_time_wait_set,turnaround_time_count,turnaround_time_set; //最大电压占空比  //6500能够刹住车
//extern double kp;
extern int weight[11];  //前排红外偏差权值

//extern int pulsecount; //5ms脉冲数
//extern unsigned int pulsetotal;  //总脉冲数

extern char send_value[16]; //zigbee发送数据(不使用)

///////////////////////////////hao///////////////////////
//extern int rederror,rederror1,rederror2;//边沿跳变获得误差
//extern int red2error,red2error1,red2error2;//边沿跳变获得误差
extern int testvalue0,testvalue1,testvalue2,testvalue3,testvalue4,testvalue5,haoswitch,identityset,redatah;
//extern int routechoice;
extern int goahead_finish,goahead_distance_set,goahead_distance_count,getcorner_finish,robot_controlable,robot_controlable_downgrade,atcorner,turnleft_finish,turnright_finish,turnaround_finish,break_finish;


#endif


////////////////备注////////////////////
/* 每轮控制结束必须流程
    routechoice=stop; 重置控制模式位停止控制
    goahead_finish;//重置状态
    goahead_distance_count;
    goahead_distance_set;
    robot_controlable=1;//每次给指令将控制权置0 
*/