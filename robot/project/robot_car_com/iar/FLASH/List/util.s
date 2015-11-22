///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    30/Jul/2014  22:50:09 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\app\util.c                             /
//    Command line =  C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\app\util.c -D IAR -D LPLD_K60 -lCN     /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\FLASH\List\ -lB                    /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\FLASH\List\ -o                     /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\FLASH\Obj\ --no_cse --no_unroll    /
//                    --no_inline --no_code_motion --no_tbaa --no_clustering  /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config             /
//                    D:\IAR\arm\INC\c\DLib_Config_Normal.h -I                /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\app\ -I                         /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\common\ -I            /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\cpu\ -I               /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\cpu\headers\ -I       /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\drivers\adc16\ -I     /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\drivers\enet\ -I      /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\drivers\lptmr\ -I     /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\drivers\mcg\ -I       /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\drivers\pmc\ -I       /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\drivers\rtc\ -I       /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\drivers\uart\ -I      /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\drivers\wdog\ -I      /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\platforms\ -I         /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\LPLD\ -I              /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\LPLD\FatFs\ -I        /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\LPLD\USB\ -I          /
//                    C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\..\..\..\lib\iar_config_files\ -Ol /
//    List file    =  C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\iar\FLASH\List\util.s                  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME util

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_GPIO_Set_b

        PUBLIC abs
        PUBLIC beep
        PUBLIC delayMs
        PUBLIC delayUs

// C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\project\robot_car_com\app\util.c
//    1 #include "common.h"
//    2 #include "HAL_GPIO.h"

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    3 void delayMs(uint16 t)
//    4 {
//    5   uint32 i=t*20000;
delayMs:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVW     R1,#+20000
        MULS     R0,R1,R0
//    6   while(i--);
??delayMs_0:
        MOVS     R1,R0
        SUBS     R0,R1,#+1
        CMP      R1,#+0
        BNE.N    ??delayMs_0
//    7 }
        BX       LR               ;; return
//    8 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    9 void delayUs(uint16 t)
//   10 {
//   11   uint32 i=t*20;
delayUs:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVS     R1,#+20
        MULS     R0,R1,R0
//   12   while(i--);
??delayUs_0:
        MOVS     R1,R0
        SUBS     R0,R1,#+1
        CMP      R1,#+0
        BNE.N    ??delayUs_0
//   13 }
        BX       LR               ;; return
//   14 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   15 int abs(int x)
//   16 {
//   17 	if(x>0) return x;
abs:
        CMP      R0,#+1
        BGE.N    ??abs_0
//   18 	else return -x;
??abs_1:
        RSBS     R0,R0,#+0
??abs_0:
        BX       LR               ;; return
//   19 }
//   20 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   21 void beep()
//   22 {
beep:
        PUSH     {R7,LR}
//   23   LPLD_GPIO_Set_b(PTB, 23, OUTPUT_H);
        MOVS     R2,#+1
        MOVS     R1,#+23
        MOVS     R0,#+1
        BL       LPLD_GPIO_Set_b
//   24   delayMs(10);
        MOVS     R0,#+10
        BL       delayMs
//   25    LPLD_GPIO_Set_b(PTB, 23, OUTPUT_L);
        MOVS     R2,#+0
        MOVS     R1,#+23
        MOVS     R0,#+1
        BL       LPLD_GPIO_Set_b
//   26 }
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
// 72 bytes in section .text
// 
// 72 bytes of CODE memory
//
//Errors: none
//Warnings: none
