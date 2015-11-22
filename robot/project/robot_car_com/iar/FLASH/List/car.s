///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    25/Jul/2014  21:09:31 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\robot\project\robot_car_com\app\car.c                /
//    Command line =  D:\robot\project\robot_car_com\app\car.c -D IAR -D      /
//                    LPLD_K60 -lCN D:\robot\project\robot_car_com\iar\FLASH\ /
//                    List\ -lB D:\robot\project\robot_car_com\iar\FLASH\List /
//                    \ -o D:\robot\project\robot_car_com\iar\FLASH\Obj\      /
//                    --no_cse --no_unroll --no_inline --no_code_motion       /
//                    --no_tbaa --no_clustering --no_scheduling --debug       /
//                    --endian=little --cpu=Cortex-M4 -e --fpu=None           /
//                    --dlib_config D:\IAR\arm\INC\c\DLib_Config_Normal.h -I  /
//                    D:\robot\project\robot_car_com\iar\..\app\ -I           /
//                    D:\robot\project\robot_car_com\iar\..\..\..\lib\common\ /
//                     -I D:\robot\project\robot_car_com\iar\..\..\..\lib\cpu /
//                    \ -I D:\robot\project\robot_car_com\iar\..\..\..\lib\cp /
//                    u\headers\ -I D:\robot\project\robot_car_com\iar\..\..\ /
//                    ..\lib\drivers\adc16\ -I D:\robot\project\robot_car_com /
//                    \iar\..\..\..\lib\drivers\enet\ -I                      /
//                    D:\robot\project\robot_car_com\iar\..\..\..\lib\drivers /
//                    \lptmr\ -I D:\robot\project\robot_car_com\iar\..\..\..\ /
//                    lib\drivers\mcg\ -I D:\robot\project\robot_car_com\iar\ /
//                    ..\..\..\lib\drivers\pmc\ -I                            /
//                    D:\robot\project\robot_car_com\iar\..\..\..\lib\drivers /
//                    \rtc\ -I D:\robot\project\robot_car_com\iar\..\..\..\li /
//                    b\drivers\uart\ -I D:\robot\project\robot_car_com\iar\. /
//                    .\..\..\lib\drivers\wdog\ -I                            /
//                    D:\robot\project\robot_car_com\iar\..\..\..\lib\platfor /
//                    ms\ -I D:\robot\project\robot_car_com\iar\..\..\..\lib\ /
//                    LPLD\ -I D:\robot\project\robot_car_com\iar\..\..\..\li /
//                    b\LPLD\FatFs\ -I D:\robot\project\robot_car_com\iar\..\ /
//                    ..\..\lib\LPLD\USB\ -I D:\robot\project\robot_car_com\i /
//                    ar\..\..\..\lib\iar_config_files\ -Ol                   /
//    List file    =  D:\robot\project\robot_car_com\iar\FLASH\List\car.s     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME car

        #define SHT_PROGBITS 0x1

        EXTERN get_infrare
        EXTERN motor_set_left_speed
        EXTERN motor_set_right_speed

        PUBLIC car_change_direction
        PUBLIC car_direction
        PUBLIC car_front_infrare
        PUBLIC car_init
        PUBLIC car_left_infrare
        PUBLIC car_right_infrare
        PUBLIC car_set_left_speed
        PUBLIC car_set_right_speed
        PUBLIC car_speed
        PUBLIC car_tail_infrare

// D:\robot\project\robot_car_com\app\car.c
//    1 #include "car.h"
//    2 #include "infrare.h"
//    3 #include "motor.h"

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//    4 int car_direction=1; //1 zigbee   0 ba
car_direction:
        DATA
        DC32 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    5 int car_speed=0;
car_speed:
        DS8 4
//    6 
//    7 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    8 unsigned char *car_front_infrare;
car_front_infrare:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    9 unsigned char *car_left_infrare;
car_left_infrare:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   10 unsigned char *car_right_infrare;
car_right_infrare:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   11 unsigned char *car_tail_infrare;
car_tail_infrare:
        DS8 4
//   12 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   13 void car_init()
//   14 {
car_init:
        PUSH     {R7,LR}
