///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  13:46:19 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\project\LPLD_Template\app\function /
//                    .c                                                      /
//    Command line =  "F:\robot _init\robot\project\LPLD_Template\app\functio /
//                    n.c" -D IAR -D LPLD_K60 -lCN "F:\robot                  /
//                    _init\robot\project\LPLD_Template\iar\FLASH\List\" -lB  /
//                    "F:\robot _init\robot\project\LPLD_Template\iar\FLASH\L /
//                    ist\" -o "F:\robot _init\robot\project\LPLD_Template\ia /
//                    r\FLASH\Obj\" --no_cse --no_unroll --no_inline          /
//                    --no_code_motion --no_tbaa --no_clustering              /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config "D:\IAR     /
//                    Systems\Embedded Workbench                              /
//                    6.4\arm\INC\c\DLib_Config_Normal.h" -I "F:\robot        /
//                    _init\robot\project\LPLD_Template\iar\..\app\" -I       /
//                    "F:\robot _init\robot\project\LPLD_Template\iar\..\..\. /
//                    .\lib\common\" -I "F:\robot                             /
//                    _init\robot\project\LPLD_Template\iar\..\..\..\lib\cpu\ /
//                    " -I "F:\robot _init\robot\project\LPLD_Template\iar\.. /
//                    \..\..\lib\cpu\headers\" -I "F:\robot                   /
//                    _init\robot\project\LPLD_Template\iar\..\..\..\lib\driv /
//                    ers\adc16\" -I "F:\robot _init\robot\project\LPLD_Templ /
//                    ate\iar\..\..\..\lib\drivers\enet\" -I "F:\robot        /
//                    _init\robot\project\LPLD_Template\iar\..\..\..\lib\driv /
//                    ers\lptmr\" -I "F:\robot _init\robot\project\LPLD_Templ /
//                    ate\iar\..\..\..\lib\drivers\mcg\" -I "F:\robot         /
//                    _init\robot\project\LPLD_Template\iar\..\..\..\lib\driv /
//                    ers\pmc\" -I "F:\robot _init\robot\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\drivers\rtc\" -I "F:\robot           /
//                    _init\robot\project\LPLD_Template\iar\..\..\..\lib\driv /
//                    ers\uart\" -I "F:\robot _init\robot\project\LPLD_Templa /
//                    te\iar\..\..\..\lib\drivers\wdog\" -I "F:\robot         /
//                    _init\robot\project\LPLD_Template\iar\..\..\..\lib\plat /
//                    forms\" -I "F:\robot _init\robot\project\LPLD_Template\ /
//                    iar\..\..\..\lib\LPLD\" -I "F:\robot                    /
//                    _init\robot\project\LPLD_Template\iar\..\..\..\lib\LPLD /
//                    \FatFs\" -I "F:\robot _init\robot\project\LPLD_Template /
//                    \iar\..\..\..\lib\LPLD\USB\" -I "F:\robot               /
//                    _init\robot\project\LPLD_Template\iar\..\..\..\lib\iar_ /
//                    config_files\" -Ol                                      /
//    List file    =  F:\robot _init\robot\project\LPLD_Template\iar\FLASH\Li /
//                    st\function.s                                           /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME function

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_FTM0_PWM_Init
        EXTERN LPLD_FTM0_PWM_Open
        EXTERN LPLD_GPIO_Get_b
        EXTERN LPLD_GPIO_Init

        PUBLIC calculate_infrared_error
        PUBLIC delayMs
        PUBLIC delayUs
        PUBLIC init_gpio
        PUBLIC init_pwm
        PUBLIC scan_infrared
        PUBLIC scan_infront
        PUBLIC scan_switch

// F:\robot _init\robot\project\LPLD_Template\app\function.c
//    1 #include "common.h"
//    2 #include "HAL_GPIO.h"
//    3 #include "HAL_FTM.h"
//    4 #include "function.h"
//    5 #include "config.h"
//    6 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    7 void init_gpio()
//    8 {
init_gpio:
        PUSH     {R7,LR}
