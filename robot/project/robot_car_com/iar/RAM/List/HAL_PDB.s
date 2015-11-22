///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:10 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_PDB.c      /
//    Command line =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_PDB.c -D   /
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
//                    ar\RAM\List\HAL_PDB.s                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_PDB

        #define SHT_PROGBITS 0x1

        EXTERN enable_irq

        PUBLIC LPLD_PDB_ADC_Trigger_Congfig
        PUBLIC LPLD_PDB_DAC_Interval_Congfig
        PUBLIC LPLD_PDB_Delay
        PUBLIC LPLD_PDB_Init
        PUBLIC LPLD_PDB_Isr
        PUBLIC LPLD_PDB_SetDelayIsr
        PUBLIC LPLD_PDB_SetUp
        PUBLIC PDB_ISR

// D:\中国机器人大赛\robot_project\lib\LPLD\HAL_PDB.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_PDB.c
//   10  * 用途: PDB底层模块相关函数
//   11  * 最后修改日期: 20120321
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17 */
//   18 #include "HAL_PDB.h"
//   19 #include "common.h"
//   20 
//   21 /*
//   22  *******需用到PDB中断，请在isr.h中粘贴一下代码:*********
//   23 #undef  VECTOR_088
//   24 #define VECTOR_088 LPLD_PDB_Isr
//   25 //以下函数在LPLD_Kinetis底层包，不必修改
//   26 extern void LPLD_PDB_Isr(void);
//   27  ***********************代码结束*************************
//   28 */
//   29 
//   30 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   31 PDB_ISR_CALLBACK PDB_ISR[1];
PDB_ISR:
        DS8 4
