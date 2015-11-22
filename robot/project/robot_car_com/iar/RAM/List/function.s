///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:14:57 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\project\LPLD_Template\a /
//                    pp\function.c                                           /
//    Command line =  D:\中国机器人大赛\robot_project\project\LPLD_Template\a /
//                    pp\function.c -D IAR -D LPLD_K60 -lCN                   /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\ -lB D:\中国机器人大赛\robot_project\projec /
//                    t\LPLD_Template\iar\RAM\List\ -o                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\RAM\Obj\ --no_cse --no_unroll --no_inline            /
//                    --no_code_motion --no_tbaa --no_clustering              /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config             /
//                    "D:\Program Files\IAR Systems\Embedded Workbench        /
//                    6.0\arm\INC\c\DLib_Config_Normal.h" -I                  /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\app\ -I D:\中国机器人大赛\robot_project\project\L /
//                    PLD_Template\iar\..\..\..\lib\common\ -I                /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\cpu\ -I D:\中国机器人大赛\robot_project /
//                    \project\LPLD_Template\iar\..\..\..\lib\cpu\headers\    /
//                    -I D:\中国机器人大赛\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\drivers\adc16\ -I                    /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\enet\ -I                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\lptmr\ -I                       /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\mcg\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\pmc\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\rtc\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\uart\ -I                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\wdog\ -I                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\platforms\ -I                           /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\LPLD\ -I D:\中国机器人大赛\robot_projec /
//                    t\project\LPLD_Template\iar\..\..\..\lib\LPLD\FatFs\    /
//                    -I D:\中国机器人大赛\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\LPLD\USB\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\iar_config_files\ -Ol                   /
//    List file    =  D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\function.s                                  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME function

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_FTM0_PWM_Init
        EXTERN LPLD_FTM0_PWM_Open
        EXTERN LPLD_GPIO_Get_b
        EXTERN LPLD_GPIO_Init
        EXTERN LPLD_GPIO_Set_b
        EXTERN `r1`
        EXTERN `r2`
        EXTERN `r3`
        EXTERN `r4`

        PUBLIC delayMs
        PUBLIC delayUs
        PUBLIC init_gpio
        PUBLIC init_pwm
        PUBLIC nobeep
        PUBLIC scan_infrared
        PUBLIC scan_switch
        PUBLIC yesbeep

// D:\中国机器人大赛\robot_project\project\LPLD_Template\app\function.c
//    1 #include "common.h"
//    2 #include "HAL_GPIO.h"
//    3 #include "HAL_FTM.h"
//    4 #include "function.h"
//    5 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    6 void init_gpio()
//    7 {
init_gpio:
        PUSH     {R7,LR}
