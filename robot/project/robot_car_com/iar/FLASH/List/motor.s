///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    23/Jul/2014  21:57:12 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\robot\project\robot_car_com\app\motor.c              /
//    Command line =  D:\robot\project\robot_car_com\app\motor.c -D IAR -D    /
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
//    List file    =  D:\robot\project\robot_car_com\iar\FLASH\List\motor.s   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME motor

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_FTM0_PWM_ChangeDuty
        EXTERN LPLD_FTM0_PWM_Init
        EXTERN LPLD_FTM0_PWM_Open

        PUBLIC motor_get_left_speed
        PUBLIC motor_get_right_speed
        PUBLIC motor_init
        PUBLIC motor_left_speed
        PUBLIC motor_right_speed
        PUBLIC motor_set_left_speed
        PUBLIC motor_set_right_speed

// D:\robot\project\robot_car_com\app\motor.c
//    1 #include "motor.h"
//    2 #include "common.h"
//    3 #include "HAL_GPIO.h"
//    4 #include "HAL_FTM.h"
//    5 
//    6 
//    7 
//    8 
//    9 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   10 int motor_left_speed = 0;
motor_left_speed:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   11 int motor_right_speed =0;
motor_right_speed:
        DS8 4
//   12 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   13 void motor_init()
//   14 {
motor_init:
        PUSH     {R7,LR}
//   15 	 //设置FTM0模块PWM频率为10kHz
//   16   LPLD_FTM0_PWM_Init(10000);
        MOVW     R0,#+10000
        BL       LPLD_FTM0_PWM_Init
//   17   
//   18   LPLD_FTM0_PWM_Open(4, 0);  //PTD4 左侧马达前进
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       LPLD_FTM0_PWM_Open
//   19   LPLD_FTM0_PWM_Open(5, 0);  //PTD5 左侧马达后退
        MOVS     R1,#+0
        MOVS     R0,#+5
        BL       LPLD_FTM0_PWM_Open
//   20 
//   21   LPLD_FTM0_PWM_Open(7, 0);  //PTD6 右侧马达前进
        MOVS     R1,#+0
        MOVS     R0,#+7
        BL       LPLD_FTM0_PWM_Open
//   22   LPLD_FTM0_PWM_Open(6, 0);  //PTD7 右侧马达后退
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       LPLD_FTM0_PWM_Open
//   23 }
        POP      {R0,PC}          ;; return
//   24 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   25 void motor_set_left_speed(int speed)
//   26 {
motor_set_left_speed:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   27   motor_left_speed=speed;
        LDR.N    R0,??DataTable3
        STR      R4,[R0, #+0]
//   28   if((int)speed>=0)
        CMP      R4,#+0
        BMI.N    ??motor_set_left_speed_0
//   29   {
//   30     LPLD_FTM0_PWM_ChangeDuty(4,speed);
        MOVS     R1,R4
        MOVS     R0,#+4
        BL       LPLD_FTM0_PWM_ChangeDuty
//   31     LPLD_FTM0_PWM_ChangeDuty(5,0);
        MOVS     R1,#+0
        MOVS     R0,#+5
        BL       LPLD_FTM0_PWM_ChangeDuty
        B.N      ??motor_set_left_speed_1
//   32   }
//   33   else
//   34   {
//   35     LPLD_FTM0_PWM_ChangeDuty(4,0);
??motor_set_left_speed_0:
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       LPLD_FTM0_PWM_ChangeDuty
//   36     LPLD_FTM0_PWM_ChangeDuty(5,-speed);
        RSBS     R1,R4,#+0
        MOVS     R0,#+5
        BL       LPLD_FTM0_PWM_ChangeDuty
//   37   }
//   38 }
??motor_set_left_speed_1:
        POP      {R4,PC}          ;; return
//   39 
//   40 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 void motor_set_right_speed(int speed)
//   42 {
motor_set_right_speed:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   43   motor_right_speed=speed;
        LDR.N    R0,??DataTable3_1
        STR      R4,[R0, #+0]
//   44   if((int)speed>=0)
        CMP      R4,#+0
        BMI.N    ??motor_set_right_speed_0
//   45   {
//   46     LPLD_FTM0_PWM_ChangeDuty(7,speed);
        MOVS     R1,R4
        MOVS     R0,#+7
        BL       LPLD_FTM0_PWM_ChangeDuty
//   47     LPLD_FTM0_PWM_ChangeDuty(6,0);
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       LPLD_FTM0_PWM_ChangeDuty
        B.N      ??motor_set_right_speed_1
//   48   }
//   49   else
//   50   {
//   51     LPLD_FTM0_PWM_ChangeDuty(7,0);
??motor_set_right_speed_0:
        MOVS     R1,#+0
        MOVS     R0,#+7
        BL       LPLD_FTM0_PWM_ChangeDuty
//   52     LPLD_FTM0_PWM_ChangeDuty(6,-speed);
        RSBS     R1,R4,#+0
        MOVS     R0,#+6
        BL       LPLD_FTM0_PWM_ChangeDuty
//   53   }
//   54 }
??motor_set_right_speed_1:
        POP      {R4,PC}          ;; return
//   55 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   56 int motor_get_right_speed()
//   57 {
//   58 	return motor_right_speed;
motor_get_right_speed:
        LDR.N    R0,??DataTable3_1
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
//   59 }
//   60 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   61 int motor_get_left_speed()
//   62 {
//   63 	return motor_left_speed;
motor_get_left_speed:
        LDR.N    R0,??DataTable3
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
//   64 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     motor_left_speed

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     motor_right_speed

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
//   8 bytes in section .bss
// 160 bytes in section .text
// 
// 160 bytes of CODE memory
//   8 bytes of DATA memory
//
//Errors: none
//Warnings: none
