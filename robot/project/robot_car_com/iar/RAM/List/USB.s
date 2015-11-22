///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:05 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\LPLD\USB\USB.c      /
//    Command line =  D:\中国机器人大赛\robot_project\lib\LPLD\USB\USB.c -D   /
//                    IAR -D LPLD_K60 -lCN D:\中国机器人大赛\robot_project\pr /
//                    oject\LPLD_Template\iar\RAM\List\ -lB                   /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\ -o D:\中国机器人大赛\robot_project\project /
//                    \LPLD_Template\iar\RAM\Obj\ --no_cse --no_unroll        /
//                    --no_inline --no_code_motion --no_tbaa --no_clustering  /
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
//                    ar\RAM\List\USB.s                                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME USB

        #define SHT_PROGBITS 0x1

        EXTERN CDC_InterfaceReq_Handler

        PUBLIC BufferPointer
        PUBLIC Configuration_Descriptor
        PUBLIC Device_Descriptor
        PUBLIC EP_IN_Transfer
        PUBLIC EP_OUT_Transfer
        PUBLIC Setup_Pkt
        PUBLIC String_Descriptor0
        PUBLIC String_Descriptor1
        PUBLIC String_Descriptor2
        PUBLIC String_Descriptor3
        PUBLIC String_Table
        PUBLIC USB_EP0_IN_Handler
        PUBLIC USB_EP0_OUT_Handler
        PUBLIC USB_EP0_Stall
        PUBLIC USB_EP_OUT_SizeCheck
        PUBLIC USB_Endpoint_Setup_Handler
        PUBLIC USB_Handler
        PUBLIC USB_Protocol_Handler
        PUBLIC USB_Reset_Handler
        PUBLIC USB_Rev_SetIsr
        PUBLIC USB_Set_Interface
        PUBLIC USB_Setup_Handler
        PUBLIC USB_Stall_Handler
        PUBLIC USB_StdReq_Handler
        PUBLIC cEP_Size
        PUBLIC gu8Dummy
        PUBLIC gu8EP0_IN_EVEN_Buffer
        PUBLIC gu8EP0_IN_ODD_Buffer
        PUBLIC gu8EP0_OUT_EVEN_Buffer
        PUBLIC gu8EP0_OUT_ODD_Buffer
        PUBLIC gu8EP1_IN_EVEN_Buffer
        PUBLIC gu8EP1_IN_ODD_Buffer
        PUBLIC gu8EP1_OUT_EVEN_Buffer
        PUBLIC gu8EP1_OUT_ODD_Buffer
        PUBLIC gu8EP2_IN_EVEN_Buffer
        PUBLIC gu8EP2_IN_ODD_Buffer
        PUBLIC gu8EP2_OUT_EVEN_Buffer
        PUBLIC gu8EP2_OUT_ODD_Buffer
        PUBLIC gu8EP3_IN_EVEN_Buffer
        PUBLIC gu8EP3_IN_ODD_Buffer
        PUBLIC gu8EP3_OUT_EVEN_Buffer
        PUBLIC gu8EP3_OUT_ODD_Buffer
        PUBLIC gu8HALT_EP
        PUBLIC gu8IN_Counter
        PUBLIC gu8Interface
        PUBLIC gu8Status
        PUBLIC gu8USBClearFlags
        PUBLIC gu8USB_Flags
        PUBLIC gu8USB_State
        PUBLIC gu8USB_Toogle_flags
        PUBLIC pu8IN_DataPointer
        PUBLIC tBDTtable
        PUBLIC usb_rev_data_isr

// D:\中国机器人大赛\robot_project\lib\LPLD\USB\USB.c
//    1 /*
//    2  * 文件名: USB.c
//    3  * 用途: 定义USB底层协议函数和变量
//    4  * 最后修改日期: 20121204
//    5  *
//    6  *
//    7  * 说明:本页代码基于Freescale官方示例代码修改，源代码文件为 USB.c
//    8  *    在本文件中将USB_Init函数移除
//    9  *    将USB_EP_OUT_SizeCheck函数中的获得数据长度部分进行了修改
//   10  *    将USB_Reset_Handler函数中的gu8USB_Toogle_flags变量修改为0xFE，原程序此处有BUG致使端点少接收一个字节
//   11  */
//   12 #include "USB.h"
//   13 #include "USB_Desc.h"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
// __absolute unsigned char const Device_Descriptor[18]
Device_Descriptor:
        DATA
        DC8 18, 1, 0, 2, 2, 0, 0, 64, 162, 21, 15, 165, 0, 2, 1, 2, 3, 1, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
// __absolute unsigned char const String_Descriptor0[4]
String_Descriptor0:
        DATA
        DC8 4, 3, 9, 4

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
// __absolute unsigned char const String_Descriptor1[20]
String_Descriptor1:
        DATA
        DC8 20, 3, 76, 0, 97, 0, 112, 0, 108, 0, 101, 0, 110, 0, 100, 0, 101, 0
        DC8 110, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
// __absolute unsigned char const String_Descriptor2[18]
String_Descriptor2:
        DATA
        DC8 18, 3, 85, 0, 83, 0, 66, 0, 45, 0, 85, 0, 65, 0, 82, 0, 84, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
// __absolute unsigned char const String_Descriptor3[18]
String_Descriptor3:
        DATA
        DC8 18, 3, 84, 0, 69, 0, 83, 0, 84, 0, 95, 0, 49, 0, 46, 0, 49, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
// __absolute unsigned char const Configuration_Descriptor[67]
Configuration_Descriptor:
        DATA
        DC8 9, 2, 67, 0, 2, 1, 0, 192, 50, 9, 4, 0, 0, 1, 2, 2, 1, 1, 5, 36, 0
        DC8 16, 1, 5, 36, 1, 0, 1, 4, 36, 2, 0, 5, 36, 6, 0, 1, 7, 5, 129, 3
        DC8 64, 0, 2, 9, 4, 1, 0, 2, 10, 0, 0, 1, 7, 5, 130, 2, 64, 0, 0, 7, 5
        DC8 3, 2, 64, 0, 0, 0
//   14 
//   15 //设置USB 缓冲区对齐
//   16 //USB缓冲区必须是512字节对齐
//   17 #pragma data_alignment=512
//   18 

        SECTION `.bss`:DATA:REORDER:NOROOT(9)
//   19 tBDT tBDTtable[16]; //为16个缓冲区分配缓冲区描述符
tBDTtable:
        DS8 128
//   20 
//   21 //定义端点0缓冲区

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   22 UINT8 gu8EP0_OUT_ODD_Buffer[EP0_SIZE];
gu8EP0_OUT_ODD_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   23 UINT8 gu8EP0_OUT_EVEN_Buffer[EP0_SIZE];
gu8EP0_OUT_EVEN_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   24 UINT8 gu8EP0_IN_ODD_Buffer[EP0_SIZE];
gu8EP0_IN_ODD_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   25 UINT8 gu8EP0_IN_EVEN_Buffer[EP0_SIZE];
gu8EP0_IN_EVEN_Buffer:
        DS8 64
//   26 //定义端点1缓冲区

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27 UINT8 gu8EP1_OUT_ODD_Buffer[EP1_SIZE];
gu8EP1_OUT_ODD_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   28 UINT8 gu8EP1_OUT_EVEN_Buffer[EP1_SIZE];
gu8EP1_OUT_EVEN_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   29 UINT8 gu8EP1_IN_ODD_Buffer[EP1_SIZE];
gu8EP1_IN_ODD_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   30 UINT8 gu8EP1_IN_EVEN_Buffer[EP1_SIZE];
gu8EP1_IN_EVEN_Buffer:
        DS8 64
//   31 //定义端点2缓冲区

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   32 UINT8 gu8EP2_OUT_ODD_Buffer[EP2_SIZE];
gu8EP2_OUT_ODD_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   33 UINT8 gu8EP2_OUT_EVEN_Buffer[EP2_SIZE];
gu8EP2_OUT_EVEN_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   34 UINT8 gu8EP2_IN_ODD_Buffer[EP2_SIZE];
gu8EP2_IN_ODD_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   35 UINT8 gu8EP2_IN_EVEN_Buffer[EP2_SIZE];
gu8EP2_IN_EVEN_Buffer:
        DS8 64