//    8   //拨码开关
//    9   LPLD_GPIO_Init(PTE, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   10   LPLD_GPIO_Init(PTE, 1, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   11   LPLD_GPIO_Init(PTE, 2, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+2
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   12   LPLD_GPIO_Init(PTE, 3, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+3
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   13   LPLD_GPIO_Init(PTE, 4, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+4
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   14   LPLD_GPIO_Init(PTE, 5, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+5
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   15 
//   16   LPLD_GPIO_Init(PTE, 6, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+6
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   17 
//   18   //核心板指示灯
//   19   LPLD_GPIO_Init(PTA, 15, DIR_OUTPUT, OUTPUT_L, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+0
        MOVS     R2,#+1
        MOVS     R1,#+15
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   20   
//   21   //蜂鸣器
//   22   LPLD_GPIO_Init(PTB, 23, DIR_OUTPUT, OUTPUT_L, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+0
        MOVS     R2,#+1
        MOVS     R1,#+23
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   23   
//   24   //前排红外r1
//   25   LPLD_GPIO_Init(PTB, 9, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+9
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   26   LPLD_GPIO_Init(PTB, 10, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+10
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   27   LPLD_GPIO_Init(PTB, 11, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   28   LPLD_GPIO_Init(PTB, 18, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+18
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   29   LPLD_GPIO_Init(PTB, 19, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+19
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   30   LPLD_GPIO_Init(PTB, 20, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+20
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   31   LPLD_GPIO_Init(PTB, 21, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+21
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   32   LPLD_GPIO_Init(PTB, 22, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+22
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   33   LPLD_GPIO_Init(PTC, 6, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+6
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   34   LPLD_GPIO_Init(PTC, 7, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+7
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   35   LPLD_GPIO_Init(PTC, 8, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+8
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   36   //后排红外r2
//   37   LPLD_GPIO_Init(PTA, 4, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   38   LPLD_GPIO_Init(PTA, 5, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   39   LPLD_GPIO_Init(PTA, 12, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+12
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   40   LPLD_GPIO_Init(PTA, 13, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+13
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   41   LPLD_GPIO_Init(PTA, 14, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+14
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   42   LPLD_GPIO_Init(PTA, 16, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+16
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   43   LPLD_GPIO_Init(PTA, 17, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+17
        MOVS     R0,#+0
        BL       LPLD_GPIO_Init
//   44   //左侧红外r3
//   45   LPLD_GPIO_Init(PTE, 24, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+24
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   46   LPLD_GPIO_Init(PTE, 25, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+25
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   47   LPLD_GPIO_Init(PTE, 26, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+26
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   48   //右侧红外r4
//   49   LPLD_GPIO_Init(PTC, 9, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+9
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   50   LPLD_GPIO_Init(PTC, 12, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+12
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   51   LPLD_GPIO_Init(PTC, 13, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+13
        MOVS     R0,#+2
        BL       LPLD_GPIO_Init
//   52 }
        POP      {R0,PC}          ;; return
//   53 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   54 void init_pwm()
//   55 {
init_pwm:
        PUSH     {R7,LR}
//   56   //设置FTM0模块PWM频率为10kHz
//   57   LPLD_FTM0_PWM_Init(10000);
        MOVW     R0,#+10000
        BL       LPLD_FTM0_PWM_Init
//   58   LPLD_FTM0_PWM_Open(4, 0);
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       LPLD_FTM0_PWM_Open
//   59   LPLD_FTM0_PWM_Open(5, 0);
        MOVS     R1,#+0
        MOVS     R0,#+5
        BL       LPLD_FTM0_PWM_Open
//   60   LPLD_FTM0_PWM_Open(6, 0);
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       LPLD_FTM0_PWM_Open
//   61   LPLD_FTM0_PWM_Open(7, 0);
        MOVS     R1,#+0
        MOVS     R0,#+7
        BL       LPLD_FTM0_PWM_Open
//   62 }
        POP      {R0,PC}          ;; return
//   63 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   64 void scan_infrared()
//   65 {
scan_infrared:
        PUSH     {R7,LR}
//   66   r1[0]=LPLD_GPIO_Get_b(PTB, 9);
        MOVS     R1,#+9
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+0]
//   67   r1[1]=LPLD_GPIO_Get_b(PTB, 10);
        MOVS     R1,#+10
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+1]
//   68   r1[2]=LPLD_GPIO_Get_b(PTB, 11);
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+2]
//   69   r1[3]=LPLD_GPIO_Get_b(PTB, 18);
        MOVS     R1,#+18
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+3]
//   70   r1[4]=LPLD_GPIO_Get_b(PTB, 19);
        MOVS     R1,#+19
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+4]
//   71   r1[5]=LPLD_GPIO_Get_b(PTB, 20);
        MOVS     R1,#+20
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+5]
//   72   r1[6]=LPLD_GPIO_Get_b(PTB, 21);
        MOVS     R1,#+21
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+6]
//   73   r1[7]=LPLD_GPIO_Get_b(PTB, 22);
        MOVS     R1,#+22
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+7]
//   74   r1[8]=LPLD_GPIO_Get_b(PTC, 6);
        MOVS     R1,#+6
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+8]
//   75   r1[9]=LPLD_GPIO_Get_b(PTC, 7);
        MOVS     R1,#+7
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+9]
//   76   r1[10]=LPLD_GPIO_Get_b(PTC, 8);
        MOVS     R1,#+8
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0
        STRB     R0,[R1, #+10]
//   77   
//   78   r2[0]=LPLD_GPIO_Get_b(PTA, 4);
        MOVS     R1,#+4
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_1
        STRB     R0,[R1, #+0]
//   79   r2[1]=LPLD_GPIO_Get_b(PTA, 5);
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_1
        STRB     R0,[R1, #+1]
//   80   r2[2]=LPLD_GPIO_Get_b(PTA, 12);
        MOVS     R1,#+12
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_1
        STRB     R0,[R1, #+2]
//   81   r2[3]=LPLD_GPIO_Get_b(PTA, 13);
        MOVS     R1,#+13
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_1
        STRB     R0,[R1, #+3]
//   82   r2[4]=LPLD_GPIO_Get_b(PTA, 14);
        MOVS     R1,#+14
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_1
        STRB     R0,[R1, #+4]
//   83   r2[5]=LPLD_GPIO_Get_b(PTA, 16);
        MOVS     R1,#+16
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_1
        STRB     R0,[R1, #+5]
//   84   r2[6]=LPLD_GPIO_Get_b(PTA, 17);
        MOVS     R1,#+17
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_1
        STRB     R0,[R1, #+6]
//   85   
//   86   r3[0]=LPLD_GPIO_Get_b(PTE, 24);
        MOVS     R1,#+24
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_2
        STRB     R0,[R1, #+0]
//   87   r3[1]=LPLD_GPIO_Get_b(PTE, 25);
        MOVS     R1,#+25
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_2
        STRB     R0,[R1, #+1]
//   88   r3[2]=LPLD_GPIO_Get_b(PTE, 26);
        MOVS     R1,#+26
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_2
        STRB     R0,[R1, #+2]
//   89   
//   90   r4[0]=LPLD_GPIO_Get_b(PTC, 9);
        MOVS     R1,#+9
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_3
        STRB     R0,[R1, #+0]
//   91   r4[1]=LPLD_GPIO_Get_b(PTC, 12);
        MOVS     R1,#+12
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_3
        STRB     R0,[R1, #+1]
//   92   r4[2]=LPLD_GPIO_Get_b(PTC, 13);
        MOVS     R1,#+13
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        LDR.N    R1,??DataTable0_3
        STRB     R0,[R1, #+2]
//   93 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     `r1`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_1:
        DC32     `r2`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_2:
        DC32     `r3`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0_3:
        DC32     `r4`
//   94 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   95 void delayMs(uint16 t)  //粗略定时
//   96 {
//   97   uint32 i=t*20000;
delayMs:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVW     R1,#+20000
        MULS     R0,R1,R0
//   98   while(i--);
??delayMs_0:
        MOVS     R1,R0
        SUBS     R0,R1,#+1
        CMP      R1,#+0
        BNE.N    ??delayMs_0
//   99 }
        BX       LR               ;; return
//  100 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  101 void delayUs(uint16 t)  //粗略定时
//  102 {
//  103   uint32 i=t*20;
delayUs:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVS     R1,#+20
        MULS     R0,R1,R0
//  104   while(i--);
??delayUs_0:
        MOVS     R1,R0
        SUBS     R0,R1,#+1
        CMP      R1,#+0
        BNE.N    ??delayUs_0
//  105 }
        BX       LR               ;; return
//  106 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  107 unsigned char scan_switch()
//  108 {
scan_switch:
        PUSH     {R4,LR}
//  109   unsigned char code=0;
        MOVS     R4,#+0
//  110   if(LPLD_GPIO_Get_b(PTE, 0)==0)code+=1;
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BNE.N    ??scan_switch_0
        ADDS     R4,R4,#+1
//  111   if(LPLD_GPIO_Get_b(PTE, 1)==0)code+=2;
??scan_switch_0:
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BNE.N    ??scan_switch_1
        ADDS     R4,R4,#+2
//  112   if(LPLD_GPIO_Get_b(PTE, 2)==0)code+=4;
??scan_switch_1:
        MOVS     R1,#+2
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BNE.N    ??scan_switch_2
        ADDS     R4,R4,#+4
//  113   if(LPLD_GPIO_Get_b(PTE, 3)==0)code+=8;
??scan_switch_2:
        MOVS     R1,#+3
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BNE.N    ??scan_switch_3
        ADDS     R4,R4,#+8
//  114   if(LPLD_GPIO_Get_b(PTE, 4)==0)code+=16;
??scan_switch_3:
        MOVS     R1,#+4
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BNE.N    ??scan_switch_4
        ADDS     R4,R4,#+16
//  115   if(LPLD_GPIO_Get_b(PTE, 5)==0)code+=32;
??scan_switch_4:
        MOVS     R1,#+5
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BNE.N    ??scan_switch_5
        ADDS     R4,R4,#+32
//  116   if(LPLD_GPIO_Get_b(PTE, 6)==0)code+=64;
??scan_switch_5:
        MOVS     R1,#+6
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BNE.N    ??scan_switch_6
        ADDS     R4,R4,#+64
//  117   return code;
??scan_switch_6:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4,PC}          ;; return
//  118 }
//  119 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  120 void yesbeep()
//  121 {
yesbeep:
        PUSH     {R7,LR}
//  122   LPLD_GPIO_Set_b(PTB, 23, OUTPUT_H);
        MOVS     R2,#+1
        MOVS     R1,#+23
        MOVS     R0,#+1
        BL       LPLD_GPIO_Set_b
//  123 }
        POP      {R0,PC}          ;; return
//  124 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  125 void nobeep()
//  126 {
nobeep:
        PUSH     {R7,LR}
//  127   LPLD_GPIO_Set_b(PTB, 23, OUTPUT_L);
        MOVS     R2,#+0
        MOVS     R1,#+23
        MOVS     R0,#+1
        BL       LPLD_GPIO_Set_b
//  128 }
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
// 1 054 bytes in section .text
// 
// 1 054 bytes of CODE memory
//
//Errors: none
//Warnings: 1
