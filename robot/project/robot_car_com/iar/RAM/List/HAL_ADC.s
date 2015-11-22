///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:09 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_ADC.c      /
//    Command line =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_ADC.c -D   /
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
//                    ar\RAM\List\HAL_ADC.s                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_ADC

        #define SHT_PROGBITS 0x1

        EXTERN ADC_Cal
        EXTERN ADC_Config_Alt
        EXTERN enable_irq

        PUBLIC ADC_ISR
        PUBLIC ADC_Init
        PUBLIC ADCx_Ptr
        PUBLIC Adc0_Config
        PUBLIC Adc1_Config
        PUBLIC LPLD_ADC_Channel_Init
        PUBLIC LPLD_ADC_Init
        PUBLIC LPLD_ADC_Isr
        PUBLIC LPLD_ADC_SE_Get
        PUBLIC LPLD_ADC_SetHWTrg

// D:\中国机器人大赛\robot_project\lib\LPLD\HAL_ADC.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_ADC.c
//   10  * 用途: ADC底层模块相关函数
//   11  * 最后修改日期: 20120323
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17  */
//   18 #include "common.h"
//   19 #include "HAL_ADC.h"
//   20 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   21 ADC_ISR_CALLBACK ADC_ISR[2];
ADC_ISR:
        DS8 8
//   22 //全局变量定义

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   23 tADC_Config Adc0_Config;  // ADC0 寄存器结构体
Adc0_Config:
        DS8 16

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   24 tADC_Config Adc1_Config;  // ADC0 寄存器结构体
Adc1_Config:
        DS8 16
