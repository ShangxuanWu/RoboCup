///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  22:43:18 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\project\LPLD_Template\a /
//                    pp\LPLD_Template.c                                      /
//    Command line =  D:\中国机器人大赛\robot_project\project\LPLD_Template\a /
//                    pp\LPLD_Template.c -D IAR -D LPLD_K60 -lCN              /
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
//                    ar\RAM\List\LPLD_Template.s                             /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME LPLD_Template

        #define SHT_PROGBITS 0x1

        EXTERN BufRFID
        EXTERN GetCardUID
        EXTERN LPLD_PIT_Init
        EXTERN LPLD_UART_GetChar
        EXTERN LPLD_UART_Init
        EXTERN LPLD_UART_RIE_Enable
        EXTERN ParseRFIDData
        EXTERN UART2_ParseData
        EXTERN init_gpio
        EXTERN init_pwm
        EXTERN scan_infrared
        EXTERN scan_switch

        PUBLIC keyCode
        PUBLIC main
        PUBLIC pit_isr0
        PUBLIC pit_isr1
        PUBLIC `r1`
        PUBLIC `r2`
        PUBLIC `r3`
        PUBLIC `r4`
        PUBLIC uart1_recv_isr
        PUBLIC uart2_recv_isr
        PUBLIC uart5_recv_isr

// D:\中国机器人大赛\robot_project\project\LPLD_Template\app\LPLD_Template.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"示例工程-----------------
//    3  *
//    4  * 测试硬件平台:  LPLD_K60 Card
//    5  * 版权所有:      北京拉普兰德电子技术有限公司
//    6  * 网络销售:      http://laplenden.taobao.com
//    7  * 公司门户:      http://www.lpld.cn
//    8  *
//    9  * 说明:    本工程基于"拉普兰德K60底层库"开发，
//   10  *          所有开源驱动代码均在"LPLD"文件夹下，调用说明见文档[#LPLD-003-N]
//   11  *
//   12  * 文件名:  LPLD_Template.c
//   13  * 用途:    Kinetis通用工程模板，用户可根据此模板工程新建自己的工程
//   14  *          本功能默认包含所有底层驱动，可以按需裁剪工程不需要的驱动，以减小生成文件
//   15  *
//   16  */
//   17 
//   18 #include "common.h"
//   19 #include "HAL_MCG.h"
//   20 #include "HAL_GPIO.h"
//   21 #include "HAL_PIT.h"
//   22 #include "HAL_FTM.h"
//   23 #include "HAL_LPTMR.h"
//   24 #include "HAL_UART.h"
//   25 #include "function.h"
//   26 #include "variable.h"

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute unsigned char r1[11]
`r1`:
        DS8 12

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute unsigned char r2[7]
`r2`:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute unsigned char r3[3]
`r3`:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// __absolute unsigned char r4[3]
`r4`:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
// __absolute unsigned char keyCode
keyCode:
        DS8 1
//   27 #include "UP_UART2Parser.h"
//   28 //声明中断函数
//   29 void pit_isr0();
//   30 void pit_isr1();
//   31 void uart1_recv_isr(void);
//   32 void uart2_recv_isr(void);
//   33 void uart5_recv_isr(void);
//   34 /********************************************************************/
//   35 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   36 static unsigned char tmpUID[4] ={0,0,0,0};
tmpUID:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   37 static unsigned char resGetUID=0;
resGetUID:
        DS8 1
//   38 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   39 void main (void)
//   40 {
main:
        PUSH     {R7,LR}
//   41   init_gpio();
        BL       init_gpio
//   42   init_pwm();
        BL       init_pwm
//   43   LPLD_PIT_Init(PIT0, 5000, pit_isr0); //电机控制
        ADR.W    R2,pit_isr0
        MOVW     R1,#+5000
        MOVS     R0,#+0
        BL       LPLD_PIT_Init
//   44   LPLD_PIT_Init(PIT1, 100000, pit_isr1);  //计时
        ADR.W    R2,pit_isr1
        LDR.N    R1,??DataTable1  ;; 0x186a0
        MOVS     R0,#+1
        BL       LPLD_PIT_Init
//   45   //计时器寄存器每减少50过1us
//   46   LPLD_UART_Init(UART1, 19200);
        MOV      R1,#+19200
        MOVS     R0,#+1
        BL       LPLD_UART_Init
//   47   LPLD_UART_Init(UART2, 19200);
        MOV      R1,#+19200
        MOVS     R0,#+2
        BL       LPLD_UART_Init
//   48   LPLD_UART_Init(UART5, 19200);
        MOV      R1,#+19200
        MOVS     R0,#+5
        BL       LPLD_UART_Init
