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

//Ӳ����Ϣ
//���� ��pwm4=+ pwm5
//     ��pwm6 pwm7=+

//����ԭ�б���
extern unsigned char tmpUID[4];
extern unsigned char resGetUID;
extern unsigned char Card[4];

//���յ���Ϣ
//extern unsigned char r1[11],r2[7],r3[3],r4[3]; //r1ǰ�ź��� r2���ź��� r3���ź��� r4���ź���
extern unsigned char keyCode;  //���뿪��ֵ0-127
extern unsigned char cmd;  //�Ӳ��н��յ�����

//����
extern unsigned char black_total1,black_total2;  //r1��r2�ڵ����
extern int err1,err2,err1_use,err2_use;  //err1ǰ��ƫ�err2����ƫ�err1_use��err2_useΪ�ж�ƫ�������������Ƶ�ƫ��
extern double v_output,v_offset; //��ѹֵƫ���׼��v_offset����ѹֵ�����v_output
extern int v_max,v_maxone,v_getcorner,turnleft_time_count,turnleft_time_set,turnright_time_count,turnright_time_set,motor_time_wait,motor_time_wait_set,turnaround_time_count,turnaround_time_set; //����ѹռ�ձ�  //6500�ܹ�ɲס��
//extern double kp;
extern int weight[11];  //ǰ�ź���ƫ��Ȩֵ

//extern int pulsecount; //5ms������
//extern unsigned int pulsetotal;  //��������

extern char send_value[16]; //zigbee��������(��ʹ��)

///////////////////////////////hao///////////////////////
//extern int rederror,rederror1,rederror2;//�������������
//extern int red2error,red2error1,red2error2;//�������������
extern int testvalue0,testvalue1,testvalue2,testvalue3,testvalue4,testvalue5,haoswitch,identityset,redatah;
//extern int routechoice;
extern int goahead_finish,goahead_distance_set,goahead_distance_count,getcorner_finish,robot_controlable,robot_controlable_downgrade,atcorner,turnleft_finish,turnright_finish,turnaround_finish,break_finish;


#endif


////////////////��ע////////////////////
/* ÿ�ֿ��ƽ�����������
    routechoice=stop; ���ÿ���ģʽλֹͣ����
    goahead_finish;//����״̬
    goahead_distance_count;
    goahead_distance_set;
    robot_controlable=1;//ÿ�θ�ָ�����Ȩ��0 
*/