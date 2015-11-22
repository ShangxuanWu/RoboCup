///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  22:37:20 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\project\LPLD_Template\a /
//                    pp\CycleBuf.c                                           /
//    Command line =  D:\中国机器人大赛\robot_project\project\LPLD_Template\a /
//                    pp\CycleBuf.c -D IAR -D LPLD_K60 -lCN                   /
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
//                    ar\RAM\List\CycleBuf.s                                  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME CycleBuf

        #define SHT_PROGBITS 0x1

        PUBLIC Cyc_Get
        PUBLIC Cyc_Init
        PUBLIC Cyc_PutIn

// D:\中国机器人大赛\robot_project\project\LPLD_Template\app\CycleBuf.c
//    1 #include "CycleBuf.h"
//    2 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    3 static int i;
i:
        DS8 4
//    4 /************************  结构体初始化  ****************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//    5 void Cyc_Init(CycleBuf* inCB)
//    6 {
//    7 	inCB->put = 0;
Cyc_Init:
        MOVS     R1,#+0
        STRB     R1,[R0, #+257]
//    8 	inCB->get = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+256]
//    9         
//   10         for(i=0;i<CYC_BUF_MAX;i++)
        LDR.N    R1,??DataTable0
        MOVS     R2,#+0
        STR      R2,[R1, #+0]
        B.N      ??Cyc_Init_0
//   11         {
//   12           inCB->buf[i] = 0;
??Cyc_Init_1:
        LDR.N    R1,??DataTable0
        LDR      R1,[R1, #+0]
        MOVS     R2,#+0
        STRB     R2,[R1, R0]
//   13         }
        LDR.N    R1,??DataTable0
        LDR      R1,[R1, #+0]
        ADDS     R1,R1,#+1
        LDR.N    R2,??DataTable0
        STR      R1,[R2, #+0]
??Cyc_Init_0:
        LDR.N    R1,??DataTable0
        LDR      R1,[R1, #+0]
        CMP      R1,#+255
        BLE.N    ??Cyc_Init_1
//   14 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable0:
        DC32     i
//   15 
//   16 /************************  将数据放进缓冲区  ****************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   17 void Cyc_PutIn(CycleBuf* inCB,unsigned char inData)
//   18 {
//   19 	inCB->buf[inCB->put] = inData;
Cyc_PutIn:
        LDRB     R2,[R0, #+257]
        STRB     R1,[R2, R0]
//   20 	inCB->put ++;
        LDRB     R1,[R0, #+257]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+257]
//   21 
//   22 	if(inCB->put >= CYC_BUF_MAX)
        LDRB     R1,[R0, #+257]
        MOV      R2,#+256
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,R2
        BCC.N    ??Cyc_PutIn_0
//   23 	{
//   24 	  inCB->put = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+257]
//   25 	}
//   26 }
??Cyc_PutIn_0:
        BX       LR               ;; return
//   27 
//   28 /************************  将数据放进缓冲区  ****************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   29 unsigned char Cyc_Get(CycleBuf* inCB,unsigned char* inData)
//   30 {
Cyc_Get:
        PUSH     {R4}
//   31   unsigned char result = 0;
        MOVS     R2,#+0
//   32   if(inCB->put != inCB->get)
        LDRB     R3,[R0, #+257]
        LDRB     R4,[R0, #+256]
        CMP      R3,R4
        BEQ.N    ??Cyc_Get_0
//   33   {
//   34     *inData = inCB->buf[inCB->get];
        LDRB     R2,[R0, #+256]
        LDRB     R2,[R2, R0]
        STRB     R2,[R1, #+0]
//   35     inCB->get ++;
        LDRB     R1,[R0, #+256]
        ADDS     R1,R1,#+1
        STRB     R1,[R0, #+256]
//   36     if(inCB->get >=CYC_BUF_MAX)
        LDRB     R1,[R0, #+256]
        MOV      R2,#+256
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,R2
        BCC.N    ??Cyc_Get_1
//   37     {
//   38       inCB->get = 0;
        MOVS     R1,#+0
        STRB     R1,[R0, #+256]
//   39     }
//   40     result = 1;
??Cyc_Get_1:
        MOVS     R2,#+1
        B.N      ??Cyc_Get_2
//   41   }
//   42   else
//   43   {
//   44     result = 0;
??Cyc_Get_0:
        MOVS     R2,#+0
//   45   }
//   46 
//   47   return result;
??Cyc_Get_2:
        MOVS     R0,R2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4}
        BX       LR               ;; return
//   48 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//   49 
// 
//   4 bytes in section .bss
// 158 bytes in section .text
// 
// 158 bytes of CODE memory
//   4 bytes of DATA memory
//
//Errors: none
//Warnings: 2