//   49   LPLD_UART_RIE_Enable(UART1, uart1_recv_isr);
        ADR.W    R1,uart1_recv_isr
        MOVS     R0,#+1
        BL       LPLD_UART_RIE_Enable
//   50   LPLD_UART_RIE_Enable(UART2, uart2_recv_isr);
        ADR.W    R1,uart2_recv_isr
        MOVS     R0,#+2
        BL       LPLD_UART_RIE_Enable
//   51   LPLD_UART_RIE_Enable(UART5, uart5_recv_isr);
        ADR.W    R1,uart5_recv_isr
        MOVS     R0,#+5
        BL       LPLD_UART_RIE_Enable
//   52   //UP_LCD_Init();		//初始化LCD
//   53   while(1)
//   54   {
//   55     scan_infrared();
??main_0:
        BL       scan_infrared
//   56     ParseRFIDData();   //解析读卡器获得的数据
        BL       ParseRFIDData
//   57     if (1)
//   58     {	
//   59         resGetUID =1;
        LDR.N    R0,??DataTable1_1
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//   60     	GetCardUID(tmpUID);		//获取RFID卡号
        LDR.N    R0,??DataTable1_2
        BL       GetCardUID
//   61     }
//   62     else
//   63     {	resGetUID=0;
//   64     	tmpUID[0]=0;
//   65     	tmpUID[1]=0;
//   66     	tmpUID[2]=0;
//   67     	tmpUID[3]=0;
//   68     	Card[0]	 =0;
//   69     	Card[1]	 =0;
//   70     	Card[2]	 =0;
//   71     	Card[3]	 =0;
//   72     }
//   73     if ((resGetUID==1)&&(tmpUID[0]==0)&&(tmpUID[1]==0)&&(tmpUID[2]==0)&&(tmpUID[3]==0))
        LDR.N    R0,??DataTable1_1
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??main_1
        LDR.N    R0,??DataTable1_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??main_1
        LDR.N    R0,??DataTable1_2
        LDRB     R0,[R0, #+1]
        CMP      R0,#+0
        BNE.N    ??main_1
        LDR.N    R0,??DataTable1_2
        LDRB     R0,[R0, #+2]
        CMP      R0,#+0
        BNE.N    ??main_1
        LDR.N    R0,??DataTable1_2
        LDRB     R0,[R0, #+3]
        CMP      R0,#+0
        BNE.N    ??main_1
//   74     {	
//   75       resGetUID=0;
        LDR.N    R0,??DataTable1_1
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   76     }
//   77 
//   78     if (resGetUID==1)
??main_1:
        B.N      ??main_0
//   79     {	
//   80     	//printf("%x %x %x %x \n",tmpUID[0],tmpUID[1],tmpUID[2],tmpUID[3]);
//   81     	//delayMs(2000);
//   82     }    
//   83   } 
//   84 }
//   85 /********************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   86 void pit_isr0()
//   87 {
//   88   
//   89 }
pit_isr0:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   90 void pit_isr1()
//   91 {
pit_isr1:
        PUSH     {R7,LR}
//   92   keyCode=scan_switch();
        BL       scan_switch
        LDR.N    R1,??DataTable1_3
        STRB     R0,[R1, #+0]
//   93 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     0x186a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     resGetUID

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     tmpUID

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     keyCode

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   94 void uart1_recv_isr(void)
//   95 {
uart1_recv_isr:
        PUSH     {R7,LR}
//   96   char data;
//   97   data=LPLD_UART_GetChar(UART1);
        MOVS     R0,#+1
        BL       LPLD_UART_GetChar
//   98   BufRFID(data);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       BufRFID
//   99 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  100 void uart2_recv_isr(void)
//  101 {
uart2_recv_isr:
        PUSH     {R7,LR}
//  102   char data;
//  103   data=LPLD_UART_GetChar(UART2);
        MOVS     R0,#+2
        BL       LPLD_UART_GetChar
//  104   UART2_ParseData(data);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       UART2_ParseData
//  105 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  106 void uart5_recv_isr(void)
//  107 {
uart5_recv_isr:
        PUSH     {R7,LR}
//  108   char data;
//  109   data=LPLD_UART_GetChar(UART5);
        MOVS     R0,#+5
        BL       LPLD_UART_GetChar
//  110   BufRFID(data);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       BufRFID
//  111 }
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
//  34 bytes in section .bss
// 242 bytes in section .text
// 
// 242 bytes of CODE memory
//  34 bytes of DATA memory
//
//Errors: none
//Warnings: none
