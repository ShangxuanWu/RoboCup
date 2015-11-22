///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:48 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\project\robot_car_com\app\variable /
//                    .c                                                      /
//    Command line =  "F:\robot _init\robot\project\robot_car_com\app\variabl /
//                    e.c" -D IAR -D LPLD_K60 -lCN "F:\robot                  /
//                    _init\robot\project\robot_car_com\iar\FLASH\List\" -lB  /
//                    "F:\robot _init\robot\project\robot_car_com\iar\FLASH\L /
//                    ist\" -o "F:\robot _init\robot\project\robot_car_com\ia /
//                    r\FLASH\Obj\" --no_cse --no_unroll --no_inline          /
//                    --no_code_motion --no_tbaa --no_clustering              /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config "D:\IAR     /
//                    Systems\Embedded Workbench                              /
//                    6.4\arm\INC\c\DLib_Config_Normal.h" -I "F:\robot        /
//                    _init\robot\project\robot_car_com\iar\..\app\" -I       /
//                    "F:\robot _init\robot\project\robot_car_com\iar\..\..\. /
//                    .\lib\common\" -I "F:\robot                             /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\cpu\ /
//                    " -I "F:\robot _init\robot\project\robot_car_com\iar\.. /
//                    \..\..\lib\cpu\headers\" -I "F:\robot                   /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\adc16\" -I "F:\robot _init\robot\project\robot_car_ /
//                    com\iar\..\..\..\lib\drivers\enet\" -I "F:\robot        /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\lptmr\" -I "F:\robot _init\robot\project\robot_car_ /
//                    com\iar\..\..\..\lib\drivers\mcg\" -I "F:\robot         /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\pmc\" -I "F:\robot _init\robot\project\robot_car_co /
//                    m\iar\..\..\..\lib\drivers\rtc\" -I "F:\robot           /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\uart\" -I "F:\robot _init\robot\project\robot_car_c /
//                    om\iar\..\..\..\lib\drivers\wdog\" -I "F:\robot         /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\plat /
//                    forms\" -I "F:\robot _init\robot\project\robot_car_com\ /
//                    iar\..\..\..\lib\LPLD\" -I "F:\robot                    /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\LPLD /
//                    \FatFs\" -I "F:\robot _init\robot\project\robot_car_com /
//                    \iar\..\..\..\lib\LPLD\USB\" -I "F:\robot               /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\iar_ /
//                    config_files\" -Ol                                      /
//    List file    =  F:\robot _init\robot\project\robot_car_com\iar\FLASH\Li /
//                    st\variable.s                                           /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME variable

        #define SHT_PROGBITS 0x1

        PUBLIC Card
        PUBLIC black_total1
        PUBLIC black_total2
        PUBLIC cmd
        PUBLIC err1
        PUBLIC err1_use
        PUBLIC err2
        PUBLIC err2_use
        PUBLIC haoswitch
        PUBLIC identityset
        PUBLIC keyCode
        PUBLIC motor_time_wait
        PUBLIC motor_time_wait_set
        PUBLIC pulsecount
        PUBLIC pulsetotal
        PUBLIC `r1`
        PUBLIC `r2`
        PUBLIC `r3`
        PUBLIC `r4`
        PUBLIC redatah
        PUBLIC resGetUID
        PUBLIC send_value
        PUBLIC testvalue0
        PUBLIC testvalue1
        PUBLIC testvalue2
        PUBLIC testvalue3
        PUBLIC testvalue4
        PUBLIC testvalue5
        PUBLIC tmpUID
        PUBLIC turnaround_time_count
        PUBLIC turnaround_time_set
        PUBLIC turnleft_time_count
        PUBLIC turnleft_time_set
        PUBLIC turnright_time_count
        PUBLIC turnright_time_set
        PUBLIC v_getcorner
        PUBLIC v_max
        PUBLIC v_maxone
        PUBLIC v_offset
        PUBLIC v_output
        PUBLIC weight

// F:\robot _init\robot\project\robot_car_com\app\variable.c
//    1 #include "variable.h"
//    2 //硬件信息
//    3 //正跑 左pwm4=+ pwm5=0
//    4 //     右pwm6=0 pwm7=+
//    5 
//    6 //例程原有变量

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    7  unsigned char tmpUID[4] ={0,0,0,0};
tmpUID:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//    8  unsigned char resGetUID=0;
resGetUID:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    9  unsigned char Card[4];
Card:
        DS8 4
