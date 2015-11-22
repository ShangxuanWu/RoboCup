///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  19:23:19 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\LPLD\USB\RingBuffer /
//                    .c                                                      /
//    Command line =  D:\中国机器人大赛\robot_project\lib\LPLD\USB\RingBuffer /
//                    .c -D IAR -D LPLD_K60 -lCN                              /
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
//                    ar\RAM\List\RingBuffer.s                                /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME RingBuffer

        #define SHT_PROGBITS 0x1

        PUBLIC Buffer_Init
        PUBLIC Buffer_Request
        PUBLIC OUT_EndAddress
        PUBLIC OUT_SciPointer
        PUBLIC OUT_StartAddress
        PUBLIC OUT_UsbPointer
        PUBLIC gu8BufferMaxSize
        PUBLIC gu8BufferOverFlow

// D:\中国机器人大赛\robot_project\lib\LPLD\USB\RingBuffer.c
//    1 /*
//    2  * 文件名: RingBuffer.c
//    3  * 用途:  定义缓冲区配置函数
//    4  * 最后修改日期: 20121204
//    5  *
//    6  *
//    7  * 说明:本页代码基于Freescale官方示例代码修改，源代码文件为 RingBuffer.c
//    8  *    本文件未经修改
//    9  */
//   10 #include "RingBuffer.h"
//   11 
//   12 /* Pointers */

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   13 volatile UINT8 *OUT_StartAddress;
OUT_StartAddress:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   14 volatile UINT8 *OUT_EndAddress;
OUT_EndAddress:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   15 volatile UINT8 *OUT_UsbPointer;
OUT_UsbPointer:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   16 volatile UINT8 *OUT_SciPointer;
OUT_SciPointer:
        DS8 4
//   17 
//   18 /* Variables */

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   19 volatile UINT8 gu8BufferMaxSize;
gu8BufferMaxSize:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   20 volatile UINT8 gu8BufferOverFlow;
gu8BufferOverFlow:
        DS8 1
