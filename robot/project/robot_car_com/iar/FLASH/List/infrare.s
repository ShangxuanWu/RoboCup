///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    30/Jul/2014  22:50:09 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\app\infrare.c                          /
//    Command line =  C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\proje /
//                    ct\robot_car_com\app\infrare.c -D IAR -D LPLD_K60 -lCN  /
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
//                    ct\robot_car_com\iar\FLASH\List\infrare.s               /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME infrare

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_GPIO_Get_b
        EXTERN LPLD_GPIO_Init
        EXTERN LPLD_PIT_Init

        PUBLIC front_infrare
        PUBLIC get_infrare
        PUBLIC infrare_init
        PUBLIC infrare_update
        PUBLIC left_infrare
        PUBLIC right_infrare
        PUBLIC tail_infrare

// C:\Users\hp\Desktop\安防机器人大赛\程序工程\robot\project\robot_car_com\app\infrare.c
//    1 #include "infrare.h"
//    2 #include "common.h"
//    3 #include "HAL_GPIO.h"
//    4 #include "HAL_FTM.h"
//    5 #include "HAL_PIT.h"
//    6 /*
//    7        front
//    8       _______
//    9      |       |
//   10      |  zb   |
//   11 left |       | right
//   12      |  K60  | 
//   13      |_______|   
//   14         tail
//   15 */
//   16 
//   17 #define FRONT_INFRARE_NUM 11
//   18 #define TAIL_INFRARE_NUM 11 
//   19 #define LEFT_INFRARE_NUM 3
//   20 #define RIGHT_INFRARE_NUM 3
//   21 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   22 unsigned char front_infrare[FRONT_INFRARE_NUM];
front_infrare:
        DS8 12

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   23 unsigned char tail_infrare[TAIL_INFRARE_NUM];
tail_infrare:
        DS8 12

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   24 unsigned char left_infrare[LEFT_INFRARE_NUM];
left_infrare:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   25 unsigned char right_infrare[RIGHT_INFRARE_NUM];
right_infrare:
        DS8 4
//   26 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   27 void infrare_init()
//   28 {
infrare_init:
        PUSH     {R7,LR}
