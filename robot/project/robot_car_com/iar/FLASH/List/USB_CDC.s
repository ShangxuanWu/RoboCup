///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:51 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\USB\USB_CDC.c             /
//    Command line =  "F:\robot _init\robot\lib\LPLD\USB\USB_CDC.c" -D IAR    /
//                    -D LPLD_K60 -lCN "F:\robot                              /
//                    _init\robot\project\robot_car_com\iar\FLASH\List\" -lB  /
//                    "F:\robot _init\robot\project\robot_car_com\iar\FLASH\L /
//                    ist\" -o "F:\robot _init\robot\project\robot_car_com\ia /
//                    r\FLASH\Obj\" --no_cse --no_unroll --no_inline          /
//                    --no_code_motion --no_tbaa --no_clustering              /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config "D:\IAR     /
//                    Systems\Embedded Workbench                              /
//                    6.4\arm\INC\c\DLib_Config_Normal.h" -I "F:\robot        /
//                    _init\robot\project\robot_car_com\iar\..\app\" -I       /
//                    "F:\robot _init\robot\project\robot_car_com\iar\..\..\. /
//                    .\lib\common\" -I "F:\robot                             /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\cpu\ /
//                    " -I "F:\robot _init\robot\project\robot_car_com\iar\.. /
//                    \..\..\lib\cpu\headers\" -I "F:\robot                   /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\adc16\" -I "F:\robot _init\robot\project\robot_car_ /
//                    com\iar\..\..\..\lib\drivers\enet\" -I "F:\robot        /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\lptmr\" -I "F:\robot _init\robot\project\robot_car_ /
//                    com\iar\..\..\..\lib\drivers\mcg\" -I "F:\robot         /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\pmc\" -I "F:\robot _init\robot\project\robot_car_co /
//                    m\iar\..\..\..\lib\drivers\rtc\" -I "F:\robot           /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\uart\" -I "F:\robot _init\robot\project\robot_car_c /
//                    om\iar\..\..\..\lib\drivers\wdog\" -I "F:\robot         /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\plat /
//                    forms\" -I "F:\robot _init\robot\project\robot_car_com\ /
//                    iar\..\..\..\lib\LPLD\" -I "F:\robot                    /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\LPLD /
//                    \FatFs\" -I "F:\robot _init\robot\project\robot_car_com /
//                    \iar\..\..\..\lib\LPLD\USB\" -I "F:\robot               /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\iar_ /
//                    config_files\" -Ol                                      /
//    List file    =  F:\robot _init\robot\project\robot_car_com\iar\FLASH\Li /
//                    st\USB_CDC.s                                            /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME USB_CDC

        #define SHT_PROGBITS 0x1

        EXTERN Buffer_Init
        EXTERN EP_IN_Transfer
        EXTERN EP_OUT_Transfer
        EXTERN Setup_Pkt
        EXTERN gu8Interface
        EXTERN gu8USB_Flags

        PUBLIC CDC_Init
        PUBLIC CDC_InterfaceReq_Handler
        PUBLIC CDC_OUT_Data
        PUBLIC LWordSwap
        PUBLIC LineCoding

// F:\robot _init\robot\lib\LPLD\USB\USB_CDC.c
//    1 /*
//    2  *
//    3  * 文件名: USB_CDC.c
//    4  * 用途: 在该文件中定义了USB CDC类的应用函数
//    5  *
//    6  * 说明:本页代码基于Freescale官方示例代码修改，源代码文件为 USB_CDC.c
//    7  *    在本文件中将CDC_engine函数删除
//    8  *    修改了CDC_InterfaceReq_Handler函数中SET_LINE_CODING和SET_CONTROL_LINE_STATE处理过程
//    9  */
//   10 #include"USB_CDC.h"
//   11 /* CDC Global Structures */

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   12 CDC_Line_Coding LineCoding;
LineCoding:
        DS8 8

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   13 UINT8 CDC_OUT_Data[CDC_BUFFER_SIZE];
CDC_OUT_Data:
        DS8 128
//   14 
//   15 /* USB Variables & Flags */
//   16 extern UINT8 gu8USB_Flags; 
//   17 extern UINT8 gu8USB_State;              
//   18 extern tUSB_Setup *Setup_Pkt;
//   19 extern UINT8 gu8EP2_IN_ODD_Buffer[];
//   20 extern UINT8 gu8EP3_OUT_ODD_Buffer[];
//   21 
//   22 
//   23 extern tBDT tBDTtable[];
//   24 extern UINT8 gu8Interface;
//   25 
//   26 
//   27 /*
//   28 * LPLD_CDC_Init
//   29 *   USB CDC类初始化函数
//   30 *    设置CDC类的状态
//   31 *    设置CDC类的通讯参数
//   32 *    初始化CDC类的数据缓冲
//   33 */
//   34 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   35 void CDC_Init(void)
//   36 {
CDC_Init:
        PUSH     {R7,LR}