//   25 
//   26 //ADC映射地址数组

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   27 volatile ADC_MemMapPtr ADCx_Ptr[2] = {ADC0_BASE_PTR, 
ADCx_Ptr:
        DATA
        DC32 4003B000H, 400BB000H
//   28                                       ADC1_BASE_PTR};
//   29 
//   30 
//   31 /*
//   32  * LPLD_ADC_Init
//   33  * ADC模块通用初始化函数--用于非中断模式、单次转换、软件触发
//   34  * 
//   35  * 参数:
//   36  *    adcx--ADC模块号
//   37  *      |__ADC0         -ADC0模块
//   38  *      |__ADC1         -ADC1模块
//   39  *    mode--AD转换精度
//   40  *      |__MODE_8       --单端8位，差分9位
//   41  *      |__MODE_12      --单端12位，差分13位
//   42  *      |__MODE_10      --单端10位，差分11位
//   43  *      |__MODE_16      --单端16位，差分16位
//   44  *    diff--单端输入或差分输入
//   45  *      |__CONV_SING    --单端
//   46  *      |__CONV_DIFF    --差分
//   47  *
//   48  * 输出:
//   49  *    0--配置错误
//   50  *    1--配置成功
//   51  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   52 uint8 LPLD_ADC_Init(ADCx adcx, uint8 mode, uint8 diff)
//   53 {
LPLD_ADC_Init:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R2
//   54   tADC_ConfigPtr ADC_CfgPtr;
//   55   
//   56   if(adcx == ADC0)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_ADC_Init_0
//   57   {
//   58     SIM_SCGC6 |= (SIM_SCGC6_ADC0_MASK);   // 开启ADC0时钟
        LDR.W    R0,??DataTable5  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R2,??DataTable5  ;; 0x4004803c
        STR      R0,[R2, #+0]
//   59     ADC_CfgPtr = &Adc0_Config;
        LDR.W    R6,??DataTable5_1
//   60   }
//   61   else if(adcx == ADC1)
//   62   {
//   63     SIM_SCGC3 |= (SIM_SCGC3_ADC1_MASK);   // 开启ADC1时钟
//   64     ADC_CfgPtr = &Adc1_Config;
//   65   }
//   66   else
//   67   {
//   68     return 0;
//   69   }
//   70   
//   71   // 初始化ADC
//   72   ADC_CfgPtr->CONFIG1  = ADLPC_NORMAL                   // 重新为正常使用进行配置，4次硬件平均
//   73                       | ADC_CFG1_ADIV(ADIV_8) //| ADC_CFG1_ADIV(ADIV_1) // ADC输入时钟分频为 1
//   74                       | ADLSMP_LONG                     // 长采样时间设置 
//   75                       | ADC_CFG1_ADICLK(ADICLK_BUS_2);  // ADC输入时钟源为 BusClk/2
??LPLD_ADC_Init_1:
        MOVS     R0,#+113
        STRB     R0,[R6, #+0]
//   76   
//   77   // 选择转换精度
//   78   switch(mode)
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??LPLD_ADC_Init_2
        CMP      R1,#+2
        BEQ.N    ??LPLD_ADC_Init_3
        BCC.N    ??LPLD_ADC_Init_4
        CMP      R1,#+3
        BEQ.N    ??LPLD_ADC_Init_5
        B.N      ??LPLD_ADC_Init_6
//   79   {
//   80     case MODE_8:
//   81        ADC_CfgPtr->CONFIG1 |= ADC_CFG1_MODE(MODE_8);
??LPLD_ADC_Init_2:
        LDRB     R0,[R6, #+0]
        STRB     R0,[R6, #+0]
//   82        break;
//   83     case MODE_12:
//   84        ADC_CfgPtr->CONFIG1 |= ADC_CFG1_MODE(MODE_12);
//   85        break;
//   86     case MODE_10:
//   87        ADC_CfgPtr->CONFIG1 |= ADC_CFG1_MODE(MODE_10);
//   88        break;
//   89     case MODE_16:
//   90        ADC_CfgPtr->CONFIG1 |= ADC_CFG1_MODE(MODE_16);
//   91        break;
//   92     default:
//   93       return 0;
//   94   }
//   95   // 选择ADxxa为输入通道
//   96   // 异步时钟输出使能
//   97   // 高速转换
//   98   // 长采样时间时钟周期选择 额外20个时钟周期，共24个ADCK周期
//   99   // 总采样周期见K60技术文档 page:840
//  100   ADC_CfgPtr->CONFIG2  = MUXSEL_ADCA 
//  101                       | ADACKEN_DISABLED 
//  102                       | ADHSC_HISPEED
//  103                       | ADC_CFG2_ADLSTS(ADLSTS_20) ;
??LPLD_ADC_Init_7:
        MOVS     R0,#+4
        STRB     R0,[R6, #+1]
//  104   //用于设定阈值
//  105   ADC_CfgPtr->COMPARE1 = 0x1234u ; 
        MOVW     R0,#+4660
        STRH     R0,[R6, #+2]
//  106   ADC_CfgPtr->COMPARE2 = 0x5678u ;
        MOVW     R0,#+22136
        STRH     R0,[R6, #+4]
//  107   
//  108   ADC_CfgPtr->STATUS2  = ADTRG_SW     //初始化设置成为软件触发
//  109                       | ACFE_DISABLED 
//  110                       | ACFGT_GREATER 
//  111                       | ACREN_ENABLED
//  112                       | DMAEN_DISABLED
//  113                       | ADC_SC2_REFSEL(REFSEL_EXT);
        MOVS     R0,#+24
        STRB     R0,[R6, #+6]
//  114   
//  115   ADC_CfgPtr->STATUS3  = CAL_OFF    //关闭校准
//  116                       | ADCO_SINGLE 
//  117                       | AVGE_ENABLED 
//  118                       | ADC_SC3_AVGS(AVGS_32);
        MOVS     R0,#+7
        STRB     R0,[R6, #+7]
//  119   
//  120   ADC_CfgPtr->PGA      = PGAEN_DISABLED 
//  121                       | PGACHP_NOCHOP 
//  122                       | PGALP_NORMAL 
//  123                       | ADC_PGA_PGAG(PGAG_64);
        MOVS     R0,#+393216
        STR      R0,[R6, #+12]
//  124   
//  125   ADC_Config_Alt(ADCx_Ptr[adcx], ADC_CfgPtr);    //配置 ADC寄存器
        MOVS     R1,R6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.W    R0,??DataTable5_2
        LDR      R0,[R0, R4, LSL #+2]
        BL       ADC_Config_Alt
//  126   ADC_Cal(ADCx_Ptr[adcx]);                       //首先进行32次的硬件平均校准进行校准
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.W    R0,??DataTable5_2
        LDR      R0,[R0, R4, LSL #+2]
        BL       ADC_Cal
//  127   
//  128   //选择单端或差分模式
//  129   if(diff == CONV_SING)
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??LPLD_ADC_Init_8
//  130   {
//  131     ADC_CfgPtr->STATUS1A =  DIFF_SINGLE ;
        MOVS     R0,#+0
        STRB     R0,[R6, #+8]
//  132   }  
//  133   else if(diff == CONV_DIFF)
//  134   {
//  135     ADC_CfgPtr->STATUS1A =  DIFF_DIFFERENTIAL;
//  136   } 
//  137   else
//  138   {
//  139     return 0;
//  140   }
//  141   
//  142   ADC_Config_Alt(ADCx_Ptr[adcx], ADC_CfgPtr);  //再校准后，再次初始化，配置ADC0
??LPLD_ADC_Init_9:
        MOVS     R1,R6
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.W    R0,??DataTable5_2
        LDR      R0,[R0, R4, LSL #+2]
        BL       ADC_Config_Alt
//  143   
//  144   return 1;
        MOVS     R0,#+1
??LPLD_ADC_Init_10:
        POP      {R4-R6,PC}       ;; return
??LPLD_ADC_Init_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??LPLD_ADC_Init_11
        LDR.W    R0,??DataTable5_3  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R2,??DataTable5_3  ;; 0x40048030
        STR      R0,[R2, #+0]
        LDR.W    R6,??DataTable5_4
        B.N      ??LPLD_ADC_Init_1
??LPLD_ADC_Init_11:
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_Init_10
??LPLD_ADC_Init_4:
        LDRB     R0,[R6, #+0]
        ORRS     R0,R0,#0x4
        STRB     R0,[R6, #+0]
        B.N      ??LPLD_ADC_Init_7
??LPLD_ADC_Init_3:
        LDRB     R0,[R6, #+0]
        ORRS     R0,R0,#0x8
        STRB     R0,[R6, #+0]
        B.N      ??LPLD_ADC_Init_7
??LPLD_ADC_Init_5:
        LDRB     R0,[R6, #+0]
        ORRS     R0,R0,#0xC
        STRB     R0,[R6, #+0]
        B.N      ??LPLD_ADC_Init_7
??LPLD_ADC_Init_6:
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_Init_10
??LPLD_ADC_Init_8:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+1
        BNE.N    ??LPLD_ADC_Init_12
        MOVS     R0,#+32
        STRB     R0,[R6, #+8]
        B.N      ??LPLD_ADC_Init_9
??LPLD_ADC_Init_12:
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_Init_10
//  145 }
//  146 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  147 void ADC_Init(ADCx adcx)
//  148 {
ADC_Init:
        PUSH     {R4,LR}
//  149   tADC_ConfigPtr ADC_CfgPtr;
//  150   if(adcx == ADC0)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??ADC_Init_0
//  151   {
//  152     SIM_SCGC6 |= (SIM_SCGC6_ADC0_MASK);   // 开启ADC0时钟
        LDR.W    R0,??DataTable5  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R1,??DataTable5  ;; 0x4004803c
        STR      R0,[R1, #+0]
//  153     ADC_CfgPtr = &Adc0_Config;
        LDR.W    R4,??DataTable5_1
//  154   }
//  155   else if(adcx == ADC1)
//  156   {
//  157     SIM_SCGC3 |= (SIM_SCGC3_ADC1_MASK);   // 开启ADC1时钟
//  158     ADC_CfgPtr = &Adc1_Config;
//  159   }
//  160   else
//  161   {
//  162     return;
//  163   }
//  164   ADC_CfgPtr->CONFIG1 = ADLPC_NORMAL 
//  165                       | ADC_CFG1_ADIV(ADIV_8) 
//  166                       | ADLSMP_LONG 
//  167                       | ADC_CFG1_MODE(MODE_10)
//  168                       | ADC_CFG1_ADICLK(ADICLK_BUS_2);
??ADC_Init_1:
        MOVS     R0,#+121
        STRB     R0,[R4, #+0]
//  169   
//  170   ADC_CfgPtr->CONFIG2 = MUXSEL_ADCA 
//  171                       | ADACKEN_DISABLED
//  172                       | ADHSC_HISPEED 
//  173                       | ADC_CFG2_ADLSTS(ADLSTS_20) ;
        MOVS     R0,#+4
        STRB     R0,[R4, #+1]
//  174   
//  175   ADC_CfgPtr->COMPARE1 = 0x1234u ; 
        MOVW     R0,#+4660
        STRH     R0,[R4, #+2]
//  176   ADC_CfgPtr->COMPARE2 = 0x5678u ;
        MOVW     R0,#+22136
        STRH     R0,[R4, #+4]
//  177   
//  178   ADC_CfgPtr->STATUS2  = ADTRG_SW 
//  179                       |  ACFE_DISABLED 
//  180                       |  ACFGT_GREATER 
//  181                       |  ACREN_ENABLED 
//  182                       |  DMAEN_ENABLED
//  183                       |  ADC_SC2_REFSEL(REFSEL_EXT);
        MOVS     R0,#+28
        STRB     R0,[R4, #+6]
//  184   
//  185   ADC_CfgPtr->STATUS3  = CAL_OFF
//  186                        | ADCO_SINGLE
//  187                        | AVGE_ENABLED
//  188                        | ADC_SC3_AVGS(AVGS_32);
        MOVS     R0,#+7
        STRB     R0,[R4, #+7]
//  189   
//  190   ADC_CfgPtr->PGA     = PGAEN_DISABLED 
//  191                       | PGACHP_NOCHOP 
//  192                       | PGALP_NORMAL 
//  193                       | ADC_PGA_PGAG(PGAG_64);
        MOVS     R0,#+393216
        STR      R0,[R4, #+12]
//  194   
//  195   //ADC_CfgPtr->STATUS1A = AIEN_OFF | DIFF_SINGLE | ADC_SC1_ADCH(31);
//  196   //ADC_CfgPtr->STATUS1B = AIEN_OFF | DIFF_SINGLE | ADC_SC1_ADCH(31);
//  197   
//  198   ADC_Config_Alt(ADC0_BASE_PTR, ADC_CfgPtr);   // config ADC
        MOVS     R1,R4
        LDR.W    R0,??DataTable5_5  ;; 0x4003b000
        BL       ADC_Config_Alt
//  199   ADC_Cal(ADC0_BASE_PTR);                      // do the calibration
        LDR.W    R0,??DataTable5_5  ;; 0x4003b000
        BL       ADC_Cal
//  200   
//  201   enable_irq(57);
        MOVS     R0,#+57
        BL       enable_irq
//  202   ADC_CfgPtr->STATUS1A = AIEN_OFF | DIFF_SINGLE | ADC_SC1_ADCH(0);
        MOVS     R0,#+0
        STRB     R0,[R4, #+8]
//  203   ADC_CfgPtr->STATUS1B = AIEN_OFF | DIFF_SINGLE | ADC_SC1_ADCH(0);
        MOVS     R0,#+0
        STRB     R0,[R4, #+9]
//  204   ADC_Config_Alt(ADC0_BASE_PTR, ADC_CfgPtr);   // config ADC0
        MOVS     R1,R4
        LDR.W    R0,??DataTable5_5  ;; 0x4003b000
        BL       ADC_Config_Alt
//  205 }
??ADC_Init_2:
        POP      {R4,PC}          ;; return
??ADC_Init_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BNE.N    ??ADC_Init_3
        LDR.W    R0,??DataTable5_3  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R1,??DataTable5_3  ;; 0x40048030
        STR      R0,[R1, #+0]
        LDR.W    R4,??DataTable5_4
        B.N      ??ADC_Init_1
??ADC_Init_3:
        B.N      ??ADC_Init_2
//  206 
//  207 
//  208 /*
//  209  * LPLD_ADC_SE_Get
//  210  * 取得ADC模块单端输入转换值--软件触发
//  211  * 
//  212  * 参数:
//  213  *    adcx--ADC模块号
//  214  *      |__ADC0         -ADC0模块
//  215  *      |__ADC1         -ADC0模块
//  216  *    channel--ADC通道号，不同的通道号对应不同的引脚，注意有些通道并非都有ADC0或ADC1
//  217  *      |__0            --ADC0:PGA0_DP;  ADC1:PGA1_DP
//  218  *      |__1            --ADC0:PGA2_DP;  ADC1:PGA3_DP
//  219  *      |__2            --ADC0:PGA0_DP;  ADC1:PGA1_DP
//  220  *      |__3            --ADC0:ADC0_DP3; ADC1:PGA0_DP
//  221  *      |__4            --ADC0:NC;       ADC1:PTE0
//  222  *      |__5            --ADC0:NC;       ADC1:PTE1
//  223  *      |__6            --ADC0:NC;       ADC1:PTE2
//  224  *      |__7            --ADC0:NC;       ADC1:PTE3
//  225  *      |__8            --ADC0:PTB0;     ADC1:PTB0
//  226  *      |__9            --ADC0:PTB1;     ADC1:PTB1
//  227  *      |__10           --ADC0:PTA7;    ADC1:PTB4
//  228  *      |__11           --ADC0:PTA8;    ADC1:PTB5
//  229  *      |__12           --ADC0:PTB2;    ADC1:PTB6
//  230  *      |__13           --ADC0:PTB3;    ADC1:PTB7
//  231  *      |__14           --ADC0:PTC0;    ADC1:PTB10
//  232  *      |__15           --ADC0:PTC1;    ADC1:PTB11
//  233  *      |__16           --ADC0:ADC0_SE16;ADC1:ADC1_SE16
//  234  *      |__17           --ADC0:PTE24;   ADC1:PTA17
//  235  *      |__18           --ADC0:PTE25;   ADC1:VREF Output
//  236  *      |__19           --ADC0:PGA0_DM; ADC1:PGA1_DM
//  237  *      |__20           --ADC0:PGA2_DM; ADC1:PGA3_DM
//  238  *      |__23           --ADC0:DAC0_OUT;ADC1:DAC1_OUT
//  239  *      |__26           --ADC0:Temperature Sensor;  ADC1:Temperature Sensor
//  240  *      |__27           --ADC0:Bandgap; ADC1:Bandgap
//  241  *      |__29           --ADC0:VREFH;   ADC1:VREFH
//  242  *      |__30           --ADC0:VREFL;   ADC1:VREFL
//  243  *
//  244  * 输出:
//  245  *    0--配置错误，或电压值为0
//  246  *    其他--AD通道转换值，右对齐
//  247  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  248 uint16 LPLD_ADC_SE_Get(ADCx adcx, uint8 channel)
//  249 {
//  250   ADC_MemMapPtr adcptr = ADCx_Ptr[adcx];
LPLD_ADC_SE_Get:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R2,??DataTable5_2
        LDR      R2,[R2, R0, LSL #+2]
//  251   
//  252   if(channel>30)
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+31
        BCC.N    ??LPLD_ADC_SE_Get_0
//  253     return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_SE_Get_1
//  254   
//  255   //不同的通道对应不同的引脚，因此需要判断并配置
//  256   if(adcx == ADC0)
??LPLD_ADC_SE_Get_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.W    ??LPLD_ADC_SE_Get_2
//  257   {
//  258     switch(channel)
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R1
        CMP      R0,#+0
        CMP      R0,#+3
        BLS.N    ??LPLD_ADC_SE_Get_3
        SUBS     R0,R0,#+8
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_4
        SUBS     R0,R0,#+2
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_5
        SUBS     R0,R0,#+2
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_6
        SUBS     R0,R0,#+2
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_7
        SUBS     R0,R0,#+2
        BEQ.N    ??LPLD_ADC_SE_Get_8
        SUBS     R0,R0,#+1
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_9
        SUBS     R0,R0,#+2
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_10
        SUBS     R0,R0,#+4
        BEQ.N    ??LPLD_ADC_SE_Get_10
        SUBS     R0,R0,#+3
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_10
        SUBS     R0,R0,#+3
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_10
        B.N      ??LPLD_ADC_SE_Get_11
//  259     {
//  260       case 0:   //ADC0_DP0 -- PGA0_DP
//  261       case 1:   //ADC0_DP1 -- PGA2_DP
//  262       case 2:   //PGA0_DP
//  263       case 3:   //ADC0_DP3 -- PGA1_DP
//  264         break;
//  265       case 8:  //ADC0_SE8 -- PTB0
//  266       case 9:  //ADC0_SE9 -- PTB1
//  267         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  268         PORT_PCR_REG(PORTB_BASE_PTR, channel-8) =  PORT_PCR_MUX(0);
//  269         break;
//  270       case 10:  //ADC0_SE10 -- PTA7
//  271       case 11:  //ADC0_SE11 -- PTA8
//  272         SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
//  273         PORT_PCR_REG(PORTA_BASE_PTR, channel-3) =  PORT_PCR_MUX(0);
//  274         break;
//  275       case 12:  //ADC0_SE12 -- PTB2
//  276       case 13:  //ADC0_SE13 -- PTB3
//  277         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  278         PORT_PCR_REG(PORTB_BASE_PTR, channel-10) =  PORT_PCR_MUX(0);
//  279         break;
//  280       case 14:  //ADC0_SE14 -- PTC0
//  281       case 15:  //ADC0_SE15 -- PTC1
//  282         SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK; 
//  283         PORT_PCR_REG(PORTC_BASE_PTR, channel-14) =  PORT_PCR_MUX(0);
//  284         break;
//  285       case 16:   //ADC0_SE16
//  286         break;
//  287       case 17:   //ADC0_SE17 -- PTE24
//  288       case 18:   //ADC0_SE17 -- PTE25
//  289         SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; 
//  290         PORT_PCR_REG(PORTE_BASE_PTR, channel+7) =  PORT_PCR_MUX(0);
//  291         break;
//  292       case 19:   //ADC0_DM0 -- PGA0_DM
//  293       case 20:   //ADC0_DM1 -- PGA2_DM
//  294       case 23:   //ADC0_SE23 -- DAC0_OUT
//  295       case 26:   //Temperature Sensor (S.E)
//  296       case 27:   //Bandgap (S.E)
//  297       case 29:   //VREFH (S.E)
//  298       case 30:   //VREFL
//  299         break;
//  300       default:
//  301         return 0;  
//  302     }
//  303   }
//  304   else if(adcx == ADC1)
//  305   {
//  306     switch(channel)
//  307     {
//  308       case 0:   //ADC1_DP0 -- PGA1_DP
//  309       case 1:   //ADC1_DP1 -- PGA3_DP
//  310       case 2:   //PGA1_DP 
//  311       case 3:   //ADC1_DP3 -- PGA0_DP
//  312         break;
//  313       case 4:   //ADC1_SE4a -- PTE0
//  314       case 5:   //ADC1_SE5a -- PTE1
//  315       case 6:   //ADC1_SE6a -- PTE2
//  316       case 7:   //ADC1_SE7a -- PTE3
//  317         SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; 
//  318         PORT_PCR_REG(PORTE_BASE_PTR, channel-4) =  PORT_PCR_MUX(0);
//  319         break;
//  320       case 8:  //ADC1_SE8 -- PTB0
//  321       case 9:  //ADC1_SE9 -- PTB1
//  322         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  323         PORT_PCR_REG(PORTB_BASE_PTR, channel-8) =  PORT_PCR_MUX(0);
//  324         break;
//  325       case 10:  //ADC1_SE10 -- PTB4
//  326       case 11:  //ADC1_SE11 -- PTB5
//  327       case 12:  //ADC1_SE12 -- PTB6
//  328       case 13:  //ADC1_SE13 -- PTB7
//  329         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  330         PORT_PCR_REG(PORTB_BASE_PTR, channel-6) =  PORT_PCR_MUX(0);
//  331         break;
//  332       case 14:  //ADC1_SE14 -- PTB10
//  333       case 15:  //ADC1_SE15 -- PTB11
//  334         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  335         PORT_PCR_REG(PORTB_BASE_PTR, channel-4) =  PORT_PCR_MUX(0);
//  336         break;
//  337       case 16:   //ADC1_SE16
//  338         break;
//  339       case 17:  //ADC1_SE17 -- PTA17
//  340         SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
//  341         PORT_PCR_REG(PORTA_BASE_PTR, channel) =  PORT_PCR_MUX(0);
//  342         break;
//  343       case 18:   //VREF Output
//  344       case 19:   //ADC1_DM0 -- PGA1_DM
//  345       case 20:   //ADC1_DM1 -- PGA3_DM
//  346       case 23:   //DAC1_OUT 
//  347       case 26:   //Temperature Sensor (S.E)
//  348       case 27:   //Bandgap (S.E)
//  349       case 29:   //VREFH (S.E)
//  350       case 30:   //VREFL
//  351         break;
//  352       default:
//  353         return 0;  
//  354     }
//  355   }
//  356   else
//  357   {
//  358     return 0;
//  359   }
//  360   
//  361   ADC_SC1_REG(adcptr,0) &= ~(ADC_SC1_ADCH_MASK);
??LPLD_ADC_SE_Get_3:
??LPLD_ADC_SE_Get_12:
        LDR      R0,[R2, #+0]
        LSRS     R0,R0,#+5
        LSLS     R0,R0,#+5
        STR      R0,[R2, #+0]
//  362   ADC_SC1_REG(adcptr,0) |= ADC_SC1_ADCH(channel);
        LDR      R0,[R2, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        ANDS     R1,R1,#0x1F
        ORRS     R0,R1,R0
        STR      R0,[R2, #+0]
//  363   
//  364   while((ADC_SC1_REG(adcptr,0)&ADC_SC1_COCO_MASK) == 0);  //等待转换完成
??LPLD_ADC_SE_Get_13:
        LDR      R0,[R2, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??LPLD_ADC_SE_Get_13
//  365   return ADC_R_REG(adcptr, 0);
        LDR      R0,[R2, #+16]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
??LPLD_ADC_SE_Get_1:
        BX       LR               ;; return
??LPLD_ADC_SE_Get_4:
        LDR.W    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.W    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R0,R1,#+2
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+303104
        MOVS     R3,#+0
        STR      R3,[R0, #-32]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_5:
        LDR.W    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        MOV      R3,#+512
        ORRS     R0,R3,R0
        LDR.W    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R0,R1,#+2
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+299008
        MOVS     R3,#+0
        STR      R3,[R0, #-12]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_6:
        LDR.W    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.W    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R0,R1,#+2
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+303104
        MOVS     R3,#+0
        STR      R3,[R0, #-40]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_7:
        LDR.W    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800
        LDR.W    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R0,R1,#+2
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+307200
        MOVS     R3,#+0
        STR      R3,[R0, #-56]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_8:
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_9:
        LDR.W    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.W    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R0,R1,#+2
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+315392
        MOVS     R3,#+0
        STR      R3,[R0, #+28]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_10:
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_11:
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_SE_Get_1
??LPLD_ADC_SE_Get_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BNE.N    ??LPLD_ADC_SE_Get_14
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R1
        CMP      R0,#+0
        CMP      R0,#+3
        BLS.N    ??LPLD_ADC_SE_Get_15
        SUBS     R0,R0,#+4
        CMP      R0,#+3
        BLS.N    ??LPLD_ADC_SE_Get_16
        SUBS     R0,R0,#+4
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_17
        SUBS     R0,R0,#+2
        CMP      R0,#+3
        BLS.N    ??LPLD_ADC_SE_Get_18
        SUBS     R0,R0,#+4
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_19
        SUBS     R0,R0,#+2
        BEQ.N    ??LPLD_ADC_SE_Get_20
        SUBS     R0,R0,#+1
        BEQ.N    ??LPLD_ADC_SE_Get_21
        SUBS     R0,R0,#+1
        CMP      R0,#+2
        BLS.N    ??LPLD_ADC_SE_Get_22
        SUBS     R0,R0,#+5
        BEQ.N    ??LPLD_ADC_SE_Get_22
        SUBS     R0,R0,#+3
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_22
        SUBS     R0,R0,#+3
        CMP      R0,#+1
        BLS.N    ??LPLD_ADC_SE_Get_22
        B.N      ??LPLD_ADC_SE_Get_23
??LPLD_ADC_SE_Get_15:
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_16:
        LDR.W    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000
        LDR.W    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R0,R1,#+2
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+315392
        MOVS     R3,#+0
        STR      R3,[R0, #-16]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_17:
        LDR.W    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.W    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R0,R1,#+2
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+303104
        MOVS     R3,#+0
        STR      R3,[R0, #-32]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_18:
        LDR.W    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.W    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R0,R1,#+2
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+303104
        MOVS     R3,#+0
        STR      R3,[R0, #-24]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_19:
        LDR.N    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x400
        LDR.N    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R0,R1,#+2
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+303104
        MOVS     R3,#+0
        STR      R3,[R0, #-16]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_20:
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_21:
        LDR.N    R0,??DataTable5_6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        MOV      R3,#+512
        ORRS     R0,R3,R0
        LDR.N    R3,??DataTable5_6  ;; 0x40048038
        STR      R0,[R3, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.N    R0,??DataTable5_7  ;; 0x40049000
        MOVS     R3,#+0
        STR      R3,[R0, R1, LSL #+2]
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_22:
        B.N      ??LPLD_ADC_SE_Get_12
??LPLD_ADC_SE_Get_23:
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_SE_Get_1
??LPLD_ADC_SE_Get_14:
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_SE_Get_1
//  366 }
//  367 
//  368 
//  369 /*
//  370  * LPLD_ADC_Channel_Init
//  371  * ADC通道初始化,在该函数中配置ADC的输入通道，配置ADC中断、DMA请求，和相应的中断服务函数
//  372  * 
//  373  * 参数:
//  374  *    adcx--ADC模块号
//  375  *      |__ADC0         -ADC0模块
//  376  *      |__ADC1         -ADC0模块
//  377  *    channel--ADC通道号，不同的通道号对应不同的引脚，注意有些通道并非都有ADC0或ADC1
//  378  *      |__0            --ADC0:PGA0_DP;  ADC1:PGA1_DP
//  379  *      |__1            --ADC0:PGA2_DP;  ADC1:PGA3_DP
//  380  *      |__2            --ADC0:PGA0_DP;  ADC1:PGA1_DP
//  381  *      |__3            --ADC0:ADC0_DP3; ADC1:PGA0_DP
//  382  *      |__4            --ADC0:NC;       ADC1:PTE0
//  383  *      |__5            --ADC0:NC;       ADC1:PTE1
//  384  *      |__6            --ADC0:NC;       ADC1:PTE2
//  385  *      |__7            --ADC0:NC;       ADC1:PTE3
//  386  *      |__8            --ADC0:PTB0;     ADC1:PTB0
//  387  *      |__9            --ADC0:PTB1;     ADC1:PTB1
//  388  *      |__10           --ADC0:PTA7;    ADC1:PTB4
//  389  *      |__11           --ADC0:PTA8;    ADC1:PTB5
//  390  *      |__12           --ADC0:PTB2;    ADC1:PTB6
//  391  *      |__13           --ADC0:PTB3;    ADC1:PTB7
//  392  *      |__14           --ADC0:PTC0;    ADC1:PTB10
//  393  *      |__15           --ADC0:PTC1;    ADC1:PTB11
//  394  *      |__16           --ADC0:ADC0_SE16;ADC1:ADC1_SE16
//  395  *      |__17           --ADC0:PTE24;   ADC1:PTA17
//  396  *      |__18           --ADC0:PTE25;   ADC1:VREF Output
//  397  *      |__19           --ADC0:PGA0_DM; ADC1:PGA1_DM
//  398  *      |__20           --ADC0:PGA2_DM; ADC1:PGA3_DM
//  399  *      |__23           --ADC0:DAC0_OUT;ADC1:DAC1_OUT
//  400  *      |__26           --ADC0:Temperature Sensor;  ADC1:Temperature Sensor
//  401  *      |__27           --ADC0:Bandgap; ADC1:Bandgap
//  402  *      |__29           --ADC0:VREFH;   ADC1:VREFH
//  403  *      |__30           --ADC0:VREFL;   ADC1:VREFL
//  404  *  ad_event--ADC事件，包括ADC中断禁止、使能，DMA请求禁止、使能。
//  405  *      |__ADC_INT_DISABLE    --中断禁止
//  406  *      |__ADC_INT_ENABLE     --中断使能
//  407  *      |__ADC_DMA_DISABLE    --DMA请求禁止
//  408  *      |__ADC_DMA_ENABLE     --DMA请求使能
//  409  *
//  410  *  ADC_ISR_CALLBACK
//  411  *      |__isr                --如果使能中断，设置中断服务函数的路径，
//  412  *                              如果没有设置中断，将其设置成为NULL
//  413  * 输出:
//  414  *    0--配置错误，或电压值为0
//  415  *    其他--AD通道转换值，右对齐
//  416  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  417 uint8_t LPLD_ADC_Channel_Init(ADCx adcx, uint8_t channel ,uint8_t ad_event,ADC_ISR_CALLBACK isr)
//  418 {
LPLD_ADC_Channel_Init:
        PUSH     {R3-R7,LR}
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R7,R3
//  419   ADC_MemMapPtr adcptr = ADCx_Ptr[adcx];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable5_2
        LDR      R6,[R1, R0, LSL #+2]
//  420   
//  421   if(channel>30)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+31
        BCC.N    ??LPLD_ADC_Channel_Init_0
//  422     return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_Channel_Init_1
//  423   
//  424   //不同的通道对应不同的引脚，因此需要判断并配置
//  425   if(adcx == ADC0)
??LPLD_ADC_Channel_Init_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_ADC_Channel_Init_2
//  426   {
//  427     switch(channel)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,R4
        CMP      R1,#+0
        CMP      R1,#+3
        BLS.N    ??LPLD_ADC_Channel_Init_3
        SUBS     R1,R1,#+8
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_4
        SUBS     R1,R1,#+2
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_5
        SUBS     R1,R1,#+2
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_6
        SUBS     R1,R1,#+2
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_7
        SUBS     R1,R1,#+2
        BEQ.N    ??LPLD_ADC_Channel_Init_8
        SUBS     R1,R1,#+1
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_9
        SUBS     R1,R1,#+2
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_10
        SUBS     R1,R1,#+4
        BEQ.N    ??LPLD_ADC_Channel_Init_10
        SUBS     R1,R1,#+3
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_10
        SUBS     R1,R1,#+3
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_10
        B.N      ??LPLD_ADC_Channel_Init_11
//  428     {
//  429       case 0:   //ADC0_DP0 -- PGA0_DP
//  430       case 1:   //ADC0_DP1 -- PGA2_DP
//  431       case 2:   //PGA0_DP
//  432       case 3:   //ADC0_DP3 -- PGA1_DP
//  433         break;
//  434       case 8:  //ADC0_SE8 -- PTB0
//  435       case 9:  //ADC0_SE9 -- PTB1
//  436         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  437         PORT_PCR_REG(PORTB_BASE_PTR, channel-8) =  PORT_PCR_MUX(0);
//  438         break;
//  439       case 10:  //ADC0_SE10 -- PTA7
//  440       case 11:  //ADC0_SE11 -- PTA8
//  441         SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
//  442         PORT_PCR_REG(PORTA_BASE_PTR, channel-3) =  PORT_PCR_MUX(0);
//  443         break;
//  444       case 12:  //ADC0_SE12 -- PTB2
//  445       case 13:  //ADC0_SE13 -- PTB3
//  446         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  447         PORT_PCR_REG(PORTB_BASE_PTR, channel-10) =  PORT_PCR_MUX(0);
//  448         break;
//  449       case 14:  //ADC0_SE14 -- PTC0
//  450       case 15:  //ADC0_SE15 -- PTC1
//  451         SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK; 
//  452         PORT_PCR_REG(PORTC_BASE_PTR, channel-14) =  PORT_PCR_MUX(0);
//  453         break;
//  454       case 16:   //ADC0_SE16
//  455         break;
//  456       case 17:   //ADC0_SE17 -- PTE24
//  457       case 18:   //ADC0_SE17 -- PTE25
//  458         SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; 
//  459         PORT_PCR_REG(PORTE_BASE_PTR, channel+7) =  PORT_PCR_MUX(0);
//  460         break;
//  461       case 19:   //ADC0_DM0 -- PGA0_DM
//  462       case 20:   //ADC0_DM1 -- PGA2_DM
//  463       case 23:   //ADC0_SE23 -- DAC0_OUT
//  464       case 26:   //Temperature Sensor (S.E)
//  465       case 27:   //Bandgap (S.E)
//  466       case 29:   //VREFH (S.E)
//  467       case 30:   //VREFL
//  468         break;
//  469       default:
//  470         return 0;  
//  471     }
//  472   }
//  473   else if(adcx == ADC1)
//  474   {
//  475     switch(channel)
//  476     {
//  477       case 0:   //ADC1_DP0 -- PGA1_DP
//  478       case 1:   //ADC1_DP1 -- PGA3_DP
//  479       case 2:   //PGA1_DP 
//  480       case 3:   //ADC1_DP3 -- PGA0_DP
//  481         break;
//  482       case 4:   //ADC1_SE4a -- PTE0
//  483       case 5:   //ADC1_SE5a -- PTE1
//  484       case 6:   //ADC1_SE6a -- PTE2
//  485       case 7:   //ADC1_SE7a -- PTE3
//  486         SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; 
//  487         PORT_PCR_REG(PORTE_BASE_PTR, channel-4) =  PORT_PCR_MUX(0);
//  488         break;
//  489       case 8:  //ADC1_SE8 -- PTB0
//  490       case 9:  //ADC1_SE9 -- PTB1
//  491         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  492         PORT_PCR_REG(PORTB_BASE_PTR, channel-8) =  PORT_PCR_MUX(0);
//  493         break;
//  494       case 10:  //ADC1_SE10 -- PTB4
//  495       case 11:  //ADC1_SE11 -- PTB5
//  496       case 12:  //ADC1_SE12 -- PTB6
//  497       case 13:  //ADC1_SE13 -- PTB7
//  498         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  499         PORT_PCR_REG(PORTB_BASE_PTR, channel-6) =  PORT_PCR_MUX(0);
//  500         break;
//  501       case 14:  //ADC1_SE14 -- PTB10
//  502       case 15:  //ADC1_SE15 -- PTB11
//  503         SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
//  504         PORT_PCR_REG(PORTB_BASE_PTR, channel-4) =  PORT_PCR_MUX(0);
//  505         break;
//  506       case 16:   //ADC1_SE16
//  507         break;
//  508       case 17:  //ADC1_SE17 -- PTA17
//  509         SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
//  510         PORT_PCR_REG(PORTA_BASE_PTR, channel) =  PORT_PCR_MUX(0);
//  511         break;
//  512       case 18:   //VREF Output
//  513       case 19:   //ADC1_DM0 -- PGA1_DM
//  514       case 20:   //ADC1_DM1 -- PGA3_DM
//  515       case 23:   //DAC1_OUT 
//  516       case 26:   //Temperature Sensor (S.E)
//  517       case 27:   //Bandgap (S.E)
//  518       case 29:   //VREFH (S.E)
//  519       case 30:   //VREFL
//  520         break;
//  521       default:
//  522         return 0;  
//  523     }
//  524   }
//  525   else
//  526   {
//  527     return 0;
//  528   }
//  529   
//  530   if(ad_event & ADC_INT_DISABLE)
??LPLD_ADC_Channel_Init_3:
??LPLD_ADC_Channel_Init_12:
        LSLS     R1,R5,#+31
        BPL.W    ??LPLD_ADC_Channel_Init_13
//  531   {
//  532     ADC_SC1_REG(adcptr,0) &= ~(ADC_SC1_AIEN_MASK); //禁止中断
        LDR      R0,[R6, #+0]
        BICS     R0,R0,#0x40
        STR      R0,[R6, #+0]
        B.N      ??LPLD_ADC_Channel_Init_14
//  533   }
??LPLD_ADC_Channel_Init_4:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x400
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+2
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+303104
        MOVS     R2,#+0
        STR      R2,[R1, #-32]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_5:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        MOV      R2,#+512
        ORRS     R1,R2,R1
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+2
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+299008
        MOVS     R2,#+0
        STR      R2,[R1, #-12]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_6:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x400
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+2
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+303104
        MOVS     R2,#+0
        STR      R2,[R1, #-40]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_7:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x800
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+2
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+307200
        MOVS     R2,#+0
        STR      R2,[R1, #-56]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_8:
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_9:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x2000
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+2
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+315392
        MOVS     R2,#+0
        STR      R2,[R1, #+28]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_10:
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_11:
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_Channel_Init_1
??LPLD_ADC_Channel_Init_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BNE.N    ??LPLD_ADC_Channel_Init_15
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        MOVS     R1,R4
        CMP      R1,#+0
        CMP      R1,#+3
        BLS.N    ??LPLD_ADC_Channel_Init_16
        SUBS     R1,R1,#+4
        CMP      R1,#+3
        BLS.N    ??LPLD_ADC_Channel_Init_17
        SUBS     R1,R1,#+4
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_18
        SUBS     R1,R1,#+2
        CMP      R1,#+3
        BLS.N    ??LPLD_ADC_Channel_Init_19
        SUBS     R1,R1,#+4
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_20
        SUBS     R1,R1,#+2
        BEQ.N    ??LPLD_ADC_Channel_Init_21
        SUBS     R1,R1,#+1
        BEQ.N    ??LPLD_ADC_Channel_Init_22
        SUBS     R1,R1,#+1
        CMP      R1,#+2
        BLS.N    ??LPLD_ADC_Channel_Init_23
        SUBS     R1,R1,#+5
        BEQ.N    ??LPLD_ADC_Channel_Init_23
        SUBS     R1,R1,#+3
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_23
        SUBS     R1,R1,#+3
        CMP      R1,#+1
        BLS.N    ??LPLD_ADC_Channel_Init_23
        B.N      ??LPLD_ADC_Channel_Init_24
??LPLD_ADC_Channel_Init_16:
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_17:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x2000
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+2
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+315392
        MOVS     R2,#+0
        STR      R2,[R1, #-16]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_18:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x400
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+2
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+303104
        MOVS     R2,#+0
        STR      R2,[R1, #-32]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_19:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x400
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+2
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+303104
        MOVS     R2,#+0
        STR      R2,[R1, #-24]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_20:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x400
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+2
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+303104
        MOVS     R2,#+0
        STR      R2,[R1, #-16]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_21:
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_22:
        LDR.N    R1,??DataTable5_6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        MOV      R2,#+512
        ORRS     R1,R2,R1
        LDR.N    R2,??DataTable5_6  ;; 0x40048038
        STR      R1,[R2, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R1,??DataTable5_7  ;; 0x40049000
        MOVS     R2,#+0
        STR      R2,[R1, R4, LSL #+2]
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_23:
        B.N      ??LPLD_ADC_Channel_Init_12
??LPLD_ADC_Channel_Init_24:
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_Channel_Init_1
??LPLD_ADC_Channel_Init_15:
        MOVS     R0,#+0
        B.N      ??LPLD_ADC_Channel_Init_1
//  534   else if(ad_event & ADC_INT_ENABLE)
??LPLD_ADC_Channel_Init_13:
        LSLS     R1,R5,#+30
        BPL.N    ??LPLD_ADC_Channel_Init_14
//  535   {
//  536     ADC_SC1_REG(adcptr,0) |= ADC_SC1_AIEN_MASK;   //使能中断
        LDR      R1,[R6, #+0]
        ORRS     R1,R1,#0x40
        STR      R1,[R6, #+0]
//  537     if(adcx == ADC0)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_ADC_Channel_Init_25
//  538     {
//  539       enable_irq(57);      //使能ADC0 NVIC中断
        MOVS     R0,#+57
        BL       enable_irq
//  540       ADC_ISR[ADC0] = isr; //添加中断路径 
        LDR.N    R0,??DataTable5_8
        STR      R7,[R0, #+0]
        B.N      ??LPLD_ADC_Channel_Init_14
//  541     }
//  542     else
//  543     {
//  544       enable_irq(58);      //使能ADC1 NVIC中断
??LPLD_ADC_Channel_Init_25:
        MOVS     R0,#+58
        BL       enable_irq
//  545       ADC_ISR[ADC1] = isr; //添加中断路径 
        LDR.N    R0,??DataTable5_8
        STR      R7,[R0, #+4]
//  546     }
//  547   }
//  548   if(ad_event & ADC_DMA_DISABLE)
??LPLD_ADC_Channel_Init_14:
        LSLS     R0,R5,#+29
        BPL.N    ??LPLD_ADC_Channel_Init_26
//  549   {
//  550     ADC_SC2_REG(adcptr)  &= ~( ADC_SC2_DMAEN_MASK ); //禁止DMA
        LDR      R0,[R6, #+32]
        BICS     R0,R0,#0x4
        STR      R0,[R6, #+32]
        B.N      ??LPLD_ADC_Channel_Init_27
//  551   }
//  552   else if(ad_event & ADC_DMA_ENABLE)
??LPLD_ADC_Channel_Init_26:
        LSLS     R0,R5,#+28
        BPL.N    ??LPLD_ADC_Channel_Init_27
//  553   {
//  554     ADC_SC2_REG(adcptr)  |= ADC_SC2_DMAEN_MASK;     //使能DMA
        LDR      R0,[R6, #+32]
        ORRS     R0,R0,#0x4
        STR      R0,[R6, #+32]
//  555   }
//  556   ADC_SC1_REG(adcptr,0) &= ~(ADC_SC1_ADCH_MASK);   
??LPLD_ADC_Channel_Init_27:
        LDR      R0,[R6, #+0]
        LSRS     R0,R0,#+5
        LSLS     R0,R0,#+5
        STR      R0,[R6, #+0]
//  557   ADC_SC1_REG(adcptr,0) |= ADC_SC1_ADCH(channel);   //设置通道
        LDR      R0,[R6, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ANDS     R1,R4,#0x1F
        ORRS     R0,R1,R0
        STR      R0,[R6, #+0]
//  558   
//  559   return 1;
        MOVS     R0,#+1
??LPLD_ADC_Channel_Init_1:
        POP      {R1,R4-R7,PC}    ;; return
//  560 }
//  561 /*
//  562  * LPLD_ADC_SetHWTrg
//  563  * 设置ADC为硬件触发方式
//  564  * 
//  565  * 参数:
//  566  *    adcx--ADC模块号
//  567  *      |__ADC0         -ADC0模块
//  568  *      |__ADC1         -ADC0模块
//  569  *
//  570  * 输出:
//  571  *    无
//  572  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  573 void LPLD_ADC_SetHWTrg(ADCx adcx)
//  574 {
//  575   ADC_MemMapPtr adcptr = ADCx_Ptr[adcx];
LPLD_ADC_SetHWTrg:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable5_2
        LDR      R0,[R1, R0, LSL #+2]
//  576   //选择ADC为硬件触发方式
//  577   ADC_SC2_REG(adcptr)  |= ADC_SC2_ADTRG_MASK;
        LDR      R1,[R0, #+32]
        ORRS     R1,R1,#0x40
        STR      R1,[R0, #+32]
//  578 }
        BX       LR               ;; return
//  579 
//  580 /*
//  581  * LPLD_ADC_Isr
//  582  * ADC中断服务函数
//  583  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  584 void LPLD_ADC_Isr(void)
//  585 {
LPLD_ADC_Isr:
        PUSH     {R4,LR}
//  586   #define ADC_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
//  587   uint8 adc_ch = ADC_VECTORNUM - 73;
        LDR.N    R0,??DataTable5_9  ;; 0xe000ed04
        LDRB     R0,[R0, #+0]
        SUBS     R4,R0,#+73
//  588     
//  589   //调用用户自定义中断服务
//  590   if(ADC_ISR[adc_ch] != (ADC_ISR_CALLBACK)0)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable5_8
        LDR      R0,[R0, R4, LSL #+2]
        CMP      R0,#+0
        BEQ.N    ??LPLD_ADC_Isr_0
//  591     ADC_ISR[adc_ch](); 
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable5_8
        LDR      R0,[R0, R4, LSL #+2]
        BLX      R0
//  592   if(!adc_ch)
??LPLD_ADC_Isr_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_ADC_Isr_1
//  593     ADC_SC1_REG(ADC0_BASE_PTR,0) |= ADC_SC1_COCO_MASK;
        LDR.N    R0,??DataTable5_5  ;; 0x4003b000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable5_5  ;; 0x4003b000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_ADC_Isr_2
//  594   else
//  595     ADC_SC1_REG(ADC1_BASE_PTR,0) |= ADC_SC1_COCO_MASK;
??LPLD_ADC_Isr_1:
        LDR.N    R0,??DataTable5_10  ;; 0x400bb000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable5_10  ;; 0x400bb000
        STR      R0,[R1, #+0]
//  596 }
??LPLD_ADC_Isr_2:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     Adc0_Config

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     ADCx_Ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     Adc1_Config

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     0x4003b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     0x40048038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     0x40049000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_8:
        DC32     ADC_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_9:
        DC32     0xe000ed04

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_10:
        DC32     0x400bb000

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
//    40 bytes in section .bss
//     8 bytes in section .data
// 1 676 bytes in section .text
// 
// 1 676 bytes of CODE memory
//    48 bytes of DATA memory
//
//Errors: none
//Warnings: none
