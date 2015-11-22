///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:55 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\HAL_DAC.c                 /
//    Command line =  "F:\robot _init\robot\lib\LPLD\HAL_DAC.c" -D IAR -D     /
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
//                    st\HAL_DAC.s                                            /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_DAC

        #define SHT_PROGBITS 0x1

        EXTERN enable_irq

        PUBLIC DAC_ISR
        PUBLIC DACx_Ptr
        PUBLIC LPLD_DAC_Init
        PUBLIC LPLD_DAC_Isr
        PUBLIC LPLD_DAC_Reset_Reg
        PUBLIC LPLD_DAC_Set_Buffer
        PUBLIC LPLD_DAC_Soft_Trig

// F:\robot _init\robot\lib\LPLD\HAL_DAC.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_DAC.c
//   10  * 用途: DAC底层模块相关函数
//   11  * 最后修改日期: 20120618
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17 */
//   18 
//   19 #include "HAL_DAC.h"
//   20 #include "common.h"
//   21 
//   22 
//   23 //内部函数
//   24 uint8 LPLD_DAC_Config(LPLD_DAC_Cfg_t *);
//   25 
//   26 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   27 DAC_ISR_CALLBACK DAC_ISR[2];
DAC_ISR:
        DS8 8
//   28 
//   29 /*******需用到DAC中断，请在isr.h中粘贴一下代码:*********
//   30 
//   31 //DAC模块中断服务定义
//   32 #undef  VECTOR_097
//   33 #define VECTOR_097 LPLD_DAC_Isr
//   34 #undef  VECTOR_098
//   35 #define VECTOR_098 LPLD_DAC_Isr
//   36 
//   37 //以下函数在LPLD_Kinetis底层包，不必修改
//   38 extern void LPLD_DAC_Isr(void);
//   39 */
//   40 
//   41 
//   42 
//   43 //DAC映射地址数组

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   44 volatile DAC_MemMapPtr DACx_Ptr[2] = {DAC0_BASE_PTR, 
DACx_Ptr:
        DATA
        DC32 400CC000H, 400CD000H
//   45                                       DAC1_BASE_PTR};
//   46 /*
//   47 
//   48  * LPLD_DAC_Set_Buffer
//   49  * 设置DAC通道的缓冲区
//   50  * 
//   51  * 参数:
//   52  *    dacx--DAC模块号
//   53  *      |__DAC0           --DAC0模块
//   54  *      |__DAC1           --DAC1模块
//   55  *    DACx_DATn--DAC缓冲区号
//   56  *      |__0~15           --缓冲区0~15号
//   57  *    data16--DAC缓冲区数据
//   58  *
//   59  * 输出
//   60  *    无
//   61  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   62 void LPLD_DAC_Set_Buffer(DACx dacx, uint8 DACx_DATn, uint16 data16)
//   63 {
//   64   DAC_MemMapPtr dacptr = DACx_Ptr[dacx];
LPLD_DAC_Set_Buffer:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R3,??DataTable4
        LDR      R0,[R3, R0, LSL #+2]
//   65   DAC_DATL_REG(dacptr, DACx_DATn) = (data16&0x0ff); 
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        STRB     R2,[R0, R1, LSL #+1]
//   66   DAC_DATH_REG(dacptr, DACx_DATn) = (data16&0xf00)>>8;                                
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ADDS     R0,R0,R1, LSL #+1
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ASRS     R1,R2,#+8
        ANDS     R1,R1,#0xF
        STRB     R1,[R0, #+1]
//   67 }
        BX       LR               ;; return
//   68 
//   69 
//   70 
//   71 /*
//   72  * LPLD_DAC_Reset_Reg
//   73  * 复位DAC通道以及各个寄存器
//   74  * 
//   75  * 参数:
//   76  *    dacx--DAC模块号
//   77  *      |__DAC0           --DAC0模块
//   78  *      |__DAC1           --DAC1模块
//   79  * 输出
//   80  *    无
//   81  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   82 void LPLD_DAC_Reset_Reg(DACx dacx)
//   83 {
LPLD_DAC_Reset_Reg:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
//   84   DAC_MemMapPtr dacptr = DACx_Ptr[dacx];
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable4
        LDR      R5,[R0, R4, LSL #+2]
//   85   uint8 i;   
//   86   
//   87   //复位16个通道缓存
//   88   for (i=0; i<16;i++)
        MOVS     R6,#+0
        B.N      ??LPLD_DAC_Reset_Reg_0
//   89   {
//   90     LPLD_DAC_Set_Buffer(dacx, i, 0x00); 
??LPLD_DAC_Reset_Reg_1:
        MOVS     R2,#+0
        MOVS     R1,R6
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_DAC_Set_Buffer
//   91   }
        ADDS     R6,R6,#+1
??LPLD_DAC_Reset_Reg_0:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+16
        BCC.N    ??LPLD_DAC_Reset_Reg_1
//   92   //DAC 缓存读指针清零
//   93   DAC_SR_REG(dacptr) = DAC_SR_DACBFRPTF_MASK ;
        MOVS     R0,#+2
        STRB     R0,[R5, #+32]
//   94   //清空 C0 寄存器 
//   95   DAC_C0_REG(dacptr) = 0x00 ;
        MOVS     R0,#+0
        STRB     R0,[R5, #+33]
//   96   //清空 C1 寄存器 
//   97   DAC_C1_REG(dacptr) = 0x00 ;
        MOVS     R0,#+0
        STRB     R0,[R5, #+34]
//   98   //将缓冲区的上限设置为最大
//   99   DAC_C2_REG(dacptr) = 0x0F;
        MOVS     R0,#+15
        STRB     R0,[R5, #+35]
//  100 }
        POP      {R4-R6,PC}       ;; return
//  101 
//  102 /*
//  103  * LPLD_DAC_Init
//  104  * DAC模块初始化函数，在此函数中设置默认参数以及调用LPLD_DAC_Config配置寄存器
//  105  *
//  106  * 参数 LPLD_DAC_Cfg_t *DAC_Config
//  107  * 详细参数在LPLD_DAC_Cfg_t 结构体中定义
//  108  * LPLD_DAC_Cfg_t 结构体在（在HAL_DAC.h）头文件中定义
//  109  *
//  110  * 输出：
//  111  *   0 初始化失败
//  112  *   1 初始化成功
//  113 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  114 uint8 LPLD_DAC_Init(LPLD_DAC_Cfg_t *DAC_Config)
//  115 { 
LPLD_DAC_Init:
        PUSH     {R7,LR}
//  116   
//  117   if(DAC_Config -> dacx > DAC1)
        LDRB     R1,[R0, #+0]
        CMP      R1,#+2
        BCC.N    ??LPLD_DAC_Init_0
//  118   {
//  119     return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_Init_1
//  120   }
//  121   
//  122   //如果用户没有设置 水印模式的字数 默认为1个字
//  123   if(DAC_Config -> Water_Mark_Mode  == NULL)
??LPLD_DAC_Init_0:
        LDRB     R1,[R0, #+1]
        CMP      R1,#+0
        BNE.N    ??LPLD_DAC_Init_2
//  124   {
//  125     DAC_Config -> Water_Mark_Mode = WATER_MODE_1WORD;
        MOVS     R1,#+0
        STRB     R1,[R0, #+1]
//  126   }
//  127   
//  128   //如果用户没有设置 缓冲区使能 默认为禁用缓冲区
//  129   if(DAC_Config -> Buffer_Enable == NULL)
??LPLD_DAC_Init_2:
        LDRB     R1,[R0, #+2]
        CMP      R1,#+0
        BNE.N    ??LPLD_DAC_Init_3
//  130   {
//  131     DAC_Config -> Buffer_Enable = BUFFER_DISABLE;       
        MOVS     R1,#+0
        STRB     R1,[R0, #+2]
//  132   }
//  133   
//  134   //如果用户没有设置 缓冲区的模式 默认为正常模式
//  135   if(DAC_Config -> Buffer_Mode == NULL)
??LPLD_DAC_Init_3:
        LDRB     R1,[R0, #+3]
        CMP      R1,#+0
        BNE.N    ??LPLD_DAC_Init_4
//  136   {
//  137     DAC_Config -> Buffer_Mode = BUFFER_MODE_NORMAL;       
        MOVS     R1,#+0
        STRB     R1,[R0, #+3]
//  138   }
//  139   
//  140   //如果用户没有设置 触发模式 默认为无触发模式
//  141   if(DAC_Config -> Triger_Mode == NULL)
??LPLD_DAC_Init_4:
        LDRB     R1,[R0, #+4]
        CMP      R1,#+0
        BNE.N    ??LPLD_DAC_Init_5
//  142   {
//  143     DAC_Config -> Triger_Mode = TRIGER_MODE_NONE;   
        MOVS     R1,#+0
        STRB     R1,[R0, #+4]
//  144   } 
//  145   
//  146   //如果用户没有设置 缓冲区的起始位置 默认为0
//  147   if(DAC_Config -> Buffer_Init_Pos ==NULL)
??LPLD_DAC_Init_5:
        LDRB     R1,[R0, #+5]
        CMP      R1,#+0
        BNE.N    ??LPLD_DAC_Init_6
//  148   {
//  149     DAC_Config -> Buffer_Init_Pos = 0;    
        MOVS     R1,#+0
        STRB     R1,[R0, #+5]
//  150   }
//  151   
//  152   //如果用户没有设置 缓冲区的最大值 默认为16
//  153   if(DAC_Config -> Buffer_Up_Limit == NULL)
??LPLD_DAC_Init_6:
        LDRB     R1,[R0, #+6]
        CMP      R1,#+0
        BNE.N    ??LPLD_DAC_Init_7
//  154   {
//  155     DAC_Config -> Buffer_Up_Limit = 15;   
        MOVS     R1,#+15
        STRB     R1,[R0, #+6]
//  156   }
//  157     
//  158   //如果用户没有设置 中断方式 默认为不开中断
//  159   if(DAC_Config -> DAC_irqc == NULL)
??LPLD_DAC_Init_7:
        LDRB     R1,[R0, #+7]
        CMP      R1,#+0
        BNE.N    ??LPLD_DAC_Init_8
//  160   {
//  161     DAC_Config -> DAC_irqc = 0;     
        MOVS     R1,#+0
        STRB     R1,[R0, #+7]
//  162   } 
//  163 
//  164   //配置DAC寄存器
//  165   return LPLD_DAC_Config(DAC_Config);
??LPLD_DAC_Init_8:
        BL       LPLD_DAC_Config
??LPLD_DAC_Init_1:
        POP      {R1,PC}          ;; return
//  166 
//  167 }
//  168 
//  169 /*
//  170  * 内部函数，用户无需调用
//  171  * LPLD_DAC_Config
//  172  * 配置DAC寄存器函数
//  173  *
//  174  * 参数 LPLD_DAC_Cfg_t *DAC_Config
//  175  * 详细参数在LPLD_DAC_Cfg_t 结构体中定义
//  176  * LPLD_DAC_Cfg_t 结构体在（在HAL_DAC.h）头文件中定义
//  177  *
//  178  * 输出：
//  179  *   0 配置失败
//  180  *   1 配置成功
//  181 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  182 static uint8 LPLD_DAC_Config(LPLD_DAC_Cfg_t *DAC_Config)
//  183 {
LPLD_DAC_Config:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  184   DAC_MemMapPtr dacptr = DACx_Ptr[DAC_Config->dacx];
        LDRB     R0,[R4, #+0]
        LDR.N    R1,??DataTable4
        LDR      R5,[R1, R0, LSL #+2]
//  185   
//  186   //===========配置DAC_C0寄存器=================//
//  187   if( dacptr == DAC0_BASE_PTR )
        LDR.N    R0,??DataTable4_1  ;; 0x400cc000
        CMP      R5,R0
        BNE.N    ??LPLD_DAC_Config_0
//  188   {
//  189     //开启DAC0时钟
//  190     SIM_SCGC2 |= SIM_SCGC2_DAC0_MASK ; 
        LDR.N    R0,??DataTable4_2  ;; 0x4004802c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1000
        LDR.N    R1,??DataTable4_2  ;; 0x4004802c
        STR      R0,[R1, #+0]
//  191     
//  192     if(DAC_Config -> DAC_irqc)
        LDRB     R0,[R4, #+7]
        CMP      R0,#+0
        BEQ.N    ??LPLD_DAC_Config_1
//  193     {
//  194       enable_irq(81);//开启DAC0 CPU级中断
        MOVS     R0,#+81
        BL       enable_irq
//  195       DAC_ISR[0]=DAC_Config -> isr_func;
        LDR      R0,[R4, #+8]
        LDR.N    R1,??DataTable4_3
        STR      R0,[R1, #+0]
//  196     }
//  197     
//  198   }
//  199   else if( dacptr == DAC1_BASE_PTR )
//  200   {
//  201     //开启DAC1时钟
//  202     SIM_SCGC2 |= SIM_SCGC2_DAC1_MASK ; 
//  203     
//  204     if(DAC_Config->DAC_irqc)
//  205     {
//  206       enable_irq(82);//开启DAC1 CPU级中断
//  207       DAC_ISR[1]=DAC_Config->isr_func;
//  208     }
//  209   }
//  210   else
//  211     return 0;
//  212   
//  213   //===========配置DAC_C0寄存器=================//
//  214   DAC_C0_REG(dacptr)  =0;
??LPLD_DAC_Config_1:
        MOVS     R0,#+0
        STRB     R0,[R5, #+33]
//  215   //禁止DAC模块所有中断
//  216   if(DAC_Config->DAC_irqc == DAC_IRQ_DISABLE)
        LDRB     R0,[R4, #+7]
        CMP      R0,#+0
        BNE.N    ??LPLD_DAC_Config_2
//  217   {
//  218     //The DAC buffer read pointer bottom flag interrupt is disabled.
//  219     DAC_C0_REG(dacptr) &= (~DAC_C0_DACBBIEN_MASK);
        LDRB     R0,[R5, #+33]
        ANDS     R0,R0,#0xFE
        STRB     R0,[R5, #+33]
//  220     //The DAC buffer read pointer top flag interrupt is disabled.
//  221     DAC_C0_REG(dacptr) &= (~DAC_C0_DACBTIEN_MASK);
        LDRB     R0,[R5, #+33]
        ANDS     R0,R0,#0xFD
        STRB     R0,[R5, #+33]
//  222     //The DAC buffer watermark interrupt is disabled.
//  223     DAC_C0_REG(dacptr) &= (~DAC_C0_DACBWIEN_MASK); 
        LDRB     R0,[R5, #+33]
        ANDS     R0,R0,#0xFB
        STRB     R0,[R5, #+33]
//  224   }
//  225   //开启DAC模块计数指针指底中断
//  226   else if(DAC_Config->DAC_irqc == DAC_IRQ_POINTER_BOTTOM)
//  227   {
//  228     //The DAC buffer read pointer bottom flag interrupt is disabled.
//  229     DAC_C0_REG(dacptr) |= DAC_C0_DACBBIEN_MASK; 
//  230   }
//  231   //开启DAC模块计数指针指顶中断
//  232   else if(DAC_Config->DAC_irqc == DAC_IRQ_POINTER_TOP)
//  233   {
//  234     //The DAC buffer read pointer top flag interrupt is disabled.
//  235     DAC_C0_REG(dacptr) |=  DAC_C0_DACBTIEN_MASK; 
//  236   }
//  237   //开启DAC模块计数水印中断
//  238   else if(DAC_Config->DAC_irqc == DAC_IRQ_WATER_MARK)
//  239   {
//  240     //The DAC buffer watermark interrupt is disabled.
//  241     DAC_C0_REG(dacptr) |=  DAC_C0_DACBWIEN_MASK;   
//  242   }
//  243   else 
//  244     return 0;
//  245 
//  246   //设置DAC能耗模式：设置成为高功耗模式
//  247   DAC_C0_REG(dacptr) &= (~DAC_C0_LPEN_MASK);
??LPLD_DAC_Config_3:
        LDRB     R0,[R5, #+33]
        ANDS     R0,R0,#0xF7
        STRB     R0,[R5, #+33]
//  248   
//  249   //配置触发方式
//  250   //无触发方式，DAC根据BUFFER0的数值从DAC0通道输出
//  251   if(DAC_Config->Triger_Mode == TRIGER_MODE_NONE)
        LDRB     R0,[R4, #+4]
        CMP      R0,#+0
        BNE.N    ??LPLD_DAC_Config_4
//  252   {
//  253     //设置DAC触发方式：软件触发禁止
//  254     DAC_C0_REG(dacptr) &= (~DAC_C0_DACTRGSEL_MASK);
        LDRB     R0,[R5, #+33]
        ANDS     R0,R0,#0xDF
        STRB     R0,[R5, #+33]
//  255     //设置DAC软件触发方式是否有效：=1 有效 =0 无效
//  256     DAC_C0_REG(dacptr) |=  DAC_C0_DACSWTRG_MASK;
        LDRB     R0,[R5, #+33]
        ORRS     R0,R0,#0x10
        STRB     R0,[R5, #+33]
//  257   }
//  258   //软件触发方式，DAC根据DAC_C0_DACSWTRG_MASK 产生软件触发信号
//  259   else if(DAC_Config->Triger_Mode == TRIGER_MODE_SOFTWARE)
//  260   {
//  261     //设置DAC触发方式：软件触发开启
//  262     DAC_C0_REG(dacptr) |=  DAC_C0_DACTRGSEL_MASK;
//  263     //设置DAC软件触发方式是否有效：=1 有效 =0 无效
//  264     DAC_C0_REG(dacptr) |=  DAC_C0_DACSWTRG_MASK;
//  265   }
//  266   //软件触发方式，DAC根据硬件产生的信号 产生触发
//  267   else if(DAC_Config->Triger_Mode == TRIGER_MODE_HARDWARE)
//  268   {
//  269     //设置DAC触发方式：硬件出发开启
//  270     DAC_C0_REG(dacptr) &= (~DAC_C0_DACTRGSEL_MASK);
//  271     //设置DAC软件触发方式是否有效：=1 有效 =0 无效
//  272     DAC_C0_REG(dacptr) &= (~DAC_C0_DACSWTRG_MASK );
//  273   }
//  274   else 
//  275     return 0;
//  276   //选择DAC电压参考源
//  277   //0 The DAC selets DACREF_1 as the reference voltage.
//  278   //  VREF_OUT = DACREF_1
//  279   //1 The DAC selets DACREF_2 as the reference voltage.
//  280   //  VDDA = DACREF_2
//  281   //选择VDDA作为参考电压
//  282   DAC_C0_REG(dacptr) |=  DAC_C0_DACRFS_MASK;
??LPLD_DAC_Config_5:
        LDRB     R0,[R5, #+33]
        ORRS     R0,R0,#0x40
        STRB     R0,[R5, #+33]
//  283   //使能DAC模块
//  284   DAC_C0_REG(dacptr) |=  DAC_C0_DACEN_MASK;
        LDRB     R0,[R5, #+33]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+33]
//  285   //===========DAC_C0配置完毕====================//
//  286   
//  287   //===========配置DAC_C1寄存器=================//
//  288   DAC_C1_REG(dacptr)  = 0;
        MOVS     R0,#+0
        STRB     R0,[R5, #+34]
//  289   //禁止DAC的DMA模式 
//  290   DAC_C1_REG(dacptr) &= (~DAC_C1_DMAEN_MASK);
        LDRB     R0,[R5, #+34]
        ANDS     R0,R0,#0x7F
        STRB     R0,[R5, #+34]
//  291   //DAC buffer watermark select
//  292   
//  293   //DAC 水印缓冲设置为 1个word 
//  294   if(DAC_Config->Water_Mark_Mode == WATER_MODE_1WORD)
        LDRB     R0,[R4, #+1]
        CMP      R0,#+0
        BNE.N    ??LPLD_DAC_Config_6
//  295   {
//  296     DAC_C1_REG(dacptr) |= DAC_C1_DACBFWM(WATER_MODE_1WORD);
        LDRB     R0,[R5, #+34]
        STRB     R0,[R5, #+34]
//  297   }
//  298    //DAC 水印缓冲设置为 2个word 
//  299   else if(DAC_Config->Water_Mark_Mode == WATER_MODE_2WORD)
//  300   {
//  301     DAC_C1_REG(dacptr) |= DAC_C1_DACBFWM(WATER_MODE_2WORD);  
//  302   }
//  303    //DAC 水印缓冲设置为 3word 
//  304   else if(DAC_Config->Water_Mark_Mode == WATER_MODE_3WORD)
//  305   {
//  306     DAC_C1_REG(dacptr) |= DAC_C1_DACBFWM(WATER_MODE_3WORD);   
//  307   }
//  308   //DAC 水印缓冲设置为 4个word 
//  309   else if(DAC_Config->Water_Mark_Mode == WATER_MODE_4WORD)
//  310   {
//  311     DAC_C1_REG(dacptr) |= DAC_C1_DACBFWM(WATER_MODE_4WORD);   
//  312   }
//  313   else
//  314     return 0;
//  315   
//  316   //DAC 选择为正常模式
//  317   //DAC Buffer 指针从零开始++ 直到等于 DAC Buffer Limit
//  318   //然后DAC Buffer 指针清零
//  319   //设置成为正常模式
//  320   if(DAC_Config->Buffer_Mode == BUFFER_MODE_NORMAL)
??LPLD_DAC_Config_7:
        LDRB     R0,[R4, #+3]
        CMP      R0,#+0
        BNE.W    ??LPLD_DAC_Config_8
//  321   {
//  322     DAC_C1_REG(dacptr) |= DAC_C1_DACBFMD(BUFFER_MODE_NORMAL);
        LDRB     R0,[R5, #+34]
        STRB     R0,[R5, #+34]
//  323   }
//  324   //设置成为反转模式
//  325   else if(DAC_Config->Buffer_Mode == BUFFER_MODE_SWING)
//  326   {
//  327     DAC_C1_REG(dacptr) |= DAC_C1_DACBFMD(BUFFER_MODE_SWING);  
//  328   }
//  329   //设置成为一次扫描模式
//  330   else if(DAC_Config->Buffer_Mode == BUFFER_MODE_ONETIMESCAN)
//  331   {
//  332     DAC_C1_REG(dacptr) |= DAC_C1_DACBFMD(BUFFER_MODE_ONETIMESCAN);   
//  333   }
//  334   else
//  335     return 0;
//  336   
//  337   //是否使能DAC Buffer  
//  338   if(DAC_Config->Buffer_Enable == BUFFER_ENABLE)
??LPLD_DAC_Config_9:
        LDRB     R0,[R4, #+2]
        CMP      R0,#+1
        BNE.W    ??LPLD_DAC_Config_10
//  339   {
//  340     DAC_C1_REG(dacptr) |= DAC_C1_DACBFEN_MASK;
        LDRB     R0,[R5, #+34]
        ORRS     R0,R0,#0x1
        STRB     R0,[R5, #+34]
        B.N      ??LPLD_DAC_Config_11
//  341   }
??LPLD_DAC_Config_0:
        LDR.N    R0,??DataTable4_4  ;; 0x400cd000
        CMP      R5,R0
        BNE.N    ??LPLD_DAC_Config_12
        LDR.N    R0,??DataTable4_2  ;; 0x4004802c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.N    R1,??DataTable4_2  ;; 0x4004802c
        STR      R0,[R1, #+0]
        LDRB     R0,[R4, #+7]
        CMP      R0,#+0
        BEQ.N    ??LPLD_DAC_Config_1
        MOVS     R0,#+82
        BL       enable_irq
        LDR.N    R0,??DataTable4_3
        LDR      R1,[R4, #+8]
        STR      R1,[R0, #+4]
        B.N      ??LPLD_DAC_Config_1
??LPLD_DAC_Config_12:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_Config_13
??LPLD_DAC_Config_2:
        LDRB     R0,[R4, #+7]
        CMP      R0,#+1
        BNE.N    ??LPLD_DAC_Config_14
        LDRB     R0,[R5, #+33]
        ORRS     R0,R0,#0x1
        STRB     R0,[R5, #+33]
        B.N      ??LPLD_DAC_Config_3
??LPLD_DAC_Config_14:
        LDRB     R0,[R4, #+7]
        CMP      R0,#+2
        BNE.N    ??LPLD_DAC_Config_15
        LDRB     R0,[R5, #+33]
        ORRS     R0,R0,#0x2
        STRB     R0,[R5, #+33]
        B.N      ??LPLD_DAC_Config_3
??LPLD_DAC_Config_15:
        LDRB     R0,[R4, #+7]
        CMP      R0,#+3
        BNE.N    ??LPLD_DAC_Config_16
        LDRB     R0,[R5, #+33]
        ORRS     R0,R0,#0x4
        STRB     R0,[R5, #+33]
        B.N      ??LPLD_DAC_Config_3
??LPLD_DAC_Config_16:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_Config_13
??LPLD_DAC_Config_4:
        LDRB     R0,[R4, #+4]
        CMP      R0,#+1
        BNE.N    ??LPLD_DAC_Config_17
        LDRB     R0,[R5, #+33]
        ORRS     R0,R0,#0x20
        STRB     R0,[R5, #+33]
        LDRB     R0,[R5, #+33]
        ORRS     R0,R0,#0x10
        STRB     R0,[R5, #+33]
        B.N      ??LPLD_DAC_Config_5
??LPLD_DAC_Config_17:
        LDRB     R0,[R4, #+4]
        CMP      R0,#+2
        BNE.N    ??LPLD_DAC_Config_18
        LDRB     R0,[R5, #+33]
        ANDS     R0,R0,#0xDF
        STRB     R0,[R5, #+33]
        LDRB     R0,[R5, #+33]
        ANDS     R0,R0,#0xEF
        STRB     R0,[R5, #+33]
        B.N      ??LPLD_DAC_Config_5
??LPLD_DAC_Config_18:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_Config_13
??LPLD_DAC_Config_6:
        LDRB     R0,[R4, #+1]
        CMP      R0,#+1
        BNE.N    ??LPLD_DAC_Config_19
        LDRB     R0,[R5, #+34]
        ORRS     R0,R0,#0x8
        STRB     R0,[R5, #+34]
        B.N      ??LPLD_DAC_Config_7
??LPLD_DAC_Config_19:
        LDRB     R0,[R4, #+1]
        CMP      R0,#+2
        BNE.N    ??LPLD_DAC_Config_20
        LDRB     R0,[R5, #+34]
        ORRS     R0,R0,#0x10
        STRB     R0,[R5, #+34]
        B.N      ??LPLD_DAC_Config_7
??LPLD_DAC_Config_20:
        LDRB     R0,[R4, #+1]
        CMP      R0,#+3
        BNE.N    ??LPLD_DAC_Config_21
        LDRB     R0,[R5, #+34]
        ORRS     R0,R0,#0x18
        STRB     R0,[R5, #+34]
        B.N      ??LPLD_DAC_Config_7
??LPLD_DAC_Config_21:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_Config_13
??LPLD_DAC_Config_8:
        LDRB     R0,[R4, #+3]
        CMP      R0,#+1
        BNE.N    ??LPLD_DAC_Config_22
        LDRB     R0,[R5, #+34]
        ORRS     R0,R0,#0x2
        STRB     R0,[R5, #+34]
        B.N      ??LPLD_DAC_Config_9
??LPLD_DAC_Config_22:
        LDRB     R0,[R4, #+3]
        CMP      R0,#+2
        BNE.N    ??LPLD_DAC_Config_23
        LDRB     R0,[R5, #+34]
        ORRS     R0,R0,#0x4
        STRB     R0,[R5, #+34]
        B.N      ??LPLD_DAC_Config_9
??LPLD_DAC_Config_23:
        MOVS     R0,#+0
        B.N      ??LPLD_DAC_Config_13
//  342   else
//  343   {
//  344     DAC_C1_REG(dacptr) &= (~DAC_C1_DACBFEN_MASK);
??LPLD_DAC_Config_10:
        LDRB     R0,[R5, #+34]
        ANDS     R0,R0,#0xFE
        STRB     R0,[R5, #+34]
//  345   }
//  346   //===========DAC_C1配置完毕====================//  
//  347     
//  348   //===========配置DAC_C2寄存器=================//
//  349   //设置Buffer上限 
//  350   DAC_C2_REG(dacptr) = DAC_C2_DACBFUP((DAC_Config->Buffer_Up_Limit & 0x0f)); 
??LPLD_DAC_Config_11:
        LDRB     R0,[R4, #+6]
        ANDS     R0,R0,#0xF
        STRB     R0,[R5, #+35]
//  351   //设置Buffer指针位置
//  352   DAC_C2_REG(dacptr) |=DAC_C2_DACBFRP((DAC_Config->Buffer_Init_Pos & 0xf0));
        LDRB     R0,[R5, #+35]
        STRB     R0,[R5, #+35]
//  353   //===========DAC_C2配置完毕====================//  
//  354   
//  355   return 1;
        MOVS     R0,#+1
??LPLD_DAC_Config_13:
        POP      {R1,R4,R5,PC}    ;; return
//  356 }
//  357 
//  358 
//  359 /*
//  360  * LPLD_DAC_Soft_Trig
//  361  * 设置软件触发信号
//  362  * 
//  363  * 参数:
//  364  *    dacx--DAC模块号
//  365  *      |__DAC0           --DAC0模块
//  366  *      |__DAC1           --DAC1模块
//  367  * 输出：
//  368  *    无
//  369  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  370 void LPLD_DAC_Soft_Trig(DACx dacx)
//  371 {
//  372   DAC_MemMapPtr dacptr = DACx_Ptr[dacx];
LPLD_DAC_Soft_Trig:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable4
        LDR      R0,[R1, R0, LSL #+2]
//  373   DAC_C0_REG(dacptr) |= DAC_C0_DACSWTRG_MASK;
        LDRB     R1,[R0, #+33]
        ORRS     R1,R1,#0x10
        STRB     R1,[R0, #+33]
//  374 }
        BX       LR               ;; return
//  375 
//  376 /*
//  377  * LPLD_DAC_Isr
//  378  * DAC通用中断底层入口函数
//  379  * 
//  380  * 用户无需修改，程序自动进入对应通道中断函数
//  381  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  382 void LPLD_DAC_Isr(void)
//  383 {
LPLD_DAC_Isr:
        PUSH     {R4,LR}
//  384   #define DAC_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
//  385   uint8 dac_ch = DAC_VECTORNUM - 97;
        LDR.N    R0,??DataTable4_5  ;; 0xe000ed04
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+97
//  386   DAC_MemMapPtr DACx_Base_Ptr = (DAC_MemMapPtr)((0x400CC+dac_ch)<<12);
        LDR.N    R1,??DataTable4_6  ;; 0x400cc
        UXTAB    R1,R1,R0
        LSLS     R4,R1,#+12
//  387   
//  388   if ((DAC_SR_REG(DACx_Base_Ptr)&DAC_SR_DACBFRPBF_MASK) ) 
        LDRB     R1,[R4, #+32]
        LSLS     R1,R1,#+31
        BPL.N    ??LPLD_DAC_Isr_0
//  389   {
//  390     DAC_ISR[dac_ch]();
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable4_3
        LDR      R0,[R1, R0, LSL #+2]
        BLX      R0
//  391     DAC_SR_REG(DACx_Base_Ptr)=0x06; //清除中断标志位
        MOVS     R0,#+6
        STRB     R0,[R4, #+32]
        B.N      ??LPLD_DAC_Isr_1
//  392   }
//  393   else if ((DAC_SR_REG(DACx_Base_Ptr)&DAC_SR_DACBFRPTF_MASK))
??LPLD_DAC_Isr_0:
        LDRB     R1,[R4, #+32]
        LSLS     R1,R1,#+30
        BPL.N    ??LPLD_DAC_Isr_2
//  394   {
//  395     DAC_ISR[dac_ch]();
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable4_3
        LDR      R0,[R1, R0, LSL #+2]
        BLX      R0
//  396     DAC_SR_REG(DACx_Base_Ptr)=0x05 ;//清除中断标志位
        MOVS     R0,#+5
        STRB     R0,[R4, #+32]
        B.N      ??LPLD_DAC_Isr_1
//  397   }
//  398   else if ((DAC_SR_REG(DACx_Base_Ptr)&DAC_SR_DACBFWMF_MASK))
??LPLD_DAC_Isr_2:
        LDRB     R1,[R4, #+32]
        LSLS     R1,R1,#+29
        BPL.N    ??LPLD_DAC_Isr_1
//  399   {
//  400     DAC_ISR[dac_ch]();
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable4_3
        LDR      R0,[R1, R0, LSL #+2]
        BLX      R0
//  401     DAC_SR_REG(DACx_Base_Ptr)=0x03 ;//清除中断标志位
        MOVS     R0,#+3
        STRB     R0,[R4, #+32]
//  402   }
//  403 }
??LPLD_DAC_Isr_1:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     DACx_Ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x400cc000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0x4004802c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     DAC_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x400cd000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0xe000ed04

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x400cc

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
//   8 bytes in section .bss
//   8 bytes in section .data
// 876 bytes in section .text
// 
// 876 bytes of CODE memory
//  16 bytes of DATA memory
//
//Errors: none
//Warnings: none
