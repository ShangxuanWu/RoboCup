///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:58 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\HAL_SDHC.c                /
//    Command line =  "F:\robot _init\robot\lib\LPLD\HAL_SDHC.c" -D IAR -D    /
//                    LPLD_K60 -lCN "F:\robot _init\robot\project\robot_car_c /
//                    om\iar\FLASH\List\" -lB "F:\robot                       /
//                    _init\robot\project\robot_car_com\iar\FLASH\List\" -o   /
//                    "F:\robot _init\robot\project\robot_car_com\iar\FLASH\O /
//                    bj\" --no_cse --no_unroll --no_inline --no_code_motion  /
//                    --no_tbaa --no_clustering --no_scheduling --debug       /
//                    --endian=little --cpu=Cortex-M4 -e --fpu=None           /
//                    --dlib_config "D:\IAR Systems\Embedded Workbench        /
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
//                    st\HAL_SDHC.s                                           /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_SDHC

        #define SHT_PROGBITS 0x1

        EXTERN core_clk_khz
        EXTERN malloc

        PUBLIC LPLD_SDHC_IOC
        PUBLIC LPLD_SDHC_InitCard
        PUBLIC LPLD_SDHC_ReadBlocks
        PUBLIC LPLD_SDHC_WriteBlocks
        PUBLIC sdcard_ptr

// F:\robot _init\robot\lib\LPLD\HAL_SDHC.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_SDHC.c
//   10  * 用途: SDHC底层模块相关函数
//   11  * 最后修改日期: 20130214
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17  *
//   18  * 版权说明:
//   19  *  SDHC模块驱动程序摘取自飞思卡尔MQX底层驱动，部分功能由拉普兰德修改。
//   20  *  HAL_SDHC.h及HAL_SDHC.c内的代码版权归飞思卡尔公司享有。
//   21  */
//   22 
//   23 #include "common.h"
//   24 #include "HAL_SDHC.h"
//   25 
//   26 //SD卡信息全局变量

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27 SDCARD_STRUCT_PTR        sdcard_ptr;
sdcard_ptr:
        DS8 4