//   15 	car_speed = 0;
        LDR.N    R0,??DataTable3
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//   16 	car_direction =1;
        LDR.N    R0,??DataTable3_1
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//   17 	car_front_infrare = get_infrare(FRONT);
        MOVS     R0,#+0
        BL       get_infrare
        LDR.N    R1,??DataTable3_2
        STR      R0,[R1, #+0]
//   18 	car_left_infrare = get_infrare(LEFT);
        MOVS     R0,#+2
        BL       get_infrare
        LDR.N    R1,??DataTable3_3
        STR      R0,[R1, #+0]
//   19 	car_right_infrare = get_infrare(RIGHT);
        MOVS     R0,#+1
        BL       get_infrare
        LDR.N    R1,??DataTable3_4
        STR      R0,[R1, #+0]
//   20 	car_tail_infrare = get_infrare(TAIL);
        MOVS     R0,#+3
        BL       get_infrare
        LDR.N    R1,??DataTable3_5
        STR      R0,[R1, #+0]
//   21 }
        POP      {R0,PC}          ;; return
//   22 
//   23 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   24 void car_change_direction() //改变方向时映射传感器的位置
//   25 {
car_change_direction:
        PUSH     {R7,LR}
//   26   //TODO：两侧红外的顺序没有映射，还有前后红外的左右方向不对
//   27   car_direction=1-car_direction;
        LDR.N    R0,??DataTable3_1
        LDR      R0,[R0, #+0]
        RSBS     R0,R0,#+1
        LDR.N    R1,??DataTable3_1
        STR      R0,[R1, #+0]
//   28   car_speed=-car_speed;
        LDR.N    R0,??DataTable3
        LDR.N    R1,??DataTable3
        LDR      R1,[R1, #+0]
        RSBS     R1,R1,#+0
        STR      R1,[R0, #+0]
//   29   if(car_direction)
        LDR.N    R0,??DataTable3_1
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??car_change_direction_0
//   30   {
//   31     car_front_infrare = get_infrare(FRONT);
        MOVS     R0,#+0
        BL       get_infrare
        LDR.N    R1,??DataTable3_2
        STR      R0,[R1, #+0]
//   32     car_left_infrare  = get_infrare(LEFT);
        MOVS     R0,#+2
        BL       get_infrare
        LDR.N    R1,??DataTable3_3
        STR      R0,[R1, #+0]
//   33     car_right_infrare = get_infrare(RIGHT);
        MOVS     R0,#+1
        BL       get_infrare
        LDR.N    R1,??DataTable3_4
        STR      R0,[R1, #+0]
//   34     car_tail_infrare  = get_infrare(TAIL);
        MOVS     R0,#+3
        BL       get_infrare
        LDR.N    R1,??DataTable3_5
        STR      R0,[R1, #+0]
        B.N      ??car_change_direction_1
//   35   }
//   36   else
//   37   {
//   38     car_front_infrare = get_infrare(TAIL);
??car_change_direction_0:
        MOVS     R0,#+3
        BL       get_infrare
        LDR.N    R1,??DataTable3_2
        STR      R0,[R1, #+0]
//   39     car_tail_infrare  = get_infrare(FRONT);
        MOVS     R0,#+0
        BL       get_infrare
        LDR.N    R1,??DataTable3_5
        STR      R0,[R1, #+0]
//   40     car_left_infrare  = get_infrare(LEFT);
        MOVS     R0,#+2
        BL       get_infrare
        LDR.N    R1,??DataTable3_3
        STR      R0,[R1, #+0]
//   41     car_right_infrare = get_infrare(RIGHT);
        MOVS     R0,#+1
        BL       get_infrare
        LDR.N    R1,??DataTable3_4
        STR      R0,[R1, #+0]
//   42   }
//   43 }
??car_change_direction_1:
        POP      {R0,PC}          ;; return
//   44 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   45 void car_set_right_speed(int speed) //设置车子当前方向的右侧轮子速度 负数为反转
//   46 {
car_set_right_speed:
        PUSH     {R7,LR}
//   47   
//   48   if(car_direction)
        LDR.N    R1,??DataTable3_1
        LDR      R1,[R1, #+0]
        CMP      R1,#+0
        BEQ.N    ??car_set_right_speed_0
//   49   {
//   50     motor_set_right_speed(speed);
        BL       motor_set_right_speed
        B.N      ??car_set_right_speed_1
//   51   }
//   52   else
//   53   {
//   54     motor_set_left_speed(speed);
??car_set_right_speed_0:
        BL       motor_set_left_speed
//   55   }
//   56 }
??car_set_right_speed_1:
        POP      {R0,PC}          ;; return
//   57 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   58 void car_set_left_speed(int speed) //设置车子当前方向的左侧轮子速度 负数为反转
//   59 {
car_set_left_speed:
        PUSH     {R7,LR}
//   60   if(car_direction)
        LDR.N    R1,??DataTable3_1
        LDR      R1,[R1, #+0]
        CMP      R1,#+0
        BEQ.N    ??car_set_left_speed_0
//   61   {
//   62     motor_set_left_speed(speed);
        BL       motor_set_left_speed
        B.N      ??car_set_left_speed_1
//   63   }
//   64   else
//   65   {
//   66     motor_set_right_speed(speed);
??car_set_left_speed_0:
        BL       motor_set_right_speed
//   67   }
//   68 }
??car_set_left_speed_1:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     car_speed

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     car_direction

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     car_front_infrare

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     car_left_infrare

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     car_right_infrare

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     car_tail_infrare

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
//  20 bytes in section .bss
//   4 bytes in section .data
// 240 bytes in section .text
// 
// 240 bytes of CODE memory
//  24 bytes of DATA memory
//
//Errors: none
//Warnings: none