//   21 
//   22 
//   23 /*
//   24 * Buffer_Init
//   25 *   USB 缓冲区初始化函数
//   26 *
//   27 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 void Buffer_Init(UINT8* pu8BufferPointer ,UINT8 u8MaxSize)
//   29 {
//   30     /* Buffer Initialization */
//   31     OUT_EndAddress=pu8BufferPointer+u8MaxSize-1;
Buffer_Init:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R2,R1,R0
        SUBS     R2,R2,#+1
        LDR.N    R3,??DataTable1
        STR      R2,[R3, #+0]
//   32     OUT_StartAddress=pu8BufferPointer;
        LDR.N    R2,??DataTable1_1
        STR      R0,[R2, #+0]
//   33     gu8BufferMaxSize=u8MaxSize;
        LDR.N    R2,??DataTable1_2
        STRB     R1,[R2, #+0]
//   34     OUT_UsbPointer=pu8BufferPointer;
        LDR.N    R1,??DataTable1_3
        STR      R0,[R1, #+0]
//   35     OUT_SciPointer=pu8BufferPointer;
        LDR.N    R1,??DataTable1_4
        STR      R0,[R1, #+0]
//   36     gu8BufferOverFlow=0;
        LDR.N    R0,??DataTable1_5
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   37 }
        BX       LR               ;; return
//   38 
//   39 
//   40 /********************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 UINT8 Buffer_Request(UINT8* pu8DataPointer ,UINT16 u8RequestSize)
//   42 {
Buffer_Request:
        PUSH     {R4}
//   43     UINT8 u8FreeSpace; 
//   44     // Check for OverFlow
//   45   
//   46     if(gu8BufferOverFlow)
        LDR.N    R2,??DataTable1_5
        LDRB     R2,[R2, #+0]
        CMP      R2,#+0
        BEQ.N    ??Buffer_Request_0
//   47         return(NOT_ENOUGH_SPACE);
        MOVS     R0,#+1
        B.N      ??Buffer_Request_1
//   48     
//   49     
//   50     // Calculate Free Space
//   51     if(OUT_UsbPointer < OUT_SciPointer)
??Buffer_Request_0:
        LDR.N    R2,??DataTable1_3
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable1_4
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BCS.N    ??Buffer_Request_2
//   52         u8FreeSpace=(UINT8)(OUT_SciPointer-OUT_UsbPointer);
        LDR.N    R2,??DataTable1_4
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable1_3
        LDR      R3,[R3, #+0]
        SUBS     R2,R2,R3
        B.N      ??Buffer_Request_3
//   53     
//   54     else
//   55         u8FreeSpace=gu8BufferMaxSize-(OUT_UsbPointer-OUT_SciPointer);
??Buffer_Request_2:
        LDR.N    R2,??DataTable1_2
        LDRB     R2,[R2, #+0]
        LDR.N    R3,??DataTable1_3
        LDR      R3,[R3, #+0]
        LDR.N    R4,??DataTable1_4
        LDR      R4,[R4, #+0]
        SUBS     R3,R3,R4
        SUBS     R2,R2,R3
//   56     
//   57     // Validate requested size
//   58     if(u8FreeSpace<u8RequestSize)
??Buffer_Request_3:
        MOVS     R3,R2
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R3,R1
        BCS.N    ??Buffer_Request_4
//   59         return(NOT_ENOUGH_SPACE);
        MOVS     R0,#+1
        B.N      ??Buffer_Request_1
//   60       
//   61     if(u8FreeSpace==u8RequestSize)
??Buffer_Request_4:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R2,R1
        BNE.N    ??Buffer_Request_5
//   62         gu8BufferOverFlow=1; 
        LDR.N    R2,??DataTable1_5
        MOVS     R3,#+1
        STRB     R3,[R2, #+0]
        B.N      ??Buffer_Request_5
//   63     // Buffer Copy
//   64     while(u8RequestSize--)
//   65     {
//   66         *OUT_UsbPointer=*pu8DataPointer;
??Buffer_Request_6:
        LDR.N    R2,??DataTable1_3
        LDR      R2,[R2, #+0]
        LDRB     R3,[R0, #+0]
        STRB     R3,[R2, #+0]
//   67         OUT_UsbPointer++;
        LDR.N    R2,??DataTable1_3
        LDR      R2,[R2, #+0]
        ADDS     R2,R2,#+1
        LDR.N    R3,??DataTable1_3
        STR      R2,[R3, #+0]
//   68         pu8DataPointer++;
        ADDS     R0,R0,#+1
//   69         if(OUT_UsbPointer > OUT_EndAddress)
        LDR.N    R2,??DataTable1
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable1_3
        LDR      R3,[R3, #+0]
        CMP      R2,R3
        BCS.N    ??Buffer_Request_5
//   70         {
//   71             OUT_UsbPointer=OUT_StartAddress;
        LDR.N    R2,??DataTable1_3
        LDR.N    R3,??DataTable1_1
        LDR      R3,[R3, #+0]
        STR      R3,[R2, #+0]
//   72         }
//   73     }
??Buffer_Request_5:
        MOVS     R2,R1
        SUBS     R1,R2,#+1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        CMP      R2,#+0
        BNE.N    ??Buffer_Request_6
//   74     return(OK);
        MOVS     R0,#+0
??Buffer_Request_1:
        POP      {R4}
        BX       LR               ;; return
//   75 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     OUT_EndAddress

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     OUT_StartAddress

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     gu8BufferMaxSize

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     OUT_UsbPointer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_4:
        DC32     OUT_SciPointer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_5:
        DC32     gu8BufferOverFlow

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
//  18 bytes in section .bss
// 202 bytes in section .text
// 
// 202 bytes of CODE memory
//  18 bytes of DATA memory
//
//Errors: none
//Warnings: none