//   28 //引用内核时钟
//   29 extern int core_clk_khz;
//   30 
//   31 
//   32 /*
//   33  * LPLD_SDHC_InitGPIO
//   34  * 初始化SDHC模块相关的GPIO引脚,并使能SDHC寄存器时钟
//   35  * 
//   36  * 参数:
//   37  *    init--PCR寄存器掩码
//   38  *
//   39  * 输出:
//   40  *    无
//   41  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   42 static void LPLD_SDHC_InitGPIO(uint32 init)
//   43 {  
//   44   PORTE_PCR0 = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.D1  */
LPLD_SDHC_InitGPIO:
        MOVW     R1,#+1091
        ANDS     R1,R1,R0
        LDR.W    R2,??DataTable8  ;; 0x4004d000
        STR      R1,[R2, #+0]
//   45   PORTE_PCR1 = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.D0  */
        MOVW     R1,#+1091
        ANDS     R1,R1,R0
        LDR.W    R2,??DataTable8_1  ;; 0x4004d004
        STR      R1,[R2, #+0]
//   46   PORTE_PCR2 = init & (PORT_PCR_MUX(4) | PORT_PCR_DSE_MASK);                                          /* SDHC.CLK */
        ANDS     R1,R0,#0x440
        LDR.W    R2,??DataTable8_2  ;; 0x4004d008
        STR      R1,[R2, #+0]
//   47   PORTE_PCR3 = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.CMD */
        MOVW     R1,#+1091
        ANDS     R1,R1,R0
        LDR.W    R2,??DataTable8_3  ;; 0x4004d00c
        STR      R1,[R2, #+0]
//   48   PORTE_PCR4 = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.D3  */
        MOVW     R1,#+1091
        ANDS     R1,R1,R0
        LDR.W    R2,??DataTable8_4  ;; 0x4004d010
        STR      R1,[R2, #+0]
//   49   PORTE_PCR5 = init & (PORT_PCR_MUX(4) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_DSE_MASK);    /* SDHC.D2  */
        MOVW     R1,#+1091
        ANDS     R0,R1,R0
        LDR.W    R1,??DataTable8_5  ;; 0x4004d014
        STR      R0,[R1, #+0]
//   50   
//   51   SIM_SCGC3 |= SIM_SCGC3_SDHC_MASK; 
        LDR.W    R0,??DataTable9  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20000
        LDR.W    R1,??DataTable9  ;; 0x40048030
        STR      R0,[R1, #+0]
//   52 }
        BX       LR               ;; return
//   53 
//   54 
//   55 /*
//   56  * LPLD_SDHC_SetBaudrate
//   57  * 设置SDHC波特率
//   58  * 
//   59  * 参数:
//   60  *    clock--模块输入时钟，即core_clk_khz*1000，单位Hz
//   61  *    baud--SDHC期望时钟频率，单位Hz
//   62  *
//   63  * 输出:
//   64  *    无
//   65  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   66 static void LPLD_SDHC_SetBaudrate(uint32 clock, uint32 baud)
//   67 {
LPLD_SDHC_SetBaudrate:
        PUSH     {R4-R7}
//   68   uint32 pres, div, min, minpres = 0x80, mindiv = 0x0F;
        MOVS     R2,#+128
        MOVS     R3,#+15
//   69   int32  val;
//   70   
//   71   //找到相近的分频因子
//   72   min = (uint32)-1;
        MOVS     R6,#-1
//   73   for (pres = 2; pres <= 256; pres <<= 1)
        MOVS     R4,#+2
        B.N      ??LPLD_SDHC_SetBaudrate_0
//   74   {
//   75     for (div = 1; div <= 16; div++)
//   76     {
//   77       val = pres * div * baud - clock;
??LPLD_SDHC_SetBaudrate_1:
        MUL      R7,R5,R4
        MULS     R7,R1,R7
        SUBS     R7,R7,R0
//   78       if (val >= 0)
        CMP      R7,#+0
        BMI.N    ??LPLD_SDHC_SetBaudrate_2
//   79       {
//   80         if (min > val)
        CMP      R7,R6
        BCS.N    ??LPLD_SDHC_SetBaudrate_2
//   81         {
//   82           min = val;
        MOVS     R6,R7
//   83           minpres = pres;
        MOVS     R2,R4
//   84           mindiv = div;
        MOVS     R3,R5
//   85         }
//   86       }
//   87     }
??LPLD_SDHC_SetBaudrate_2:
        ADDS     R5,R5,#+1
??LPLD_SDHC_SetBaudrate_3:
        CMP      R5,#+17
        BCC.N    ??LPLD_SDHC_SetBaudrate_1
        LSLS     R4,R4,#+1
??LPLD_SDHC_SetBaudrate_0:
        CMP      R4,#+256
        BHI.N    ??LPLD_SDHC_SetBaudrate_4
        MOVS     R5,#+1
        B.N      ??LPLD_SDHC_SetBaudrate_3
//   88   }
//   89   
//   90   //禁止SDHC模块时钟
//   91   SDHC_BASE_PTR->SYSCTL &= (~ SDHC_SYSCTL_SDCLKEN_MASK);
??LPLD_SDHC_SetBaudrate_4:
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x8
        LDR.W    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//   92   
//   93   //修改分频因子
//   94   div = SDHC_BASE_PTR->SYSCTL & (~ (SDHC_SYSCTL_DTOCV_MASK | SDHC_SYSCTL_SDCLKFS_MASK | SDHC_SYSCTL_DVS_MASK));
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        MOVS     R5,R0
        BFC      R5,#+4,#+16
//   95   SDHC_BASE_PTR->SYSCTL = div | (SDHC_SYSCTL_DTOCV(0x0E) | SDHC_SYSCTL_SDCLKFS(minpres >> 1) | SDHC_SYSCTL_DVS(mindiv - 1));
        LSLS     R0,R2,#+7
        ANDS     R0,R0,#0xFF00
        ORRS     R0,R0,R5
        SUBS     R1,R3,#+1
        LSLS     R1,R1,#+4
        ANDS     R1,R1,#0xF0
        ORRS     R0,R1,R0
        ORRS     R0,R0,#0xE0000
        LDR.W    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//   96   
//   97   //等在时钟稳定
//   98   while (0 == (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_SDSTB_MASK))
??LPLD_SDHC_SetBaudrate_5:
        LDR.W    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BPL.N    ??LPLD_SDHC_SetBaudrate_5
//   99   {};
//  100   
//  101   //使能SDHC模块时钟
//  102   SDHC_BASE_PTR->SYSCTL |= SDHC_SYSCTL_SDCLKEN_MASK;
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8
        LDR.W    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  103   SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DTOE_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x100000
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  104 }
        POP      {R4-R7}
        BX       LR               ;; return
//  105 
//  106 /*
//  107  * LPLD_SDHC_IsRunning
//  108  * 获取SDHC模块运行状态
//  109  * 
//  110  * 参数:
//  111  *    无
//  112  *
//  113  * 输出:
//  114  *    TRUE--正在运行
//  115  *    FALSE--停止运行
//  116  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  117 static boolean LPLD_SDHC_IsRunning(void)
//  118 {
//  119   return (0 != (SDHC_BASE_PTR->PRSSTAT & (SDHC_PRSSTAT_RTA_MASK | SDHC_PRSSTAT_WTA_MASK | SDHC_PRSSTAT_DLA_MASK | SDHC_PRSSTAT_CDIHB_MASK | SDHC_PRSSTAT_CIHB_MASK)));
LPLD_SDHC_IsRunning:
        LDR.W    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        MOVW     R1,#+775
        TST      R0,R1
        BEQ.N    ??LPLD_SDHC_IsRunning_0
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_IsRunning_1
??LPLD_SDHC_IsRunning_0:
        MOVS     R0,#+0
??LPLD_SDHC_IsRunning_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  120 }
//  121 
//  122 /*
//  123  * LPLD_SDHC_WaitStatus
//  124  * 等待指定状态标志位置位
//  125  * 
//  126  * 参数:
//  127  *    mask--状态标志位掩码
//  128  *
//  129  * 输出:
//  130  *    状态标志
//  131  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  132 static uint32 LPLD_SDHC_WaitStatus(uint32 mask)
//  133 {
//  134   uint32 result;
//  135   do
//  136   {
//  137     result = SDHC_BASE_PTR->IRQSTAT & mask;
LPLD_SDHC_WaitStatus:
??LPLD_SDHC_WaitStatus_0:
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        LDR      R1,[R1, #+0]
        ANDS     R1,R0,R1
//  138   }
//  139   while (0 == result);
        CMP      R1,#+0
        BEQ.N    ??LPLD_SDHC_WaitStatus_0
//  140   return result;
        MOVS     R0,R1
        BX       LR               ;; return
//  141 }
//  142 
//  143 /*
//  144  * LPLD_SDHC_Init
//  145  * SDHC模块初始化函数
//  146  * 
//  147  * 参数:
//  148  *    coreClk--系統主频，单位Hz
//  149  *    baud--SDHC期望时钟频率，单位Hz
//  150  *
//  151  * 输出:
//  152  *    STA_OK--状态正常
//  153  *    STA_NOINIT--驱动未初始化
//  154  *    STA_NODISK--为插入卡
//  155  *    STA_PROTECT--卡写保护
//  156  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  157 static DRESULT LPLD_SDHC_Init(uint32 coreClk, uint32 baud)
//  158 {
LPLD_SDHC_Init:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  159   
//  160   sdcard_ptr->CARD = ESDHC_CARD_NONE;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STR      R1,[R0, #+16]
//  161   
//  162   //禁用GPIO的SDHC复用功能
//  163   LPLD_SDHC_InitGPIO (0);
        MOVS     R0,#+0
        BL       LPLD_SDHC_InitGPIO
//  164   
//  165   //复位SDHC模块
//  166   SDHC_BASE_PTR->SYSCTL = SDHC_SYSCTL_RSTA_MASK | SDHC_SYSCTL_SDCLKFS(0x80);
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR.W    R1,??DataTable9_1  ;; 0x1008000
        STR      R1,[R0, #+0]
//  167   while (SDHC_BASE_PTR->SYSCTL & SDHC_SYSCTL_RSTA_MASK)
??LPLD_SDHC_Init_0:
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+7
        BMI.N    ??LPLD_SDHC_Init_0
//  168   { };
//  169   
//  170   //初始化寄存器值
//  171   SDHC_BASE_PTR->VENDOR = 0;
        LDR.W    R0,??DataTable9_2  ;; 0x400b10c0
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  172   SDHC_BASE_PTR->BLKATTR = SDHC_BLKATTR_BLKCNT(1) | SDHC_BLKATTR_BLKSIZE(512);
        LDR.W    R0,??DataTable9_3  ;; 0x400b1004
        MOVS     R1,#+66048
        STR      R1,[R0, #+0]
//  173   SDHC_BASE_PTR->PROCTL = SDHC_PROCTL_EMODE(ESDHC_PROCTL_EMODE_LITTLE) | SDHC_PROCTL_D3CD_MASK;
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        MOVS     R1,#+40
        STR      R1,[R0, #+0]
//  174   SDHC_BASE_PTR->WML = SDHC_WML_RDWML(2) | SDHC_WML_WRWML(1);
        LDR.W    R0,??DataTable9_4  ;; 0x400b1044
        LDR.W    R1,??DataTable9_5  ;; 0x10002
        STR      R1,[R0, #+0]
//  175   
//  176   //设置SDHC初始化时钟，最好不要超过400kHz
//  177   LPLD_SDHC_SetBaudrate (coreClk, baud);
        MOVS     R1,R5
        MOVS     R0,R4
        BL       LPLD_SDHC_SetBaudrate
//  178   
//  179   //等待
//  180   while (SDHC_BASE_PTR->PRSSTAT & (SDHC_PRSSTAT_CIHB_MASK | SDHC_PRSSTAT_CDIHB_MASK))
??LPLD_SDHC_Init_1:
        LDR.W    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        TST      R0,#0x3
        BNE.N    ??LPLD_SDHC_Init_1
//  181   { };
//  182   
//  183   //使能GPIO的SDHC复用
//  184   LPLD_SDHC_InitGPIO (0xFFFF);
        MOVW     R0,#+65535
        BL       LPLD_SDHC_InitGPIO
//  185   
//  186   //使能各种请求
//  187   SDHC_BASE_PTR->IRQSTAT = 0xFFFF;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        MOVW     R1,#+65535
        STR      R1,[R0, #+0]
//  188   SDHC_BASE_PTR->IRQSTATEN = SDHC_IRQSTATEN_DEBESEN_MASK | SDHC_IRQSTATEN_DCESEN_MASK | SDHC_IRQSTATEN_DTOESEN_MASK
//  189     | SDHC_IRQSTATEN_CIESEN_MASK | SDHC_IRQSTATEN_CEBESEN_MASK | SDHC_IRQSTATEN_CCESEN_MASK | SDHC_IRQSTATEN_CTOESEN_MASK
//  190       | SDHC_IRQSTATEN_BRRSEN_MASK | SDHC_IRQSTATEN_BWRSEN_MASK | SDHC_IRQSTATEN_CRMSEN_MASK
//  191         | SDHC_IRQSTATEN_TCSEN_MASK | SDHC_IRQSTATEN_CCSEN_MASK;
        LDR.W    R0,??DataTable10_3  ;; 0x400b1034
        LDR.W    R1,??DataTable10_4  ;; 0x7f00b3
        STR      R1,[R0, #+0]
//  192   
//  193   //等待80个初始时钟
//  194   SDHC_BASE_PTR->SYSCTL |= SDHC_SYSCTL_INITA_MASK;
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  195   while (SDHC_BASE_PTR->SYSCTL & SDHC_SYSCTL_INITA_MASK)
??LPLD_SDHC_Init_2:
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4
        BMI.N    ??LPLD_SDHC_Init_2
//  196   { };
//  197   
//  198   //检查卡是否插入
//  199   if (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_CINS_MASK)
        LDR.W    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+15
        BPL.N    ??LPLD_SDHC_Init_3
//  200   {
//  201     sdcard_ptr->CARD = ESDHC_CARD_UNKNOWN;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STR      R1,[R0, #+16]
        B.N      ??LPLD_SDHC_Init_4
//  202   }
//  203   else
//  204   {
//  205     sdcard_ptr->STATUS = STA_NODISK;
??LPLD_SDHC_Init_3:
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+2
        STR      R1,[R0, #+20]
//  206   }
//  207   SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_CRM_MASK;
??LPLD_SDHC_Init_4:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  208   
//  209   return RES_OK;
        MOVS     R0,#+0
        POP      {R1,R4,R5,PC}    ;; return
//  210 }
//  211 
//  212 /*
//  213  * LPLD_SDHC_SendCommand
//  214  * 向SD卡发送指定CMD命令
//  215  * 
//  216  * 参数:
//  217  *    command--SDHC命令信息结构体
//  218  *
//  219  * 输出:
//  220  *    DRESULT--磁盘功能返回值
//  221  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  222 static DRESULT LPLD_SDHC_SendCommand(ESDHC_COMMAND_STRUCT_PTR command)
//  223 {
LPLD_SDHC_SendCommand:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  224   uint32 xfertyp;
//  225   uint32 blkattr;
//  226   
//  227   //检查命令
//  228   xfertyp = command->COMMAND;
        LDR      R5,[R4, #+0]
//  229   
//  230   if (ESDHC_XFERTYP_CMDTYP_RESUME == ((xfertyp & SDHC_XFERTYP_CMDTYP_MASK) >> SDHC_XFERTYP_CMDTYP_SHIFT))
        UBFX     R0,R5,#+22,#+2
        CMP      R0,#+2
        BNE.N    ??LPLD_SDHC_SendCommand_0
//  231   {
//  232     //恢复类型命令必须设置DPSEL位
//  233     xfertyp |= SDHC_XFERTYP_DPSEL_MASK;
        ORRS     R5,R5,#0x200000
//  234   }
//  235   
//  236   if ((0 != command->BLOCKS) && (0 != command->BLOCKSIZE))
??LPLD_SDHC_SendCommand_0:
        LDR      R0,[R4, #+8]
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_SendCommand_1
        LDR      R0,[R4, #+12]
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_SendCommand_1
//  237   {
//  238     xfertyp |= SDHC_XFERTYP_DPSEL_MASK;
        ORRS     R5,R5,#0x200000
//  239     if (command->BLOCKS != 1)
        LDR      R0,[R4, #+8]
        CMP      R0,#+1
        BEQ.N    ??LPLD_SDHC_SendCommand_2
//  240     {
//  241       //多块传输
//  242       xfertyp |= SDHC_XFERTYP_MSBSEL_MASK;
        ORRS     R5,R5,#0x20
//  243     }
//  244     if ((uint32)-1 == command->BLOCKS)
??LPLD_SDHC_SendCommand_2:
        LDR      R0,[R4, #+8]
        CMN      R0,#+1
        BNE.N    ??LPLD_SDHC_SendCommand_3
//  245     {
//  246       //大量传输
//  247       blkattr = SDHC_BLKATTR_BLKSIZE(command->BLOCKSIZE) | SDHC_BLKATTR_BLKCNT(0xFFFF);
        LDR      R0,[R4, #+12]
        LSLS     R0,R0,#+19       ;; ZeroExtS R0,R0,#+19,#+19
        LSRS     R0,R0,#+19
        ORR      R0,R0,#0xFF000000
        ORRS     R0,R0,#0xFF0000
        B.N      ??LPLD_SDHC_SendCommand_4
//  248     }
//  249     else
//  250     {
//  251       blkattr = SDHC_BLKATTR_BLKSIZE(command->BLOCKSIZE) | SDHC_BLKATTR_BLKCNT(command->BLOCKS);
??LPLD_SDHC_SendCommand_3:
        LDR      R0,[R4, #+12]
        LSLS     R0,R0,#+19       ;; ZeroExtS R0,R0,#+19,#+19
        LSRS     R0,R0,#+19
        LDR      R1,[R4, #+8]
        ORRS     R0,R0,R1, LSL #+16
//  252       xfertyp |= SDHC_XFERTYP_BCEN_MASK;
        ORRS     R5,R5,#0x2
        B.N      ??LPLD_SDHC_SendCommand_4
//  253     }
//  254   }
//  255   else
//  256   {
//  257     blkattr = 0;
??LPLD_SDHC_SendCommand_1:
        MOVS     R0,#+0
//  258   }
//  259   
//  260   //卡移除状态清除
//  261   SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_CRM_MASK;
??LPLD_SDHC_SendCommand_4:
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x80
        LDR.W    R2,??DataTable10  ;; 0x400b1030
        STR      R1,[R2, #+0]
//  262   
//  263   //等待CMD线空闲
//  264   while (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_CIHB_MASK)
??LPLD_SDHC_SendCommand_5:
        LDR.W    R1,??DataTable8_7  ;; 0x400b1024
        LDR      R1,[R1, #+0]
        LSLS     R1,R1,#+31
        BMI.N    ??LPLD_SDHC_SendCommand_5
//  265   { };
//  266   
//  267   //初始化命令
//  268   SDHC_BASE_PTR->CMDARG = command->ARGUMENT;
        LDR      R1,[R4, #+4]
        LDR.W    R2,??DataTable10_5  ;; 0x400b1008
        STR      R1,[R2, #+0]
//  269   SDHC_BASE_PTR->BLKATTR = blkattr;
        LDR.W    R1,??DataTable9_3  ;; 0x400b1004
        STR      R0,[R1, #+0]
//  270   SDHC_BASE_PTR->DSADDR = 0;
        LDR.W    R0,??DataTable10_6  ;; 0x400b1000
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  271   
//  272   //发送命令
//  273   SDHC_BASE_PTR->XFERTYP = xfertyp;
        LDR.W    R0,??DataTable10_7  ;; 0x400b100c
        STR      R5,[R0, #+0]
//  274   
//  275   //等待响应
//  276   if (LPLD_SDHC_WaitStatus (SDHC_IRQSTAT_CIE_MASK | SDHC_IRQSTAT_CEBE_MASK | SDHC_IRQSTAT_CCE_MASK | SDHC_IRQSTAT_CC_MASK) != SDHC_IRQSTAT_CC_MASK)
        LDR.W    R0,??DataTable10_8  ;; 0xe0001
        BL       LPLD_SDHC_WaitStatus
        CMP      R0,#+1
        BEQ.N    ??LPLD_SDHC_SendCommand_6
//  277   {
//  278     SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_CTOE_MASK | SDHC_IRQSTAT_CIE_MASK | SDHC_IRQSTAT_CEBE_MASK | SDHC_IRQSTAT_CCE_MASK | SDHC_IRQSTAT_CC_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0xF0000
        ORRS     R0,R0,#0x1
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  279     return RES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_SendCommand_7
//  280   }
//  281   
//  282   //检查卡是否移除
//  283   if (SDHC_BASE_PTR->IRQSTAT & SDHC_IRQSTAT_CRM_MASK)
??LPLD_SDHC_SendCommand_6:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??LPLD_SDHC_SendCommand_8
//  284   {
//  285     SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_CTOE_MASK | SDHC_IRQSTAT_CC_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10001
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  286     sdcard_ptr->STATUS = STA_NODISK;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+2
        STR      R1,[R0, #+20]
//  287     return RES_NOTRDY;
        MOVS     R0,#+3
        B.N      ??LPLD_SDHC_SendCommand_7
//  288   }
//  289   
//  290   //获取响应
//  291   if (SDHC_BASE_PTR->IRQSTAT & SDHC_IRQSTAT_CTOE_MASK)
??LPLD_SDHC_SendCommand_8:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+15
        BPL.N    ??LPLD_SDHC_SendCommand_9
//  292   {
//  293     SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_CTOE_MASK | SDHC_IRQSTAT_CC_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10001
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  294     return RES_NONRSPNS;
        MOVS     R0,#+5
        B.N      ??LPLD_SDHC_SendCommand_7
//  295   }
//  296   if ((xfertyp & SDHC_XFERTYP_RSPTYP_MASK) != SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_NO))
??LPLD_SDHC_SendCommand_9:
        TST      R5,#0x30000
        BEQ.N    ??LPLD_SDHC_SendCommand_10
//  297   {
//  298     command->RESPONSE[0] = SDHC_BASE_PTR->CMDRSP[0];
        LDR.W    R0,??DataTable11  ;; 0x400b1010
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+16]
//  299     if ((xfertyp & SDHC_XFERTYP_RSPTYP_MASK) == SDHC_XFERTYP_RSPTYP(ESDHC_XFERTYP_RSPTYP_136))
        ANDS     R0,R5,#0x30000
        CMP      R0,#+65536
        BNE.N    ??LPLD_SDHC_SendCommand_10
//  300     {
//  301       command->RESPONSE[1] = SDHC_BASE_PTR->CMDRSP[1];
        LDR.W    R0,??DataTable11_1  ;; 0x400b1014
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+20]
//  302       command->RESPONSE[2] = SDHC_BASE_PTR->CMDRSP[2];
        LDR.W    R0,??DataTable11_2  ;; 0x400b1018
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+24]
//  303       command->RESPONSE[3] = SDHC_BASE_PTR->CMDRSP[3];
        LDR.W    R0,??DataTable11_3  ;; 0x400b101c
        LDR      R0,[R0, #+0]
        STR      R0,[R4, #+28]
//  304     }
//  305   }
//  306   SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_CC_MASK;
??LPLD_SDHC_SendCommand_10:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  307   
//  308   return RES_OK;
        MOVS     R0,#+0
??LPLD_SDHC_SendCommand_7:
        POP      {R1,R4,R5,PC}    ;; return
//  309 }
//  310 
//  311 
//  312 /*
//  313  * LPLD_SDHC_IOC
//  314  * SDHC模块其他控制服务函数
//  315  * 
//  316  * 参数:
//  317  *    cmd--SDHC模块控制命令
//  318  *    *param_ptr--控制参数
//  319  *
//  320  * 输出:
//  321  *    DRESULT--磁盘功能返回值
//  322  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  323 DRESULT LPLD_SDHC_IOC(uint32 cmd, void *param_ptr)
//  324 {
LPLD_SDHC_IOC:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+36
        MOVS     R5,R1
//  325   
//  326   ESDHC_COMMAND_STRUCT    command;
//  327   boolean                 mem, io, mmc, ceata, mp, hc;
//  328   int32                  val;
//  329   DRESULT                 result = RES_OK;
        MOVS     R4,#+0
//  330   uint32 *             param32_ptr = param_ptr;
//  331   
//  332   switch (cmd)
        CMP      R0,#+1
        BEQ.N    ??LPLD_SDHC_IOC_0
        CMP      R0,#+2
        BEQ.W    ??LPLD_SDHC_IOC_1
        CMP      R0,#+3
        BEQ.W    ??LPLD_SDHC_IOC_2
        CMP      R0,#+4
        BEQ.W    ??LPLD_SDHC_IOC_3
        CMP      R0,#+5
        BEQ.W    ??LPLD_SDHC_IOC_4
        CMP      R0,#+6
        BEQ.W    ??LPLD_SDHC_IOC_5
        CMP      R0,#+7
        BEQ.W    ??LPLD_SDHC_IOC_6
        CMP      R0,#+147
        BEQ.W    ??LPLD_SDHC_IOC_7
        B.N      ??LPLD_SDHC_IOC_8
//  333   {
//  334   case IO_IOCTL_ESDHC_INIT:  
//  335     //初始化SDHC模块
//  336     result = LPLD_SDHC_Init (core_clk_khz*1000, 400000);
??LPLD_SDHC_IOC_0:
        LDR.W    R1,??DataTable11_4  ;; 0x61a80
        LDR.W    R0,??DataTable11_5
        LDR      R0,[R0, #+0]
        MOV      R2,#+1000
        MULS     R0,R2,R0
        BL       LPLD_SDHC_Init
        MOVS     R4,R0
//  337     if (RES_OK != result)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  338     {
//  339       break;
//  340     }
//  341     
//  342     mem = FALSE;
??LPLD_SDHC_IOC_10:
        MOVS     R5,#+0
//  343     io = FALSE;
        MOVS     R6,#+0
//  344     mmc = FALSE;
        MOVS     R7,#+0
//  345     ceata = FALSE;
        MOVS     R8,#+0
//  346     hc = FALSE;
        MOVS     R10,#+0
//  347     mp = FALSE;
        MOVS     R9,#+0
//  348     
//  349     //CMD0 - 空闲命令，复位卡
//  350     command.COMMAND = ESDHC_CMD0;
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  351     command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  352     command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  353     result = LPLD_SDHC_SendCommand (&command);
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
//  354     if (result!=RES_OK)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??LPLD_SDHC_IOC_11
//  355     {
//  356       sdcard_ptr->STATUS = STA_NOINIT;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STR      R1,[R0, #+20]
//  357       break;
        B.N      ??LPLD_SDHC_IOC_9
//  358     }
//  359     
//  360     //CMD8 - 发送接口状态，检查是否支持高容量
//  361     command.COMMAND = ESDHC_CMD8;
??LPLD_SDHC_IOC_11:
        LDR.W    R0,??DataTable11_6  ;; 0x81a0000
        STR      R0,[SP, #+0]
//  362     command.ARGUMENT = 0x000001AA;
        MOV      R0,#+426
        STR      R0,[SP, #+4]
//  363     command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  364     result = LPLD_SDHC_SendCommand (&command);
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
//  365     if (result==RES_ERROR)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??LPLD_SDHC_IOC_12
//  366     {
//  367       sdcard_ptr->STATUS = STA_NOINIT;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STR      R1,[R0, #+20]
//  368       break;
        B.N      ??LPLD_SDHC_IOC_9
//  369     }
//  370     if (result == RES_OK)
??LPLD_SDHC_IOC_12:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_SDHC_IOC_13
//  371     {
//  372       if (command.RESPONSE[0] != command.ARGUMENT)
        LDR      R0,[SP, #+16]
        LDR      R1,[SP, #+4]
        CMP      R0,R1
        BEQ.N    ??LPLD_SDHC_IOC_14
//  373       {
//  374         sdcard_ptr->STATUS = STA_NOINIT;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STR      R1,[R0, #+20]
//  375         result = RES_ERROR;
        MOVS     R4,#+1
//  376         break;
        B.N      ??LPLD_SDHC_IOC_9
//  377       }
//  378       hc = TRUE;
??LPLD_SDHC_IOC_14:
        MOVS     R10,#+1
//  379     }
//  380     
//  381     //CMD5 - 发送操作状态，测试IO
//  382     command.COMMAND = ESDHC_CMD5;
??LPLD_SDHC_IOC_13:
        LDR.W    R0,??DataTable11_7  ;; 0x5020000
        STR      R0,[SP, #+0]
//  383     command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  384     command.BLOCKS = 0;      
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  385     result = LPLD_SDHC_SendCommand (&command);
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
//  386     if (result==RES_ERROR)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??LPLD_SDHC_IOC_15
//  387     {
//  388       sdcard_ptr->STATUS = STA_NOINIT;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STR      R1,[R0, #+20]
//  389       break;
        B.N      ??LPLD_SDHC_IOC_9
//  390     }
//  391     if (result == RES_OK)
??LPLD_SDHC_IOC_15:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_SDHC_IOC_16
//  392     {
//  393       if (((command.RESPONSE[0] >> 28) & 0x07) && (command.RESPONSE[0] & 0x300000))
        LDR      R0,[SP, #+16]
        UBFX     R0,R0,#+28,#+3
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_IOC_17
        LDR      R0,[SP, #+16]
        TST      R0,#0x300000
        BEQ.N    ??LPLD_SDHC_IOC_17
//  394       {
//  395         command.COMMAND = ESDHC_CMD5;
        LDR.W    R0,??DataTable11_7  ;; 0x5020000
        STR      R0,[SP, #+0]
//  396         command.ARGUMENT = 0x300000;
        MOVS     R0,#+3145728
        STR      R0,[SP, #+4]
//  397         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  398         val = 0;
        MOVS     R11,#+0
//  399         do
//  400         {
//  401           val++;
??LPLD_SDHC_IOC_18:
        ADDS     R11,R11,#+1
//  402           if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_19
//  403           {
//  404             break;
//  405           }
//  406         } while ((0 == (command.RESPONSE[0] & 0x80000000)) && (val < ESDHC_ALARM_FREQUENCY));
??LPLD_SDHC_IOC_20:
        LDR      R0,[SP, #+16]
        CMP      R0,#+0
        BMI.N    ??LPLD_SDHC_IOC_19
        CMP      R11,#+100
        BLT.N    ??LPLD_SDHC_IOC_18
//  407         if (RES_OK != result)
??LPLD_SDHC_IOC_19:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  408         {
//  409           break;
//  410         }
//  411         if (command.RESPONSE[0] & 0x80000000)
??LPLD_SDHC_IOC_21:
        LDR      R0,[SP, #+16]
        CMP      R0,#+0
        BPL.N    ??LPLD_SDHC_IOC_22
//  412         {
//  413           io = TRUE;
        MOVS     R6,#+1
//  414         }
//  415         if (command.RESPONSE[0] & 0x08000000)
??LPLD_SDHC_IOC_22:
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+4
        BPL.N    ??LPLD_SDHC_IOC_17
//  416         {
//  417           mp = TRUE;
        MOVS     R9,#+1
        B.N      ??LPLD_SDHC_IOC_17
//  418         }
//  419       }
//  420     }
//  421     else
//  422     {
//  423       mp = TRUE;
??LPLD_SDHC_IOC_16:
        MOVS     R9,#+1
//  424     }
//  425     
//  426     if (mp)
??LPLD_SDHC_IOC_17:
        UXTB     R9,R9            ;; ZeroExt  R9,R9,#+24,#+24
        CMP      R9,#+0
        BEQ.W    ??LPLD_SDHC_IOC_23
//  427     {
//  428       //CMD55 - 特殊应用命令，检查MMC卡
//  429       command.COMMAND = ESDHC_CMD55;
        LDR.W    R0,??DataTable11_8  ;; 0x371a0000
        STR      R0,[SP, #+0]
//  430       command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  431       command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  432       if ((result = LPLD_SDHC_SendCommand (&command))==RES_ERROR)
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BEQ.W    ??LPLD_SDHC_IOC_9
//  433       {
//  434         break;
//  435       }
//  436       if (result == RES_NONRSPNS)
??LPLD_SDHC_IOC_24:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+5
        BNE.N    ??LPLD_SDHC_IOC_25
//  437       {
//  438         //如果为MMC 或 CE-ATA 卡
//  439         io = FALSE;
        MOVS     R6,#+0
//  440         mem = FALSE;
        MOVS     R5,#+0
//  441         hc = FALSE;
        MOVS     R10,#+0
//  442         
//  443         //CMD1 - 发送测试命令，检查高容量支持
//  444         command.COMMAND = ESDHC_CMD1;
        MOVS     R0,#+16777216
        STR      R0,[SP, #+0]
//  445         command.ARGUMENT = 0x40300000;
        LDR.W    R0,??DataTable11_9  ;; 0x40300000
        STR      R0,[SP, #+4]
//  446         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  447         if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  448         {
//  449           break;
//  450         }
//  451         if (0x20000000 == (command.RESPONSE[0] & 0x60000000))
??LPLD_SDHC_IOC_26:
        LDR      R0,[SP, #+16]
        ANDS     R0,R0,#0x60000000
        CMP      R0,#+536870912
        BNE.N    ??LPLD_SDHC_IOC_27
//  452         {
//  453           hc = TRUE;
        MOVS     R10,#+1
//  454         }
//  455         mmc = TRUE;
??LPLD_SDHC_IOC_27:
        MOVS     R7,#+1
//  456         
//  457         //CMD39 - 快速IO，检查CE-ATA的CE签名 */
//  458         command.COMMAND = ESDHC_CMD39;
        LDR.W    R0,??DataTable11_10  ;; 0x27020000
        STR      R0,[SP, #+0]
//  459         command.ARGUMENT = 0x0C00;
        MOV      R0,#+3072
        STR      R0,[SP, #+4]
//  460         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  461         if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  462         {
//  463           break;
//  464         }
//  465         if (0xCE == (command.RESPONSE[0] >> 8) & 0xFF)
??LPLD_SDHC_IOC_28:
        LDR      R0,[SP, #+16]
        LSRS     R0,R0,#+8
        CMP      R0,#+206
        BNE.N    ??LPLD_SDHC_IOC_29
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_IOC_30
??LPLD_SDHC_IOC_29:
        MOVS     R0,#+0
??LPLD_SDHC_IOC_30:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_IOC_23
//  466         {
//  467           //CMD39 - 快速IO，检查CE-ATA的AA签名 */
//  468           command.COMMAND = ESDHC_CMD39;
        LDR.W    R0,??DataTable11_10  ;; 0x27020000
        STR      R0,[SP, #+0]
//  469           command.ARGUMENT = 0x0D00;
        MOV      R0,#+3328
        STR      R0,[SP, #+4]
//  470           command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  471           if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  472           {
//  473             break;
//  474           }
//  475           if (0xAA == (command.RESPONSE[0] >> 8) & 0xFF)
??LPLD_SDHC_IOC_31:
        LDR      R0,[SP, #+16]
        LSRS     R0,R0,#+8
        CMP      R0,#+170
        BNE.N    ??LPLD_SDHC_IOC_32
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_IOC_33
??LPLD_SDHC_IOC_32:
        MOVS     R0,#+0
??LPLD_SDHC_IOC_33:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_IOC_23
//  476           {
//  477             mmc = FALSE;
        MOVS     R7,#+0
//  478             ceata = TRUE;
        MOVS     R8,#+1
        B.N      ??LPLD_SDHC_IOC_23
//  479           }
//  480         }
//  481       }
//  482       else
//  483       {
//  484         //如果为SD卡
//  485         //ACMD41 - 发送操作状态
//  486         command.COMMAND = ESDHC_ACMD41;
??LPLD_SDHC_IOC_25:
        LDR.W    R0,??DataTable11_11  ;; 0x29020000
        STR      R0,[SP, #+0]
//  487         command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  488         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  489         if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_IOC_34
//  490         {
//  491           sdcard_ptr->STATUS = STA_NOINIT;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STR      R1,[R0, #+20]
//  492           break;
        B.N      ??LPLD_SDHC_IOC_9
//  493         }
//  494         if (command.RESPONSE[0] & 0x300000)
??LPLD_SDHC_IOC_34:
        LDR      R0,[SP, #+16]
        TST      R0,#0x300000
        BEQ.N    ??LPLD_SDHC_IOC_23
//  495         {
//  496           val = 0;
        MOVS     R11,#+0
//  497           do
//  498           {
//  499             val++;
??LPLD_SDHC_IOC_35:
        ADDS     R11,R11,#+1
//  500             
//  501             //CMD55 + ACMD41 - 发送OCR
//  502             command.COMMAND = ESDHC_CMD55;
        LDR.W    R0,??DataTable11_8  ;; 0x371a0000
        STR      R0,[SP, #+0]
//  503             command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  504             command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  505             if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_36
//  506             {
//  507               break;
//  508             }
//  509             
//  510             command.COMMAND = ESDHC_ACMD41;
??LPLD_SDHC_IOC_37:
        LDR.W    R0,??DataTable11_11  ;; 0x29020000
        STR      R0,[SP, #+0]
//  511             if (hc)
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??LPLD_SDHC_IOC_38
//  512             {
//  513               command.ARGUMENT = 0x40300000;
        LDR.W    R0,??DataTable11_9  ;; 0x40300000
        STR      R0,[SP, #+4]
        B.N      ??LPLD_SDHC_IOC_39
//  514             }
//  515             else
//  516             {
//  517               command.ARGUMENT = 0x00300000;
??LPLD_SDHC_IOC_38:
        MOVS     R0,#+3145728
        STR      R0,[SP, #+4]
//  518             }
//  519             command.BLOCKS = 0;
??LPLD_SDHC_IOC_39:
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
//  520             if (result = LPLD_SDHC_SendCommand (&command))
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_36
//  521             {
//  522               break;
//  523             }
//  524           } while ((0 == (command.RESPONSE[0] & 0x80000000)) && (val < ESDHC_ALARM_FREQUENCY));
??LPLD_SDHC_IOC_40:
        LDR      R0,[SP, #+16]
        CMP      R0,#+0
        BMI.N    ??LPLD_SDHC_IOC_36
        CMP      R11,#+100
        BLT.N    ??LPLD_SDHC_IOC_35
//  525           if (RES_OK != result)
??LPLD_SDHC_IOC_36:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.W    ??LPLD_SDHC_IOC_9
//  526           {
//  527             break;
//  528           }
//  529           if (val >= ESDHC_ALARM_FREQUENCY)
??LPLD_SDHC_IOC_41:
        CMP      R11,#+100
        BLT.N    ??LPLD_SDHC_IOC_42
//  530           {
//  531             hc = FALSE;
        MOVS     R10,#+0
        B.N      ??LPLD_SDHC_IOC_23
//  532           }
//  533           else
//  534           {
//  535             mem = TRUE;
??LPLD_SDHC_IOC_42:
        MOVS     R5,#+1
//  536             if (hc)
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??LPLD_SDHC_IOC_23
//  537             {
//  538               hc = FALSE;
        MOVS     R10,#+0
//  539               if (command.RESPONSE[0] & 0x40000000)
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+1
        BPL.N    ??LPLD_SDHC_IOC_23
//  540               {
//  541                 hc = TRUE;
        MOVS     R10,#+1
//  542               }
//  543             }
//  544           }
//  545         }
//  546       }
//  547     }
//  548     if (mmc)
??LPLD_SDHC_IOC_23:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BEQ.N    ??LPLD_SDHC_IOC_43
//  549     {
//  550       sdcard_ptr->CARD = ESDHC_CARD_MMC;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+7
        STR      R1,[R0, #+16]
//  551     }
//  552     if (ceata)
??LPLD_SDHC_IOC_43:
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BEQ.N    ??LPLD_SDHC_IOC_44
//  553     {
//  554       sdcard_ptr->CARD = ESDHC_CARD_CEATA;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+8
        STR      R1,[R0, #+16]
//  555     }
//  556     if (io)
??LPLD_SDHC_IOC_44:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??LPLD_SDHC_IOC_45
//  557     {
//  558       sdcard_ptr->CARD = ESDHC_CARD_SDIO;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+4
        STR      R1,[R0, #+16]
//  559     }
//  560     if (mem)
??LPLD_SDHC_IOC_45:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??LPLD_SDHC_IOC_46
//  561     {
//  562       sdcard_ptr->CARD = ESDHC_CARD_SD;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+2
        STR      R1,[R0, #+16]
//  563       if (hc)
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??LPLD_SDHC_IOC_46
//  564       {
//  565         sdcard_ptr->CARD = ESDHC_CARD_SDHC;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+3
        STR      R1,[R0, #+16]
//  566       }
//  567     }
//  568     if (io && mem)
??LPLD_SDHC_IOC_46:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??LPLD_SDHC_IOC_47
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??LPLD_SDHC_IOC_47
//  569     {
//  570       sdcard_ptr->CARD = ESDHC_CARD_SDCOMBO;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+5
        STR      R1,[R0, #+16]
//  571       if (hc)
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??LPLD_SDHC_IOC_47
//  572       {
//  573         sdcard_ptr->CARD = ESDHC_CARD_SDHCCOMBO;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+6
        STR      R1,[R0, #+16]
//  574       }
//  575     }
//  576     
//  577     //禁用GPIO的SDHC复用
//  578     LPLD_SDHC_InitGPIO (0);
??LPLD_SDHC_IOC_47:
        MOVS     R0,#+0
        BL       LPLD_SDHC_InitGPIO
//  579     
//  580     //设置SDHC工作状态下的默认波特率
//  581     LPLD_SDHC_SetBaudrate (core_clk_khz*1000, 25000000);
        LDR.W    R1,??DataTable11_12  ;; 0x17d7840
        LDR.W    R0,??DataTable11_5
        LDR      R0,[R0, #+0]
        MOV      R2,#+1000
        MULS     R0,R2,R0
        BL       LPLD_SDHC_SetBaudrate
//  582     
//  583     //使能GPIO的SDHC复用
//  584     LPLD_SDHC_InitGPIO (0xFFFF);
        MOVW     R0,#+65535
        BL       LPLD_SDHC_InitGPIO
//  585     
//  586     if(result == RES_OK)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_SDHC_IOC_48
//  587     {
//  588       sdcard_ptr->STATUS = STA_OK;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STR      R1,[R0, #+20]
//  589     }
//  590     break;
??LPLD_SDHC_IOC_48:
        B.N      ??LPLD_SDHC_IOC_9
//  591   case IO_IOCTL_ESDHC_SEND_COMMAND:
//  592     result = LPLD_SDHC_SendCommand ((ESDHC_COMMAND_STRUCT_PTR)param32_ptr);
??LPLD_SDHC_IOC_1:
        MOVS     R0,R5
        BL       LPLD_SDHC_SendCommand
        MOVS     R4,R0
//  593     break;
        B.N      ??LPLD_SDHC_IOC_9
//  594   case IO_IOCTL_ESDHC_GET_BAUDRATE:
//  595     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_3:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_49
//  596     {
//  597       result = RES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_50
//  598     }
//  599     else
//  600     {
//  601       //获取波特率
//  602       val = ((SDHC_BASE_PTR->SYSCTL & SDHC_SYSCTL_SDCLKFS_MASK) >> SDHC_SYSCTL_SDCLKFS_SHIFT) << 1;
??LPLD_SDHC_IOC_49:
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+7
        ANDS     R11,R0,#0x1FE
//  603       val *= ((SDHC_BASE_PTR->SYSCTL & SDHC_SYSCTL_DVS_MASK) >> SDHC_SYSCTL_DVS_SHIFT) + 1;
        LDR.W    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        UBFX     R0,R0,#+4,#+4
        ADDS     R0,R0,#+1
        MUL      R11,R0,R11
//  604       *param32_ptr = (uint32)((core_clk_khz*1000 / val));
        LDR.W    R0,??DataTable11_5
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        MULS     R0,R1,R0
        SDIV     R0,R0,R11
        STR      R0,[R5, #+0]
//  605     }
//  606     break;
??LPLD_SDHC_IOC_50:
        B.N      ??LPLD_SDHC_IOC_9
//  607   case IO_IOCTL_ESDHC_SET_BAUDRATE:
//  608     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_4:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_51
//  609     {
//  610       result = RES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_52
//  611     }
//  612     else if (0 == (*param32_ptr))
??LPLD_SDHC_IOC_51:
        LDR      R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_53
//  613     {
//  614       result = RES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_52
//  615     }
//  616     else
//  617     {
//  618       if (! LPLD_SDHC_IsRunning ())
??LPLD_SDHC_IOC_53:
        BL       LPLD_SDHC_IsRunning
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_54
//  619       {
//  620         //禁用GPIO的SDHC复用
//  621         LPLD_SDHC_InitGPIO (0);
        MOVS     R0,#+0
        BL       LPLD_SDHC_InitGPIO
//  622         
//  623         //设置波特率
//  624         LPLD_SDHC_SetBaudrate (core_clk_khz*1000, *param32_ptr);
        LDR      R1,[R5, #+0]
        LDR.W    R0,??DataTable11_5
        LDR      R0,[R0, #+0]
        MOV      R2,#+1000
        MULS     R0,R2,R0
        BL       LPLD_SDHC_SetBaudrate
//  625         
//  626         //使能GPIO的SDHC复用
//  627         LPLD_SDHC_InitGPIO (0xFFFF);
        MOVW     R0,#+65535
        BL       LPLD_SDHC_InitGPIO
        B.N      ??LPLD_SDHC_IOC_52
//  628       }
//  629       else
//  630       {
//  631         result = RES_ERROR;
??LPLD_SDHC_IOC_54:
        MOVS     R4,#+1
//  632       }
//  633     }
//  634     break;
??LPLD_SDHC_IOC_52:
        B.N      ??LPLD_SDHC_IOC_9
//  635   case IO_IOCTL_ESDHC_GET_BUS_WIDTH:
//  636     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_5:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_55
//  637     {
//  638       result = RES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_56
//  639     }
//  640     else
//  641     {
//  642       //获得SDHC总线宽度
//  643       val = (SDHC_BASE_PTR->PROCTL & SDHC_PROCTL_DTW_MASK) >> SDHC_PROCTL_DTW_SHIFT;
??LPLD_SDHC_IOC_55:
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        UBFX     R11,R0,#+1,#+2
//  644       if (ESDHC_PROCTL_DTW_1BIT == val)
        CMP      R11,#+0
        BNE.N    ??LPLD_SDHC_IOC_57
//  645       {
//  646         *param32_ptr = ESDHC_BUS_WIDTH_1BIT;
        MOVS     R0,#+0
        STR      R0,[R5, #+0]
        B.N      ??LPLD_SDHC_IOC_56
//  647       }
//  648       else if (ESDHC_PROCTL_DTW_4BIT == val)
??LPLD_SDHC_IOC_57:
        CMP      R11,#+1
        BNE.N    ??LPLD_SDHC_IOC_58
//  649       {
//  650         *param32_ptr = ESDHC_BUS_WIDTH_4BIT;
        MOVS     R0,#+1
        STR      R0,[R5, #+0]
        B.N      ??LPLD_SDHC_IOC_56
//  651       }
//  652       else if (ESDHC_PROCTL_DTW_8BIT == val)
??LPLD_SDHC_IOC_58:
        CMP      R11,#+16
        BNE.N    ??LPLD_SDHC_IOC_59
//  653       {
//  654         *param32_ptr = ESDHC_BUS_WIDTH_8BIT;
        MOVS     R0,#+2
        STR      R0,[R5, #+0]
        B.N      ??LPLD_SDHC_IOC_56
//  655       }
//  656       else
//  657       {
//  658         result = RES_ERROR;
??LPLD_SDHC_IOC_59:
        MOVS     R4,#+1
//  659       }
//  660     }
//  661     break;
??LPLD_SDHC_IOC_56:
        B.N      ??LPLD_SDHC_IOC_9
//  662   case IO_IOCTL_ESDHC_SET_BUS_WIDTH:
//  663     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_6:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_60
//  664     {
//  665       result = RES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_61
//  666     }
//  667     else
//  668     {
//  669       //设置SDHC总线宽度
//  670       if (! LPLD_SDHC_IsRunning ())
??LPLD_SDHC_IOC_60:
        BL       LPLD_SDHC_IsRunning
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_62
//  671       {
//  672         if (ESDHC_BUS_WIDTH_1BIT == *param32_ptr)
        LDR      R0,[R5, #+0]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_63
//  673         {
//  674           SDHC_BASE_PTR->PROCTL &= (~ SDHC_PROCTL_DTW_MASK);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x6
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  675           SDHC_BASE_PTR->PROCTL |= SDHC_PROCTL_DTW(ESDHC_PROCTL_DTW_1BIT);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        LDR      R1,[R1, #+0]
        STR      R1,[R0, #+0]
        B.N      ??LPLD_SDHC_IOC_61
//  676         }
//  677         else if (ESDHC_BUS_WIDTH_4BIT == *param32_ptr)
??LPLD_SDHC_IOC_63:
        LDR      R0,[R5, #+0]
        CMP      R0,#+1
        BNE.N    ??LPLD_SDHC_IOC_64
//  678         {
//  679           SDHC_BASE_PTR->PROCTL &= (~ SDHC_PROCTL_DTW_MASK);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x6
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  680           SDHC_BASE_PTR->PROCTL |= SDHC_PROCTL_DTW(ESDHC_PROCTL_DTW_4BIT);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
        B.N      ??LPLD_SDHC_IOC_61
//  681         }
//  682         else if (ESDHC_BUS_WIDTH_8BIT == *param32_ptr)
??LPLD_SDHC_IOC_64:
        LDR      R0,[R5, #+0]
        CMP      R0,#+2
        BNE.N    ??LPLD_SDHC_IOC_65
//  683         {
//  684           SDHC_BASE_PTR->PROCTL &= (~ SDHC_PROCTL_DTW_MASK);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x6
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        STR      R0,[R1, #+0]
//  685           SDHC_BASE_PTR->PROCTL |= SDHC_PROCTL_DTW(ESDHC_PROCTL_DTW_8BIT);
        LDR.W    R0,??DataTable10_2  ;; 0x400b1028
        LDR.W    R1,??DataTable10_2  ;; 0x400b1028
        LDR      R1,[R1, #+0]
        STR      R1,[R0, #+0]
        B.N      ??LPLD_SDHC_IOC_61
//  686         }
//  687         else
//  688         {
//  689           result = RES_ERROR;
??LPLD_SDHC_IOC_65:
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_61
//  690         }
//  691       }
//  692       else
//  693       {
//  694         result = RES_ERROR;
??LPLD_SDHC_IOC_62:
        MOVS     R4,#+1
//  695       }
//  696     }
//  697     break;
??LPLD_SDHC_IOC_61:
        B.N      ??LPLD_SDHC_IOC_9
//  698   case IO_IOCTL_ESDHC_GET_CARD:
//  699     if (NULL == param32_ptr)
??LPLD_SDHC_IOC_2:
        CMP      R5,#+0
        BNE.N    ??LPLD_SDHC_IOC_66
//  700     {
//  701       result = RES_ERROR;
        MOVS     R4,#+1
        B.N      ??LPLD_SDHC_IOC_67
//  702     }
//  703     else
//  704     {
//  705       //等待80个时钟
//  706       SDHC_BASE_PTR->SYSCTL |= SDHC_SYSCTL_INITA_MASK;
??LPLD_SDHC_IOC_66:
        LDR.N    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.N    R1,??DataTable8_6  ;; 0x400b102c
        STR      R0,[R1, #+0]
//  707       while (SDHC_BASE_PTR->SYSCTL & SDHC_SYSCTL_INITA_MASK)
??LPLD_SDHC_IOC_68:
        LDR.N    R0,??DataTable8_6  ;; 0x400b102c
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4
        BMI.N    ??LPLD_SDHC_IOC_68
//  708       { };
//  709       
//  710       //更新并返回卡实际状态
//  711       if (SDHC_BASE_PTR->IRQSTAT & SDHC_IRQSTAT_CRM_MASK)
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??LPLD_SDHC_IOC_69
//  712       {
//  713         SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_CRM_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  714         sdcard_ptr->CARD = ESDHC_CARD_NONE;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STR      R1,[R0, #+16]
//  715         sdcard_ptr->STATUS = STA_NODISK;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+2
        STR      R1,[R0, #+20]
//  716       }
//  717       if (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_CINS_MASK)
??LPLD_SDHC_IOC_69:
        LDR.N    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+15
        BPL.N    ??LPLD_SDHC_IOC_70
//  718       {
//  719         if (ESDHC_CARD_NONE == sdcard_ptr->CARD)
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+16]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_IOC_71
//  720         {
//  721           sdcard_ptr->CARD = ESDHC_CARD_UNKNOWN;
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STR      R1,[R0, #+16]
        B.N      ??LPLD_SDHC_IOC_71
//  722         }
//  723       }
//  724       else
//  725       {
//  726         sdcard_ptr->CARD = ESDHC_CARD_NONE;
??LPLD_SDHC_IOC_70:
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STR      R1,[R0, #+16]
//  727       }
//  728       *param32_ptr = sdcard_ptr->CARD;
??LPLD_SDHC_IOC_71:
        LDR.W    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+16]
        STR      R0,[R5, #+0]
//  729     }
//  730     break;
??LPLD_SDHC_IOC_67:
        B.N      ??LPLD_SDHC_IOC_9
//  731     
//  732   case IO_IOCTL_FLUSH_OUTPUT:
//  733     //等待传输完成
//  734     LPLD_SDHC_WaitStatus (SDHC_IRQSTAT_TC_MASK);
??LPLD_SDHC_IOC_7:
        MOVS     R0,#+2
        BL       LPLD_SDHC_WaitStatus
//  735     if (SDHC_BASE_PTR->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        TST      R0,#0x700000
        BEQ.N    ??LPLD_SDHC_IOC_72
//  736     {
//  737       SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x700000
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  738       result = RES_ERROR;
        MOVS     R4,#+1
//  739     }
//  740     SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_TC_MASK | SDHC_IRQSTAT_BRR_MASK | SDHC_IRQSTAT_BWR_MASK;
??LPLD_SDHC_IOC_72:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x32
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  741     break;
        B.N      ??LPLD_SDHC_IOC_9
//  742   default:
//  743     result = RES_ERROR;
??LPLD_SDHC_IOC_8:
        MOVS     R4,#+1
//  744     break;
//  745   }
//  746   
//  747   
//  748   return result;
??LPLD_SDHC_IOC_9:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADD      SP,SP,#+36
        POP      {R4-R11,PC}      ;; return
//  749 }
//  750 
//  751 /*
//  752  * LPLD_SDHC_Read
//  753  * SDHC读操作
//  754  * 
//  755  * 参数:
//  756  *    *data_ptr--存储数据地址指针
//  757  *    n--待读的数据长度
//  758  *
//  759  * 输出:
//  760  *    DRESULT--磁盘功能返回值
//  761  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  762 static DSTATUS LPLD_SDHC_Read(uint8 *data_ptr, int32 n)
//  763 {
LPLD_SDHC_Read:
        PUSH     {R4}
//  764   uint32 buffer;
//  765   int32 remains;
//  766   
//  767   remains = n;
        MOVS     R2,R1
//  768   if (((uint32)data_ptr & 0x03) == 0)
        ANDS     R3,R0,#0x3
        CMP      R3,#+0
        BNE.N    ??LPLD_SDHC_Read_0
        B.N      ??LPLD_SDHC_Read_1
//  769   {    
//  770     //数据位字对齐，可以以最快的速度直接从寄存器拷贝
//  771     while (remains >= 4)
//  772     {
//  773       if (SDHC_BASE_PTR->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
//  774       {
//  775         SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BRR_MASK;
//  776         return RES_ERROR;
//  777       }
//  778       
//  779       //等待，直到收到的数据达到水印长度或传输完成
//  780       while ((0 == (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_BREN_MASK)) && (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_DLA_MASK))
??LPLD_SDHC_Read_2:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+20
        BMI.N    ??LPLD_SDHC_Read_3
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+29
        BMI.N    ??LPLD_SDHC_Read_2
//  781       { };
//  782       
//  783       *((uint32 *)data_ptr) = SDHC_BASE_PTR->DATPORT;
??LPLD_SDHC_Read_3:
        LDR.W    R3,??DataTable11_13  ;; 0x400b1020
        LDR      R3,[R3, #+0]
        STR      R3,[R0, #+0]
//  784       data_ptr += 4;
        ADDS     R0,R0,#+4
//  785       remains -= 4;
        SUBS     R2,R2,#+4
??LPLD_SDHC_Read_1:
        CMP      R2,#+4
        BLT.N    ??LPLD_SDHC_Read_4
        LDR.W    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Read_2
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Read_5
//  786     }
//  787   }
//  788   else
//  789   {
//  790     //非对齐数据，读到临时区域并以字节复制
//  791     while (remains >= 4)
//  792     {
//  793       if (SDHC_BASE_PTR->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
//  794       {
//  795         SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BRR_MASK;
//  796         return RES_ERROR;
//  797       }
//  798       
//  799       //等待，直到收到的数据达到水印长度或传输完成
//  800       while ((0 == (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_BREN_MASK)) && (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_DLA_MASK))
??LPLD_SDHC_Read_6:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+20
        BMI.N    ??LPLD_SDHC_Read_7
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+29
        BMI.N    ??LPLD_SDHC_Read_6
//  801       { };
//  802       
//  803       buffer = SDHC_BASE_PTR->DATPORT;
??LPLD_SDHC_Read_7:
        LDR.W    R3,??DataTable11_13  ;; 0x400b1020
        LDR      R3,[R3, #+0]
//  804       
//  805       *data_ptr++ = buffer & 0xFF;
        STRB     R3,[R0, #+0]
        ADDS     R0,R0,#+1
//  806       *data_ptr++ = (buffer >> 8) & 0xFF;
        LSRS     R4,R3,#+8
        STRB     R4,[R0, #+0]
        ADDS     R0,R0,#+1
//  807       *data_ptr++ = (buffer >> 16) & 0xFF;
        LSRS     R4,R3,#+16
        STRB     R4,[R0, #+0]
        ADDS     R0,R0,#+1
//  808       *data_ptr++ = (buffer >> 24) & 0xFF;
        LSRS     R3,R3,#+24
        STRB     R3,[R0, #+0]
        ADDS     R0,R0,#+1
//  809       
//  810       remains -= 4;
        SUBS     R2,R2,#+4
??LPLD_SDHC_Read_0:
        CMP      R2,#+4
        BLT.N    ??LPLD_SDHC_Read_4
        LDR.W    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Read_6
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Read_5
//  811     }      
//  812   }
//  813   
//  814   if (remains)
??LPLD_SDHC_Read_4:
        CMP      R2,#+0
        BEQ.N    ??LPLD_SDHC_Read_8
//  815   {
//  816     //剩下的少于单字长度数据
//  817     if (SDHC_BASE_PTR->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
        LDR.W    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Read_9
//  818     {
//  819       SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BRR_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  820       return RES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Read_5
//  821     }
//  822     
//  823     //等待，直到收到的数据达到水印长度或传输完成
//  824     while ((0 == (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_BREN_MASK)) && (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_DLA_MASK))
??LPLD_SDHC_Read_9:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+20
        BMI.N    ??LPLD_SDHC_Read_10
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+29
        BMI.N    ??LPLD_SDHC_Read_9
//  825     { };
//  826     
//  827     buffer = SDHC_BASE_PTR->DATPORT;
??LPLD_SDHC_Read_10:
        LDR.W    R3,??DataTable11_13  ;; 0x400b1020
        LDR      R3,[R3, #+0]
        B.N      ??LPLD_SDHC_Read_11
//  828     while (remains)
//  829     {
//  830       
//  831       *data_ptr++ = buffer & 0xFF;
??LPLD_SDHC_Read_12:
        STRB     R3,[R0, #+0]
        ADDS     R0,R0,#+1
//  832       buffer >>= 8;
        LSRS     R3,R3,#+8
//  833       
//  834       remains--;
        SUBS     R2,R2,#+1
//  835     }
??LPLD_SDHC_Read_11:
        CMP      R2,#+0
        BNE.N    ??LPLD_SDHC_Read_12
//  836   }
//  837   
//  838   if (SDHC_BASE_PTR->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
??LPLD_SDHC_Read_8:
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        TST      R0,#0x700000
        BEQ.N    ??LPLD_SDHC_Read_13
//  839   {
//  840     SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BRR_MASK;
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x20
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  841     return RES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Read_5
//  842   }
//  843   
//  844   return (n - remains);
??LPLD_SDHC_Read_13:
        SUBS     R0,R1,R2
??LPLD_SDHC_Read_5:
        POP      {R4}
        BX       LR               ;; return
//  845 }
//  846 
//  847 /*
//  848  * LPLD_SDHC_Write
//  849  * SDHC写操作
//  850  * 
//  851  * 参数:
//  852  *    *data_ptr--存储数据地址指针
//  853  *    n--待写的数据长度
//  854  *
//  855  * 输出:
//  856  *    DRESULT--磁盘功能返回值
//  857  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  858 static DSTATUS LPLD_SDHC_Write(uint8 *data_ptr, int32 n)
//  859 {
LPLD_SDHC_Write:
        PUSH     {R4}
//  860   uint8 *udata_ptr;
//  861   uint32 buffer;
//  862   int32 remains;
//  863   
//  864   //复制数据指针
//  865   udata_ptr = (uint8 *)data_ptr;
//  866   
//  867   remains = n;
        MOVS     R2,R1
//  868   if (((uint32)udata_ptr & 0x03) == 0)
        ANDS     R3,R0,#0x3
        CMP      R3,#+0
        BNE.N    ??LPLD_SDHC_Write_0
        B.N      ??LPLD_SDHC_Write_1
//  869   {
//  870     //数据位字对齐，可以以最快的速度直接拷贝到寄存器
//  871     while (remains >= 4)
//  872     {
//  873       if (SDHC_BASE_PTR->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
//  874       {
//  875         SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BWR_MASK;
//  876         return RES_ERROR;
//  877       }
//  878       
//  879       //等待，直到水印空间可用 
//  880       while (0 == (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_BWEN_MASK))
??LPLD_SDHC_Write_2:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+21
        BPL.N    ??LPLD_SDHC_Write_2
//  881       { };
//  882       
//  883       SDHC_BASE_PTR->DATPORT = *((uint32 *)udata_ptr);
        LDR.W    R3,??DataTable11_13  ;; 0x400b1020
        LDR      R4,[R0, #+0]
        STR      R4,[R3, #+0]
//  884       udata_ptr += 4;
        ADDS     R0,R0,#+4
//  885       remains -= 4;
        SUBS     R2,R2,#+4
??LPLD_SDHC_Write_1:
        CMP      R2,#+4
        BLT.N    ??LPLD_SDHC_Write_3
        LDR.W    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Write_2
        LDR.W    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x10
        LDR.W    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Write_4
//  886     }
//  887   }
//  888   else
//  889   {
//  890     //非对齐数据，写到临时区域并以字节复制
//  891     while (remains >= 4)
//  892     {
//  893       if (SDHC_BASE_PTR->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
//  894       {
//  895         SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BWR_MASK;
//  896         return RES_ERROR;
//  897       }
//  898       
//  899       //等待，直到水印空间可用 
//  900       while (0 == (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_BWEN_MASK))
??LPLD_SDHC_Write_5:
        LDR.N    R3,??DataTable8_7  ;; 0x400b1024
        LDR      R3,[R3, #+0]
        LSLS     R3,R3,#+21
        BPL.N    ??LPLD_SDHC_Write_5
//  901       { };
//  902       
//  903       buffer  = (*udata_ptr++);
        LDRB     R3,[R0, #+0]
        ADDS     R0,R0,#+1
//  904       buffer |= (*udata_ptr++) << 8;
        LDRB     R4,[R0, #+0]
        ORRS     R3,R3,R4, LSL #+8
        ADDS     R0,R0,#+1
//  905       buffer |= (*udata_ptr++) << 16;
        LDRB     R4,[R0, #+0]
        ORRS     R3,R3,R4, LSL #+16
        ADDS     R0,R0,#+1
//  906       buffer |= (*udata_ptr++) << 24;
        LDRB     R4,[R0, #+0]
        ORRS     R3,R3,R4, LSL #+24
        ADDS     R0,R0,#+1
//  907       
//  908       //等待，直到水印空间可用 
//  909       while (0 == (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_BWEN_MASK))
??LPLD_SDHC_Write_6:
        LDR.N    R4,??DataTable8_7  ;; 0x400b1024
        LDR      R4,[R4, #+0]
        LSLS     R4,R4,#+21
        BPL.N    ??LPLD_SDHC_Write_6
//  910       { };
//  911       
//  912       SDHC_BASE_PTR->DATPORT = buffer;
        LDR.W    R4,??DataTable11_13  ;; 0x400b1020
        STR      R3,[R4, #+0]
//  913       remains -= 4;
        SUBS     R2,R2,#+4
??LPLD_SDHC_Write_0:
        CMP      R2,#+4
        BLT.N    ??LPLD_SDHC_Write_3
        LDR.N    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Write_5
        LDR.N    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Write_4
//  914     }      
//  915   }
//  916   
//  917   if (remains)
??LPLD_SDHC_Write_3:
        CMP      R2,#+0
        BEQ.N    ??LPLD_SDHC_Write_7
//  918   {
//  919     //剩余少于单字长度的数据
//  920     if (SDHC_BASE_PTR->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
        LDR.N    R3,??DataTable10  ;; 0x400b1030
        LDR      R3,[R3, #+0]
        TST      R3,#0x700000
        BEQ.N    ??LPLD_SDHC_Write_8
//  921     {
//  922       SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BWR_MASK;
        LDR.N    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  923       return RES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Write_4
//  924     }
//  925     
//  926     buffer = 0xFFFFFFFF;
??LPLD_SDHC_Write_8:
        MOVS     R3,#-1
        B.N      ??LPLD_SDHC_Write_9
//  927     while (remains)
//  928     {
//  929       buffer <<= 8;
??LPLD_SDHC_Write_10:
        LSLS     R3,R3,#+8
//  930       buffer |= udata_ptr[remains];
        LDRB     R4,[R2, R0]
        ORRS     R3,R4,R3
//  931       remains--;
        SUBS     R2,R2,#+1
//  932     }
??LPLD_SDHC_Write_9:
        CMP      R2,#+0
        BNE.N    ??LPLD_SDHC_Write_10
//  933     
//  934     //等待，直到水印空间可用 
//  935     while (0 == (SDHC_BASE_PTR->PRSSTAT & SDHC_PRSSTAT_BWEN_MASK))
??LPLD_SDHC_Write_11:
        LDR.N    R0,??DataTable8_7  ;; 0x400b1024
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+21
        BPL.N    ??LPLD_SDHC_Write_11
//  936     { };
//  937     
//  938     SDHC_BASE_PTR->DATPORT = buffer;        
        LDR.W    R0,??DataTable11_13  ;; 0x400b1020
        STR      R3,[R0, #+0]
//  939   }
//  940   
//  941   if (SDHC_BASE_PTR->IRQSTAT & (SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK))
??LPLD_SDHC_Write_7:
        LDR.N    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        TST      R0,#0x700000
        BEQ.N    ??LPLD_SDHC_Write_12
//  942   {
//  943     SDHC_BASE_PTR->IRQSTAT |= SDHC_IRQSTAT_DEBE_MASK | SDHC_IRQSTAT_DCE_MASK | SDHC_IRQSTAT_DTOE_MASK | SDHC_IRQSTAT_BWR_MASK;
        LDR.N    R0,??DataTable10  ;; 0x400b1030
        LDR      R0,[R0, #+0]
        ORR      R0,R0,#0x700000
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable10  ;; 0x400b1030
        STR      R0,[R1, #+0]
//  944     return RES_ERROR;
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_Write_4
//  945   }
//  946   
//  947   return (n - remains);
??LPLD_SDHC_Write_12:
        SUBS     R0,R1,R2
??LPLD_SDHC_Write_4:
        POP      {R4}
        BX       LR               ;; return
//  948 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8:
        DC32     0x4004d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_1:
        DC32     0x4004d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_2:
        DC32     0x4004d008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_3:
        DC32     0x4004d00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_4:
        DC32     0x4004d010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_5:
        DC32     0x4004d014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_6:
        DC32     0x400b102c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8_7:
        DC32     0x400b1024
//  949 
//  950 /*
//  951  * LPLD_SDHC_InitCard
//  952  * 初始化SDHC模块及SD卡，设置正常工作波特率为40MHz
//  953  * 
//  954  * 参数:
//  955  *    无
//  956  *
//  957  * 输出:
//  958  *    STA_OK--状态正常
//  959  *    STA_NOINIT--驱动未初始化
//  960  *    STA_NODISK--为插入卡
//  961  *    STA_PROTECT--卡写保护
//  962  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  963 DSTATUS LPLD_SDHC_InitCard(void)
//  964 {
LPLD_SDHC_InitCard:
        PUSH     {R4,LR}
        SUB      SP,SP,#+40
//  965   uint32 baudrate, param, c_size, c_size_mult, read_bl_len, time_out = 0;
        MOVS     R4,#+0
//  966   ESDHC_COMMAND_STRUCT command;
//  967   DSTATUS result;
//  968   
//  969   //分配SD卡信息结构体的数据空间并初始化
//  970   sdcard_ptr = (SDCARD_STRUCT_PTR)malloc(sizeof(SDCARD_STRUCT));
        MOVS     R0,#+24
        BL       malloc
        LDR.N    R1,??DataTable10_1
        STR      R0,[R1, #+0]
//  971   sdcard_ptr->CARD = ESDHC_CARD_NONE;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STR      R1,[R0, #+16]
//  972   sdcard_ptr->TIMEOUT = 0;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  973   sdcard_ptr->NUM_BLOCKS = 0;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STR      R1,[R0, #+4]
//  974   sdcard_ptr->ADDRESS = 0;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STR      R1,[R0, #+12]
//  975   sdcard_ptr->SDHC = FALSE;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+8]
//  976   sdcard_ptr->VERSION2 = FALSE;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STRB     R1,[R0, #+9]
//  977   sdcard_ptr->STATUS = STA_OK;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+0
        STR      R1,[R0, #+20]
        B.N      ??LPLD_SDHC_InitCard_0
//  978    
//  979   while(time_out < 1000)
//  980   {
//  981     
//  982     //初始化SDHC模块并检测卡
//  983     if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_INIT, NULL)))
//  984     {
//  985       continue;
??LPLD_SDHC_InitCard_1:
??LPLD_SDHC_InitCard_0:
        CMP      R4,#+1000
        BCS.N    ??LPLD_SDHC_InitCard_2
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_1
//  986     }
//  987     
//  988     //SDHC检查
//  989     param = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  990     if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_GET_CARD, &param)))
        ADD      R1,SP,#+0
        MOVS     R0,#+3
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_0
//  991     {
//  992       continue;
//  993     }
//  994     if ((ESDHC_CARD_SD == param) || (ESDHC_CARD_SDHC == param) || (ESDHC_CARD_SDCOMBO == param) || (ESDHC_CARD_SDHCCOMBO == param))
??LPLD_SDHC_InitCard_3:
        LDR      R0,[SP, #+0]
        CMP      R0,#+2
        BEQ.N    ??LPLD_SDHC_InitCard_4
        LDR      R0,[SP, #+0]
        CMP      R0,#+3
        BEQ.N    ??LPLD_SDHC_InitCard_4
        LDR      R0,[SP, #+0]
        CMP      R0,#+5
        BEQ.N    ??LPLD_SDHC_InitCard_4
        LDR      R0,[SP, #+0]
        CMP      R0,#+6
        BNE.N    ??LPLD_SDHC_InitCard_5
//  995     {
//  996       if ((ESDHC_CARD_SDHC == param) || (ESDHC_CARD_SDHCCOMBO == param))
??LPLD_SDHC_InitCard_4:
        LDR      R0,[SP, #+0]
        CMP      R0,#+3
        BEQ.N    ??LPLD_SDHC_InitCard_6
        LDR      R0,[SP, #+0]
        CMP      R0,#+6
        BNE.N    ??LPLD_SDHC_InitCard_7
//  997       {
//  998         sdcard_ptr->SDHC = TRUE;
??LPLD_SDHC_InitCard_6:
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+8]
//  999         break;
// 1000       }
// 1001     }
// 1002     else
// 1003     {
// 1004       continue;
// 1005     }
// 1006     time_out++;
// 1007   }
// 1008   
// 1009   if(time_out >= 1000)
??LPLD_SDHC_InitCard_2:
        CMP      R4,#+1000
        BCC.N    ??LPLD_SDHC_InitCard_8
// 1010     return RES_NOTRDY;
        MOVS     R0,#+3
        B.N      ??LPLD_SDHC_InitCard_9
??LPLD_SDHC_InitCard_7:
        ADDS     R4,R4,#+1
        B.N      ??LPLD_SDHC_InitCard_0
??LPLD_SDHC_InitCard_5:
        B.N      ??LPLD_SDHC_InitCard_0
// 1011   
// 1012   //卡识别
// 1013   command.COMMAND = ESDHC_CMD2;
??LPLD_SDHC_InitCard_8:
        LDR.W    R0,??DataTable11_14  ;; 0x2090000
        STR      R0,[SP, #+4]
// 1014   command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
// 1015   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1016   if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_InitCard_9
// 1017   {
// 1018     return result;
// 1019   }
// 1020   
// 1021   //获取卡地址
// 1022   command.COMMAND = ESDHC_CMD3;
??LPLD_SDHC_InitCard_10:
        LDR.N    R0,??DataTable11_15  ;; 0x31a0000
        STR      R0,[SP, #+4]
// 1023   command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
// 1024   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1025   if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.W    ??LPLD_SDHC_InitCard_9
// 1026   {
// 1027     return result;
// 1028   }
// 1029   sdcard_ptr->ADDRESS = command.RESPONSE[0] & 0xFFFF0000;
??LPLD_SDHC_InitCard_11:
        LDR      R0,[SP, #+20]
        LSRS     R0,R0,#+16
        LSLS     R0,R0,#+16
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+12]
// 1030   
// 1031   //获取卡参数
// 1032   command.COMMAND = ESDHC_CMD9;
        LDR.N    R0,??DataTable11_16  ;; 0x9090000
        STR      R0,[SP, #+4]
// 1033   command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1034   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1035   if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1036   {
// 1037     return result;
// 1038   }
// 1039   if (0 == (command.RESPONSE[3] & 0x00C00000))
??LPLD_SDHC_InitCard_12:
        LDR      R0,[SP, #+32]
        TST      R0,#0xC00000
        BNE.N    ??LPLD_SDHC_InitCard_13
// 1040   {
// 1041     read_bl_len = (command.RESPONSE[2] >> 8) & 0x0F;
        LDR      R0,[SP, #+28]
        UBFX     R2,R0,#+8,#+4
// 1042     c_size = command.RESPONSE[2] & 0x03;
        LDRB     R0,[SP, #+28]
        ANDS     R0,R0,#0x3
// 1043     c_size = (c_size << 10) | (command.RESPONSE[1] >> 22);
        LDR      R1,[SP, #+24]
        LSRS     R1,R1,#+22
        ORRS     R0,R1,R0, LSL #+10
// 1044     c_size_mult = (command.RESPONSE[1] >> 7) & 0x07;
        LDR      R1,[SP, #+24]
        UBFX     R1,R1,#+7,#+3
// 1045     sdcard_ptr->NUM_BLOCKS = (c_size + 1) * (1 << (c_size_mult + 2)) * (1 << (read_bl_len - 9));
        ADDS     R0,R0,#+1
        MOVS     R3,#+1
        ADDS     R1,R1,#+2
        LSLS     R1,R3,R1
        MULS     R0,R1,R0
        MOVS     R1,#+1
        SUBS     R2,R2,#+9
        LSLS     R1,R1,R2
        MULS     R0,R1,R0
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+4]
        B.N      ??LPLD_SDHC_InitCard_14
// 1046   }
// 1047   else
// 1048   {
// 1049     sdcard_ptr->VERSION2 = TRUE;
??LPLD_SDHC_InitCard_13:
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+9]
// 1050     c_size = (command.RESPONSE[1] >> 8) & 0x003FFFFF;
        LDR      R0,[SP, #+24]
        UBFX     R0,R0,#+8,#+22
// 1051     sdcard_ptr->NUM_BLOCKS = (c_size + 1) << 10;
        ADDS     R0,R0,#+1
        LSLS     R0,R0,#+10
        LDR.N    R1,??DataTable10_1
        LDR      R1,[R1, #+0]
        STR      R0,[R1, #+4]
// 1052   }
// 1053   
// 1054   //设置正常工作波特率为40MHz
// 1055   param = 40000000;      
??LPLD_SDHC_InitCard_14:
        LDR.N    R0,??DataTable11_17  ;; 0x2625a00
        STR      R0,[SP, #+0]
// 1056   if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SET_BAUDRATE, &param)))
        ADD      R1,SP,#+0
        MOVS     R0,#+5
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1057   {
// 1058     return result;
// 1059   }
// 1060   
// 1061   //选择卡
// 1062   command.COMMAND = ESDHC_CMD7;
??LPLD_SDHC_InitCard_15:
        LDR.N    R0,??DataTable11_18  ;; 0x71b0000
        STR      R0,[SP, #+4]
// 1063   command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1064   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1065   if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1066   {
// 1067     return result;
// 1068   }
// 1069   
// 1070   //设置块大小为512字节
// 1071   command.COMMAND = ESDHC_CMD16;
??LPLD_SDHC_InitCard_16:
        LDR.N    R0,??DataTable11_19  ;; 0x101a0000
        STR      R0,[SP, #+4]
// 1072   command.ARGUMENT = IO_SDCARD_BLOCK_SIZE;
        MOV      R0,#+512
        STR      R0,[SP, #+8]
// 1073   command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1074   if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1075   {
// 1076     return result;
// 1077   }
// 1078   
// 1079   if (ESDHC_BUS_WIDTH_4BIT == ESDHC_BUS_WIDTH_4BIT)
// 1080   {
// 1081     //特殊应用命令
// 1082     command.COMMAND = ESDHC_CMD55;
??LPLD_SDHC_InitCard_17:
        LDR.N    R0,??DataTable11_8  ;; 0x371a0000
        STR      R0,[SP, #+4]
// 1083     command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1084     command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1085     if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1086     {
// 1087       return result;
// 1088     }
// 1089     
// 1090     //设置总线宽度为4bit
// 1091     command.COMMAND = ESDHC_ACMD6;
??LPLD_SDHC_InitCard_18:
        LDR.N    R0,??DataTable11_20  ;; 0x61a0000
        STR      R0,[SP, #+4]
// 1092     command.ARGUMENT = 2;
        MOVS     R0,#+2
        STR      R0,[SP, #+8]
// 1093     command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1094     if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1095     {
// 1096       return result;
// 1097     }
// 1098     
// 1099     param = ESDHC_BUS_WIDTH_4BIT;
??LPLD_SDHC_InitCard_19:
        MOVS     R0,#+1
        STR      R0,[SP, #+0]
// 1100     if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SET_BUS_WIDTH, &param)))
        ADD      R1,SP,#+0
        MOVS     R0,#+7
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_InitCard_9
// 1101     {
// 1102       return result;
// 1103     }
// 1104   }
// 1105   
// 1106   return RES_OK;
??LPLD_SDHC_InitCard_20:
        MOVS     R0,#+0
??LPLD_SDHC_InitCard_9:
        ADD      SP,SP,#+40
        POP      {R4,PC}          ;; return
// 1107 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     0x1008000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     0x400b10c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     0x400b1004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     0x400b1044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     0x10002
// 1108 
// 1109 
// 1110 /*
// 1111  * LPLD_SDHC_ReadBlocks
// 1112  * 读指定扇区指定长度的块
// 1113  * 
// 1114  * 参数:
// 1115  *    buff--存储读出数据的地址指针
// 1116  *    sector--开始的扇区号
// 1117  *    count--读出的扇区数（块数）
// 1118  *
// 1119  * 输出:
// 1120  *    DRESULT--磁盘功能返回值
// 1121  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1122 DRESULT LPLD_SDHC_ReadBlocks(uint8 *buff, uint32 sector, uint32 count)
// 1123 {
LPLD_SDHC_ReadBlocks:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+32
        MOVS     R4,R0
        MOVS     R5,R2
// 1124   ESDHC_COMMAND_STRUCT command;
// 1125   int cnt;
// 1126   int32 result;
// 1127   
// 1128   //SD卡数据地址调节
// 1129   if (! sdcard_ptr->SDHC)
        LDR.N    R0,??DataTable10_1
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+8]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_ReadBlocks_0
// 1130   {
// 1131     sector <<= IO_SDCARD_BLOCK_SIZE_POWER;
        LSLS     R1,R1,#+9
// 1132   }
// 1133   
// 1134   //设置读块命令
// 1135   if (count > 1)
??LPLD_SDHC_ReadBlocks_0:
        CMP      R5,#+2
        BCC.N    ??LPLD_SDHC_ReadBlocks_1
// 1136   {
// 1137     command.COMMAND = ESDHC_CMD18;
        LDR.N    R0,??DataTable11_21  ;; 0x121a0034
        STR      R0,[SP, #+0]
        B.N      ??LPLD_SDHC_ReadBlocks_2
// 1138   }   
// 1139   else
// 1140   {
// 1141     command.COMMAND = ESDHC_CMD17;
??LPLD_SDHC_ReadBlocks_1:
        LDR.N    R0,??DataTable11_22  ;; 0x111a0010
        STR      R0,[SP, #+0]
// 1142   }
// 1143   
// 1144   command.ARGUMENT = sector;
??LPLD_SDHC_ReadBlocks_2:
        STR      R1,[SP, #+4]
// 1145   command.BLOCKS = count;
        STR      R5,[SP, #+8]
// 1146   command.BLOCKSIZE = IO_SDCARD_BLOCK_SIZE;
        MOV      R0,#+512
        STR      R0,[SP, #+12]
// 1147   if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+0
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_ReadBlocks_3
// 1148   {
// 1149     return (DRESULT)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_ReadBlocks_4
// 1150   }
// 1151   
// 1152   //读取数据
// 1153   for (cnt = 0; cnt < count; cnt++)
??LPLD_SDHC_ReadBlocks_3:
        MOVS     R6,#+0
        B.N      ??LPLD_SDHC_ReadBlocks_5
// 1154   {
// 1155     if (IO_SDCARD_BLOCK_SIZE != (result=LPLD_SDHC_Read(buff,IO_SDCARD_BLOCK_SIZE)))
// 1156     {
// 1157       return (DRESULT)result;
// 1158     }
// 1159     buff += IO_SDCARD_BLOCK_SIZE;
??LPLD_SDHC_ReadBlocks_6:
        ADDS     R4,R4,#+512
        ADDS     R6,R6,#+1
??LPLD_SDHC_ReadBlocks_5:
        CMP      R6,R5
        BCS.N    ??LPLD_SDHC_ReadBlocks_7
        MOV      R1,#+512
        MOVS     R0,R4
        BL       LPLD_SDHC_Read
        CMP      R0,#+512
        BEQ.N    ??LPLD_SDHC_ReadBlocks_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_ReadBlocks_4
// 1160   }
// 1161   
// 1162   //等待传输结束
// 1163   if (RES_OK !=(result=LPLD_SDHC_IOC (IO_IOCTL_FLUSH_OUTPUT, NULL)))
??LPLD_SDHC_ReadBlocks_7:
        MOVS     R1,#+0
        MOVS     R0,#+147
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_ReadBlocks_8
// 1164   {
// 1165     return (DRESULT)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_ReadBlocks_4
// 1166   }
// 1167   
// 1168   return (DRESULT)result;
??LPLD_SDHC_ReadBlocks_8:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??LPLD_SDHC_ReadBlocks_4:
        ADD      SP,SP,#+32
        POP      {R4-R6,PC}       ;; return
// 1169 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC32     0x400b1030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_1:
        DC32     sdcard_ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_2:
        DC32     0x400b1028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_3:
        DC32     0x400b1034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_4:
        DC32     0x7f00b3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_5:
        DC32     0x400b1008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_6:
        DC32     0x400b1000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_7:
        DC32     0x400b100c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10_8:
        DC32     0xe0001
// 1170 
// 1171 
// 1172 /*
// 1173  * LPLD_SDHC_WriteBlocks
// 1174  * 在指定扇区写入指定长度块数数据
// 1175  * 
// 1176  * 参数:
// 1177  *    buff--存储待写入数据的地址指针
// 1178  *    sector--开始的扇区号
// 1179  *    count--写入的扇区数（块数）
// 1180  *
// 1181  * 输出:
// 1182  *    DRESULT--磁盘功能返回值
// 1183  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1184 DRESULT LPLD_SDHC_WriteBlocks(uint8* buff, uint32 sector, uint32 count)
// 1185 {
LPLD_SDHC_WriteBlocks:
        PUSH     {R4-R6,LR}
        SUB      SP,SP,#+40
        MOVS     R6,R0
        MOVS     R5,R2
// 1186     ESDHC_COMMAND_STRUCT command;
// 1187     uint8               tmp[4];
// 1188     int32             cnt;
// 1189       int32 result;
// 1190     
// 1191  
// 1192     //SD卡数据地址调节
// 1193     if (! sdcard_ptr->SDHC)
        LDR.N    R0,??DataTable11_23
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+8]
        CMP      R0,#+0
        BNE.N    ??LPLD_SDHC_WriteBlocks_0
// 1194     {
// 1195         sector <<= IO_SDCARD_BLOCK_SIZE_POWER;
        LSLS     R1,R1,#+9
// 1196     }
// 1197 
// 1198     //设置写块命令
// 1199     if (count > 1)
??LPLD_SDHC_WriteBlocks_0:
        CMP      R5,#+2
        BCC.N    ??LPLD_SDHC_WriteBlocks_1
// 1200     {
// 1201         command.COMMAND = ESDHC_CMD25;
        LDR.N    R0,??DataTable11_24  ;; 0x191a0024
        STR      R0,[SP, #+4]
        B.N      ??LPLD_SDHC_WriteBlocks_2
// 1202     }
// 1203     else
// 1204     {
// 1205         command.COMMAND = ESDHC_CMD24;
??LPLD_SDHC_WriteBlocks_1:
        LDR.N    R0,??DataTable11_25  ;; 0x181a0000
        STR      R0,[SP, #+4]
// 1206     }
// 1207 
// 1208     command.ARGUMENT = sector;
??LPLD_SDHC_WriteBlocks_2:
        STR      R1,[SP, #+8]
// 1209     command.BLOCKS = count;
        STR      R5,[SP, #+12]
// 1210     command.BLOCKSIZE = IO_SDCARD_BLOCK_SIZE;
        MOV      R0,#+512
        STR      R0,[SP, #+16]
// 1211     if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_3
// 1212     {
// 1213         return (DRESULT)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1214     }
// 1215     
// 1216     //写数据
// 1217     for (cnt = 0; cnt < count; cnt++)
??LPLD_SDHC_WriteBlocks_3:
        MOVS     R4,#+0
        B.N      ??LPLD_SDHC_WriteBlocks_5
// 1218     {
// 1219         if (IO_SDCARD_BLOCK_SIZE != (result=LPLD_SDHC_Write (buff, IO_SDCARD_BLOCK_SIZE)))
// 1220         {
// 1221             return (DRESULT)result;
// 1222         }
// 1223         buff += IO_SDCARD_BLOCK_SIZE;
??LPLD_SDHC_WriteBlocks_6:
        ADDS     R6,R6,#+512
        ADDS     R4,R4,#+1
??LPLD_SDHC_WriteBlocks_5:
        CMP      R4,R5
        BCS.N    ??LPLD_SDHC_WriteBlocks_7
        MOV      R1,#+512
        MOVS     R0,R6
        BL       LPLD_SDHC_Write
        CMP      R0,#+512
        BEQ.N    ??LPLD_SDHC_WriteBlocks_6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1224     }
// 1225 
// 1226     //等待传输结束
// 1227     if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_FLUSH_OUTPUT, NULL)))
??LPLD_SDHC_WriteBlocks_7:
        MOVS     R1,#+0
        MOVS     R0,#+147
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_8
// 1228     {
// 1229         return (DRESULT)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1230     }
// 1231 
// 1232     //等待卡准备好/传输状态
// 1233     do
// 1234     {
// 1235         command.COMMAND = ESDHC_CMD13;
??LPLD_SDHC_WriteBlocks_8:
        LDR.N    R0,??DataTable11_26  ;; 0xd1a0000
        STR      R0,[SP, #+4]
// 1236         command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable11_23
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1237         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1238         if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_9
// 1239         {
// 1240             return (DRESULT)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1241         }
// 1242 
// 1243         //卡状态错误检查
// 1244         if (command.RESPONSE[0] & 0xFFD98008)
??LPLD_SDHC_WriteBlocks_9:
        LDR      R0,[SP, #+20]
        LDR.N    R1,??DataTable11_27  ;; 0xffd98008
        TST      R0,R1
        BEQ.N    ??LPLD_SDHC_WriteBlocks_10
// 1245         {
// 1246             count = 0; /* necessary to get real number of written blocks */
        MOVS     R5,#+0
// 1247             break;
        B.N      ??LPLD_SDHC_WriteBlocks_11
// 1248         }
// 1249 
// 1250     } while (0x000000900 != (command.RESPONSE[0] & 0x00001F00));
??LPLD_SDHC_WriteBlocks_10:
        LDR      R0,[SP, #+20]
        ANDS     R0,R0,#0x1F00
        CMP      R0,#+2304
        BNE.N    ??LPLD_SDHC_WriteBlocks_8
// 1251 
// 1252     if (cnt != count)
??LPLD_SDHC_WriteBlocks_11:
        CMP      R4,R5
        BEQ.N    ??LPLD_SDHC_WriteBlocks_12
// 1253     {
// 1254         //特殊应用命令
// 1255         command.COMMAND = ESDHC_CMD55;
        LDR.N    R0,??DataTable11_8  ;; 0x371a0000
        STR      R0,[SP, #+4]
// 1256         command.ARGUMENT = sdcard_ptr->ADDRESS;
        LDR.N    R0,??DataTable11_23
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+12]
        STR      R0,[SP, #+8]
// 1257         command.BLOCKS = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+12]
// 1258         if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_13
// 1259         {
// 1260             return (DRESULT)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1261         }
// 1262                 
// 1263         //使用ACMD22命令获得写入的块数量
// 1264         command.COMMAND = ESDHC_ACMD22;
??LPLD_SDHC_WriteBlocks_13:
        LDR.N    R0,??DataTable11_28  ;; 0x161a0010
        STR      R0,[SP, #+4]
// 1265         command.ARGUMENT = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+8]
// 1266         command.BLOCKS = 1;
        MOVS     R0,#+1
        STR      R0,[SP, #+12]
// 1267         command.BLOCKSIZE = 4;
        MOVS     R0,#+4
        STR      R0,[SP, #+16]
// 1268         if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_ESDHC_SEND_COMMAND, &command)))
        ADD      R1,SP,#+4
        MOVS     R0,#+2
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_14
// 1269         {
// 1270             return (DRESULT)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1271         }
// 1272         
// 1273         if (4 != (result=LPLD_SDHC_Read (tmp, 4)))
??LPLD_SDHC_WriteBlocks_14:
        MOVS     R1,#+4
        ADD      R0,SP,#+0
        BL       LPLD_SDHC_Read
        CMP      R0,#+4
        BEQ.N    ??LPLD_SDHC_WriteBlocks_15
// 1274         {
// 1275             return (DRESULT)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1276             
// 1277         }
// 1278 
// 1279         if (RES_OK != (result=LPLD_SDHC_IOC (IO_IOCTL_FLUSH_OUTPUT, NULL)))
??LPLD_SDHC_WriteBlocks_15:
        MOVS     R1,#+0
        MOVS     R0,#+147
        BL       LPLD_SDHC_IOC
        CMP      R0,#+0
        BEQ.N    ??LPLD_SDHC_WriteBlocks_16
// 1280         {
// 1281             return (DRESULT)result;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1282         }
// 1283 
// 1284         count = (tmp[0] << 24) | (tmp[1] << 16) | (tmp[2] << 8) | tmp[3];
??LPLD_SDHC_WriteBlocks_16:
        LDRB     R0,[SP, #+0]
        LDRB     R1,[SP, #+1]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[SP, #+2]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[SP, #+3]
        ORRS     R5,R1,R0
// 1285         if ((cnt < 0) || (cnt > count))
        CMP      R4,#+0
        BMI.N    ??LPLD_SDHC_WriteBlocks_17
        CMP      R5,R4
        BCS.N    ??LPLD_SDHC_WriteBlocks_12
// 1286             return RES_ERROR;
??LPLD_SDHC_WriteBlocks_17:
        MOVS     R0,#+1
        B.N      ??LPLD_SDHC_WriteBlocks_4
// 1287     }
// 1288     
// 1289     return RES_OK;
??LPLD_SDHC_WriteBlocks_12:
        MOVS     R0,#+0
??LPLD_SDHC_WriteBlocks_4:
        ADD      SP,SP,#+40
        POP      {R4-R6,PC}       ;; return
// 1290 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11:
        DC32     0x400b1010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_1:
        DC32     0x400b1014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_2:
        DC32     0x400b1018

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_3:
        DC32     0x400b101c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_4:
        DC32     0x61a80

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_5:
        DC32     core_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_6:
        DC32     0x81a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_7:
        DC32     0x5020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_8:
        DC32     0x371a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_9:
        DC32     0x40300000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_10:
        DC32     0x27020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_11:
        DC32     0x29020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_12:
        DC32     0x17d7840

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_13:
        DC32     0x400b1020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_14:
        DC32     0x2090000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_15:
        DC32     0x31a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_16:
        DC32     0x9090000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_17:
        DC32     0x2625a00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_18:
        DC32     0x71b0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_19:
        DC32     0x101a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_20:
        DC32     0x61a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_21:
        DC32     0x121a0034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_22:
        DC32     0x111a0010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_23:
        DC32     sdcard_ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_24:
        DC32     0x191a0024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_25:
        DC32     0x181a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_26:
        DC32     0xd1a0000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_27:
        DC32     0xffd98008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_28:
        DC32     0x161a0010

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
//     4 bytes in section .bss
// 3 956 bytes in section .text
// 
// 3 956 bytes of CODE memory
//     4 bytes of DATA memory
//
//Errors: none
//Warnings: 1
