///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:09 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_SPI.c      /
//    Command line =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_SPI.c -D   /
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
//                    ar\RAM\List\HAL_SPI.s                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_SPI

        #define SHT_PROGBITS 0x1

        PUBLIC LPLD_SPI_Init
        PUBLIC LPLD_SPI_Master_Read
        PUBLIC LPLD_SPI_Master_Write
        PUBLIC LPLD_SPI_Master_WriteRead
        PUBLIC SPIx_Ptr

// D:\中国机器人大赛\robot_project\lib\LPLD\HAL_SPI.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_SPI.c
//   10  * 用途: SPI底层模块相关函数
//   11  * 最后修改日期: 20120321
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17  */
//   18 #include"HAL_SPI.h"
//   19 
//   20 /*
//   21 //SPI模块中断服务定义
//   22 #undef  VECTOR_042
//   23 #define VECTOR_042 LPLD_SPI_Isr
//   24 #undef  VECTOR_043
//   25 #define VECTOR_043 LPLD_SPI_Isr
//   26 #undef  VECTOR_044
//   27 #define VECTOR_044 LPLD_SPI_Isr
//   28 //以下函数在LPLD_Kinetis底层包，不必修改
//   29 extern void LPLD_SPI_Isr(void);
//   30 */
//   31 
//   32 //SPI映射地址数组

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   33 volatile SPI_MemMapPtr SPIx_Ptr[3] = {SPI0_BASE_PTR, 
SPIx_Ptr:
        DATA
        DC32 4002C000H, 4002D000H, 400AC000H
//   34                                       SPI1_BASE_PTR, 
//   35                                       SPI2_BASE_PTR};
//   36 
//   37 /*
//   38  * LPLD_SPI_Init
//   39  * SPI初始化函数
//   40  * 
//   41  * 参数:
//   42  *    spix--选择SPI通道
//   43  *      |__SPI0     PORTA15 SCK 
//   44  *                  PORTA16 SOUT (serial OUT)
//   45  *                  PORTA17 SIN  (serial IN)
//   46  *      |__SPI1     PORTB11 SCK 
//   47  *                  PORTB16 SOUT (serial OUT)
//   48  *                  PORTB17 SIN  (serial IN)
//   49  *      |__SPI2     PORTD12 SCK      
//   50  *                  PORTD13 SOUT (serial OUT)
//   51  *                  PORTD14 SIN  (serial IN)
//   52  *    sck_div--SCK SCK分频系数
//   53  *      由SCK的时钟源为系统外设总线时钟f_PBUSSYS，一般为50Mhz
//   54  *      SCK频率：F_SCK = (f_PBUSSYS/PBR) x [(1+DBR)/BR]
//   55  *      在初始化函数中将DBR = 1、PBR = 2 
//   56  *      经计算得 F_SCK = f_PBUSSYS/BR
//   57  *      BR = SPI_SCK_DIV_x
//   58  *      |__SPI_SCK_DIV_2      -2分频
//   59  *      |__SPI_SCK_DIV_4      -4分频
//   60  *      |__SPI_SCK_DIV_6      -6分频
//   61  *      |__SPI_SCK_DIV_8      -8分频
//   62  *      |__SPI_SCK_DIV_16     -16分频
//   63  *      |__SPI_SCK_DIV_32     -32分频
//   64  *      ......
//   65  *      |__SPI_SCK_DIV_8192   -8192分频
//   66  *      |__SPI_SCK_DIV_16384  -16384分频
//   67  *      |__SPI_SCK_DIV_32768  -32768分频
//   68  *
//   69  *    pcs_num--PCS端口的数量
//   70  *      如果 spix = SPI0
//   71  *      |__1--PCS0 PORTA14
//   72  *      |__2--PCS0 PORTA14
//   73  *            PCS1 PORTC3
//   74  *      |__3--PCS0 PORTA14
//   75  *            PCS1 PORTC3
//   76  *            PCS2 PORTC2
//   77  *      |__4--PCS0 PORTA14
//   78  *            PCS1 PORTC3
//   79  *            PCS2 PORTC2
//   80  *            PCS3 PORTC1
//   81  *      |__5--PCS0 PORTA14
//   82  *            PCS1 PORTC3
//   83  *            PCS2 PORTC2
//   84  *            PCS3 PORTC1
//   85  *            PCS4 PORTC0
//   86  *      |__6--PCS0 PORTA14
//   87  *            PCS1 PORTC3
//   88  *            PCS2 PORTC2
//   89  *            PCS3 PORTC1
//   90  *            PCS4 PORTC0
//   91  *            PCS5 PORTB23
//   92  *      如果 spix = SPI1
//   93  *      |__1--PCS0 PORTB10
//   94  *      |__2--PCS0 PORTB10
//   95  *            PCS1 PORTB9
//   96  *      |__3--PCS0 PORTB10
//   97  *            PCS1 PORTB9
//   98  *            PCS2 PORTE5
//   99  *      |__4--PCS0 PORTB10
//  100  *            PCS1 PORTB9
//  101  *            PCS2 PORTE5
//  102  *            PCS3 PORTE6
//  103  *      如果 spix = SPI2
//  104  *      |__1--PCS0 PORTD11
//  105  *      |__2--PCS0 PORTD11
//  106  *            PCS1 PORTD15
//  107  * 输出:
//  108  *    0：初始化错误
//  109  *    1：初始化成功
//  110  */
//  111 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  112 uint8 LPLD_SPI_Init(SPIx spix,uint8 sck_div,uint8 pcs_num)
//  113 {
LPLD_SPI_Init:
        PUSH     {R4}
//  114   SPI_MemMapPtr spi = SPIx_Ptr[spix];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R3,??DataTable3
        LDR      R3,[R3, R0, LSL #+2]
//  115   
//  116   switch(spix)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LPLD_SPI_Init_0
        CMP      R0,#+2
        BEQ.W    ??LPLD_SPI_Init_1
        BCC.W    ??LPLD_SPI_Init_2
        B.N      ??LPLD_SPI_Init_3
//  117   {
//  118     case SPI0:
//  119       //选择SPI模块时钟
//  120       SIM_SCGC6 |= SIM_SCGC6_DSPI0_MASK;  
??LPLD_SPI_Init_0:
        LDR.N    R0,??DataTable3_1  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R4,??DataTable3_1  ;; 0x4004803c
        STR      R0,[R4, #+0]
//  121       //配置SPI0接口
//  122       if(pcs_num > 6)
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+7
        BCC.N    ??LPLD_SPI_Init_4
//  123         return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_SPI_Init_5
//  124       //判断当前使用的PCS的个数
//  125       switch(pcs_num)
??LPLD_SPI_Init_4:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+1
        BEQ.N    ??LPLD_SPI_Init_6
        BCC.N    ??LPLD_SPI_Init_7
        CMP      R2,#+3
        BEQ.N    ??LPLD_SPI_Init_8
        BCC.N    ??LPLD_SPI_Init_9
        CMP      R2,#+5
        BEQ.N    ??LPLD_SPI_Init_10
        BCC.N    ??LPLD_SPI_Init_11
        CMP      R2,#+6
        BEQ.N    ??LPLD_SPI_Init_12
        B.N      ??LPLD_SPI_Init_7
//  126       {
//  127         case 1: PORTA_PCR14 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS0 
??LPLD_SPI_Init_6:
        LDR.N    R0,??DataTable3_2  ;; 0x40049038
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_13
//  128         
//  129         case 2: PORTA_PCR14 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS0 
??LPLD_SPI_Init_9:
        LDR.N    R0,??DataTable3_2  ;; 0x40049038
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  130                 PORTC_PCR3  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS1
        LDR.N    R0,??DataTable3_3  ;; 0x4004b00c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_13
//  131                 
//  132         case 3: PORTA_PCR14 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS0
??LPLD_SPI_Init_8:
        LDR.N    R0,??DataTable3_2  ;; 0x40049038
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  133                 PORTC_PCR3  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS1
        LDR.N    R0,??DataTable3_3  ;; 0x4004b00c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  134                 PORTC_PCR2  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS2
        LDR.N    R0,??DataTable3_4  ;; 0x4004b008
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_13
//  135                 
//  136         case 4: PORTA_PCR14 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS0
??LPLD_SPI_Init_11:
        LDR.N    R0,??DataTable3_2  ;; 0x40049038
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  137                 PORTC_PCR3  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS1
        LDR.N    R0,??DataTable3_3  ;; 0x4004b00c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  138                 PORTC_PCR2  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS2
        LDR.N    R0,??DataTable3_4  ;; 0x4004b008
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  139                 PORTC_PCR1  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS3
        LDR.N    R0,??DataTable3_5  ;; 0x4004b004
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_13
//  140                 
//  141         case 5: PORTA_PCR14 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS0
??LPLD_SPI_Init_10:
        LDR.N    R0,??DataTable3_2  ;; 0x40049038
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  142                 PORTC_PCR3  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS1
        LDR.N    R0,??DataTable3_3  ;; 0x4004b00c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  143                 PORTC_PCR2  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS2
        LDR.N    R0,??DataTable3_4  ;; 0x4004b008
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  144                 PORTC_PCR1  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS3
        LDR.N    R0,??DataTable3_5  ;; 0x4004b004
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  145                 PORTC_PCR0  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS4
        LDR.N    R0,??DataTable3_6  ;; 0x4004b000
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_13
//  146                 
//  147         case 6: PORTA_PCR14 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS0
??LPLD_SPI_Init_12:
        LDR.N    R0,??DataTable3_2  ;; 0x40049038
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  148                 PORTC_PCR3  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS1
        LDR.N    R0,??DataTable3_3  ;; 0x4004b00c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  149                 PORTC_PCR2  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS2
        LDR.N    R0,??DataTable3_4  ;; 0x4004b008
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  150                 PORTC_PCR1  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS3
        LDR.N    R0,??DataTable3_5  ;; 0x4004b004
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  151                 PORTC_PCR0  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS4
        LDR.N    R0,??DataTable3_6  ;; 0x4004b000
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  152                 PORTB_PCR23 = 0 | PORT_PCR_MUX(3) | PORT_PCR_DSE_MASK; break;//PCS5
        LDR.N    R0,??DataTable3_7  ;; 0x4004a05c
        MOV      R2,#+832
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_13
//  153         default:break;
//  154       }
//  155       
//  156       PORTA_PCR15 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;//SCK
??LPLD_SPI_Init_7:
??LPLD_SPI_Init_13:
        LDR.N    R0,??DataTable3_8  ;; 0x4004903c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  157       PORTA_PCR16 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;//SOUT
        LDR.N    R0,??DataTable3_9  ;; 0x40049040
        MOV      R2,#+576
        STR      R2,[R0, #+0]
//  158       PORTA_PCR17 = 0 | PORT_PCR_MUX(2);                    //SIN
        LDR.N    R0,??DataTable3_10  ;; 0x40049044
        MOV      R2,#+512
        STR      R2,[R0, #+0]
//  159      
//  160       break;
//  161     case SPI1:
//  162       //选择SPI模块时钟
//  163       SIM_SCGC6 |= SIM_SCGC6_SPI1_MASK;
//  164       if(pcs_num > 4)
//  165         return 0;
//  166       //判断当前使用的PCS的个数
//  167       switch(pcs_num)
//  168       {
//  169         case 1: PORTB_PCR10 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS0 
//  170         
//  171         case 2: PORTB_PCR10 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS0 
//  172                 PORTB_PCR9  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS1
//  173                 
//  174         case 3: PORTB_PCR10 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS0 
//  175                 PORTB_PCR9  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS1
//  176                 PORTE_PCR5  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS2
//  177                 
//  178         case 4: PORTB_PCR10 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS0 
//  179                 PORTB_PCR9  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS1
//  180                 PORTE_PCR5  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS2   
//  181                 PORTE_PCR6  = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;break; //PCS3
//  182         default:break;
//  183       }
//  184       //配置SPI1接口
//  185       PORTB_PCR11 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;//SCK
//  186       PORTB_PCR16 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;//SOUT
//  187       PORTB_PCR17 = 0 | PORT_PCR_MUX(2);                    //SIN
//  188       break;
//  189     case SPI2:
//  190       //选择SPI模块时钟
//  191       SIM_SCGC3 |= SIM_SCGC3_SPI2_MASK;
//  192       if(pcs_num > 2)
//  193         return 0;
//  194       //判断当前使用的PCS的个数
//  195       switch(pcs_num)
//  196       {
//  197         case 1: PORTD_PCR11 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS0 
//  198         
//  199         case 2: PORTD_PCR11 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;       //PCS0 
//  200                 PORTD_PCR15 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK; break;//PCS1
//  201         default:break;
//  202       }
//  203       //配置SPI2接口
//  204       
//  205       PORTD_PCR12 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;//SCK
//  206       PORTD_PCR13 = 0 | PORT_PCR_MUX(2) | PORT_PCR_DSE_MASK;//SOUT
//  207       PORTD_PCR14 = 0 | PORT_PCR_MUX(2);                    //SIN
//  208       break;
//  209     default: return 0; 
//  210   }
//  211   //配置SPI MCR寄存器
//  212   SPI_MCR_REG(spi) = 0 & (~SPI_MCR_MDIS_MASK) //使能SPI时钟
//  213                     |SPI_MCR_HALT_MASK        //让SPI进入停止模式
//  214                     |SPI_MCR_MSTR_MASK        //配置SPI为主机模式
//  215                     |SPI_MCR_PCSIS_MASK       //PCS为高电平当在SPI不工作的时候
//  216                     |SPI_MCR_CLR_TXF_MASK     //首先要清除MDIS，清除TXF_MASK和RXF_MASK
//  217                     |SPI_MCR_CLR_RXF_MASK  
//  218                     |SPI_MCR_DIS_TXF_MASK     //然后再禁止TXD和RXD FIFO 模式 ，将SPI配置成正常模式
//  219                     |SPI_MCR_DIS_RXF_MASK; 
??LPLD_SPI_Init_14:
        LDR.N    R0,??DataTable3_11  ;; 0x803f3c01
        STR      R0,[R3, #+0]
//  220   
//  221   //配置SPI CTAR寄存器
//  222   SPI_CTAR_REG(spi,0) = 0 | SPI_CTAR_DBR_MASK  //设置DBR = 1
//  223                     |SPI_CTAR_PBR(0)           //设置PBR = 2,上述两步配置占空比为50%
//  224                     |SPI_CTAR_FMSZ(7)          //设置一帧为8位，一个字节数据
//  225                     &~(SPI_CTAR_LSBFE_MASK);   //高位在前传输
        MOVS     R0,#-1207959552
        STR      R0,[R3, #+12]
//  226                                                //不活动时SCK为高
//  227   //==================配置 Spi 时序======================
//  228   //配置SCK的频率
//  229   //F_SCK = (fSYS/PBR) x [(1+DBR)/BR]
//  230   //现在DBR = 1、PBR = 2 经计算得 F_SCK = fSYS/BR
//  231   SPI_CTAR_REG(spi,0) |=SPI_CTAR_BR(sck_div);
        LDR      R0,[R3, #+12]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ANDS     R1,R1,#0xF
        ORRS     R0,R1,R0
        STR      R0,[R3, #+12]
//  232   //配置PCS to SCK的延时
//  233   //tCSC = (1/fSYS) x PCSSCK x CSSCK
//  234   //tCSC = 1/150,000,000 x PCSSCK x CSSCK
//  235   SPI_CTAR_REG(spi,0) |=SPI_CTAR_PCSSCK(1); // Prescaler value is 3.
        LDR      R0,[R3, #+12]
        ORRS     R0,R0,#0x400000
        STR      R0,[R3, #+12]
//  236   SPI_CTAR_REG(spi,0) |=SPI_CTAR_CSSCK(1);  // Delay Scaler Value is 4.
        LDR      R0,[R3, #+12]
        ORRS     R0,R0,#0x1000
        STR      R0,[R3, #+12]
//  237   
//  238   //配置 PCS 结束 to 系一个帧开始延时
//  239   //tDT = (1/fSYS) x PDT x DT
//  240   SPI_CTAR_REG(spi,0) |=SPI_CTAR_DT(1);
        LDR      R0,[R3, #+12]
        ORRS     R0,R0,#0x10
        STR      R0,[R3, #+12]
//  241   SPI_CTAR_REG(spi,0) |=SPI_CTAR_PDT(1);
        LDR      R0,[R3, #+12]
        ORRS     R0,R0,#0x40000
        STR      R0,[R3, #+12]
//  242   
//  243   //Config the Delay of the last edge of SCK and the negation of PCS
//  244   //tASC = (1/fSYS) x PASC x ASC
//  245   SPI_CTAR_REG(spi,0) |=SPI_CTAR_PASC(1);
        LDR      R0,[R3, #+12]
        ORRS     R0,R0,#0x100000
        STR      R0,[R3, #+12]
//  246   SPI_CTAR_REG(spi,0) |=SPI_CTAR_ASC(1);
        LDR      R0,[R3, #+12]
        MOV      R1,#+256
        ORRS     R0,R1,R0
        STR      R0,[R3, #+12]
//  247   //===============配置 Spi 时序完成====================== 
//  248   
//  249   SPI_SR_REG(spi) =  SPI_SR_RFDF_MASK   //清除状态标识
//  250                     |SPI_SR_RFOF_MASK
//  251                     |SPI_SR_TFFF_MASK
//  252                     |SPI_SR_TFUF_MASK
//  253                     |SPI_SR_TCF_MASK
//  254                     |SPI_SR_EOQF_MASK;
        LDR.N    R0,??DataTable3_12  ;; 0x9a0a0000
        STR      R0,[R3, #+44]
//  255   
//  256   SPI_MCR_REG(spi) &=~SPI_MCR_HALT_MASK; //退出等待模式,SPI开始工作
        LDR      R0,[R3, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        STR      R0,[R3, #+0]
//  257   
//  258   return 1;
        MOVS     R0,#+1
??LPLD_SPI_Init_5:
        POP      {R4}
        BX       LR               ;; return
??LPLD_SPI_Init_2:
        LDR.N    R0,??DataTable3_1  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.N    R4,??DataTable3_1  ;; 0x4004803c
        STR      R0,[R4, #+0]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+5
        BCC.N    ??LPLD_SPI_Init_15
        MOVS     R0,#+0
        B.N      ??LPLD_SPI_Init_5
??LPLD_SPI_Init_15:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+1
        BEQ.N    ??LPLD_SPI_Init_16
        BCC.N    ??LPLD_SPI_Init_17
        CMP      R2,#+3
        BEQ.N    ??LPLD_SPI_Init_18
        BCC.N    ??LPLD_SPI_Init_19
        CMP      R2,#+4
        BEQ.N    ??LPLD_SPI_Init_20
        B.N      ??LPLD_SPI_Init_17
??LPLD_SPI_Init_16:
        LDR.N    R0,??DataTable3_13  ;; 0x4004a028
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_21
??LPLD_SPI_Init_19:
        LDR.N    R0,??DataTable3_13  ;; 0x4004a028
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_14  ;; 0x4004a024
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_21
??LPLD_SPI_Init_18:
        LDR.N    R0,??DataTable3_13  ;; 0x4004a028
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_14  ;; 0x4004a024
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_15  ;; 0x4004d014
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_21
??LPLD_SPI_Init_20:
        LDR.N    R0,??DataTable3_13  ;; 0x4004a028
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_14  ;; 0x4004a024
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_15  ;; 0x4004d014
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_16  ;; 0x4004d018
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_21
??LPLD_SPI_Init_17:
??LPLD_SPI_Init_21:
        LDR.N    R0,??DataTable3_17  ;; 0x4004a02c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_18  ;; 0x4004a040
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_19  ;; 0x4004a044
        MOV      R2,#+512
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_14
??LPLD_SPI_Init_1:
        LDR.N    R0,??DataTable3_20  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R4,??DataTable3_20  ;; 0x40048030
        STR      R0,[R4, #+0]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+3
        BCC.N    ??LPLD_SPI_Init_22
        MOVS     R0,#+0
        B.N      ??LPLD_SPI_Init_5
??LPLD_SPI_Init_22:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+1
        BEQ.N    ??LPLD_SPI_Init_23
        CMP      R2,#+2
        BEQ.N    ??LPLD_SPI_Init_24
        B.N      ??LPLD_SPI_Init_25
??LPLD_SPI_Init_23:
        LDR.N    R0,??DataTable3_21  ;; 0x4004c02c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_26
??LPLD_SPI_Init_24:
        LDR.N    R0,??DataTable3_21  ;; 0x4004c02c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_22  ;; 0x4004c03c
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_26
??LPLD_SPI_Init_25:
??LPLD_SPI_Init_26:
        LDR.N    R0,??DataTable3_23  ;; 0x4004c030
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_24  ;; 0x4004c034
        MOV      R2,#+576
        STR      R2,[R0, #+0]
        LDR.N    R0,??DataTable3_25  ;; 0x4004c038
        MOV      R2,#+512
        STR      R2,[R0, #+0]
        B.N      ??LPLD_SPI_Init_14
??LPLD_SPI_Init_3:
        MOVS     R0,#+0
        B.N      ??LPLD_SPI_Init_5
//  259 }
//  260 
//  261 
//  262 
//  263 /*
//  264  * LPLD_SPI_Master_WriteRead
//  265  * K60主机SPI向从机写数据，并读取从机数据
//  266  * 
//  267  * 参数:
//  268  *    spix--SPI选择
//  269  *      |__SPI0       -选择SPI0模块
//  270  *      |__SPI1       -选择SPI1模块
//  271  *      |__SPI2       -选择SPI2模块
//  272  *    data--要发送数据
//  273  *      |__单位为一个字节，8位
//  274  *    pcsx--CS片选端口号
//  275  *      |__SPI_PCS0       -0号片选(SPI0、SPI1、SPI2含有)
//  276  *      |__SPI_PCS1       -1号片选(SPI0、SPI1、SPI2含有)
//  277  *      |__SPI_PCS2       -2号片选(SPI0、SPI1含有)
//  278  *      |__SPI_PCS3       -3号片选(SPI0、SPI1含有)
//  279  *      |__SPI_PCS4       -4号片选(SPI0含有)
//  280  *      |__SPI_PCS5       -5号片选(SPI0含有)
//  281  *    pcs_state--一帧数据传输完成后CS的状态
//  282  *      |__SPI_PCS_ASSERTED -保持片选有效
//  283  *      |__SPI_PCS_INACTIVE -片选无效
//  284  * 输出:
//  285  *    8位的读取从机的数据
//  286  */
//  287 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  288 uint8 LPLD_SPI_Master_WriteRead(SPIx spix,uint8 data,uint8 pcsx,uint8 pcs_state)
//  289 {
LPLD_SPI_Master_WriteRead:
        PUSH     {R4}
//  290   uint8 temp;
//  291   SPI_MemMapPtr spi = SPIx_Ptr[spix];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R4,??DataTable3
        LDR      R4,[R4, R0, LSL #+2]
//  292   
//  293   //根据pcs_state选择片选是否有效
//  294   SPI_PUSHR_REG(spi) = (((uint32_t)(((uint32_t)(pcs_state))<<SPI_PUSHR_CONT_SHIFT))&SPI_PUSHR_CONT_MASK)
//  295                |SPI_PUSHR_CTAS(0)
//  296                |SPI_PUSHR_PCS(pcsx)
//  297                |data;                 
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LSLS     R0,R2,#+16
        ANDS     R0,R0,#0x3F0000
        ORRS     R0,R0,R3, LSL #+31
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ORRS     R0,R1,R0
        STR      R0,[R4, #+52]
//  298   
//  299   while(!(SPI_SR_REG(spi) & SPI_SR_TCF_MASK));
??LPLD_SPI_Master_WriteRead_0:
        LDR      R0,[R4, #+44]
        CMP      R0,#+0
        BPL.N    ??LPLD_SPI_Master_WriteRead_0
//  300   SPI_SR_REG(spi) |= SPI_SR_TCF_MASK ;               //清除发送缓冲标志位
        LDR      R0,[R4, #+44]
        ORRS     R0,R0,#0x80000000
        STR      R0,[R4, #+44]
//  301   
//  302   //使接收缓冲器为空
//  303   while((SPI_SR_REG(spi) & SPI_SR_RFDF_MASK) == 0){}; //RX FIFO 未接收到数据则一直等待
??LPLD_SPI_Master_WriteRead_1:
        LDR      R0,[R4, #+44]
        LSLS     R0,R0,#+14
        BPL.N    ??LPLD_SPI_Master_WriteRead_1
//  304   temp = (uint8)(SPI_POPR_REG(spi) & 0xff);           //数据以32位形式存在POPR中，转化格式 
        LDR      R0,[R4, #+56]
//  305   SPI_SR_REG(spi) |= SPI_SR_RFDF_MASK;                //清除标志位
        LDR      R1,[R4, #+44]
        ORRS     R1,R1,#0x20000
        STR      R1,[R4, #+44]
//  306   return temp;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4}
        BX       LR               ;; return
//  307   
//  308 }
//  309 
//  310 
//  311 /*
//  312  * LPLD_SPI_Master_Read
//  313  * K60主机读取从机数据
//  314  * 
//  315  * 参数:
//  316  *    spix--SPI选择
//  317  *      |__SPI0       -选择SPI0模块
//  318  *      |__SPI1       -选择SPI1模块
//  319  *      |__SPI2       -选择SPI2模块
//  320  * 输出:
//  321  *    8位的读取从机的数据
//  322  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  323 uint8 LPLD_SPI_Master_Read(SPIx spix)
//  324 {
//  325   uint8 temp;
//  326   SPI_MemMapPtr spi = SPIx_Ptr[spix];
LPLD_SPI_Master_Read:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable3
        LDR      R1,[R1, R0, LSL #+2]
//  327 
//  328   while(!(SPI_SR_REG(spi) & SPI_SR_RFDF_MASK)); //=1 RIFO is not empty
??LPLD_SPI_Master_Read_0:
        LDR      R0,[R1, #+44]
        LSLS     R0,R0,#+14
        BPL.N    ??LPLD_SPI_Master_Read_0
//  329   temp=(uint8)SPI_POPR_REG(spi);
        LDR      R0,[R1, #+56]
//  330   SPI_SR_REG(spi) |=SPI_SR_RFDF_MASK;
        LDR      R2,[R1, #+44]
        ORRS     R2,R2,#0x20000
        STR      R2,[R1, #+44]
//  331 
//  332   return temp;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  333 }
//  334 /*
//  335  * LPLD_SPI_Master_Write
//  336  * K60主机SPI向从机写数据
//  337  * 
//  338  * 参数:
//  339  *    spix--SPI选择
//  340  *      |__SPI0       -选择SPI0模块
//  341  *      |__SPI1       -选择SPI1模块
//  342  *      |__SPI2       -选择SPI2模块
//  343  *    data--要发送数据
//  344  *      |__单位为一个字节，8位
//  345  *    pcsx--CS片选端口号
//  346  *      |__SPI_PCS0       -0号片选(SPI0、SPI1、SPI2含有)
//  347  *      |__SPI_PCS1       -1号片选(SPI0、SPI1、SPI2含有)
//  348  *      |__SPI_PCS2       -2号片选(SPI0、SPI1含有)
//  349  *      |__SPI_PCS3       -3号片选(SPI0、SPI1含有)
//  350  *      |__SPI_PCS4       -4号片选(SPI0含有)
//  351  *      |__SPI_PCS5       -5号片选(SPI0含有)
//  352  *    pcs_state--一帧数据传输完成后CS的状态
//  353  *      |__SPI_PCS_ASSERTED -保持片选有效
//  354  *      |__SPI_PCS_INACTIVE -片选无效
//  355  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  356 void LPLD_SPI_Master_Write(SPIx spix,uint8 data,uint8 pcsx,uint8 pcs_state)
//  357 {  
LPLD_SPI_Master_Write:
        PUSH     {R4}
//  358   SPI_MemMapPtr spi = SPIx_Ptr[spix];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R4,??DataTable3
        LDR      R0,[R4, R0, LSL #+2]
//  359 
//  360   //根据pcs_state选择片选是否有效
//  361   SPI_PUSHR_REG(spi) = (((uint32_t)(((uint32_t)(pcs_state))<<SPI_PUSHR_CONT_SHIFT))&SPI_PUSHR_CONT_MASK)
//  362                |SPI_PUSHR_CTAS(0)
//  363                |SPI_PUSHR_PCS(pcsx)
//  364                |data; 
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LSLS     R2,R2,#+16
        ANDS     R2,R2,#0x3F0000
        ORRS     R2,R2,R3, LSL #+31
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ORRS     R1,R1,R2
        STR      R1,[R0, #+52]
//  365 
//  366   while(!(SPI_SR_REG(spi) & SPI_SR_TCF_MASK));
??LPLD_SPI_Master_Write_0:
        LDR      R1,[R0, #+44]
        CMP      R1,#+0
        BPL.N    ??LPLD_SPI_Master_Write_0
//  367   SPI_SR_REG(spi) |= SPI_SR_TCF_MASK ;            //清除发送缓冲标志位
        LDR      R1,[R0, #+44]
        ORRS     R1,R1,#0x80000000
        STR      R1,[R0, #+44]
//  368 }
        POP      {R4}
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     SPIx_Ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     0x40049038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     0x4004b00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     0x4004b008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     0x4004b004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     0x4004b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     0x4004a05c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     0x4004903c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     0x40049040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_10:
        DC32     0x40049044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_11:
        DC32     0x803f3c01

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_12:
        DC32     0x9a0a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_13:
        DC32     0x4004a028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_14:
        DC32     0x4004a024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_15:
        DC32     0x4004d014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_16:
        DC32     0x4004d018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_17:
        DC32     0x4004a02c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_18:
        DC32     0x4004a040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_19:
        DC32     0x4004a044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_20:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_21:
        DC32     0x4004c02c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_22:
        DC32     0x4004c03c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_23:
        DC32     0x4004c030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_24:
        DC32     0x4004c034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_25:
        DC32     0x4004c038

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  369 
//  370 
//  371 
//  372 
// 
//  12 bytes in section .data
// 864 bytes in section .text
// 
// 864 bytes of CODE memory
//  12 bytes of DATA memory
//
//Errors: none
//Warnings: none
