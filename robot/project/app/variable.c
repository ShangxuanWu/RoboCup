#include "variable.h"
//Ӳ����Ϣ
//���� ��pwm4=+ pwm5=0
//     ��pwm6=0 pwm7=+

//����ԭ�б���
 unsigned char tmpUID[4] ={0,0,0,0};
 unsigned char resGetUID=0;
 unsigned char Card[4];

//���յ���Ϣ
 unsigned char r1[11],r2[7],r3[3],r4[3]; //r1ǰ�ź��� r2���ź��� r3���ź��� r4���ź���
 unsigned char keyCode;  //���뿪��ֵ0-127
 unsigned char cmd;  //�Ӳ��н��յ�����

//����
 unsigned char black_total1=0,black_total2=0;  //r1��r2�ڵ����
 int err1=0,err2=0,err1_use=0,err2_use=0;  //err1ǰ��ƫ�err2����ƫ�err1_use��err2_useΪ�ж�ƫ�������������Ƶ�ƫ��
 double v_output=0,v_offset=0; //��ѹֵƫ���׼��v_offset����ѹֵ�����v_output
 int v_max=6500,v_maxone=0,v_getcorner=7000,turnleft_time_count=0,turnleft_time_set=70,turnright_time_count=0,turnright_time_set=70,motor_time_wait=0,motor_time_wait_set=30,turnaround_time_count=0,turnaround_time_set=140; //����ѹռ�ձ�  //6500�ܹ�ɲס��
 //double kp=1000;
 int weight[11]={-7,-5,-3,-2,-1,0,1,2,3,5,7};  //ǰ�ź���ƫ��Ȩֵ

 int pulsecount=0; //5ms������
 unsigned int pulsetotal=0;  //��������

 char send_value[16]={0}; //zigbee��������(��ʹ��)

///////////////////////////////hao///////////////////////
 //int rederror=0,rederror1=0,rederror2=0;//�������������
 //int red2error=0,red2error1=0,red2error2=0;//�������������
 int testvalue0=0,testvalue1=0,testvalue2=0,testvalue3=0,testvalue4=0,testvalue5=0,haoswitch=0,identityset=0,redatah=0;
// int routechoice=0;
// int goahead_finish=0,goahead_distance_set=0,goahead_distance_count=0,getcorner_finish=0,robot_controlable=1,robot_controlable_downgrade=0,atcorner=0,turnleft_finish=0,turnright_finish=0,turnaround_finish=0,break_finish=0;

