///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:07 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_UART.c     /
//    Command line =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_UART.c -D  /
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
//                    ar\RAM\List\HAL_UART.s                                  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_UART

        #define SHT_PROGBITS 0x1

        EXTERN core_clk_khz
        EXTERN disable_irq
        EXTERN enable_irq
        EXTERN periph_clk_khz

        PUBLIC LPLD_UART_GetChar
        PUBLIC LPLD_UART_Init
        PUBLIC LPLD_UART_Isr
        PUBLIC LPLD_UART_PutChar
        PUBLIC LPLD_UART_PutCharArr
        PUBLIC LPLD_UART_RIE_Disable
        PUBLIC LPLD_UART_RIE_Enable
        PUBLIC UART_R_ISR
        PUBLIC UART_T_ISR
        PUBLIC UARTx_Ptr

// D:\中国机器人大赛\robot_project\lib\LPLD\HAL_UART.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_UART.c
//   10  * 用途: UART底层模块相关函数
//   11  * 最后修改日期: 20120330
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17 */
//   18 /*
//   19  *******需用到UART中断，请在isr.h中粘贴一下代码:*********
//   20 
//   21 //UART模块中断服务定义
//   22 #undef  VECTOR_061
//   23 #define VECTOR_061 LPLD_UART_Isr
//   24 #undef  VECTOR_063
//   25 #define VECTOR_063 LPLD_UART_Isr
//   26 #undef  VECTOR_065
//   27 #define VECTOR_065 LPLD_UART_Isr
//   28 #undef  VECTOR_067
//   29 #define VECTOR_067 LPLD_UART_Isr
//   30 #undef  VECTOR_069
//   31 #define VECTOR_069 LPLD_UART_Isr
//   32 #undef  VECTOR_071
//   33 #define VECTOR_071 LPLD_UART_Isr
//   34 //以下函数在LPLD_Kinetis底层包，不必修改
//   35 extern void LPLD_UART_Isr(void);
//   36 
//   37  ***********************代码结束*************************
//   38 */
//   39 
//   40 #include "common.h"
//   41 #include "HAL_UART.h"
//   42 
//   43 
//   44 extern int core_clk_khz;          //系统主频时钟频率
//   45 extern int periph_clk_khz;        //总线时钟频率
//   46 
//   47 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   48 UART_ISR_CALLBACK UART_R_ISR[6];  //用户接收中断函数入口地址数组
UART_R_ISR:
        DS8 24

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   49 UART_ISR_CALLBACK UART_T_ISR[6];  //用户发送中断函数入口地址数组
UART_T_ISR:
        DS8 24