//   32 
//   33 
//   34 /*
//   35  * LPLD_PDB_Init
//   36  * 用于初始化PDB
//   37  * 设置PDB的prescale预分频值
//   38  * 设置PDB的trgsel输入触发源
//   39  * 设置PDB的ldmod加载模式
//   40  * 设置PDB的cont持续工作模式和one-shot模式
//   41  * 设置PDB的dma_en
//   42  * 
//   43  * 参数:
//   44  *    prescale--PDB 分频系数
//   45  *      PDB的计数器频率 等于 外设总线频率除以 prescale和mult的乘积\ 
//   46  *      |__PDB_PRESC_1      -设置prescale = MULT * 1
//   47  *      |__PDB_PRESC_2      -设置prescale = MULT * 2
//   48  *      |__PDB_PRESC_4      -设置prescale = MULT * 4
//   49  *      |__PDB_PRESC_8      -设置prescale = MULT * 8
//   50  *      |__PDB_PRESC_16     -设置prescale = MULT * 16
//   51  *      |__PDB_PRESC_32     -设置prescale = MULT * 32
//   52  *      |__PDB_PRESC_64     -设置prescale = MULT * 64
//   53  *      |__PDB_PRESC_128    -设置prescale = MULT * 128
//   54  *
//   55  *    mult--PDB 分频因子
//   56  *      PDB的计数器频率 等于 外设总线频率除以 prescale和mult的乘积
//   57  *      |__PDB_MULT_1       -设置MULT = 1
//   58  *      |__PDB_MULT_10      -设置MULT = 10
//   59  *      |__PDB_MULT_20      -设置MULT = 20
//   60  *      |__PDB_MULT_40      -设置MULT = 40
//   61  *
//   62  *    mod--PDB 模计数器，
//   63  *      当PDB计数器等于MOD的值，PDB计数器清零
//   64  *
//   65  *    trgsel-- PDB 触发源选择
//   66  *      |__TRIGER_IN0        -输入触发源0
//   67  *      |__...                  
//   68  *      |__TRIGER_IN14       -输入触发源14
//   69  *      |__SOFTWARE_TRIGER   -软件触发
//   70  * 
//   71  *    ldmod--设置PDB ADC通道x的预触发通道
//   72  *      |__LDMOD0   -当LDOK=1后 MOD, IDLY, CHnDLYm, INTx, 和 POyDLY 寄存器立即加载
//   73  *      |__LDMOD1   -当LDOK=1和PDB计数器到达MOD后 MOD, IDLY, CHnDLYm, INTx, 和 POyDLY 寄存器立即加载
//   74  *      |__LDMOD2   -当LDOK=1和一个输入事件设置为1后 MOD, IDLY, CHnDLYm, INTx, 和 POyDLY 寄存器立即加载
//   75  *      |__LDMOD3   -当LDOK=1后和一个输入事件设置为1或PDB计数器到达MOD后 MOD, IDLY, CHnDLYm, INTx, 和 POyDLY 寄存器立即加载
//   76  *
//   77  *    cont -- 设置PDB 工作模式
//   78  *      |__PDB_ONESHOT   -单次模式
//   79  *      |__PDB_CONTINUE  -连续模式
//   80  * 
//   81  *    dma_en -- 使能DMA功能
//   82  *      |__PDB_DMA_OFF   -禁止DMA模式
//   83  *      |__PDB_DMA_ON    -使能DMA模式
//   84  *
//   85  *    返回值:
//   86  *       0 错误
//   87  *       1 设置成功
//   88  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   89 uint8 LPLD_PDB_Init(uint8 prescale,uint8 mult,uint16 mod ,uint8 trgsel,uint8 ldmod,uint8 cont,uint8 dma_en)
//   90 {
LPLD_PDB_Init:
        PUSH     {R4-R7}
        LDR      R4,[SP, #+16]
        LDR      R5,[SP, #+20]
        LDR      R6,[SP, #+24]
//   91   //使能PDB时钟
//   92   SIM_SCGC6 |= SIM_SCGC6_PDB_MASK ;
        LDR.N    R7,??DataTable6  ;; 0x4004803c
        LDR      R7,[R7, #+0]
        ORRS     R7,R7,#0x400000
        LDR.W    R12,??DataTable6  ;; 0x4004803c
        STR      R7,[R12, #+0]
//   93   
//   94   PDB0_SC = 0x00;
        LDR.N    R7,??DataTable6_1  ;; 0x40036000
        MOVS     R12,#+0
        STR      R12,[R7, #+0]
//   95   //设置分频因子
//   96   //f_PDB = f_perpherial_bus / (mult * prescale)
//   97   //其中f_perpherial_bus在PLL锁相环中设置
//   98   if( mult > 3)
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+4
        BCC.N    ??LPLD_PDB_Init_0
//   99     return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_PDB_Init_1
//  100   else
//  101     PDB0_SC |=PDB_SC_MULT(mult);
??LPLD_PDB_Init_0:
        LDR.N    R7,??DataTable6_1  ;; 0x40036000
        LDR      R7,[R7, #+0]
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R1,R1,#+2
        ANDS     R1,R1,#0xC
        ORRS     R1,R1,R7
        LDR.N    R7,??DataTable6_1  ;; 0x40036000
        STR      R1,[R7, #+0]
//  102   
//  103   if(prescale >7)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+8
        BCC.N    ??LPLD_PDB_Init_2
//  104     return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_PDB_Init_1
//  105   else
//  106     PDB0_SC |=PDB_SC_PRESCALER(prescale);
??LPLD_PDB_Init_2:
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        LDR      R1,[R1, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+12
        ANDS     R0,R0,#0x7000
        ORRS     R0,R0,R1
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  107   
//  108   if(ldmod > 3)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BCC.N    ??LPLD_PDB_Init_3
//  109     return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_PDB_Init_1
//  110   else
//  111     //设置加载模式
//  112     PDB0_SC |= PDB_SC_LDMOD(ldmod); 
??LPLD_PDB_Init_3:
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+18
        ANDS     R1,R1,#0xC0000
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  113   
//  114   if(trgsel >15)
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R3,#+16
        BCC.N    ??LPLD_PDB_Init_4
//  115     return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_PDB_Init_1
//  116   else
//  117     //设置触发模式
//  118     PDB0_SC |= PDB_SC_TRGSEL(trgsel);
??LPLD_PDB_Init_4:
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        LSLS     R1,R3,#+8
        ANDS     R1,R1,#0xF00
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  119   
//  120   //设置PDB工作模式
//  121   if(cont)
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??LPLD_PDB_Init_5
//  122   {
//  123     //PDB 工作在连续模式
//  124     PDB0_SC |= PDB_SC_CONT_MASK ;
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_PDB_Init_6
//  125   }
//  126   else
//  127   {
//  128     //PDB 工作在连续模式
//  129     PDB0_SC &=(~PDB_SC_CONT_MASK);
??LPLD_PDB_Init_5:
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x2
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  130   }
//  131   //设置DMA模式
//  132   if(dma_en)
??LPLD_PDB_Init_6:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??LPLD_PDB_Init_7
//  133   {
//  134     //PDB 工作在连续模式
//  135     PDB0_SC |= PDB_SC_DMAEN_MASK ;
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_PDB_Init_8
//  136   }
//  137   else
//  138   {
//  139     //PDB 工作在连续模式
//  140     PDB0_SC &=(~PDB_SC_DMAEN_MASK);
??LPLD_PDB_Init_7:
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x8000
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  141   }
//  142   
//  143   PDB0_MOD = mod;
??LPLD_PDB_Init_8:
        LDR.N    R0,??DataTable6_2  ;; 0x40036004
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        STR      R2,[R0, #+0]
//  144   
//  145   return 1;
        MOVS     R0,#+1
??LPLD_PDB_Init_1:
        POP      {R4-R7}
        BX       LR               ;; return
//  146 }
//  147 
//  148 /*
//  149  * LPLD_PDB_SetUp
//  150  * 用于开启关闭PDB计数器
//  151  * 开启的同时根据LMOD的配置加载MOD, IDLY, CHnDLYm, DACINTx, and POyDLY
//  152  * 如果设置为软件触发，此时清零计数器
//  153  *
//  154  * 参数:
//  155  *   is_operate -- 决定是否开启PDB
//  156  *     |__PDB_STOP        -关闭PDB
//  157  *     |__PDB_OPERATION   -开启PDB
//  158  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  159 void LPLD_PDB_SetUp(uint8 is_operate)
//  160 {
//  161   if(is_operate==PDB_OPERATION)
LPLD_PDB_SetUp:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BNE.N    ??LPLD_PDB_SetUp_0
//  162   {
//  163     //开启PDB0
//  164     PDB0_SC |= PDB_SC_PDBEN_MASK ; 
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  165     //LDOK 只有在PDBEN = 1情况下才有用；
//  166     //更细MOD, IDLY, CHnDLYm, DACINTx, and POyDLY中的值
//  167     //将所有设置的时间值加载到相对应的缓冲区中。
//  168     PDB0_SC |= PDB_SC_LDOK_MASK ;
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  169     
//  170     //PDB使能后且软件触发模式后
//  171     //此时计数器会清零，复位计数器
//  172     PDB0_SC |= PDB_SC_SWTRIG_MASK ;
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10000
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_PDB_SetUp_1
//  173   }
//  174   else
//  175   {
//  176     //关闭PDB
//  177     PDB0_SC &= (~PDB_SC_PDBEN_MASK); 
??LPLD_PDB_SetUp_0:
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x80
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  178   }
//  179 }
??LPLD_PDB_SetUp_1:
        BX       LR               ;; return
//  180 
//  181 /*
//  182  * LPLD_PDB_ADC_Trigger_Congfig
//  183  * 用于设置通过PDB设置ADC的触发信号，在该函数中
//  184  * 设置PDB的adcx通道
//  185  * 设置PDB的adcx预触发延时计数器的值
//  186  * 设置PDB的adcx预触发通道
//  187  * 设置PDB的adcx预触发通道bb模式
//  188  * 
//  189  * 参数:
//  190  *    adcx--选择PDB ADC的通道
//  191  *      |__ADC0       -选择PDB ADC通道0
//  192  *      |__ADC1       -选择PDB ADC通道1
//  193  * 
//  194  *    *pre_dalay--PDB ADC的预触发延时器的计数值，该参数最大为65536
//  195  *        PDB ADC的延时频率 等于 PDB计数器的频率 乘以 pre_dalay 
//  196  *        因为每个通道有两个预触发延时器，需要两个延时值，所以定义为*pre_dalay
//  197  * 
//  198  *    pre_ch--设置PDB ADC通道x的预触发通道
//  199  *      |__PDB_PRECH_DIS  -不选择预触发位
//  200  *      |__PDB_PRECH_EN0  -选择预触发0  
//  201  *      |__PDB_PRECH_EN1  -选择预触发1  
//  202  *
//  203  *    pre_bb_mode--设置PDB ADC通道x的预触发的back to back模式
//  204  *      |__PDB_PREBB_DIS  -禁止PDB ADC通道x的预触发的b to b模式
//  205  *      |__PDB_PREBB_EN0  -选择PDB ADC通道x的预触发0的的b to b模式
//  206  *      |__PDB_PREBB_EN1  -选择PDB ADC通道x的预触发1的的b to b模式
//  207  */
//  208 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  209 void LPLD_PDB_ADC_Trigger_Congfig(ADCx adcx, uint16 *pre_dalay, uint8 pre_ch, uint8 pre_bb_mode)
//  210 {
LPLD_PDB_ADC_Trigger_Congfig:
        PUSH     {R4,R5}
//  211   PDB_C1_REG(PDB0_BASE_PTR,adcx) = (0 
//  212                                     | PDB_C1_BB(pre_bb_mode)
//  213                                     | PDB_C1_TOS(pre_ch)
//  214                                     | PDB_C1_EN(pre_ch)
//  215                                     );
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LSLS     R4,R2,#+8
        ORRS     R3,R4,R3, LSL #+16
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        ORRS     R3,R2,R3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R4,#+40
        LDR.N    R5,??DataTable6_3  ;; 0x40036010
        MLA      R4,R4,R0,R5
        STR      R3,[R4, #+0]
//  216   
//  217   if(pre_ch) 
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??LPLD_PDB_ADC_Trigger_Congfig_0
//  218   {
//  219     PDB_DLY_REG(PDB0_BASE_PTR,adcx,pre_ch-1) = *pre_dalay;
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        MOVS     R3,#+40
        LDR.N    R4,??DataTable6_3  ;; 0x40036010
        MLA      R0,R3,R0,R4
        ADDS     R0,R0,R2, LSL #+2
        LDRH     R1,[R1, #+0]
        STR      R1,[R0, #+4]
//  220   }
//  221 }
??LPLD_PDB_ADC_Trigger_Congfig_0:
        POP      {R4,R5}
        BX       LR               ;; return
//  222 
//  223 /*
//  224  * LPLD_PDB_DAC_Interval_Congfig
//  225  * 该函数用于设置DAC的PDB触发周期，在该函数中
//  226  * 设置PDB的dacx通道
//  227  * 设置PDB的dacx的PDB0_DACINTx的计数值，
//  228  * 设置PDB的dacx外部引脚触发模式
//  229  * 
//  230  * 参数:
//  231  *    dacx--选择PDB DAC的通道
//  232  *      |__DAC0       -选择PDB DAC通道0
//  233  *      |__DAC1       -选择PDB DAC通道1
//  234  * 
//  235  *    interval -- DAC的触发间隔，该参数最大为65536
//  236  *        DAC的触发频率 等于 PDB计数器的频率 乘以 interval 
//  237  * 
//  238  *    extrigger -- DAC外部触发输入使能，如果设置此位PDB0_DACINTx会被放弃
//  239  *      |__PDB_EXTRG_DIS  -禁用外部触发输入
//  240  *      |__PDB_EXTRG_EN   -使能外部触发输入   
//  241  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  242 void LPLD_PDB_DAC_Interval_Congfig(DACx dacx,uint16 interval,uint8 extrigger)
//  243 {
//  244 
//  245   if(extrigger == PDB_EXTRG_EN)
LPLD_PDB_DAC_Interval_Congfig:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+1
        BNE.N    ??LPLD_PDB_DAC_Interval_Congfig_0
//  246   {
//  247     //外部触发模式下，PDB0_DACINT0无用
//  248     //DAC output delay from PDB Software trigger
//  249     PDB_INTC_REG(PDB0_BASE_PTR,dacx) |= PDB_INTC_EXT_MASK ;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable6_4  ;; 0x40036150
        LDR      R1,[R1, R0, LSL #+3]
        ORRS     R1,R1,#0x2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable6_4  ;; 0x40036150
        STR      R1,[R2, R0, LSL #+3]
        B.N      ??LPLD_PDB_DAC_Interval_Congfig_1
//  250   }
//  251   else
//  252   {
//  253     //设置PDB0_DACINT0时，必须保证PDSC_DACTOE = 1,意思是开启PDB内部DAC计数器
//  254     //DAC output changes are base on the interval defined by this value
//  255     PDB_INT_REG(PDB0_BASE_PTR,dacx) = interval;
??LPLD_PDB_DAC_Interval_Congfig_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable6_4  ;; 0x40036150
        ADDS     R2,R2,R0, LSL #+3
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        STR      R1,[R2, #+4]
//  256     PDB_INTC_REG(PDB0_BASE_PTR,dacx) &= ~PDB_INTC_EXT_MASK ;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable6_4  ;; 0x40036150
        LDR      R1,[R1, R0, LSL #+3]
        BICS     R1,R1,#0x2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable6_4  ;; 0x40036150
        STR      R1,[R2, R0, LSL #+3]
//  257   }
//  258   //使能DAC间隔计数器
//  259   PDB_INTC_REG(PDB0_BASE_PTR,dacx) |= PDB_INTC_TOE_MASK ;
??LPLD_PDB_DAC_Interval_Congfig_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable6_4  ;; 0x40036150
        LDR      R1,[R1, R0, LSL #+3]
        ORRS     R1,R1,#0x1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable6_4  ;; 0x40036150
        STR      R1,[R2, R0, LSL #+3]
//  260   
//  261 }
        BX       LR               ;; return
//  262 
//  263 /*
//  264  * LPLD_PDB_Delay_SetIsr
//  265  * 该函数用于设定PDB延时中断
//  266  * 
//  267  * 参数:
//  268  * 
//  269  *    delay -- PDB的延时值，该参数最大为65536
//  270  *        PDB的延时值频率 等于 PDB计数器的频率 乘以 delay 
//  271  * 
//  272  *    isr_func -- PDB延时中断服务函数
//  273  */
//  274 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  275 void LPLD_PDB_SetDelayIsr(uint16 delay,PDB_ISR_CALLBACK isr_func)
//  276 {
LPLD_PDB_SetDelayIsr:
        PUSH     {R4,LR}
        MOVS     R4,R1
//  277   //设定定时器值
//  278   PDB0_IDLY = delay;
        LDR.N    R1,??DataTable6_5  ;; 0x4003600c
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STR      R0,[R1, #+0]
//  279   
//  280   enable_irq(72);
        MOVS     R0,#+72
        BL       enable_irq
//  281   //使能定时中断
//  282   PDB0_SC |= PDB_SC_PDBIE_MASK;
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  283   //添加中断函数  
//  284   PDB_ISR[0] = isr_func;
        LDR.N    R0,??DataTable6_6
        STR      R4,[R0, #+0]
//  285 
//  286 }
        POP      {R4,PC}          ;; return
//  287 
//  288 /*
//  289  * LPLD_PDB_Delay
//  290  * 该函数用查询标志位的方式等待延时完成
//  291  * 
//  292  * 参数:
//  293  * 
//  294  *    delay -- PDB的延时值，该参数最大为65536
//  295  *        PDB的延时值频率 等于 PDB计数器单位的频率 乘以 delay 
//  296  * 
//  297  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  298 void LPLD_PDB_Delay(uint16 delay)
//  299 {
//  300   //设定定时器值
//  301   PDB0_IDLY = delay;
LPLD_PDB_Delay:
        LDR.N    R1,??DataTable6_5  ;; 0x4003600c
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STR      R0,[R1, #+0]
//  302   //禁止定时器中断
//  303   PDB0_SC &= (~PDB_SC_PDBIE_MASK);
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x20
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_PDB_Delay_0
//  304   //延时等待直到标志位置1
//  305   while(PDB0_SC & PDB_SC_PDBIF_MASK)
//  306   {
//  307     //清除标志位  
//  308     PDB0_SC |= PDB_SC_PDBIF_MASK;
??LPLD_PDB_Delay_1:
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  309   }
??LPLD_PDB_Delay_0:
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BMI.N    ??LPLD_PDB_Delay_1
//  310 }
        BX       LR               ;; return
//  311 
//  312 
//  313 /*
//  314  * LPLD_PDB_Isr
//  315  * PDB通用中断底层入口函数
//  316  * PDB一共有两个中断，其一为定时中断，其二为错误中断
//  317  * 这里仅设置定时中断处理函数
//  318  * 用户无需修改，程序自动进入对应通道中断函数
//  319  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  320 void LPLD_PDB_Isr(void)
//  321 {
LPLD_PDB_Isr:
        PUSH     {R7,LR}
//  322   #define PDB_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
//  323   uint8 pdb_ch = PDB_VECTORNUM - 88;
        LDR.N    R0,??DataTable6_7  ;; 0xe000ed04
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+88
//  324     
//  325   //调用用户自定义中断服务
//  326   PDB_ISR[pdb_ch]();  
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable6_6
        LDR      R0,[R1, R0, LSL #+2]
        BLX      R0
//  327   
//  328   //清除定时中断标志位  
//  329   PDB0_SC &= ~PDB_SC_PDBIF_MASK;
        LDR.N    R0,??DataTable6_1  ;; 0x40036000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40
        LDR.N    R1,??DataTable6_1  ;; 0x40036000
        STR      R0,[R1, #+0]
//  330 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     0x40036000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     0x40036004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     0x40036010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     0x40036150

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     0x4003600c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     PDB_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     0xe000ed04

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
//   4 bytes in section .bss
// 560 bytes in section .text
// 
// 560 bytes of CODE memory
//   4 bytes of DATA memory
//
//Errors: none
//Warnings: none
