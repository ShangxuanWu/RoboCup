///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    23/Jul/2014  00:11:45 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\robot\project\robot_car_com\app\led.c                /
//    Command line =  D:\robot\project\robot_car_com\app\led.c -D IAR -D      /
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
//    List file    =  D:\robot\project\robot_car_com\iar\FLASH\List\led.s     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME led

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_GPIO_Init
        EXTERN LPLD_GPIO_Toggle_b

        PUBLIC led_init
        PUBLIC led_twinkle

// D:\robot\project\robot_car_com\app\led.c
//    1 #include "led.h"
//    2 #include "common.h"
//    3 #include "HAL_GPIO.h"
//    4 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    5 void led_init()
//    6 {
led_init:
        PUSH     {R7,LR}
//    7 	LPLD_GPIO_Init(PTA, 15, DIR_OUTPUT, OUTPUT_L, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+0
        MOVS     R2,#+1
        MOVS     R1,#+15
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//    8 }
        POP      {R0,PC}          ;; return
//    9 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   10 void led_twinkle() //100ms中断，系统板闪灯
//   11 {
led_twinkle:
        PUSH     {R7,LR}
//   12   LPLD_GPIO_Toggle_b(PTA, 15);
        MOVS     R1,#+15
        MOVS     R0,#+0
        BL       LPLD_GPIO_Toggle_b
//   13 }
        POP      {R0,PC}          ;; return

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
// 32 bytes in section .text
// 
// 32 bytes of CODE memory
//
//Errors: none
//Warnings: none