//   37   /*初始化CDC类通讯的参数*/
//   38   LineCoding.DTERate=LWordSwap(120);
        MOVS     R0,#+120
        BL       LWordSwap
        LDR.N    R1,??DataTable1
        STR      R0,[R1, #+0]
//   39   LineCoding.CharFormat=0;
        LDR.N    R0,??DataTable1
        MOVS     R1,#+0
        STRB     R1,[R0, #+4]
//   40   LineCoding.ParityType=0;
        LDR.N    R0,??DataTable1
        MOVS     R1,#+0
        STRB     R1,[R0, #+5]
//   41   LineCoding.Databits=0x08;
        LDR.N    R0,??DataTable1
        MOVS     R1,#+8
        STRB     R1,[R0, #+6]
//   42 
//   43   /*初始化CDC类数据缓冲区*/
//   44   Buffer_Init(CDC_OUT_Data,CDC_BUFFER_SIZE);
        MOVS     R1,#+128
        LDR.N    R0,??DataTable1_1
        BL       Buffer_Init
//   45 }
        POP      {R0,PC}          ;; return
//   46 
//   47 /*
//   48 * CDC_InterfaceReq_Handler
//   49 *   设置 CDC类接口函数
//   50 *     将该函数添加到USB setup中断服务函数中去处理
//   51 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   52 UINT8 CDC_InterfaceReq_Handler(void)
//   53 {
CDC_InterfaceReq_Handler:
        PUSH     {R3-R5,LR}
//   54     UINT8 u8State=uSETUP;
        MOVS     R4,#+0
//   55     
//   56     switch(Setup_Pkt->bRequest)
        LDR.N    R0,??DataTable1_2
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+1]
        CMP      R0,#+10
        BEQ.N    ??CDC_InterfaceReq_Handler_0
        CMP      R0,#+32
        BEQ.N    ??CDC_InterfaceReq_Handler_1
        CMP      R0,#+33
        BEQ.N    ??CDC_InterfaceReq_Handler_2
        CMP      R0,#+34
        BEQ.N    ??CDC_InterfaceReq_Handler_3
        CMP      R0,#+170
        BEQ.N    ??CDC_InterfaceReq_Handler_4
        B.N      ??CDC_InterfaceReq_Handler_5
//   57     {        
//   58         case GET_INTERFACE:
//   59             EP_IN_Transfer(EP0,&gu8Interface,1);
??CDC_InterfaceReq_Handler_0:
        MOVS     R2,#+1
        LDR.N    R1,??DataTable1_3
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//   60             break;
        B.N      ??CDC_InterfaceReq_Handler_6
//   61 
//   62         case GET_LINE_CODING:
//   63             EP_IN_Transfer(EP0,(UINT8*)&LineCoding,7);
??CDC_InterfaceReq_Handler_2:
        MOVS     R2,#+7
        LDR.N    R1,??DataTable1
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//   64             break;
        B.N      ??CDC_InterfaceReq_Handler_6
//   65 
//   66         case SET_LINE_CODING:
//   67             u8State=uDATA;
??CDC_InterfaceReq_Handler_1:
        MOVS     R4,#+1
//   68             if(FLAG_CHK(EP0,gu8USB_Flags))//
        LDR.N    R0,??DataTable1_4
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??CDC_InterfaceReq_Handler_7
//   69             {
//   70               FLAG_CLR(EP0,gu8USB_Flags);
        LDR.N    R0,??DataTable1_4
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xFE
        LDR.N    R1,??DataTable1_4
        STRB     R0,[R1, #+0]
//   71               (void)EP_OUT_Transfer(EP0,(UINT8*)&LineCoding);
        LDR.N    R1,??DataTable1
        MOVS     R0,#+0
        BL       EP_OUT_Transfer
        MOVS     R5,R0
//   72               EP_IN_Transfer(EP0,0,0);       
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//   73             }//
//   74             break;
??CDC_InterfaceReq_Handler_7:
        B.N      ??CDC_InterfaceReq_Handler_6
//   75 
//   76         case SET_CONTROL_LINE_STATE:
//   77             u8State=uSETUP;
??CDC_InterfaceReq_Handler_3:
        MOVS     R4,#+0
//   78             EP_IN_Transfer(EP0,0,0);//
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//   79             break;
        B.N      ??CDC_InterfaceReq_Handler_6
//   80 
//   81         case LOADER_MODE:
//   82             Buffer_Init(CDC_OUT_Data,CDC_BUFFER_SIZE);
??CDC_InterfaceReq_Handler_4:
        MOVS     R1,#+128
        LDR.N    R0,??DataTable1_1
        BL       Buffer_Init
//   83             FLAG_SET(LOADER,gu8USB_Flags);
        LDR.N    R0,??DataTable1_4
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable1_4
        STRB     R0,[R1, #+0]
//   84             CDC_OUT_Data[0]=0xFF;
        LDR.N    R0,??DataTable1_1
        MOVS     R1,#+255
        STRB     R1,[R0, #+0]
//   85             break;
        B.N      ??CDC_InterfaceReq_Handler_6
//   86        default:break;
//   87     }
//   88     return(u8State);
??CDC_InterfaceReq_Handler_5:
??CDC_InterfaceReq_Handler_6:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
//   89 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     LineCoding

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     CDC_OUT_Data

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     Setup_Pkt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     gu8Interface

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_4:
        DC32     gu8USB_Flags
//   90 
//   91 
//   92 /**********************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   93 UINT32 LWordSwap(UINT32 u32DataSwap)
//   94 {
//   95     UINT32 u32Temp;
//   96     u32Temp= (u32DataSwap & 0xFF000000) >> 24;
LWordSwap:
        LSRS     R1,R0,#+24
//   97     u32Temp+=(u32DataSwap & 0xFF0000)   >> 8;
        LSRS     R2,R0,#+8
        ANDS     R2,R2,#0xFF00
        ADDS     R1,R2,R1
//   98     u32Temp+=(u32DataSwap & 0xFF00)     << 8;
        ANDS     R2,R0,#0xFF00
        ADDS     R1,R1,R2, LSL #+8
//   99     u32Temp+=(u32DataSwap & 0xFF)       << 24;
        ADDS     R1,R1,R0, LSL #+24
//  100     return(u32Temp);    
        MOVS     R0,R1
        BX       LR               ;; return
//  101 }

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
// 136 bytes in section .bss
// 234 bytes in section .text
// 
// 234 bytes of CODE memory
// 136 bytes of DATA memory
//
//Errors: none
//Warnings: none