//   36 //定义端点3缓冲区

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   37 UINT8 gu8EP3_OUT_ODD_Buffer[EP3_SIZE];
gu8EP3_OUT_ODD_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   38 UINT8 gu8EP3_OUT_EVEN_Buffer[EP3_SIZE];
gu8EP3_OUT_EVEN_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   39 UINT8 gu8EP3_IN_ODD_Buffer[EP3_SIZE];
gu8EP3_IN_ODD_Buffer:
        DS8 64

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   40 UINT8 gu8EP3_IN_EVEN_Buffer[EP3_SIZE];
gu8EP3_IN_EVEN_Buffer:
        DS8 64
//   41 //定义端点缓冲区指针

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   42 UINT8 *BufferPointer[]=
BufferPointer:
        DATA
        DC32 gu8EP0_OUT_ODD_Buffer, gu8EP0_OUT_EVEN_Buffer
        DC32 gu8EP0_IN_ODD_Buffer, gu8EP0_IN_EVEN_Buffer, gu8EP1_OUT_ODD_Buffer
        DC32 gu8EP1_OUT_EVEN_Buffer, gu8EP1_IN_ODD_Buffer
        DC32 gu8EP1_IN_EVEN_Buffer, gu8EP2_OUT_ODD_Buffer
        DC32 gu8EP2_OUT_EVEN_Buffer, gu8EP2_IN_ODD_Buffer
        DC32 gu8EP2_IN_EVEN_Buffer, gu8EP3_OUT_ODD_Buffer
        DC32 gu8EP3_OUT_EVEN_Buffer, gu8EP3_IN_ODD_Buffer
        DC32 gu8EP3_IN_EVEN_Buffer
//   43 {
//   44     gu8EP0_OUT_ODD_Buffer,
//   45     gu8EP0_OUT_EVEN_Buffer,
//   46     gu8EP0_IN_ODD_Buffer,
//   47     gu8EP0_IN_EVEN_Buffer,
//   48     gu8EP1_OUT_ODD_Buffer,
//   49     gu8EP1_OUT_EVEN_Buffer,
//   50     gu8EP1_IN_ODD_Buffer,
//   51     gu8EP1_IN_EVEN_Buffer,
//   52     gu8EP2_OUT_ODD_Buffer,
//   53     gu8EP2_OUT_EVEN_Buffer,
//   54     gu8EP2_IN_ODD_Buffer,
//   55     gu8EP2_IN_EVEN_Buffer,
//   56     gu8EP3_OUT_ODD_Buffer,
//   57     gu8EP3_OUT_EVEN_Buffer,
//   58     gu8EP3_IN_ODD_Buffer,
//   59     gu8EP3_IN_EVEN_Buffer
//   60 };
//   61 //定义端点缓冲区长度

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   62 const UINT8 cEP_Size[]=
cEP_Size:
        DATA
        DC8 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64
//   63 {
//   64     EP0_SIZE,    
//   65     EP0_SIZE,    
//   66     EP0_SIZE,    
//   67     EP0_SIZE,    
//   68     EP1_SIZE,    
//   69     EP1_SIZE,    
//   70     EP1_SIZE,    
//   71     EP1_SIZE,    
//   72     EP2_SIZE,    
//   73     EP2_SIZE,    
//   74     EP2_SIZE,    
//   75     EP2_SIZE,    
//   76     EP3_SIZE,
//   77     EP3_SIZE,
//   78     EP3_SIZE,
//   79     EP3_SIZE
//   80 };
//   81 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   82 const UINT8* String_Table[4]=
String_Table:
        DATA
        DC32 String_Descriptor0, String_Descriptor1, String_Descriptor2
        DC32 String_Descriptor3
//   83 {
//   84     String_Descriptor0,
//   85     String_Descriptor1,
//   86     String_Descriptor2,
//   87     String_Descriptor3
//   88 };
//   89 
//   90 
//   91 /* Global Variables for USB Handling */

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   92 UINT8 gu8USB_Flags;        //USB接收完成标志位
gu8USB_Flags:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   93 UINT8 gu8USBClearFlags;
gu8USBClearFlags:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   94 UINT8 *pu8IN_DataPointer; //USB输入缓冲区指针
pu8IN_DataPointer:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   95 UINT8 gu8IN_Counter;
gu8IN_Counter:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   96 UINT8 gu8USB_Toogle_flags;//USB数据翻转标志位
gu8USB_Toogle_flags:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   97 UINT8 gu8Dummy;
gu8Dummy:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//   98 UINT16 gu8Status;
gu8Status:
        DS8 2

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   99 UINT8 gu8Interface;       //USB接口标志位
gu8Interface:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  100 UINT8 gu8HALT_EP;         //USB端点停止标志位
gu8HALT_EP:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  101 UINT8 gu8USB_State;       //USB进程标志位
gu8USB_State:
        DS8 1
//  102 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  103 tUSB_Setup *Setup_Pkt;//定义setup数据包指针
Setup_Pkt:
        DS8 4
//  104  

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  105 USB_REV_CALLBACK usb_rev_data_isr;
usb_rev_data_isr:
        DS8 4