//   50 
//   51 //UART映射地址数组

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   52 volatile UART_MemMapPtr UARTx_Ptr[6] = {UART0_BASE_PTR, 
UARTx_Ptr:
        DATA
        DC32 4006A000H, 4006B000H, 4006C000H, 4006D000H, 400EA000H, 400EB000H
//   53                                         UART1_BASE_PTR, 
//   54                                         UART2_BASE_PTR, 
//   55                                         UART3_BASE_PTR, 
//   56                                         UART4_BASE_PTR, 
//   57                                         UART5_BASE_PTR};
//   58 
//   59 /*
//   60  * LPLD_UART_Init
//   61  * 初始化UART通道及其波特率
//   62  * 
//   63  * 参数:
//   64  *    uartx--UART模块号
//   65  *      |__UART0          --UART0  -Txd:PTB17 -Rxd:PTB16
//   66  *      |__UART1          --UART1  -Txd:PTC4  -Rxd:PTC3
//   67  *      |__UART2          --UART2  -Txd:PTD3  -Rxd:PTD2
//   68  *      |__UART3          --UART3  -Txd:PTC17 -Rxd:PTC16
//   69  *      |__UART4          --UART4  -Txd:PTC15 -Rxd:PTC14
//   70  *      |__UART5          --UART5  -Txd:PTE8  -Rxd:PTE9
//   71  *    baud--波特率，推荐设置以下常用波特率
//   72  *      |__4800
//   73  *      |__9600
//   74  *      |__19200
//   75  *      |__38400
//   76  *      |__57600
//   77  *      |__115200
//   78  *
//   79  * 输出:
//   80  *    无
//   81  *
//   82  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   83 void LPLD_UART_Init(UARTx uartx, int baud)
//   84 {
LPLD_UART_Init:
        PUSH     {R4,R5}
//   85   UART_MemMapPtr uartptr = UARTx_Ptr[uartx];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable5
        LDR      R0,[R2, R0, LSL #+2]
//   86   register uint16 sbr, brfa;
//   87   int sysclk;
//   88   uint8 temp;
//   89   
//   90   if ((uartptr == UART0_BASE_PTR) | (uartptr == UART1_BASE_PTR))
        LDR.N    R2,??DataTable5_1  ;; 0x4006a000
        CMP      R0,R2
        BEQ.N    ??LPLD_UART_Init_0
        MOVS     R2,#+0
        LDR.N    R3,??DataTable5_2  ;; 0x4006b000
        CMP      R0,R3
        BEQ.N    ??LPLD_UART_Init_0
        ORRS     R2,R2,#0x0
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??LPLD_UART_Init_1
//   91     sysclk = core_clk_khz;
??LPLD_UART_Init_0:
        LDR.N    R2,??DataTable5_3
        LDR      R2,[R2, #+0]
        B.N      ??LPLD_UART_Init_2
//   92   else
//   93     sysclk = periph_clk_khz;
??LPLD_UART_Init_1:
        LDR.N    R2,??DataTable5_4
        LDR      R2,[R2, #+0]
//   94   
//   95   //使能选中的UART串口通道时钟   
//   96   if(uartptr == UART0_BASE_PTR)
??LPLD_UART_Init_2:
        LDR.N    R3,??DataTable5_1  ;; 0x4006a000
        CMP      R0,R3
        BNE.N    ??LPLD_UART_Init_3
//   97   {
//   98     SIM_SCGC4 |= SIM_SCGC4_UART0_MASK;
        LDR.N    R3,??DataTable5_5  ;; 0x40048034
        LDR      R3,[R3, #+0]
        ORRS     R3,R3,#0x400
        LDR.N    R4,??DataTable5_5  ;; 0x40048034
        STR      R3,[R4, #+0]
//   99     //使能 PTB17 引脚的 UART0_TXD 功能 
//  100     PORTB_PCR17 = PORT_PCR_MUX(0x3); 
        LDR.N    R3,??DataTable5_6  ;; 0x4004a044
        MOV      R4,#+768
        STR      R4,[R3, #+0]
//  101     //使能 PTB16 引脚的 UART0_RXD 功能 
//  102     PORTB_PCR16 = PORT_PCR_MUX(0x3);
        LDR.N    R3,??DataTable5_7  ;; 0x4004a040
        MOV      R4,#+768
        STR      R4,[R3, #+0]
        B.N      ??LPLD_UART_Init_4
//  103   }
//  104   else
//  105   {
//  106     if (uartptr == UART1_BASE_PTR)
??LPLD_UART_Init_3:
        LDR.N    R3,??DataTable5_2  ;; 0x4006b000
        CMP      R0,R3
        BNE.N    ??LPLD_UART_Init_5
//  107     {
//  108       SIM_SCGC4 |= SIM_SCGC4_UART1_MASK;
        LDR.N    R3,??DataTable5_5  ;; 0x40048034
        LDR      R3,[R3, #+0]
        ORRS     R3,R3,#0x800
        LDR.N    R4,??DataTable5_5  ;; 0x40048034
        STR      R3,[R4, #+0]
//  109       SIM_SCGC4 |= SIM_SCGC4_UART2_MASK;
        LDR.N    R3,??DataTable5_5  ;; 0x40048034
        LDR      R3,[R3, #+0]
        ORRS     R3,R3,#0x1000
        LDR.N    R4,??DataTable5_5  ;; 0x40048034
        STR      R3,[R4, #+0]
//  110       //使能 PTC4 引脚的 UART1_TXD 功能 
//  111       PORTC_PCR4 = PORT_PCR_MUX(0x3); 
        LDR.N    R3,??DataTable5_8  ;; 0x4004b010
        MOV      R4,#+768
        STR      R4,[R3, #+0]
//  112       //使能 PTC3 引脚的 UART1_RXD 功能 
//  113       PORTC_PCR3 = PORT_PCR_MUX(0x3);
        LDR.N    R3,??DataTable5_9  ;; 0x4004b00c
        MOV      R4,#+768
        STR      R4,[R3, #+0]
        B.N      ??LPLD_UART_Init_4
//  114     }
//  115     else
//  116     {
//  117       if (uartptr == UART2_BASE_PTR)
??LPLD_UART_Init_5:
        LDR.N    R3,??DataTable5_10  ;; 0x4006c000
        CMP      R0,R3
        BNE.N    ??LPLD_UART_Init_6
//  118       {
//  119         SIM_SCGC4 |= SIM_SCGC4_UART2_MASK;
        LDR.N    R3,??DataTable5_5  ;; 0x40048034
        LDR      R3,[R3, #+0]
        ORRS     R3,R3,#0x1000
        LDR.N    R4,??DataTable5_5  ;; 0x40048034
        STR      R3,[R4, #+0]
//  120         //使能 PTD3 引脚的 UART2_TXD 功能 
//  121         PORTD_PCR3 = PORT_PCR_MUX(0x3); 
        LDR.N    R3,??DataTable5_11  ;; 0x4004c00c
        MOV      R4,#+768
        STR      R4,[R3, #+0]
//  122         //使能 PTD2 引脚的 UART2_RXD 功能 
//  123         PORTD_PCR2 = PORT_PCR_MUX(0x3);
        LDR.N    R3,??DataTable5_12  ;; 0x4004c008
        MOV      R4,#+768
        STR      R4,[R3, #+0]
        B.N      ??LPLD_UART_Init_4
//  124       }
//  125       else
//  126       {
//  127         if(uartptr == UART3_BASE_PTR)
??LPLD_UART_Init_6:
        LDR.N    R3,??DataTable5_13  ;; 0x4006d000
        CMP      R0,R3
        BNE.N    ??LPLD_UART_Init_7
//  128         {
//  129           SIM_SCGC4 |= SIM_SCGC4_UART3_MASK;
        LDR.N    R3,??DataTable5_5  ;; 0x40048034
        LDR      R3,[R3, #+0]
        ORRS     R3,R3,#0x2000
        LDR.N    R4,??DataTable5_5  ;; 0x40048034
        STR      R3,[R4, #+0]
//  130           //使能 PTC17 引脚的 UART3_TXD 功能 
//  131           PORTC_PCR15 = PORT_PCR_MUX(0x3); 
        LDR.N    R3,??DataTable5_14  ;; 0x4004b03c
        MOV      R4,#+768
        STR      R4,[R3, #+0]
//  132           //使能 PTC16 引脚的 UART3_RXD 功能 
//  133           PORTC_PCR14 = PORT_PCR_MUX(0x3);
        LDR.N    R3,??DataTable5_15  ;; 0x4004b038
        MOV      R4,#+768
        STR      R4,[R3, #+0]
        B.N      ??LPLD_UART_Init_4
//  134         }
//  135         else
//  136         {
//  137           if(uartptr == UART4_BASE_PTR)
??LPLD_UART_Init_7:
        LDR.N    R3,??DataTable5_16  ;; 0x400ea000
        CMP      R0,R3
        BNE.N    ??LPLD_UART_Init_8
//  138           {
//  139             SIM_SCGC1 |= SIM_SCGC1_UART4_MASK;
        LDR.N    R3,??DataTable5_17  ;; 0x40048028
        LDR      R3,[R3, #+0]
        ORRS     R3,R3,#0x400
        LDR.N    R4,??DataTable5_17  ;; 0x40048028
        STR      R3,[R4, #+0]
//  140             //使能 PTC15 引脚的 UART4_TXD 功能 
//  141             PORTC_PCR15 = PORT_PCR_MUX(0x3); 
        LDR.N    R3,??DataTable5_14  ;; 0x4004b03c
        MOV      R4,#+768
        STR      R4,[R3, #+0]
//  142             //使能 PTC14 引脚的 UART4_RXD 功能 
//  143             PORTC_PCR14 = PORT_PCR_MUX(0x3);
        LDR.N    R3,??DataTable5_15  ;; 0x4004b038
        MOV      R4,#+768
        STR      R4,[R3, #+0]
        B.N      ??LPLD_UART_Init_4
//  144           }
//  145           else
//  146           {
//  147             SIM_SCGC1 |= SIM_SCGC1_UART5_MASK;
??LPLD_UART_Init_8:
        LDR.N    R3,??DataTable5_17  ;; 0x40048028
        LDR      R3,[R3, #+0]
        ORRS     R3,R3,#0x800
        LDR.N    R4,??DataTable5_17  ;; 0x40048028
        STR      R3,[R4, #+0]
//  148             //使能 PTE8 引脚的 UART3_TXD 功能 
//  149             PORTE_PCR8 = PORT_PCR_MUX(0x3); 
        LDR.N    R3,??DataTable5_18  ;; 0x4004d020
        MOV      R4,#+768
        STR      R4,[R3, #+0]
//  150             //使能 PTE9 引脚的 UART3_RXD 功能 
//  151             PORTE_PCR9 = PORT_PCR_MUX(0x3); 
        LDR.N    R3,??DataTable5_19  ;; 0x4004d024
        MOV      R4,#+768
        STR      R4,[R3, #+0]
//  152           }
//  153         }
//  154       }
//  155     }
//  156   }
//  157   
//  158   //在配置好其他寄存器前，先关闭发送器和接收器
//  159   UART_C2_REG(uartptr) &= ~(UART_C2_TE_MASK | UART_C2_RE_MASK );
??LPLD_UART_Init_4:
        LDRB     R3,[R0, #+3]
        ANDS     R3,R3,#0xF3
        STRB     R3,[R0, #+3]
//  160   
//  161   //配置UART为 8位, 无奇偶校验 */
//  162   UART_C1_REG(uartptr) = 0;	
        MOVS     R3,#+0
        STRB     R3,[R0, #+2]
//  163   
//  164   //计算波特率
//  165   sbr = (uint16)((sysclk*1000)/(baud * 16));
        MOV      R3,#+1000
        MUL      R3,R3,R2
        LSLS     R4,R1,#+4
        SDIV     R3,R3,R4
//  166   
//  167   //保存UARTx_BDH寄存器中除了SBR的值
//  168   temp = UART_BDH_REG(uartptr) & ~(UART_BDH_SBR(0x1F));
        LDRB     R4,[R0, #+0]
        ANDS     R4,R4,#0xE0
//  169   
//  170   UART_BDH_REG(uartptr) = temp |  UART_BDH_SBR(((sbr & 0x1F00) >> 8));
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        LSRS     R5,R3,#+8
        ANDS     R5,R5,#0x1F
        ORRS     R4,R5,R4
        STRB     R4,[R0, #+0]
//  171   UART_BDL_REG(uartptr) = (uint8)(sbr & UART_BDL_SBR_MASK);
        STRB     R3,[R0, #+1]
//  172   
//  173   //配置波特率的微调分数
//  174   brfa = (((sysclk*32000)/(baud * 16)) - (sbr * 32));
        MOV      R4,#+32000
        MULS     R2,R4,R2
        LSLS     R1,R1,#+4
        SDIV     R1,R2,R1
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        SUBS     R1,R1,R3, LSL #+5
//  175   
//  176   //保存UARTx_C4寄存器中除了BRFA的值
//  177   temp = UART_C4_REG(uartptr) & ~(UART_C4_BRFA(0x1F));
        LDRB     R2,[R0, #+10]
        ANDS     R4,R2,#0xE0
//  178   
//  179   UART_C4_REG(uartptr) = temp |  UART_C4_BRFA(brfa);    
        ANDS     R1,R1,#0x1F
        ORRS     R1,R1,R4
        STRB     R1,[R0, #+10]
//  180   
//  181   //使能发送器和接收器
//  182   UART_C2_REG(uartptr) |= (UART_C2_TE_MASK | UART_C2_RE_MASK );
        LDRB     R1,[R0, #+3]
        ORRS     R1,R1,#0xC
        STRB     R1,[R0, #+3]
//  183 }
        POP      {R4,R5}
        BX       LR               ;; return
//  184 
//  185 /*
//  186  * LPLD_UART_GetChar
//  187  * 串口查询方式读取一个字节
//  188  * 
//  189  * 参数:
//  190  *    uartx--UART模块号
//  191  *      |__UART0          --UART0  -Txd:PTB17 -Rxd:PTB16
//  192  *      |__UART1          --UART1  -Txd:PTC4  -Rxd:PTC3
//  193  *      |__UART2          --UART2  -Txd:PTD3  -Rxd:PTD2
//  194  *      |__UART3          --UART3  -Txd:PTC17 -Rxd:PTC16
//  195  *      |__UART4          --UART4  -Txd:PTC15 -Rxd:PTC14
//  196  *      |__UART5          --UART5  -Txd:PTE8  -Rxd:PTE9
//  197  *
//  198  * 输出:
//  199  *    串口接收的1个字节
//  200  *
//  201  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  202 char LPLD_UART_GetChar(UARTx uartx)
//  203 {
//  204   UART_MemMapPtr uartptr = UARTx_Ptr[uartx];
LPLD_UART_GetChar:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable5
        LDR      R0,[R1, R0, LSL #+2]
//  205   
//  206   //等待数据接收
//  207   while (!(UART_S1_REG(uartptr) & UART_S1_RDRF_MASK));
??LPLD_UART_GetChar_0:
        LDRB     R1,[R0, #+4]
        LSLS     R1,R1,#+26
        BPL.N    ??LPLD_UART_GetChar_0
//  208   
//  209   //返回接收的1个字节数据
//  210   return UART_D_REG(uartptr);
        LDRB     R0,[R0, #+7]
        BX       LR               ;; return
//  211 }
//  212 
//  213 /*
//  214  * LPLD_UART_PutChar
//  215  * 串口查询方式发送一个字节
//  216  * 
//  217  * 参数:
//  218  *    uartx--UART模块号
//  219  *      |__UART0          --UART0  -Txd:PTB17 -Rxd:PTB16
//  220  *      |__UART1          --UART1  -Txd:PTC4  -Rxd:PTC3
//  221  *      |__UART2          --UART2  -Txd:PTD3  -Rxd:PTD2
//  222  *      |__UART3          --UART3  -Txd:PTC17 -Rxd:PTC16
//  223  *      |__UART4          --UART4  -Txd:PTC15 -Rxd:PTC14
//  224  *      |__UART5          --UART5  -Txd:PTE8  -Rxd:PTE9
//  225  *    ch--待发送的1个字节
//  226  *
//  227  * 输出:
//  228  *    无
//  229  *
//  230  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  231 void LPLD_UART_PutChar(UARTx uartx, char ch)
//  232 {
//  233   UART_MemMapPtr uartptr = UARTx_Ptr[uartx];
LPLD_UART_PutChar:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable5
        LDR      R0,[R2, R0, LSL #+2]
//  234   
//  235   //等待FIFO准备就绪
//  236   while(!(UART_S1_REG(uartptr) & UART_S1_TDRE_MASK));
??LPLD_UART_PutChar_0:
        LDRB     R2,[R0, #+4]
        LSLS     R2,R2,#+24
        BPL.N    ??LPLD_UART_PutChar_0
//  237   
//  238   //将要发送的1个字节发给UART数据寄存器
//  239   UART_D_REG(uartptr) = (uint8)ch;
        STRB     R1,[R0, #+7]
//  240 }
        BX       LR               ;; return
//  241 
//  242 
//  243 /*
//  244  * LPLD_UART_PutCharArr
//  245  * 串口查询方式发送字节型数组
//  246  * 
//  247  * 参数:
//  248  *    uartx--UART模块号
//  249  *      |__UART0          --UART0  -Txd:PTB17 -Rxd:PTB16
//  250  *      |__UART1          --UART1  -Txd:PTC4  -Rxd:PTC3
//  251  *      |__UART2          --UART2  -Txd:PTD3  -Rxd:PTD2
//  252  *      |__UART3          --UART3  -Txd:PTC17 -Rxd:PTC16
//  253  *      |__UART4          --UART4  -Txd:PTC15 -Rxd:PTC14
//  254  *      |__UART5          --UART5  -Txd:PTE8  -Rxd:PTE9
//  255  *    *ch--待发送的字节数组头地址
//  256  *    len--字节数组长度
//  257  *
//  258  * 输出:
//  259  *    无
//  260  *
//  261  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  262 void LPLD_UART_PutCharArr(UARTx uartx, char *ch, int len)
//  263 {
LPLD_UART_PutCharArr:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        B.N      ??LPLD_UART_PutCharArr_0
//  264   while(len--)
//  265   {
//  266     LPLD_UART_PutChar(uartx, *(ch++));
??LPLD_UART_PutCharArr_1:
        LDRB     R1,[R5, #+0]
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_UART_PutChar
        ADDS     R5,R5,#+1
//  267   }
??LPLD_UART_PutCharArr_0:
        MOVS     R0,R6
        SUBS     R6,R0,#+1
        CMP      R0,#+0
        BNE.N    ??LPLD_UART_PutCharArr_1
//  268 }
        POP      {R4-R6,PC}       ;; return
//  269 
//  270 /*
//  271  * LPLD_UART_RIE_Enable
//  272  * 使能串口数据接收中断，设置中断函数入口
//  273  * 
//  274  * 参数:
//  275  *    uartx--UART模块号
//  276  *      |__UART0          --UART0  -Txd:PTB17 -Rxd:PTB16
//  277  *      |__UART1          --UART1  -Txd:PTC4  -Rxd:PTC3
//  278  *      |__UART2          --UART2  -Txd:PTD3  -Rxd:PTD2
//  279  *      |__UART3          --UART3  -Txd:PTC17 -Rxd:PTC16
//  280  *      |__UART4          --UART4  -Txd:PTC15 -Rxd:PTC14
//  281  *      |__UART5          --UART5  -Txd:PTE8  -Rxd:PTE9
//  282  *    isr_func--数据接收中断程序入口地址
//  283  *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
//  284  *
//  285  * 输出:
//  286  *    无
//  287  *
//  288  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  289 void LPLD_UART_RIE_Enable(UARTx uartx, UART_ISR_CALLBACK isr_func)
//  290 {
LPLD_UART_RIE_Enable:
        PUSH     {R7,LR}
//  291   UART_MemMapPtr uartptr = UARTx_Ptr[uartx];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable5
        LDR      R2,[R2, R0, LSL #+2]
//  292   
//  293   UART_R_ISR[uartx] = isr_func;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R3,??DataTable5_20
        STR      R1,[R3, R0, LSL #+2]
//  294  
//  295   //使能UART接收中断
//  296   UART_C2_REG(uartptr) |= UART_C2_RIE_MASK; 
        LDRB     R1,[R2, #+3]
        ORRS     R1,R1,#0x20
        STRB     R1,[R2, #+3]
//  297   
//  298   //根据中断请求号使能相应中断
//  299   enable_irq( 45 + uartx*2);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+1
        ADDS     R0,R0,#+45
        BL       enable_irq
//  300 }
        POP      {R0,PC}          ;; return
//  301 
//  302 /*
//  303  * LPLD_UART_RIE_Disable
//  304  * 禁用串口数据接收中断
//  305  * 
//  306  * 参数:
//  307  *    uartx--UART模块号
//  308  *      |__UART0          --UART0  -Txd:PTB17 -Rxd:PTB16
//  309  *      |__UART1          --UART1  -Txd:PTC4  -Rxd:PTC3
//  310  *      |__UART2          --UART2  -Txd:PTD3  -Rxd:PTD2
//  311  *      |__UART3          --UART3  -Txd:PTC17 -Rxd:PTC16
//  312  *      |__UART4          --UART4  -Txd:PTC15 -Rxd:PTC14
//  313  *      |__UART5          --UART5  -Txd:PTE8  -Rxd:PTE9
//  314  *
//  315  * 输出:
//  316  *    无
//  317  *
//  318  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  319 void LPLD_UART_RIE_Disable(UARTx uartx)
//  320 {
LPLD_UART_RIE_Disable:
        PUSH     {R7,LR}
//  321   UART_MemMapPtr uartptr = UARTx_Ptr[uartx];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable5
        LDR      R1,[R1, R0, LSL #+2]
//  322  
//  323   //禁用UART接收中断
//  324   UART_C2_REG(uartptr) &= ~UART_C2_RIE_MASK;  
        LDRB     R2,[R1, #+3]
        ANDS     R2,R2,#0xDF
        STRB     R2,[R1, #+3]
//  325   
//  326   disable_irq( 45 + uartx*2);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+1
        ADDS     R0,R0,#+45
        BL       disable_irq
//  327 }
        POP      {R0,PC}          ;; return
//  328 
//  329 /*
//  330  * LPLD_UART_Isr
//  331  * UART通用中断底层入口函数
//  332  * 
//  333  * 用户无需修改，程序自动进入对应通道中断函数
//  334  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  335 void LPLD_UART_Isr(void)
//  336 {
LPLD_UART_Isr:
        PUSH     {R7,LR}
//  337   #define UART_VECTORNUM   (*(volatile uint8_t*)(0xE000ED04))
//  338   uint8_t uart_ch = (UART_VECTORNUM - 61)/2;
        LDR.N    R0,??DataTable5_21  ;; 0xe000ed04
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        SUBS     R0,R0,#+61
        MOVS     R1,#+2
        SDIV     R0,R0,R1
//  339   UART_MemMapPtr uartch = (UART_MemMapPtr)((0x4006A+uart_ch)<<12);
        LDR.N    R1,??DataTable5_22  ;; 0x4006a
        UXTAB    R1,R1,R0
        LSLS     R1,R1,#+12
//  340   if(uart_ch>3){
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BCC.N    ??LPLD_UART_Isr_0
//  341     uartch = (UART_MemMapPtr)((0x400E6+uart_ch)<<12);  
        LDR.N    R1,??DataTable5_23  ;; 0x400e6
        UXTAB    R1,R1,R0
        LSLS     R1,R1,#+12
//  342   }
//  343   
//  344   //进入接收中断函数
//  345   if(UART_S1_REG(uartch) & UART_S1_RDRF_MASK)
??LPLD_UART_Isr_0:
        LDRB     R1,[R1, #+4]
        LSLS     R1,R1,#+26
        BPL.N    ??LPLD_UART_Isr_1
//  346   {
//  347     UART_R_ISR[uart_ch]();
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable5_20
        LDR      R0,[R1, R0, LSL #+2]
        BLX      R0
//  348   }
//  349 }
??LPLD_UART_Isr_1:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     UARTx_Ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     0x4006a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     0x4006b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     core_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     periph_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     0x4004a044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     0x4004a040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     0x4004b010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_9:
        DC32     0x4004b00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_10:
        DC32     0x4006c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_11:
        DC32     0x4004c00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_12:
        DC32     0x4004c008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_13:
        DC32     0x4006d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_14:
        DC32     0x4004b03c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_15:
        DC32     0x4004b038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_16:
        DC32     0x400ea000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_17:
        DC32     0x40048028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_18:
        DC32     0x4004d020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_19:
        DC32     0x4004d024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_20:
        DC32     UART_R_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_21:
        DC32     0xe000ed04

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_22:
        DC32     0x4006a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_23:
        DC32     0x400e6

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
//  48 bytes in section .bss
//  24 bytes in section .data
// 642 bytes in section .text
// 
// 642 bytes of CODE memory
//  72 bytes of DATA memory
//
//Errors: none
//Warnings: none