//    9   //拨码开关
//   10   LPLD_GPIO_Init(PTE, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   11   LPLD_GPIO_Init(PTE, 1, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+1
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   12   LPLD_GPIO_Init(PTE, 2, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+2
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   13   LPLD_GPIO_Init(PTE, 3, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+3
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   14   LPLD_GPIO_Init(PTE, 4, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+4
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
//   15   LPLD_GPIO_Init(PTE, 5, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+5
        MOVS     R0,#+4
        BL       LPLD_GPIO_Init
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
//   37   LPLD_GPIO_Init(PTD, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+3
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
//   52   
//   53   // 接近开关
//   54   LPLD_GPIO_Init(PTB, 0, DIR_INPUT, INPUT_PUP, IRQC_DIS);
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
        MOVS     R3,#+1
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       LPLD_GPIO_Init
//   55 }
        POP      {R0,PC}          ;; return
//   56 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   57 void init_pwm()
//   58 {
init_pwm:
        PUSH     {R7,LR}
//   59   //设置FTM0模块PWM频率为10kHz
//   60   LPLD_FTM0_PWM_Init(10000);
        MOVW     R0,#+10000
        BL       LPLD_FTM0_PWM_Init
//   61   LPLD_FTM0_PWM_Open(4, 0);
        MOVS     R1,#+0
        MOVS     R0,#+4
        BL       LPLD_FTM0_PWM_Open
//   62   LPLD_FTM0_PWM_Open(5, 0);
        MOVS     R1,#+0
        MOVS     R0,#+5
        BL       LPLD_FTM0_PWM_Open
//   63   LPLD_FTM0_PWM_Open(6, 0);
        MOVS     R1,#+0
        MOVS     R0,#+6
        BL       LPLD_FTM0_PWM_Open
//   64   LPLD_FTM0_PWM_Open(7, 0);
        MOVS     R1,#+0
        MOVS     R0,#+7
        BL       LPLD_FTM0_PWM_Open
//   65 }
        POP      {R0,PC}          ;; return
//   66 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   67 _Bool scan_infront(void) {
scan_infront:
        PUSH     {R7,LR}
//   68 	return !LPLD_GPIO_Get_b(PTB, 0);
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BNE.N    ??scan_infront_0
        MOVS     R0,#+1
        B.N      ??scan_infront_1
??scan_infront_0:
        MOVS     R0,#+0
??scan_infront_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,PC}          ;; return
//   69 }
//   70 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   71 void scan_infrared(_Bool *r1, _Bool *r2, _Bool *r3, _Bool *r4)
//   72 {
scan_infrared:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//   73   r1[0]=LPLD_GPIO_Get_b(PTB, 9);
        MOVS     R1,#+9
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_0
        MOVS     R0,#+1
        B.N      ??scan_infrared_1
??scan_infrared_0:
        MOVS     R0,#+0
??scan_infrared_1:
        STRB     R0,[R4, #+0]
//   74   r1[1]=LPLD_GPIO_Get_b(PTB, 10);
        MOVS     R1,#+10
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_2
        MOVS     R0,#+1
        B.N      ??scan_infrared_3
??scan_infrared_2:
        MOVS     R0,#+0
??scan_infrared_3:
        STRB     R0,[R4, #+1]
//   75   r1[2]=LPLD_GPIO_Get_b(PTB, 11);
        MOVS     R1,#+11
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_4
        MOVS     R0,#+1
        B.N      ??scan_infrared_5
??scan_infrared_4:
        MOVS     R0,#+0
??scan_infrared_5:
        STRB     R0,[R4, #+2]
//   76   r1[3]=LPLD_GPIO_Get_b(PTB, 18);
        MOVS     R1,#+18
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_6
        MOVS     R0,#+1
        B.N      ??scan_infrared_7
??scan_infrared_6:
        MOVS     R0,#+0
??scan_infrared_7:
        STRB     R0,[R4, #+3]
//   77   r1[4]=LPLD_GPIO_Get_b(PTB, 19);
        MOVS     R1,#+19
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_8
        MOVS     R0,#+1
        B.N      ??scan_infrared_9
??scan_infrared_8:
        MOVS     R0,#+0
??scan_infrared_9:
        STRB     R0,[R4, #+4]
//   78   r1[5]=LPLD_GPIO_Get_b(PTB, 20);
        MOVS     R1,#+20
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_10
        MOVS     R0,#+1
        B.N      ??scan_infrared_11
??scan_infrared_10:
        MOVS     R0,#+0
??scan_infrared_11:
        STRB     R0,[R4, #+5]
//   79   r1[6]=LPLD_GPIO_Get_b(PTB, 21);
        MOVS     R1,#+21
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_12
        MOVS     R0,#+1
        B.N      ??scan_infrared_13
??scan_infrared_12:
        MOVS     R0,#+0
??scan_infrared_13:
        STRB     R0,[R4, #+6]
//   80   r1[7]=LPLD_GPIO_Get_b(PTB, 22);
        MOVS     R1,#+22
        MOVS     R0,#+1
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_14
        MOVS     R0,#+1
        B.N      ??scan_infrared_15
??scan_infrared_14:
        MOVS     R0,#+0
??scan_infrared_15:
        STRB     R0,[R4, #+7]
//   81   r1[8]=LPLD_GPIO_Get_b(PTC, 6);
        MOVS     R1,#+6
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_16
        MOVS     R0,#+1
        B.N      ??scan_infrared_17
??scan_infrared_16:
        MOVS     R0,#+0
??scan_infrared_17:
        STRB     R0,[R4, #+8]
//   82   r1[9]=LPLD_GPIO_Get_b(PTC, 7);
        MOVS     R1,#+7
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_18
        MOVS     R0,#+1
        B.N      ??scan_infrared_19
??scan_infrared_18:
        MOVS     R0,#+0
??scan_infrared_19:
        STRB     R0,[R4, #+9]
//   83   r1[10]=LPLD_GPIO_Get_b(PTC, 8);
        MOVS     R1,#+8
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_20
        MOVS     R0,#+1
        B.N      ??scan_infrared_21
??scan_infrared_20:
        MOVS     R0,#+0
??scan_infrared_21:
        STRB     R0,[R4, #+10]
//   84   
//   85   r2[0]=LPLD_GPIO_Get_b(PTD, 0);
        MOVS     R1,#+0
        MOVS     R0,#+3
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_22
        MOVS     R0,#+1
        B.N      ??scan_infrared_23
??scan_infrared_22:
        MOVS     R0,#+0
??scan_infrared_23:
        STRB     R0,[R5, #+0]
//   86   r2[1]=LPLD_GPIO_Get_b(PTA, 5);
        MOVS     R1,#+5
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_24
        MOVS     R0,#+1
        B.N      ??scan_infrared_25
??scan_infrared_24:
        MOVS     R0,#+0
??scan_infrared_25:
        STRB     R0,[R5, #+1]
//   87   r2[2]=LPLD_GPIO_Get_b(PTA, 12);
        MOVS     R1,#+12
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_26
        MOVS     R0,#+1
        B.N      ??scan_infrared_27
??scan_infrared_26:
        MOVS     R0,#+0
??scan_infrared_27:
        STRB     R0,[R5, #+2]
//   88   r2[3]=LPLD_GPIO_Get_b(PTA, 13);
        MOVS     R1,#+13
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_28
        MOVS     R0,#+1
        B.N      ??scan_infrared_29
??scan_infrared_28:
        MOVS     R0,#+0
??scan_infrared_29:
        STRB     R0,[R5, #+3]
//   89   r2[4]=LPLD_GPIO_Get_b(PTA, 14);
        MOVS     R1,#+14
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_30
        MOVS     R0,#+1
        B.N      ??scan_infrared_31
??scan_infrared_30:
        MOVS     R0,#+0
??scan_infrared_31:
        STRB     R0,[R5, #+4]
//   90   r2[5]=LPLD_GPIO_Get_b(PTA, 16);
        MOVS     R1,#+16
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_32
        MOVS     R0,#+1
        B.N      ??scan_infrared_33
??scan_infrared_32:
        MOVS     R0,#+0
??scan_infrared_33:
        STRB     R0,[R5, #+5]
//   91   r2[6]=LPLD_GPIO_Get_b(PTA, 17);
        MOVS     R1,#+17
        MOVS     R0,#+0
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_34
        MOVS     R0,#+1
        B.N      ??scan_infrared_35
??scan_infrared_34:
        MOVS     R0,#+0
??scan_infrared_35:
        STRB     R0,[R5, #+6]
//   92   
//   93   r3[0]=LPLD_GPIO_Get_b(PTE, 24);
        MOVS     R1,#+24
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_36
        MOVS     R0,#+1
        B.N      ??scan_infrared_37
??scan_infrared_36:
        MOVS     R0,#+0
??scan_infrared_37:
        STRB     R0,[R6, #+0]
//   94   r3[1]=LPLD_GPIO_Get_b(PTE, 25);
        MOVS     R1,#+25
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_38
        MOVS     R0,#+1
        B.N      ??scan_infrared_39
??scan_infrared_38:
        MOVS     R0,#+0
??scan_infrared_39:
        STRB     R0,[R6, #+1]
//   95   r3[2]=LPLD_GPIO_Get_b(PTE, 26);
        MOVS     R1,#+26
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_40
        MOVS     R0,#+1
        B.N      ??scan_infrared_41
??scan_infrared_40:
        MOVS     R0,#+0
??scan_infrared_41:
        STRB     R0,[R6, #+2]
//   96   
//   97   r4[0]=LPLD_GPIO_Get_b(PTC, 13);
        MOVS     R1,#+13
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_42
        MOVS     R0,#+1
        B.N      ??scan_infrared_43
??scan_infrared_42:
        MOVS     R0,#+0
??scan_infrared_43:
        STRB     R0,[R7, #+0]
//   98   r4[1]=LPLD_GPIO_Get_b(PTC, 12);
        MOVS     R1,#+12
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_44
        MOVS     R0,#+1
        B.N      ??scan_infrared_45
??scan_infrared_44:
        MOVS     R0,#+0
??scan_infrared_45:
        STRB     R0,[R7, #+1]
//   99   r4[2]=LPLD_GPIO_Get_b(PTC, 9);
        MOVS     R1,#+9
        MOVS     R0,#+2
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BEQ.N    ??scan_infrared_46
        MOVS     R0,#+1
        B.N      ??scan_infrared_47
??scan_infrared_46:
        MOVS     R0,#+0
??scan_infrared_47:
        STRB     R0,[R7, #+2]
//  100 }
        POP      {R0,R4-R7,PC}    ;; return
//  101 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  102 void calculate_infrared_error(_Bool *r, int r_size, int *error) {
calculate_infrared_error:
        PUSH     {R4-R6}
//  103 	if (r == NULL || error == NULL) return;
        CMP      R0,#+0
        BEQ.N    ??calculate_infrared_error_0
        CMP      R2,#+0
        BNE.N    ??calculate_infrared_error_1
??calculate_infrared_error_0:
        B.N      ??calculate_infrared_error_2
//  104 	int eb1 = -1, eb2 = -1;
??calculate_infrared_error_1:
        MOVS     R3,#-1
        MOVS     R4,#-1
//  105 	for (int i = 1; i < r_size; ++ i) {
        MOVS     R5,#+1
        B.N      ??calculate_infrared_error_3
//  106 		if (r[i - 1] == 0 && r[i] == 1) eb1 = i;
//  107 		else if (r[i - 1] == 1 && r[i] == 0) eb2 = i;
??calculate_infrared_error_4:
        ADDS     R6,R5,R0
        LDRB     R6,[R6, #-1]
        CMP      R6,#+0
        BEQ.N    ??calculate_infrared_error_5
        LDRB     R6,[R5, R0]
        CMP      R6,#+0
        BNE.N    ??calculate_infrared_error_5
        MOVS     R4,R5
??calculate_infrared_error_5:
        ADDS     R5,R5,#+1
??calculate_infrared_error_3:
        CMP      R5,R1
        BGE.N    ??calculate_infrared_error_6
        ADDS     R6,R5,R0
        LDRB     R6,[R6, #-1]
        CMP      R6,#+0
        BNE.N    ??calculate_infrared_error_4
        LDRB     R6,[R5, R0]
        CMP      R6,#+0
        BEQ.N    ??calculate_infrared_error_4
        MOVS     R3,R5
        B.N      ??calculate_infrared_error_5
//  108 	}
//  109 	
//  110   if(eb1 != -1 && eb2 != -1)
??calculate_infrared_error_6:
        CMN      R3,#+1
        BEQ.N    ??calculate_infrared_error_7
        CMN      R4,#+1
        BEQ.N    ??calculate_infrared_error_7
//  111   {
//  112     if(eb2 - eb1 < BLACKLINE_WIDTH + 1)//黑线应该小于等于3个红外
        SUBS     R0,R4,R3
        CMP      R0,#+4
        BGE.N    ??calculate_infrared_error_8
//  113       *error = eb1 + eb2 - r_size - 1;
        ADDS     R0,R4,R3
        SUBS     R0,R0,R1
        SUBS     R0,R0,#+1
        STR      R0,[R2, #+0]
        B.N      ??calculate_infrared_error_8
//  114     //else
//  115     // *error = r1_error;//超过4个说明是错误或者是十字等情况 暂且保持误差
//  116   }
//  117   else if(eb1 != -1 && eb2 == -1)
??calculate_infrared_error_7:
        CMN      R3,#+1
        BEQ.N    ??calculate_infrared_error_9
        CMN      R4,#+1
        BNE.N    ??calculate_infrared_error_9
//  118   {
//  119 	if (r[r_size - 1]) *error = r_size - 1;
        ADDS     R0,R1,R0
        LDRB     R0,[R0, #-1]
        CMP      R0,#+0
        BEQ.N    ??calculate_infrared_error_10
        SUBS     R0,R1,#+1
        STR      R0,[R2, #+0]
        B.N      ??calculate_infrared_error_8
//  120 	else *error = r_size;
??calculate_infrared_error_10:
        STR      R1,[R2, #+0]
        B.N      ??calculate_infrared_error_8
//  121   }	
//  122   else if(eb1 == -1 && eb2 == 1)
??calculate_infrared_error_9:
        CMN      R3,#+1
        BNE.N    ??calculate_infrared_error_8
        CMP      R4,#+1
        BNE.N    ??calculate_infrared_error_8
//  123   {
//  124 	if (r[1]) *error = 1 - r_size;
        LDRB     R0,[R0, #+1]
        CMP      R0,#+0
        BEQ.N    ??calculate_infrared_error_11
        RSBS     R0,R1,#+1
        STR      R0,[R2, #+0]
        B.N      ??calculate_infrared_error_8
//  125 	//if (r[0]) *error = 1 - r_size;
//  126 	else *error = r_size;
??calculate_infrared_error_11:
        STR      R1,[R2, #+0]
//  127   }
//  128   else	
//  129   {
//  130     //红外完全看不见，误差保持
//  131   }		
//  132 }
??calculate_infrared_error_8:
??calculate_infrared_error_2:
        POP      {R4-R6}
        BX       LR               ;; return
//  133 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  134 void delayMs(uint16 t)  //粗略定时
//  135 {
//  136   uint32 i=t*20000;
delayMs:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVW     R1,#+20000
        MULS     R0,R1,R0
//  137   while(i--);
??delayMs_0:
        MOVS     R1,R0
        SUBS     R0,R1,#+1
        CMP      R1,#+0
        BNE.N    ??delayMs_0
//  138 }
        BX       LR               ;; return
//  139 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  140 void delayUs(uint16 t)  //粗略定时
//  141 {
//  142   uint32 i=t*20;
delayUs:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        MOVS     R1,#+20
        MULS     R0,R1,R0
//  143   while(i--);
??delayUs_0:
        MOVS     R1,R0
        SUBS     R0,R1,#+1
        CMP      R1,#+0
        BNE.N    ??delayUs_0
//  144 }
        BX       LR               ;; return
//  145 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  146 unsigned char scan_switch()
//  147 {
scan_switch:
        PUSH     {R3-R5,LR}
//  148   unsigned char code = 0;
        MOVS     R4,#+0
//  149   for (char i = 0; i < 7; ++ i)
        MOVS     R5,#+0
        B.N      ??scan_switch_0
//  150 	code |= LPLD_GPIO_Get_b(PTE, i) == 0 ? (1 << i) : 0;
??scan_switch_1:
        MOVS     R0,#+0
??scan_switch_2:
        ORRS     R4,R0,R4
        ADDS     R5,R5,#+1
??scan_switch_0:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+7
        BCS.N    ??scan_switch_3
        MOVS     R1,R5
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,#+4
        BL       LPLD_GPIO_Get_b
        CMP      R0,#+0
        BNE.N    ??scan_switch_1
        MOVS     R0,#+1
        LSLS     R0,R0,R5
        B.N      ??scan_switch_2
//  151   return code;
??scan_switch_3:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
//  152 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  153 /*
//  154 void yesbeep()
//  155 {
//  156   LPLD_GPIO_Set_b(PTB, 23, OUTPUT_H);
//  157 }
//  158 
//  159 void nobeep()
//  160 {
//  161   LPLD_GPIO_Set_b(PTB, 23, OUTPUT_L);
//  162 }
//  163 */
//  164 
//  165 /*
//  166 int abs(int a) {
//  167    return a < 0 ? -a : a;
//  168 }
//  169 */
// 
// 1 346 bytes in section .text
// 
// 1 346 bytes of CODE memory
//
//Errors: none
//Warnings: none