//  106 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  107 void USB_Rev_SetIsr(USB_REV_CALLBACK isr)
//  108 {
//  109   usb_rev_data_isr = isr; 
USB_Rev_SetIsr:
        LDR.W    R1,??DataTable14
        STR      R0,[R1, #+0]
//  110 }
        BX       LR               ;; return
//  111 
//  112 /*
//  113 * EP_IN_Transfer
//  114 *   端点IN传送，在不同USB模式下IN的含义不同
//  115 *     在USB主机模式下（USB host）  IN表示  USB Host接收 USB Device的数据包
//  116 *     在USB设备模式下（USB Device）IN表示  USB Host向 USB Device发送数据包
//  117 *   当前在USB Device模式下，该函数的作用是Device设备发送数据包
//  118 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  119 void EP_IN_Transfer(UINT8 u8EP,UINT8 *pu8DataPointer,UINT8 u8DataSize)
//  120 {
EP_IN_Transfer:
        PUSH     {R4,R5}
//  121   UINT8 *pu8EPBuffer;
//  122   UINT8 u8EPSize;     //端点的数据长度
//  123   UINT16 u16Lenght=0;    
        MOVS     R5,#+0
//  124   UINT8 u8EndPointFlag;    
//  125   
//  126   /*调整当前缓冲区的位置*/
//  127   u8EndPointFlag=u8EP;
        MOVS     R3,R0
//  128   if(u8EP)   //如果不是端点0,
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??EP_IN_Transfer_0
//  129     u8EP=(UINT8)(u8EP<<2);
        LSLS     R0,R0,#+2
//  130   u8EP+=2; //EP值加2
??EP_IN_Transfer_0:
        ADDS     R0,R0,#+2
//  131   
//  132   pu8EPBuffer=BufferPointer[u8EP];   //将新EP的BUFFER地址给pu8EPBuffer
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R4,??DataTable14_1
        LDR      R4,[R4, R0, LSL #+2]
//  133   
//  134   if(FLAG_CHK(fIN,gu8USBClearFlags)) //如果gu8USBClearFlags = 1
        LDR.W    R5,??DataTable14_2
        LDRB     R5,[R5, #+0]
        LSLS     R5,R5,#+31
        BPL.N    ??EP_IN_Transfer_1
//  135   {
//  136       pu8IN_DataPointer = pu8DataPointer; //将用户数据存储区的首地址给pu8IN_DataPointer
        LDR.W    R5,??DataTable14_3
        STR      R1,[R5, #+0]
//  137       gu8IN_Counter = u8DataSize;         //将用户数据长度给gu8IN_Counter
        LDR.W    R1,??DataTable14_4
        STRB     R2,[R1, #+0]
//  138 
//  139       u16Lenght=(Setup_Pkt->wLength_h<<8)+Setup_Pkt->wLength_l ;//将setup数据的长度给u16Lenght
        LDR.W    R1,??DataTable14_5
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+7]
        LSLS     R1,R1,#+8
        LDR.W    R5,??DataTable14_5
        LDR      R5,[R5, #+0]
        LDRB     R5,[R5, #+6]
        ADDS     R5,R1,R5
//  140       if((u16Lenght < u8DataSize) && (u8EP==2)) //如果所发送的数据长度大于setup所设定的长度 同时 端点值 == 2
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        CMP      R5,R2
        BCS.N    ??EP_IN_Transfer_1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+2
        BNE.N    ??EP_IN_Transfer_1
//  141       {
//  142           gu8IN_Counter=Setup_Pkt->wLength_l; //只发送setup中的低8位长度
        LDR.W    R1,??DataTable14_5
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+6]
        LDR.W    R2,??DataTable14_4
        STRB     R1,[R2, #+0]
//  143       }
//  144   }
//  145   /*检查发送长度*/
//  146   if(gu8IN_Counter > cEP_Size[u8EP]) //如果发送数据包的长度 大于32字节时
??EP_IN_Transfer_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R1,??DataTable14_6
        LDRB     R1,[R0, R1]
        LDR.W    R2,??DataTable14_4
        LDRB     R2,[R2, #+0]
        CMP      R1,R2
        BCS.N    ??EP_IN_Transfer_2
//  147   {
//  148       u8EPSize = cEP_Size[u8EP];     //将此时端点的长度限制在端点的默认长度
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R1,??DataTable14_6
        LDRB     R1,[R0, R1]
//  149       gu8IN_Counter-=cEP_Size[u8EP]; //将数据包的长度减少EP_Size
        LDR.W    R2,??DataTable14_4
        LDRB     R2,[R2, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R5,??DataTable14_6
        LDRB     R5,[R0, R5]
        SUBS     R2,R2,R5
        LDR.W    R5,??DataTable14_4
        STRB     R2,[R5, #+0]
//  150       FLAG_CLR(fIN,gu8USBClearFlags);//将gu8USBClearFlags清零
        LDR.W    R2,??DataTable14_2
        LDRB     R2,[R2, #+0]
        ANDS     R2,R2,#0xFE
        LDR.W    R5,??DataTable14_2
        STRB     R2,[R5, #+0]
        B.N      ??EP_IN_Transfer_3
//  151   }
//  152   else
//  153   { 
//  154       u8EPSize = gu8IN_Counter;      //如果小于
??EP_IN_Transfer_2:
        LDR.W    R1,??DataTable14_4
        LDRB     R1,[R1, #+0]
//  155       gu8IN_Counter=0;            
        LDR.W    R2,??DataTable14_4
        MOVS     R5,#+0
        STRB     R5,[R2, #+0]
//  156       FLAG_SET(fIN,gu8USBClearFlags);//将gu8USBClearFlags置一
        LDR.W    R2,??DataTable14_2
        LDRB     R2,[R2, #+0]
        ORRS     R2,R2,#0x1
        LDR.W    R5,??DataTable14_2
        STRB     R2,[R5, #+0]
//  157   }
//  158 
//  159   /*将用户缓冲的区的值复制到EP 缓冲区中准备发送*/
//  160   tBDTtable[u8EP].Cnt=(u8EPSize);    //复制所要发送的数据长度
??EP_IN_Transfer_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R2,??DataTable14_7
        ADDS     R2,R2,R0, LSL #+3
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        STRH     R1,[R2, #+2]
        B.N      ??EP_IN_Transfer_4
//  161   
//  162   while(u8EPSize--)
//  163        *pu8EPBuffer++=*pu8IN_DataPointer++; //将用户的数据赋值给EP存储区
??EP_IN_Transfer_5:
        LDR.W    R2,??DataTable14_3
        LDR      R2,[R2, #+0]
        LDRB     R2,[R2, #+0]
        STRB     R2,[R4, #+0]
        LDR.W    R2,??DataTable14_3
        LDR      R2,[R2, #+0]
        ADDS     R2,R2,#+1
        LDR.W    R5,??DataTable14_3
        STR      R2,[R5, #+0]
        ADDS     R4,R4,#+1
??EP_IN_Transfer_4:
        MOVS     R2,R1
        SUBS     R1,R2,#+1
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??EP_IN_Transfer_5
//  164                                                            
//  165   if(FLAG_CHK(u8EndPointFlag,gu8USB_Toogle_flags)) //如果相应端点的gu8USB_Toogle_flags == 1
        LDR.W    R1,??DataTable14_8
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R2,R2,R3
        TST      R1,R2
        BEQ.N    ??EP_IN_Transfer_6
//  166   {
//  167       tBDTtable[u8EP].Stat._byte= kUDATA0;         
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R1,??DataTable14_7
        MOVS     R2,#+136
        STRB     R2,[R1, R0, LSL #+3]
//  168       FLAG_CLR(u8EndPointFlag,gu8USB_Toogle_flags);//清零相应端点的gu8USB_Toogle_flags
        LDR.W    R0,??DataTable14_8
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+1
        LSLS     R1,R1,R3
        BICS     R0,R0,R1
        LDR.W    R1,??DataTable14_8
        STRB     R0,[R1, #+0]
        B.N      ??EP_IN_Transfer_7
//  169   } 
//  170   else
//  171   {
//  172       tBDTtable[u8EP].Stat._byte= kUDATA1;          
??EP_IN_Transfer_6:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R1,??DataTable14_7
        MOVS     R2,#+200
        STRB     R2,[R1, R0, LSL #+3]
//  173       FLAG_SET(u8EndPointFlag,gu8USB_Toogle_flags);//置位gu8USB_Toogle_flags
        LDR.W    R0,??DataTable14_8
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+1
        LSLS     R1,R1,R3
        ORRS     R0,R1,R0
        LDR.W    R1,??DataTable14_8
        STRB     R0,[R1, #+0]
//  174   }
//  175 }
??EP_IN_Transfer_7:
        POP      {R4,R5}
        BX       LR               ;; return
//  176 
//  177 /*
//  178 * EP_OUT_Transfer
//  179 *   端点OUT传送，在不同USB模式下OUT的含义不同
//  180 *     在USB主机模式下（USB host）  OUT表示  USB Host向 USB Device发送数据包
//  181 *     在USB设备模式下（USB Device）OUT表示  USB Host从 USB Device接收数据包
//  182 *   当前在USB Device模式下，该函数的作用是Device设备接收数据包
//  183 *   返回值，返回接收到的数据的长度
//  184 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  185 UINT8 EP_OUT_Transfer(UINT8 u8EP,UINT8 *pu8DataPointer)
//  186 {
EP_OUT_Transfer:
        PUSH     {R4}
//  187     UINT8 *pu8EPBuffer;
//  188     UINT8 u8EPSize; 
//  189     /* 调整缓冲区的位置 */
//  190     u8EP++;
        ADDS     R0,R0,#+1
//  191     /* 分配合适的EP缓冲，EP0是控制点，EP1为输入中断点，EP2是输入BULK点 */
//  192     pu8EPBuffer=BufferPointer[u8EP];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R2,??DataTable14_1
        LDR      R2,[R2, R0, LSL #+2]
//  193     
//  194     u8EPSize=tBDTtable[u8EP].Cnt;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R3,??DataTable14_7
        ADDS     R0,R3,R0, LSL #+3
        LDRH     R3,[R0, #+2]
//  195     u8EP=u8EPSize;
        MOVS     R0,R3
        B.N      ??EP_OUT_Transfer_0
//  196     /* 将EP缓冲的数据复制给用户区 */
//  197     while(u8EPSize--)
//  198       *pu8DataPointer++=*pu8EPBuffer++;
??EP_OUT_Transfer_1:
        LDRB     R4,[R2, #+0]
        STRB     R4,[R1, #+0]
        ADDS     R2,R2,#+1
        ADDS     R1,R1,#+1
??EP_OUT_Transfer_0:
        MOVS     R4,R3
        SUBS     R3,R4,#+1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??EP_OUT_Transfer_1
//  199     return(u8EP);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4}
        BX       LR               ;; return
//  200 }
//  201 
//  202 /*
//  203 * USB_EP_OUT_SizeCheck
//  204 *   端点输入数据长度检查
//  205 *
//  206 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  207 UINT16 USB_EP_OUT_SizeCheck(UINT8 u8EP)
//  208 {
//  209   UINT8 u8EPSize; 
//  210    /* 读取缓冲区的长度 */
//  211   u8EPSize = tBDTtable[u8EP<<2].Cnt;
USB_EP_OUT_SizeCheck:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+2
        LDR.W    R1,??DataTable14_7
        ADDS     R0,R1,R0, LSL #+3
        LDRH     R0,[R0, #+2]
//  212   //u8EPSize=SWAP16(tBDTtable[u8EP<<2].Cnt);
//  213   return(u8EPSize & 0x03FF);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BX       LR               ;; return
//  214 }
//  215 
//  216 /*
//  217 * USB_Set_Interface
//  218 *   USB设置端点函数
//  219 *
//  220 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  221 void USB_Set_Interface(void)
//  222 {
//  223   /* 端点寄存器设置 */
//  224   USB0_ENDPT1= EP1_VALUE | USB_ENDPT_EPHSHK_MASK; //设置端点1为中断端点                       
USB_Set_Interface:
        LDR.W    R0,??DataTable14_9  ;; 0x400720c4
        MOVS     R1,#+5
        STRB     R1,[R0, #+0]
//  225   USB0_ENDPT2= EP2_VALUE | USB_ENDPT_EPHSHK_MASK; //设置端点2为输入 BULK端点                     
        LDR.W    R0,??DataTable14_10  ;; 0x400720c8
        MOVS     R1,#+5
        STRB     R1,[R0, #+0]
//  226   USB0_ENDPT3= EP3_VALUE | USB_ENDPT_EPHSHK_MASK; //设置端点3为输出 BULK端点                         
        LDR.W    R0,??DataTable14_11  ;; 0x400720cc
        MOVS     R1,#+9
        STRB     R1,[R0, #+0]
//  227   USB0_ENDPT4= EP4_VALUE | USB_ENDPT_EPHSHK_MASK; //禁止端点                        
        LDR.W    R0,??DataTable14_12  ;; 0x400720d0
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  228   USB0_ENDPT5= EP5_VALUE | USB_ENDPT_EPHSHK_MASK; //禁止端点                         
        LDR.W    R0,??DataTable14_13  ;; 0x400720d4
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  229   USB0_ENDPT6= EP6_VALUE | USB_ENDPT_EPHSHK_MASK; //禁止端点                         
        LDR.W    R0,??DataTable14_14  ;; 0x400720d8
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  230 
//  231   /* 端点 1 BDT 设置*/
//  232   tBDTtable[bEP1IN_ODD].Stat._byte= kMCU;//USB-FS 有专有权访问 BD
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+0
        STRB     R1,[R0, #+48]
//  233                                          //定义DATA0允许发送或者接收
//  234   tBDTtable[bEP1IN_ODD].Cnt = 0x00;
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+0
        STRH     R1,[R0, #+50]
//  235   tBDTtable[bEP1IN_ODD].Addr =(UINT32)gu8EP1_IN_ODD_Buffer;
        LDR.W    R0,??DataTable14_7
        LDR.W    R1,??DataTable14_15
        STR      R1,[R0, #+52]
//  236 
//  237   /* 端点 2 BDT 设置*/
//  238   tBDTtable[bEP2IN_ODD].Stat._byte= kMCU;//USB-FS 有专有权访问 BD
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+0
        STRB     R1,[R0, #+80]
//  239                                          //定义DATA0允许发送或者接收  
//  240   tBDTtable[bEP2IN_ODD].Cnt = 0x00;
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+0
        STRH     R1,[R0, #+82]
//  241   tBDTtable[bEP2IN_ODD].Addr =(UINT32)gu8EP2_IN_ODD_Buffer;            
        LDR.W    R0,??DataTable14_7
        LDR.W    R1,??DataTable14_16
        STR      R1,[R0, #+84]
//  242 
//  243   /* 端点 3 BDT 设置*/
//  244   tBDTtable[bEP3OUT_ODD].Stat._byte= kSIE;//USB-FS 有专有权访问 BD
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+128
        STRB     R1,[R0, #+96]
//  245                                           //使能USB-FS去扮演数据翻转同步
//  246                                           //定义DATA0允许发送或者接收 
//  247   tBDTtable[bEP3OUT_ODD].Cnt = 0xFF;
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+255
        STRH     R1,[R0, #+98]
//  248   tBDTtable[bEP3OUT_ODD].Addr =(UINT32)gu8EP3_OUT_ODD_Buffer;            
        LDR.W    R0,??DataTable14_7
        LDR.W    R1,??DataTable14_17
        STR      R1,[R0, #+100]
//  249 }
        BX       LR               ;; return
//  250 
//  251 
//  252 /*
//  253 * USB_StdReq_Handler
//  254 *   如果USB接收的Setup的请求形式时设备请求（标准请求）形式
//  255 *   进入到标准请求中断服务函数中
//  256 *
//  257 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  258 void USB_StdReq_Handler(void)
//  259 {
USB_StdReq_Handler:
        PUSH     {R7,LR}
//  260   switch(Setup_Pkt->bRequest) //判断该请求形式下数据包中的命令
        LDR.W    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+1]
        CMP      R0,#+0
        BEQ.N    ??USB_StdReq_Handler_0
        CMP      R0,#+5
        BEQ.N    ??USB_StdReq_Handler_1
        CMP      R0,#+6
        BEQ.N    ??USB_StdReq_Handler_2
        CMP      R0,#+8
        BEQ.N    ??USB_StdReq_Handler_3
        CMP      R0,#+9
        BEQ.N    ??USB_StdReq_Handler_4
        B.N      ??USB_StdReq_Handler_5
//  261   {
//  262     case mSET_ADDRESS:          //USB device设置地址命令
//  263         EP_IN_Transfer(EP0,0,0);//端点0开始发送自己的地址
??USB_StdReq_Handler_1:
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  264         gu8USB_State=uADDRESS;  //将USB的状态位改为已设置地址状态
        LDR.W    R0,??DataTable14_18
        MOVS     R1,#+3
        STRB     R1,[R0, #+0]
//  265         break;
        B.N      ??USB_StdReq_Handler_6
//  266   
//  267     case mGET_DESC:             //PC获得USB设置描述符命令
//  268         switch(Setup_Pkt->wValue_h) //判断Setup数据包中的要发送的描述符
??USB_StdReq_Handler_2:
        LDR.W    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+3]
        CMP      R0,#+1
        BEQ.N    ??USB_StdReq_Handler_7
        BCC.N    ??USB_StdReq_Handler_8
        CMP      R0,#+3
        BEQ.N    ??USB_StdReq_Handler_9
        BCC.N    ??USB_StdReq_Handler_10
        B.N      ??USB_StdReq_Handler_8
//  269         {
//  270             case mDEVICE:           //要求底层设备发送设备描述符
//  271                 EP_IN_Transfer(EP0,(UINT8*)Device_Descriptor,sizeof(Device_Descriptor));
??USB_StdReq_Handler_7:
        MOVS     R2,#+18
        LDR.W    R1,??DataTable14_19
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  272                 break;
        B.N      ??USB_StdReq_Handler_11
//  273                 
//  274             case mCONFIGURATION:    //要求发送配置描述符
//  275                 EP_IN_Transfer(EP0,(UINT8*)Configuration_Descriptor,sizeof(Configuration_Descriptor));
??USB_StdReq_Handler_10:
        MOVS     R2,#+67
        LDR.W    R1,??DataTable14_20
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  276                 break;
        B.N      ??USB_StdReq_Handler_11
//  277     
//  278             case mSTRING:           //要求发送字符串描述符
//  279                 EP_IN_Transfer(EP0,(UINT8*)String_Table[Setup_Pkt->wValue_l],String_Table[Setup_Pkt->wValue_l][0]);
??USB_StdReq_Handler_9:
        LDR.W    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable14_21
        LDR      R0,[R1, R0, LSL #+2]
        LDRB     R2,[R0, #+0]
        LDR.W    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable14_21
        LDR      R1,[R1, R0, LSL #+2]
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  280                 break;
        B.N      ??USB_StdReq_Handler_11
//  281 
//  282             default:               
//  283                 USB_EP0_Stall();   //如果都不是，转为端点0 stall（停止）模式
??USB_StdReq_Handler_8:
        BL       USB_EP0_Stall
//  284                 break;  
//  285         }
//  286         break;
??USB_StdReq_Handler_11:
        B.N      ??USB_StdReq_Handler_6
//  287 
//  288     case mSET_CONFIG:                             //USB device设备配置命令
//  289         gu8Dummy=Setup_Pkt->wValue_h+Setup_Pkt->wValue_l; //组合成16位数据
??USB_StdReq_Handler_4:
        LDR.W    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+3]
        LDR.W    R1,??DataTable14_5
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+2]
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable14_22
        STRB     R0,[R1, #+0]
//  290         if(Setup_Pkt->wValue_h+Setup_Pkt->wValue_l) 
        LDR.W    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+3]
        LDR.W    R1,??DataTable14_5
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, #+2]
        ADDS     R0,R1,R0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BEQ.N    ??USB_StdReq_Handler_12
//  291         {
//  292             USB_Set_Interface();                  // 配置USB device的中断端点、bulk端点                    
        BL       USB_Set_Interface
//  293             EP_IN_Transfer(EP0,0,0);              // 端点0开始传输
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  294             gu8USB_State=uENUMERATED;             // 设置USB的状态为以被枚举状态
        LDR.W    R0,??DataTable14_18
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  295         }
//  296         break;
??USB_StdReq_Handler_12:
        B.N      ??USB_StdReq_Handler_6
//  297   
//  298     case mGET_CONFIG:                             //PC获得USB的设备配置命令  
//  299         EP_IN_Transfer(EP0,(UINT8*)&gu8Dummy,1);  //端点0发送组合而成的16位数据
??USB_StdReq_Handler_3:
        MOVS     R2,#+1
        LDR.W    R1,??DataTable14_22
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  300         break;
        B.N      ??USB_StdReq_Handler_6
//  301 
//  302     case mGET_STATUS:                             //PC获得USB的状态命令
//  303         gu8Status=0;                              //设置gu8Status = 0
??USB_StdReq_Handler_0:
        LDR.W    R0,??DataTable14_23
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  304         EP_IN_Transfer(EP0,(UINT8*)&gu8Status,2); //端点0发送状2个字节的状态
        MOVS     R2,#+2
        LDR.W    R1,??DataTable14_23
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  305         break;
        B.N      ??USB_StdReq_Handler_6
//  306 
//  307     default:
//  308         USB_EP0_Stall();                          //如果都不是，转为端点0 stall（停止）模式                                                   
??USB_StdReq_Handler_5:
        BL       USB_EP0_Stall
//  309         break;
//  310   }
//  311 }
??USB_StdReq_Handler_6:
        POP      {R0,PC}          ;; return
//  312 
//  313 
//  314 /*
//  315 * USB_Setup_Handler
//  316 *  USB SETUP中断，表示一次控制传输的开始。
//  317 *  SETUP是控制传输的第一阶段，
//  318 *  并用来把一个请求从系统发往目标USB设备。
//  319 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  320 void USB_Setup_Handler(void)
//  321 {
USB_Setup_Handler:
        PUSH     {R7,LR}
//  322   UINT8 u8State;
//  323   FLAG_CLR(0,gu8USB_Toogle_flags);        //将gu8USB_Toogle_flags = 0
        LDR.W    R0,??DataTable14_8
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xFE
        LDR.W    R1,??DataTable14_8
        STRB     R0,[R1, #+0]
//  324   switch(Setup_Pkt->bmRequestType & 0x1F) //判断Setup数据包中请求的形式
        LDR.W    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0x1F
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??USB_Setup_Handler_0
        CMP      R0,#+2
        BEQ.N    ??USB_Setup_Handler_1
        BCC.N    ??USB_Setup_Handler_2
        B.N      ??USB_Setup_Handler_3
//  325   {
//  326       case DEVICE_REQ: //如果是设备请求形式
//  327           if((Setup_Pkt->bmRequestType & 0x1F)== STANDARD_REQ) //设备请求形式等于标准请求形式
??USB_Setup_Handler_0:
        LDR.W    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+31
        TST      R0,R1
        BNE.N    ??USB_Setup_Handler_4
//  328           {            
//  329               USB_StdReq_Handler(); //标准请求中断服务函数           
        BL       USB_StdReq_Handler
//  330           }
//  331           tBDTtable[bEP0OUT_ODD].Stat._byte= kUDATA0;
??USB_Setup_Handler_4:
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+136
        STRB     R1,[R0, #+0]
//  332           break;        
        B.N      ??USB_Setup_Handler_5
//  333   
//  334       case INTERFACE_REQ://如果是接口请求形式
//  335           u8State = USB_InterfaceReq_Handler(); //当前接口请求为CDC类请求   
??USB_Setup_Handler_2:
        BL       CDC_InterfaceReq_Handler
//  336   
//  337           if(u8State==uSETUP)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??USB_Setup_Handler_6
//  338               tBDTtable[bEP0OUT_ODD].Stat._byte= kUDATA0;
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+136
        STRB     R1,[R0, #+0]
        B.N      ??USB_Setup_Handler_7
//  339           else
//  340               tBDTtable[bEP0OUT_ODD].Stat._byte= kUDATA1;            
??USB_Setup_Handler_6:
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+200
        STRB     R1,[R0, #+0]
//  341           break;        
??USB_Setup_Handler_7:
        B.N      ??USB_Setup_Handler_5
//  342   
//  343       case ENDPOINT_REQ://如果是端点请求
//  344           USB_Endpoint_Setup_Handler();
??USB_Setup_Handler_1:
        BL       USB_Endpoint_Setup_Handler
//  345           tBDTtable[bEP0OUT_ODD].Stat._byte= kUDATA0;
        LDR.W    R0,??DataTable14_7
        MOVS     R1,#+136
        STRB     R1,[R0, #+0]
//  346           break;        
        B.N      ??USB_Setup_Handler_5
//  347   
//  348       default:
//  349           USB_EP0_Stall();  //stall请求
??USB_Setup_Handler_3:
        BL       USB_EP0_Stall
//  350           break;        
//  351   }
//  352   FLAG_CLR(USB_CTL_TXSUSPENDTOKENBUSY_SHIFT,USB0_CTL);
??USB_Setup_Handler_5:
        LDR.W    R0,??DataTable14_24  ;; 0x40072094
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xDF
        LDR.W    R1,??DataTable14_24  ;; 0x40072094
        STRB     R0,[R1, #+0]
//  353 }
        POP      {R0,PC}          ;; return
//  354 
//  355 
//  356 /*
//  357 * USB_Endpoint_Setup_Handler
//  358 *   USB端点Setup中断处理函数
//  359 *
//  360 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  361 void USB_Endpoint_Setup_Handler(void)
//  362 {
USB_Endpoint_Setup_Handler:
        PUSH     {R7,LR}
//  363   UINT16 u16Status;
//  364   switch(Setup_Pkt->bRequest)
        LDR.N    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+1]
        CMP      R0,#+0
        BEQ.N    ??USB_Endpoint_Setup_Handler_0
        CMP      R0,#+1
        BEQ.N    ??USB_Endpoint_Setup_Handler_1
        CMP      R0,#+3
        BEQ.N    ??USB_Endpoint_Setup_Handler_2
        B.N      ??USB_Endpoint_Setup_Handler_3
//  365   {        
//  366     case GET_STATUS: //获取当前状态
//  367         if(FLAG_CHK(Setup_Pkt->wIndex_h,gu8HALT_EP))//判断gu8HALT_EP端点HALT是否为1
??USB_Endpoint_Setup_Handler_0:
        LDR.W    R0,??DataTable14_25
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+1
        LDR.N    R2,??DataTable14_5
        LDR      R2,[R2, #+0]
        LDRSB    R2,[R2, #+5]
        LSLS     R1,R1,R2
        TST      R0,R1
        BEQ.N    ??USB_Endpoint_Setup_Handler_4
//  368             u16Status=0x0100;
        MOV      R0,#+256
        STRH     R0,[SP, #+0]
        B.N      ??USB_Endpoint_Setup_Handler_5
//  369         else
//  370             u16Status=0x0000;
??USB_Endpoint_Setup_Handler_4:
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
//  371         
//  372         EP_IN_Transfer(EP0,(UINT8*)&u16Status,2); //通过端点0向PC发送状态
??USB_Endpoint_Setup_Handler_5:
        MOVS     R2,#+2
        ADD      R1,SP,#+0
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  373         break;
        B.N      ??USB_Endpoint_Setup_Handler_6
//  374     
//  375     case CLEAR_FEATURE:
//  376         FLAG_CLR(Setup_Pkt->wIndex_h,gu8HALT_EP); //gu8HALT_EP = 0
??USB_Endpoint_Setup_Handler_1:
        LDR.N    R0,??DataTable14_25
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+1
        LDR.N    R2,??DataTable14_5
        LDR      R2,[R2, #+0]
        LDRSB    R2,[R2, #+5]
        LSLS     R1,R1,R2
        BICS     R0,R0,R1
        LDR.N    R1,??DataTable14_25
        STRB     R0,[R1, #+0]
//  377         EP_IN_Transfer(EP0,0,0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  378         break;
        B.N      ??USB_Endpoint_Setup_Handler_6
//  379     
//  380     case SET_FEATURE:
//  381         FLAG_SET(Setup_Pkt->wIndex_h,gu8HALT_EP); //gu8HALT_EP = 1
??USB_Endpoint_Setup_Handler_2:
        LDR.N    R0,??DataTable14_25
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+1
        LDR.N    R2,??DataTable14_5
        LDR      R2,[R2, #+0]
        LDRSB    R2,[R2, #+5]
        LSLS     R1,R1,R2
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable14_25
        STRB     R0,[R1, #+0]
//  382         EP_IN_Transfer(EP0,0,0);
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  383         break;
        B.N      ??USB_Endpoint_Setup_Handler_6
//  384     
//  385     default:
//  386         break;
//  387   }
//  388 }
??USB_Endpoint_Setup_Handler_3:
??USB_Endpoint_Setup_Handler_6:
        POP      {R0,PC}          ;; return
//  389 
//  390 
//  391 /*
//  392 * USB_Handler
//  393 *  USB令牌中断服务函数
//  394 *
//  395 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  396 void USB_Handler(void)
//  397 {
USB_Handler:
        PUSH     {R7,LR}
//  398   UINT8 u8EndPoint;
//  399   UINT8 u8IN;
//  400   
//  401   u8IN = USB0_STAT & 0x08;    //获得当前的传输状态，1发送；0接收
        LDR.N    R0,??DataTable14_26  ;; 0x40072090
        LDRB     R0,[R0, #+0]
        ANDS     R1,R0,#0x8
//  402   u8EndPoint = USB0_STAT >> 4;//获得当前接收令牌的端点地址
        LDR.N    R0,??DataTable14_26  ;; 0x40072090
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSRS     R0,R0,#+4
//  403   
//  404   //端点发送PC接收模式表示有目标设备发送到PC上
//  405   //端点接收PC发送模式表示PC发送目标设备接收
//  406   
//  407   /* Data EndPoints */
//  408   if(u8EndPoint) //如果非零表示是数据端点，因为端点0作为控制端点
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??USB_Handler_0
//  409   {
//  410     if(!u8IN)    //如果是端点接收模式
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BNE.N    ??USB_Handler_1
//  411     {
//  412       usbMCU_CONTROL(u8EndPoint);         //转换成单片机访问BDT
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R1,R0,#+2
        LDR.N    R2,??DataTable14_7
        MOVS     R3,#+0
        STRB     R3,[R2, R1, LSL #+3]
//  413       FLAG_SET(u8EndPoint,gu8USB_Flags);  //设置 gu8USB_Flags = 1   
        LDR.N    R1,??DataTable14_27
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R0,R2,R0
        ORRS     R0,R0,R1
        LDR.N    R1,??DataTable14_27
        STRB     R0,[R1, #+0]
//  414 
//  415       if(usb_rev_data_isr !=(USB_REV_CALLBACK)0)
        LDR.N    R0,??DataTable14
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??USB_Handler_1
//  416         usb_rev_data_isr();      
        LDR.N    R0,??DataTable14
        LDR      R0,[R0, #+0]
        BLX      R0
        B.N      ??USB_Handler_1
//  417     }
//  418   }
//  419   /* Control EndPoint */
//  420   else       //如果是端点0，端点0作为控制端点
//  421   {
//  422     if(u8IN)    //如果是端点发送PC接收
??USB_Handler_0:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??USB_Handler_2
//  423     {
//  424       USB_EP0_IN_Handler();  
        BL       USB_EP0_IN_Handler
        B.N      ??USB_Handler_1
//  425     }
//  426     else       //如果是端点接收PC发送模式
//  427     {
//  428       if(tBDTtable[bEP0OUT_ODD].Stat.RecPid.PID == mSETUP_TOKEN) //如果接收的是启动令牌
??USB_Handler_2:
        LDR.N    R0,??DataTable14_7
        LDRB     R0,[R0, #+0]
        UBFX     R0,R0,#+2,#+4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+13
        BNE.N    ??USB_Handler_3
//  429           USB_Setup_Handler();
        BL       USB_Setup_Handler
        B.N      ??USB_Handler_1
//  430       else     //如果接收的不是启动令牌
//  431           USB_EP0_OUT_Handler();
??USB_Handler_3:
        BL       USB_EP0_OUT_Handler
//  432     }
//  433   }
//  434 }
??USB_Handler_1:
        POP      {R0,PC}          ;; return
//  435 
//  436 
//  437 /*
//  438 * USB_EP0_IN_Handler
//  439 *   端点0发送PC接收模式中断服务函数，此时端点0是控制端点，
//  440 *
//  441 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  442 void USB_EP0_IN_Handler(void)
//  443 {
USB_EP0_IN_Handler:
        PUSH     {R7,LR}
//  444   if(gu8USB_State == uADDRESS)        //如果当前USB处于地址状态
        LDR.N    R0,??DataTable14_18
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??USB_EP0_IN_Handler_0
//  445   {
//  446     USB0_ADDR = Setup_Pkt->wValue_l; //将Setup_Pkt的值给USB地址寄存器
        LDR.N    R0,??DataTable14_5
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+2]
        LDR.N    R1,??DataTable14_28  ;; 0x40072098
        STRB     R0,[R1, #+0]
//  447     gu8USB_State = uREADY;           //改变当前USB状态
        LDR.N    R0,??DataTable14_18
        MOVS     R1,#+4
        STRB     R1,[R0, #+0]
//  448     FLAG_SET(fIN,gu8USBClearFlags);  //将gu8USBClearFlags设置为1
        LDR.N    R0,??DataTable14_2
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable14_2
        STRB     R0,[R1, #+0]
//  449   }
//  450   EP_IN_Transfer(0,0,0);             //端点0开始传输
??USB_EP0_IN_Handler_0:
        MOVS     R2,#+0
        MOVS     R1,#+0
        MOVS     R0,#+0
        BL       EP_IN_Transfer
//  451 }
        POP      {R0,PC}          ;; return
//  452 
//  453 
//  454 /*
//  455 * USB_EP0_Stall
//  456 *   端点0 stall停止处理
//  457 *
//  458 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  459 void USB_EP0_Stall(void)
//  460 {
//  461   FLAG_SET(USB_ENDPT_EPSTALL_SHIFT,USB0_ENDPT0);  // USB0_ENDPT0的 STALL =1                
USB_EP0_Stall:
        LDR.N    R0,??DataTable14_29  ;; 0x400720c0
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable14_29  ;; 0x400720c0
        STRB     R0,[R1, #+0]
//  462   tBDTtable[bEP0OUT_ODD].Stat._byte = kUDATA0;    // USB-FS 有专有权访问 BD
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+136
        STRB     R1,[R0, #+0]
//  463                                                   //使能USB-FS去扮演数据翻转同步
//  464                                                   //定义DATA1允许发送或者接收 
//  465   tBDTtable[bEP0OUT_ODD].Cnt = EP0_SIZE;          //设置EP0的长度32字节
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+64
        STRH     R1,[R0, #+2]
//  466 }
        BX       LR               ;; return
//  467 
//  468 
//  469 /*
//  470 * USB_EP0_OUT_Handler
//  471 *   端点0接收PC接收数据中断服务函数
//  472 *
//  473 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  474 void USB_EP0_OUT_Handler(void)
//  475 {   
//  476   FLAG_SET(0,gu8USB_Flags);   //将EP0的gu8USB_Flags置1
USB_EP0_OUT_Handler:
        LDR.N    R0,??DataTable14_27
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable14_27
        STRB     R0,[R1, #+0]
//  477   tBDTtable[bEP0OUT_ODD].Stat._byte = kUDATA0;   //USB-FS 有专有权访问 BD
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+136
        STRB     R1,[R0, #+0]
//  478                                                  //使能USB-FS去扮演数据翻转同步
//  479                                                  //定义DATA1允许发送或者接收  
//  480 }
        BX       LR               ;; return
//  481 
//  482 
//  483 /*
//  484 *   USB_Stall_Handler
//  485 *     如果USB工作在Device模式，如果获得stall证明表明其不能完成传输。
//  486 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  487 void USB_Stall_Handler(void) 
//  488 {
//  489   if(FLAG_CHK(USB_ENDPT_EPSTALL_SHIFT,USB0_ENDPT0)) //检查USB的端点0的stall位是否置位
USB_Stall_Handler:
        LDR.N    R0,??DataTable14_29  ;; 0x400720c0
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??USB_Stall_Handler_0
//  490       FLAG_CLR(USB_ENDPT_EPSTALL_SHIFT,USB0_ENDPT0);//清空端点0的stall位
        LDR.N    R0,??DataTable14_29  ;; 0x400720c0
        LDRB     R0,[R0, #+0]
        ANDS     R0,R0,#0xFD
        LDR.N    R1,??DataTable14_29  ;; 0x400720c0
        STRB     R0,[R1, #+0]
//  491   FLAG_SET(USB_ISTAT_STALL_SHIFT,USB0_ISTAT);       //清空全局状态寄存器中的Stall位
??USB_Stall_Handler_0:
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable14_30  ;; 0x40072080
        STRB     R0,[R1, #+0]
//  492 }
        BX       LR               ;; return
//  493 
//  494 
//  495 /*
//  496 *   USB_Reset_Handler
//  497 *     USB复位中断服务函数,在该函数中进行设置软件标志位、
//  498 *   禁止所有EP(端点寄存器)，同时将EP0初始为控制端点
//  499 *   并对EP0的输入、输出奇偶缓冲进行初始化，
//  500 *   开启USB令牌中断、USB第一帧传输中断、USB错误中断、USB复位中断
//  501 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  502 void USB_Reset_Handler(void)
//  503 {
//  504   /*设置软件标志位*/
//  505   gu8USBClearFlags=0xFF;
USB_Reset_Handler:
        LDR.N    R0,??DataTable14_2
        MOVS     R1,#+255
        STRB     R1,[R0, #+0]
//  506   gu8USB_Toogle_flags=0xFE;
        LDR.N    R0,??DataTable14_8
        MOVS     R1,#+254
        STRB     R1,[R0, #+0]
//  507   
//  508   /*禁止所有EP寄存器*/
//  509   USB0_ENDPT1=0x00;
        LDR.N    R0,??DataTable14_9  ;; 0x400720c4
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  510   USB0_ENDPT2=0x00;
        LDR.N    R0,??DataTable14_10  ;; 0x400720c8
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  511   USB0_ENDPT3=0x00;
        LDR.N    R0,??DataTable14_11  ;; 0x400720cc
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  512   USB0_ENDPT4=0x00;
        LDR.N    R0,??DataTable14_12  ;; 0x400720d0
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  513   USB0_ENDPT5=0x00;
        LDR.N    R0,??DataTable14_13  ;; 0x400720d4
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  514   USB0_ENDPT6=0x00;
        LDR.N    R0,??DataTable14_14  ;; 0x400720d8
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  515 
//  516   /*端点0 BDT 启动端点设置*/
//  517   tBDTtable[bEP0OUT_ODD].Cnt = EP0_SIZE;   // EP0 OUT BDT 设置
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+64
        STRH     R1,[R0, #+2]
//  518   tBDTtable[bEP0OUT_ODD].Addr =(UINT32)gu8EP0_OUT_ODD_Buffer;
        LDR.N    R0,??DataTable14_7
        LDR.N    R1,??DataTable14_31
        STR      R1,[R0, #+4]
//  519   tBDTtable[bEP0OUT_ODD].Stat._byte = kUDATA1;//USB-FS 有专有权访问 BD
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+200
        STRB     R1,[R0, #+0]
//  520                                               //使能USB-FS去扮演数据翻转同步
//  521                                               //定义DATA1允许发送或者接收        
//  522    
//  523   tBDTtable[bEP0OUT_EVEN].Cnt = EP0_SIZE; // EP0 OUT BDT 设置
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+64
        STRH     R1,[R0, #+10]
//  524   tBDTtable[bEP0OUT_EVEN].Addr =(UINT32)gu8EP0_OUT_EVEN_Buffer;
        LDR.N    R0,??DataTable14_7
        LDR.N    R1,??DataTable14_32
        STR      R1,[R0, #+12]
//  525   tBDTtable[bEP0OUT_EVEN].Stat._byte = kUDATA1;//USB-FS 有专有权访问 BD
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+200
        STRB     R1,[R0, #+8]
//  526                                                //使能USB-FS去扮演数据翻转同步
//  527                                                //定义DATA1允许发送或者接收       
//  528    
//  529   tBDTtable[bEP0IN_ODD].Cnt = EP0_SIZE;   // EP0 IN BDT 设置     
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+64
        STRH     R1,[R0, #+18]
//  530   tBDTtable[bEP0IN_ODD].Addr =(UINT32)gu8EP0_IN_ODD_Buffer;      
        LDR.N    R0,??DataTable14_7
        LDR.N    R1,??DataTable14_33
        STR      R1,[R0, #+20]
//  531   tBDTtable[bEP0IN_ODD].Stat._byte = kUDATA0;//USB-FS 有专有权访问 BD
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+136
        STRB     R1,[R0, #+16]
//  532                                              //使能USB-FS去扮演数据翻转同步
//  533                                              //定义DATA0允许发送或者接收 
//  534    
//  535   tBDTtable[bEP0IN_EVEN].Cnt = EP0_SIZE;  // EP0 IN BDT 设置            
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+64
        STRH     R1,[R0, #+26]
//  536   tBDTtable[bEP0IN_EVEN].Addr =(UINT32)gu8EP0_IN_EVEN_Buffer;      
        LDR.N    R0,??DataTable14_7
        LDR.N    R1,??DataTable14_34
        STR      R1,[R0, #+28]
//  537   tBDTtable[bEP0IN_EVEN].Stat._byte = kUDATA0;//USB-FS 有专有权访问 BD
        LDR.N    R0,??DataTable14_7
        MOVS     R1,#+136
        STRB     R1,[R0, #+24]
//  538                                               //使能USB-FS去扮演数据翻转同步
//  539                                               //定义DATA0允许发送或者接收        
//  540   
//  541   USB0_ENDPT0=0x0D; //使能端点0
        LDR.N    R0,??DataTable14_29  ;; 0x400720c0
        MOVS     R1,#+13
        STRB     R1,[R0, #+0]
//  542   
//  543   USB0_ERRSTAT=0xFF;//清空所有错误标志位
        LDR.N    R0,??DataTable14_35  ;; 0x40072088
        MOVS     R1,#+255
        STRB     R1,[R0, #+0]
//  544   
//  545   USB0_ISTAT=0xFF;  //清空所有USB中断标志位
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        MOVS     R1,#+255
        STRB     R1,[R0, #+0]
//  546 
//  547   USB0_ADDR=0x00;   // 设置USB缺省定值为0
        LDR.N    R0,??DataTable14_28  ;; 0x40072098
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  548 
//  549   USB0_ERREN=0xFF;  // 使能所有错误中断源
        LDR.N    R0,??DataTable14_36  ;; 0x4007208c
        MOVS     R1,#+255
        STRB     R1,[R0, #+0]
//  550 
//  551   /*使能USB中断*/
//  552   FLAG_SET(USB_INTEN_TOKDNEEN_SHIFT,USB0_INTEN);  //使能USB TOKDNE中断 
        LDR.N    R0,??DataTable14_37  ;; 0x40072084
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable14_37  ;; 0x40072084
        STRB     R0,[R1, #+0]
//  553   FLAG_SET(USB_INTEN_SOFTOKEN_SHIFT,USB0_INTEN);  //使能USB SOFTOK中断 
        LDR.N    R0,??DataTable14_37  ;; 0x40072084
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable14_37  ;; 0x40072084
        STRB     R0,[R1, #+0]
//  554   FLAG_SET(USB_INTEN_ERROREN_SHIFT,USB0_INTEN);   //使能USB错误中断 
        LDR.N    R0,??DataTable14_37  ;; 0x40072084
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable14_37  ;; 0x40072084
        STRB     R0,[R1, #+0]
//  555   FLAG_SET(USB_INTEN_USBRSTEN_SHIFT,USB0_INTEN);  //使能USB复位中断  
        LDR.N    R0,??DataTable14_37  ;; 0x40072084
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable14_37  ;; 0x40072084
        STRB     R0,[R1, #+0]
//  556 }
        BX       LR               ;; return
//  557 
//  558 
//  559 /*
//  560 * USB_Protocol_Handler
//  561 *   USB协议中断服务函数
//  562 *      在该函数中调用USB的底层协议
//  563 */

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  564 void USB_Protocol_Handler(void)
//  565 {
USB_Protocol_Handler:
        PUSH     {R7,LR}
//  566   uint8 err;
//  567   FLAG_SET(1,GPIOC_PDOR);
        LDR.N    R0,??DataTable14_38  ;; 0x400ff080
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable14_38  ;; 0x400ff080
        STR      R0,[R1, #+0]
//  568   /*USB 程序初始化后会首先进入复位中断 */
//  569   if(FLAG_CHK(USB_ISTAT_USBRST_SHIFT,USB0_ISTAT))//产生USB复位中断
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??USB_Protocol_Handler_0
//  570   { 
//  571     USB_Reset_Handler();                         //进入USB复位中断服务函数
        BL       USB_Reset_Handler
//  572     return;
        B.N      ??USB_Protocol_Handler_1
//  573   }
//  574   if(FLAG_CHK(USB_ISTAT_SOFTOK_SHIFT,USB0_ISTAT))//产生USB SOFTOK中断
??USB_Protocol_Handler_0:
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??USB_Protocol_Handler_2
//  575   {
//  576     USB0_ISTAT = USB_ISTAT_SOFTOK_MASK;          //清空SOFTOK标志位
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        MOVS     R1,#+4
        STRB     R1,[R0, #+0]
//  577   }
//  578   if(FLAG_CHK(USB_ISTAT_STALL_SHIFT,USB0_ISTAT)) //接收USB停止包数据处理
??USB_Protocol_Handler_2:
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??USB_Protocol_Handler_3
//  579   {
//  580     USB_Stall_Handler();                         //进入Stall中断服务函数
        BL       USB_Stall_Handler
//  581   }
//  582   if(FLAG_CHK(USB_ISTAT_TOKDNE_SHIFT,USB0_ISTAT))//产生USB令牌中断
??USB_Protocol_Handler_3:
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BPL.N    ??USB_Protocol_Handler_4
//  583   {
//  584     FLAG_SET(USB_CTL_ODDRST_SHIFT,USB0_CTL);     //复位所有BDT ODD，然后可以配置EVEN BDT
        LDR.N    R0,??DataTable14_24  ;; 0x40072094
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable14_24  ;; 0x40072094
        STRB     R0,[R1, #+0]
//  585     USB_Handler();
        BL       USB_Handler
//  586     FLAG_SET(USB_ISTAT_TOKDNE_SHIFT,USB0_ISTAT); //清零USB令牌标志位
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.N    R1,??DataTable14_30  ;; 0x40072080
        STRB     R0,[R1, #+0]
//  587   }
//  588   if(FLAG_CHK(USB_ISTAT_SLEEP_SHIFT,USB0_ISTAT)) 
??USB_Protocol_Handler_4:
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BPL.N    ??USB_Protocol_Handler_5
//  589   {
//  590     FLAG_SET(USB_ISTAT_SLEEP_SHIFT,USB0_ISTAT);   
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable14_30  ;; 0x40072080
        STRB     R0,[R1, #+0]
//  591   }
//  592   if(FLAG_CHK(USB_ISTAT_ERROR_SHIFT,USB0_ISTAT)) 
??USB_Protocol_Handler_5:
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??USB_Protocol_Handler_6
//  593   {
//  594     err = USB0_ERRSTAT;
        LDR.N    R0,??DataTable14_35  ;; 0x40072088
        LDRB     R0,[R0, #+0]
//  595     if(err==0)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??USB_Protocol_Handler_7
//  596       asm("nop");
        nop              
//  597     FLAG_CHK(USB_ISTAT_ERROR_SHIFT,USB0_ISTAT);
??USB_Protocol_Handler_7:
        LDR.N    R0,??DataTable14_30  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ANDS     R0,R0,#0x2
//  598   }
//  599 }
??USB_Protocol_Handler_6:
??USB_Protocol_Handler_1:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14:
        DC32     usb_rev_data_isr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_1:
        DC32     BufferPointer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_2:
        DC32     gu8USBClearFlags

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_3:
        DC32     pu8IN_DataPointer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_4:
        DC32     gu8IN_Counter

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_5:
        DC32     Setup_Pkt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_6:
        DC32     cEP_Size

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_7:
        DC32     tBDTtable

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_8:
        DC32     gu8USB_Toogle_flags

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_9:
        DC32     0x400720c4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_10:
        DC32     0x400720c8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_11:
        DC32     0x400720cc

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_12:
        DC32     0x400720d0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_13:
        DC32     0x400720d4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_14:
        DC32     0x400720d8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_15:
        DC32     gu8EP1_IN_ODD_Buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_16:
        DC32     gu8EP2_IN_ODD_Buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_17:
        DC32     gu8EP3_OUT_ODD_Buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_18:
        DC32     gu8USB_State

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_19:
        DC32     Device_Descriptor

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_20:
        DC32     Configuration_Descriptor

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_21:
        DC32     String_Table

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_22:
        DC32     gu8Dummy

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_23:
        DC32     gu8Status

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_24:
        DC32     0x40072094

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_25:
        DC32     gu8HALT_EP

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_26:
        DC32     0x40072090

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_27:
        DC32     gu8USB_Flags

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_28:
        DC32     0x40072098

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_29:
        DC32     0x400720c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_30:
        DC32     0x40072080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_31:
        DC32     gu8EP0_OUT_ODD_Buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_32:
        DC32     gu8EP0_OUT_EVEN_Buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_33:
        DC32     gu8EP0_IN_ODD_Buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_34:
        DC32     gu8EP0_IN_EVEN_Buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_35:
        DC32     0x40072088

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_36:
        DC32     0x4007208c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_37:
        DC32     0x40072084

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_38:
        DC32     0x400ff080

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  600 
// 
// 1 174 bytes in section .bss
//    80 bytes in section .data
//   168 bytes in section .rodata
// 1 830 bytes in section .text
// 
// 1 830 bytes of CODE  memory
//   168 bytes of CONST memory
// 1 254 bytes of DATA  memory
//
//Errors: none
//Warnings: none