//   29   //鍓嶆帓绾㈠front_infrare
//   30   LPLD_GPIO_Init(PTB, 9, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+9
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   31   LPLD_GPIO_Init(PTB, 10, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+10
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   32   LPLD_GPIO_Init(PTB, 11, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   33   LPLD_GPIO_Init(PTB, 18, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+18
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   34   LPLD_GPIO_Init(PTB, 19, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+19
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   35   LPLD_GPIO_Init(PTB, 20, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+20
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   36   LPLD_GPIO_Init(PTB, 21, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+21
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   37   LPLD_GPIO_Init(PTB, 22, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+22
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   38   LPLD_GPIO_Init(PTC, 6, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+6
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   39   LPLD_GPIO_Init(PTC, 7, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+7
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   40   LPLD_GPIO_Init(PTC, 8, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+8
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   41   //鍚庢帓绾㈠tail_infrare
//   42   LPLD_GPIO_Init(PTB, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   43   LPLD_GPIO_Init(PTA, 5, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   44   LPLD_GPIO_Init(PTA, 12, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+12
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   45   LPLD_GPIO_Init(PTA, 13, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+13
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   46   LPLD_GPIO_Init(PTA, 14, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+14
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   47   LPLD_GPIO_Init(PTA, 16, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+16
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   48   LPLD_GPIO_Init(PTA, 17, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+17
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   49   LPLD_GPIO_Init(PTD, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       LPLD_GPIO_Init
//   50   LPLD_GPIO_Init(PTD, 1, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+3
        BL       LPLD_GPIO_Init
//   51   LPLD_GPIO_Init(PTD, 2, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+2
        MOVS     R0,#+3
        BL       LPLD_GPIO_Init
//   52   LPLD_GPIO_Init(PTD, 3, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+3
        MOVS     R0,#+3
        BL       LPLD_GPIO_Init
//   53   LPLD_GPIO_Init(PTD, 4, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+4
        MOVS     R0,#+3
        BL       LPLD_GPIO_Init
//   54   //宸︿晶绾㈠left_infrare
//   55   LPLD_GPIO_Init(PTE, 24, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+24
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   56   LPLD_GPIO_Init(PTE, 25, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+25
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   57   LPLD_GPIO_Init(PTE, 26, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+26
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   58   //鍙充晶绾㈠right_infrare
//   59   LPLD_GPIO_Init(PTC, 9, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+9
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   60   LPLD_GPIO_Init(PTC, 12, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+12
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   61   LPLD_GPIO_Init(PTC, 13, DIR_INPUT, INPUT_PUP, IRQC_DIS);  
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+13
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   62 
//   63   LPLD_PIT_Init(PIT1,5000,infrare_update);
        ADR.W    R2,infrare_update
        MOVW     R1,#+5000
        MOVS     R0,#+1
        BL       LPLD_PIT_Init
//   64 }
        POP      {R0,PC}          ;; return
//   65 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   66 void infrare_update()
//   67 {
infrare_update:
        PUSH     {R7,LR}
//   68   front_infrare[0]=LPLD_GPIO_Get_b(PTB, 9);
        MOVS     R1,#+9
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+0]
//   69   front_infrare[1]=LPLD_GPIO_Get_b(PTB, 10);
        MOVS     R1,#+10
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+1]
//   70   front_infrare[2]=LPLD_GPIO_Get_b(PTB, 11);
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+2]
//   71   front_infrare[3]=LPLD_GPIO_Get_b(PTB, 18);
        MOVS     R1,#+18
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+3]
//   72   front_infrare[4]=LPLD_GPIO_Get_b(PTB, 19);
        MOVS     R1,#+19
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+4]
//   73   front_infrare[5]=LPLD_GPIO_Get_b(PTB, 20);
        MOVS     R1,#+20
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+5]
//   74   front_infrare[6]=LPLD_GPIO_Get_b(PTB, 21);
        MOVS     R1,#+21
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+6]
//   75   front_infrare[7]=LPLD_GPIO_Get_b(PTB, 22);
        MOVS     R1,#+22
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+7]
//   76   front_infrare[8]=LPLD_GPIO_Get_b(PTC, 6);
        MOVS     R1,#+6
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+8]
//   77   front_infrare[9]=LPLD_GPIO_Get_b(PTC, 7);
        MOVS     R1,#+7
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+9]
//   78   front_infrare[10]=LPLD_GPIO_Get_b(PTC, 8);
        MOVS     R1,#+8
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1
        STRB     R0,[R1, #+10]
//   79  
//   80   
//   81   tail_infrare[0]=LPLD_GPIO_Get_b(PTD, 0);
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+0]
//   82   tail_infrare[1]=LPLD_GPIO_Get_b(PTA, 5);
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+1]
//   83   tail_infrare[2]=LPLD_GPIO_Get_b(PTA, 12);
        MOVS     R1,#+12
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+2]
//   84   tail_infrare[3]=LPLD_GPIO_Get_b(PTA, 13);
        MOVS     R1,#+13
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+3]
//   85   tail_infrare[4]=LPLD_GPIO_Get_b(PTA, 14);
        MOVS     R1,#+14
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+4]
//   86   tail_infrare[5]=LPLD_GPIO_Get_b(PTA, 16);
        MOVS     R1,#+16
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+5]
//   87   tail_infrare[6]=LPLD_GPIO_Get_b(PTA, 17);
        MOVS     R1,#+17
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+6]
//   88   tail_infrare[7]=LPLD_GPIO_Get_b(PTE, 4);
        MOVS     R1,#+4
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+7]
//   89   tail_infrare[8]=LPLD_GPIO_Get_b(PTE, 2);
        MOVS     R1,#+2
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+8]
//   90   tail_infrare[9]=LPLD_GPIO_Get_b(PTE, 1);
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+9]
//   91   tail_infrare[10]=LPLD_GPIO_Get_b(PTE, 0);
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_1
        STRB     R0,[R1, #+10]
//   92   left_infrare[0]=LPLD_GPIO_Get_b(PTE, 24);
        MOVS     R1,#+24
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_2
        STRB     R0,[R1, #+0]
//   93   left_infrare[1]=LPLD_GPIO_Get_b(PTE, 25);
        MOVS     R1,#+25
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_2
        STRB     R0,[R1, #+1]
//   94   left_infrare[2]=LPLD_GPIO_Get_b(PTE, 26);
        MOVS     R1,#+26
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_2
        STRB     R0,[R1, #+2]
//   95   
//   96   right_infrare[0]=LPLD_GPIO_Get_b(PTC, 13);
        MOVS     R1,#+13
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_3
        STRB     R0,[R1, #+0]
//   97   right_infrare[1]=LPLD_GPIO_Get_b(PTC, 12);
        MOVS     R1,#+12
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_3
        STRB     R0,[R1, #+1]
//   98   right_infrare[2]=LPLD_GPIO_Get_b(PTC, 9);
        MOVS     R1,#+9
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable1_3
        STRB     R0,[R1, #+2]
//   99 }
        POP      {R0,PC}          ;; return
//  100 
//  101 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  102 unsigned char *get_infrare(int side)
//  103 {
//  104   switch(side)
get_infrare:
        CMP      R0,#+0
        BEQ.N    ??get_infrare_0
        CMP      R0,#+2
        BEQ.N    ??get_infrare_1
        BCC.N    ??get_infrare_2
        CMP      R0,#+3
        BEQ.N    ??get_infrare_3
        B.N      ??get_infrare_4
//  105   {
//  106     case FRONT:
//  107       return front_infrare;
??get_infrare_0:
        LDR.N    R0,??DataTable1
        B.N      ??get_infrare_5
//  108     case RIGHT:
//  109       return right_infrare;
??get_infrare_2:
        LDR.N    R0,??DataTable1_3
        B.N      ??get_infrare_5
//  110     case LEFT:
//  111       return left_infrare;
??get_infrare_1:
        LDR.N    R0,??DataTable1_2
        B.N      ??get_infrare_5
//  112     case TAIL:
//  113       return tail_infrare;
??get_infrare_3:
        LDR.N    R0,??DataTable1_1
        B.N      ??get_infrare_5
//  114   }
//  115   return NULL;
??get_infrare_4:
        MOVS     R0,#+0
??get_infrare_5:
        BX       LR               ;; return
//  116 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     front_infrare

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     tail_infrare

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     left_infrare

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     right_infrare

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
//  32 bytes in section .bss
// 874 bytes in section .text
// 
// 874 bytes of CODE memory
//  32 bytes of DATA memory
//
//Errors: none
//Warnings: none