//   10 
//   11 //接收的信息

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   12  unsigned char r1[11],r2[7],r3[3],r4[3]; //r1前排红外 r2后排红外 r3左排红外 r4右排红外
`r1`:
        DS8 12

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
`r2`:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
`r3`:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
`r4`:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   13  unsigned char keyCode;  //拨码开关值0-127
keyCode:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   14  unsigned char cmd;  //从裁判接收的命令
cmd:
        DS8 1
//   15 
//   16 //控制

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   17  unsigned char black_total1=0,black_total2=0;  //r1，r2黑点计数
black_total1:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
black_total2:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   18  int err1=0,err2=0,err1_use=0,err2_use=0;  //err1前排偏差，err2后排偏差，err1_use和err2_use为判断偏差合理后用作控制的偏差
err1:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
err2:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
err1_use:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
err2_use:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
//   19  double v_output=0,v_offset=0; //电压值偏离标准量v_offset，电压值输出量v_output
v_output:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(3)
v_offset:
        DS8 8

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   20  int v_max=6500,v_maxone=0,v_getcorner=7000,turnleft_time_count=0,turnleft_time_set=70,turnright_time_count=0,turnright_time_set=70,motor_time_wait=0,motor_time_wait_set=30,turnaround_time_count=0,turnaround_time_set=140; //最大电压占空比  //6500能够刹住车
v_max:
        DATA
        DC32 6500

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
v_maxone:
        DS8 4

        SECTION `.data`:DATA:REORDER:NOROOT(2)
v_getcorner:
        DATA
        DC32 7000

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
turnleft_time_count:
        DS8 4

        SECTION `.data`:DATA:REORDER:NOROOT(2)
turnleft_time_set:
        DATA
        DC32 70

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
turnright_time_count:
        DS8 4

        SECTION `.data`:DATA:REORDER:NOROOT(2)
turnright_time_set:
        DATA
        DC32 70

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
motor_time_wait:
        DS8 4

        SECTION `.data`:DATA:REORDER:NOROOT(2)
motor_time_wait_set:
        DATA
        DC32 30

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
turnaround_time_count:
        DS8 4

        SECTION `.data`:DATA:REORDER:NOROOT(2)
turnaround_time_set:
        DATA
        DC32 140
//   21  //double kp=1000;

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   22  int weight[11]={-7,-5,-3,-2,-1,0,1,2,3,5,7};  //前排红外偏差权值
weight:
        DATA
        DC32 -7, -5, -3, -2, -1, 0, 1, 2, 3, 5, 7
//   23 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   24  int pulsecount=0; //5ms脉冲数
pulsecount:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   25  unsigned int pulsetotal=0;  //总脉冲数
pulsetotal:
        DS8 4
//   26 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27  char send_value[16]={0}; //zigbee发送数据(不使用)
send_value:
        DS8 16
//   28 
//   29 ///////////////////////////////hao///////////////////////
//   30  //int rederror=0,rederror1=0,rederror2=0;//边沿跳变获得误差
//   31  //int red2error=0,red2error1=0,red2error2=0;//边沿跳变获得误差

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   32  int testvalue0=0,testvalue1=0,testvalue2=0,testvalue3=0,testvalue4=0,testvalue5=0,haoswitch=0,identityset=0,redatah=0;
testvalue0:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
testvalue1:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
testvalue2:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
testvalue3:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
testvalue4:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
testvalue5:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
haoswitch:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
identityset:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
redatah:
        DS8 4

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//   33 // int routechoice=0;
//   34 // int goahead_finish=0,goahead_distance_set=0,goahead_distance_count=0,getcorner_finish=0,robot_controlable=1,robot_controlable_downgrade=0,atcorner=0,turnleft_finish=0,turnright_finish=0,turnaround_finish=0,break_finish=0;
//   35 
// 
// 153 bytes in section .bss
//  68 bytes in section .data
// 
// 221 bytes of DATA memory
//
//Errors: none
//Warnings: none
