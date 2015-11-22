///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:04 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_LPTMR.c    /
//    Command line =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_LPTMR.c    /
//                    -D IAR -D LPLD_K60 -lCN D:\中国机器人大赛\robot_project /
//                    \project\LPLD_Template\iar\RAM\List\ -lB                /
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
//                    ar\RAM\List\HAL_LPTMR.s                                 /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_LPTMR

        #define SHT_PROGBITS 0x1

        EXTERN disable_irq
        EXTERN enable_irq

        PUBLIC LPLD_LPTMR_ClearIsr
        PUBLIC LPLD_LPTMR_DelayMs
        PUBLIC LPLD_LPTMR_GetPulseAcc
        PUBLIC LPLD_LPTMR_Init
        PUBLIC LPLD_LPTMR_Isr
        PUBLIC LPLD_LPTMR_Reset
        PUBLIC LPLD_LPTMR_SetIsr
        PUBLIC LPTMR_ISR

// D:\中国机器人大赛\robot_project\lib\LPLD\HAL_LPTMR.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_LPTMR.c
//   10  * 用途: LPTMR底层模块相关函数
//   11  * 最后修改日期: 20120326
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17  */
//   18 /*
//   19  *******需用到LPTMR中断，请在isr.h中粘贴一下代码:*********
//   20 
//   21 //LPTMR模块中断服务定义
//   22 #undef  VECTOR_101
//   23 #define VECTOR_101 LPLD_LPTMR_Isr
//   24 //以下函数在LPLD_Kinetis底层包，不必修改
//   25 extern void LPLD_LPTMR_Isr(void);
//   26 
//   27  ***********************代码结束*************************
//   28 */
//   29 
//   30 #include "common.h"
//   31 #include "HAL_LPTMR.h"
//   32 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   33 LPTMR_ISR_CALLBACK LPTMR_ISR;
LPTMR_ISR:
        DS8 4
//   34 
//   35 /*
//   36  * LPLD_LPTMR_Init
//   37  * LPTMR初始化函数
//   38  * 
//   39  * 参数:
//   40  *    mode--选择LPTMR模式
//   41  *      |__MODE_LPTMR           --低功耗定时器模式
//   42  *      |__MODE_PLACC           --脉冲累加模式
//   43  *    period_ms--设定定时器的定时值 单位ms
//   44  *      |__0                    --设置脉冲累加模式时选择为0
//   45  *      |__1~65535              --1ms<= 定时周期  <=65535ms 
//   46  *    channel--选择累加输入通道
//   47  *      |__0                    --设置为定时器时选择为0
//   48  *      |__LPTMR_ALT1           --设置LPTMR_ALT1, PTA19为脉冲累加输入
//   49  *      |__LPTMR_ALT2           --设置LPTMR_ALT2, PTC5 为脉冲累加输入
//   50  *    irq_en--输入中断
//   51  *      |__IRQ_DISABLE          --不使能中断
//   52  *      |__IRQ_ENABLE           --使能中断
//   53  *    isr_func
//   54  *      |__低功耗定时器中断回调函数
//   55  *  
//   56  * 输出:
//   57  *    0--配置错误
//   58  *    1--配置成功
//   59  */
//   60 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   61 uint8 LPLD_LPTMR_Init(uint8 mode, uint16 period_ms, uint8 channel, uint8 irq_en, LPTMR_ISR_CALLBACK isr_func)
//   62 {
LPLD_LPTMR_Init:
        PUSH     {R4-R6,LR}
        MOVS     R4,R3
        LDR      R3,[SP, #+16]
//   63   SIM_SCGC5|=SIM_SCGC5_LPTIMER_MASK;//初始化LPTMR时钟
        LDR.N    R5,??DataTable6  ;; 0x40048038
        LDR      R5,[R5, #+0]
        ORRS     R5,R5,#0x1
        LDR.N    R6,??DataTable6  ;; 0x40048038
        STR      R5,[R6, #+0]
//   64    
//   65   LPTMR0_CSR=0x00;  //清空寄存器
        LDR.N    R5,??DataTable6_1  ;; 0x40040000
        MOVS     R6,#+0
        STR      R6,[R5, #+0]
//   66   LPTMR0_PSR=0x00;
        LDR.N    R5,??DataTable6_2  ;; 0x40040004
        MOVS     R6,#+0
        STR      R6,[R5, #+0]
//   67   LPTMR0_CMR=0x00;
        LDR.N    R5,??DataTable6_3  ;; 0x40040008
        MOVS     R6,#+0
        STR      R6,[R5, #+0]
//   68    
//   69   if(mode==MODE_LPTMR)// 配置成低功耗定时器功能
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_LPTMR_Init_0
//   70   {
//   71       
//   72     /* 配置LPTMR */
//   73     // LPO 1Khz
//   74     //设置比较的值
//   75     //使用内部时钟 分频系数Prescale为 2^(X+1)
//   76     //定时器的一个计数周期=时钟源(Clk_Src)/ 预分频值(Prescale)
//   77     //定时器的定时值=设置的比较值(compare_value)/定时器的一个计数周期
//   78     LPTMR0_CMR=LPTMR_CMR_COMPARE(period_ms);                 //设置比较值
        LDR.N    R0,??DataTable6_3  ;; 0x40040008
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        STR      R1,[R0, #+0]
//   79     LPTMR0_PSR=LPTMR_PSR_PCS(0x1)|LPTMR_PSR_PBYP_MASK;  //采用LPO时钟旁路使能
        LDR.N    R0,??DataTable6_2  ;; 0x40040004
        MOVS     R1,#+5
        STR      R1,[R0, #+0]
//   80         
//   81   }
//   82   else if(mode==MODE_PLACC)               //配置成脉冲捕获模式
//   83   {
//   84     if(channel==LPTMR_ALT1)               //LPTMR_ALT1
//   85     {
//   86       SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
//   87       PORTA_PCR19=PORT_PCR_MUX(0x6);      //设置PTA19为脉冲累加
//   88     }
//   89     else if(channel==LPTMR_ALT2)          //LPTMR_ALT2
//   90     {
//   91       SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK;  //设置PTC5为脉冲累加
//   92       PORTC_PCR5=PORT_PCR_MUX(0x4);      
//   93     }
//   94     else
//   95     {
//   96       return 0;
//   97     }
//   98     
//   99     //与所用的内部时钟无关
//  100     //外部输入的信号作为计数时钟
//  101     LPTMR0_PSR =LPTMR_PSR_PCS(0x1)|LPTMR_PSR_PBYP_MASK; 
//  102     LPTMR0_CSR =LPTMR_CSR_TPS(channel);
//  103     LPTMR0_CSR|=LPTMR_CSR_TMS_MASK; //捕获模式
//  104     LPTMR0_CSR|=LPTMR_CSR_TFC_MASK; //自由计数模式
//  105   }
//  106   else
//  107   {
//  108     return 0;
//  109   }
//  110   
//  111   if(isr_func!=NULL)
??LPLD_LPTMR_Init_1:
        MOVS     R0,R3
        CMP      R0,#+0
        BEQ.N    ??LPLD_LPTMR_Init_2
//  112   {
//  113     LPTMR_ISR=isr_func;
        LDR.N    R0,??DataTable6_4
        STR      R3,[R0, #+0]
//  114     enable_irq(85);
        MOVS     R0,#+85
        BL       enable_irq
//  115   }
//  116   
//  117   if(irq_en==1)
??LPLD_LPTMR_Init_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??LPLD_LPTMR_Init_3
//  118   {
//  119     LPTMR0_CSR|=LPTMR_CSR_TIE_MASK;
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
//  120   }
//  121   else if(irq_en==0)
//  122   {
//  123     LPTMR0_CSR&=~LPTMR_CSR_TIE_MASK;
//  124   }
//  125   else
//  126   {
//  127     return 0;
//  128   }
//  129   
//  130   LPTMR0_CSR|=LPTMR_CSR_TEN_MASK; //开启LPTMR
??LPLD_LPTMR_Init_4:
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
//  131   return 1;
        MOVS     R0,#+1
??LPLD_LPTMR_Init_5:
        POP      {R4-R6,PC}       ;; return
??LPLD_LPTMR_Init_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BNE.N    ??LPLD_LPTMR_Init_6
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+1
        BNE.N    ??LPLD_LPTMR_Init_7
        LDR.N    R0,??DataTable6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        MOV      R1,#+512
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable6  ;; 0x40048038
        STR      R0,[R1, #+0]
        LDR.N    R0,??DataTable6_5  ;; 0x4004904c
        MOV      R1,#+1536
        STR      R1,[R0, #+0]
??LPLD_LPTMR_Init_8:
        LDR.N    R0,??DataTable6_2  ;; 0x40040004
        MOVS     R1,#+5
        STR      R1,[R0, #+0]
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LSLS     R0,R2,#+4
        ANDS     R0,R0,#0x30
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_LPTMR_Init_1
??LPLD_LPTMR_Init_7:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+2
        BNE.N    ??LPLD_LPTMR_Init_9
        LDR.N    R0,??DataTable6  ;; 0x40048038
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800
        LDR.N    R1,??DataTable6  ;; 0x40048038
        STR      R0,[R1, #+0]
        LDR.N    R0,??DataTable6_6  ;; 0x4004b014
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
        B.N      ??LPLD_LPTMR_Init_8
??LPLD_LPTMR_Init_9:
        MOVS     R0,#+0
        B.N      ??LPLD_LPTMR_Init_5
??LPLD_LPTMR_Init_6:
        MOVS     R0,#+0
        B.N      ??LPLD_LPTMR_Init_5
??LPLD_LPTMR_Init_3:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_LPTMR_Init_10
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
        B.N      ??LPLD_LPTMR_Init_4
??LPLD_LPTMR_Init_10:
        MOVS     R0,#+0
        B.N      ??LPLD_LPTMR_Init_5
//  132 }
//  133 
//  134 
//  135 /*
//  136  * LPLD_LPTMR_SetIsr
//  137  * 设置LPTMR通道用户定义的中断服务函数，并使能中断
//  138  * 
//  139  * 参数:
//  140  *    isr_func--用户中断程序入口地址
//  141  *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
//  142  *
//  143  * 输出:
//  144  *    0--配置错误
//  145  *    1--配置成功
//  146  *
//  147  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  148 uint8 LPLD_LPTMR_SetIsr(LPTMR_ISR_CALLBACK isr_func)
//  149 {
LPLD_LPTMR_SetIsr:
        PUSH     {R7,LR}
//  150   LPTMR_ISR=isr_func;
        LDR.N    R1,??DataTable6_4
        STR      R0,[R1, #+0]
//  151   LPTMR0_CSR|=LPTMR_CSR_TIE_MASK;
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
//  152   enable_irq(85);
        MOVS     R0,#+85
        BL       enable_irq
//  153   
//  154   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  155 }
//  156 
//  157 /*
//  158  * LPLD_LPTMR_ClearIsr
//  159  * 清除LPTMR通道用户定义的中断服务函数，并禁用中断
//  160  * 
//  161  * 参数:
//  162  *    isr_func--用户中断程序入口地址
//  163  *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
//  164  *
//  165  * 输出:
//  166  *    0--配置错误
//  167  *    1--配置成功
//  168  *
//  169  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  170 uint8 LPLD_LPTMR_ClearIsr(void)
//  171 {
LPLD_LPTMR_ClearIsr:
        PUSH     {R7,LR}
//  172   LPTMR0_CSR&=~LPTMR_CSR_TIE_MASK;
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
//  173   disable_irq(85);
        MOVS     R0,#+85
        BL       disable_irq
//  174   LPTMR_ISR=NULL;
        LDR.N    R0,??DataTable6_4
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  175   
//  176   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  177 }
//  178 
//  179 /*
//  180  *  LPLD_LPTMR_Reset
//  181  *  低功耗定时器复位，复位以后清空低功耗定时器Counter
//  182  * 
//  183  *  参数:
//  184  *      无
//  185  *  返回值:
//  186  *      无
//  187  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  188 void LPLD_LPTMR_Reset(void)
//  189 {
//  190   LPTMR0_CSR&=(~LPTMR_CSR_TEN_MASK);       //Reset LPTMR0 
LPLD_LPTMR_Reset:
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
//  191 }
        BX       LR               ;; return
//  192 
//  193 
//  194 /*
//  195  *  LPLD_LPTMR_GetPulseAcc
//  196  *  得到脉冲累加的值
//  197  * 
//  198  *  参数:
//  199  *      无
//  200  *  返回值:
//  201  *      脉冲累加值
//  202  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  203 uint16 LPLD_LPTMR_GetPulseAcc(void)
//  204 {
//  205    return (uint16)LPTMR0_CNR;
LPLD_LPTMR_GetPulseAcc:
        LDR.N    R0,??DataTable6_7  ;; 0x4004000c
        LDR      R0,[R0, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BX       LR               ;; return
//  206 }
//  207 
//  208 /*
//  209  *  LPLD_LPTMR_DelayMs
//  210  *  低功耗定时器延时n个ms
//  211  * 
//  212  * 参数:
//  213  *    period_ms--设定定时器的定时值 单位ms
//  214  *    最大65535ms
//  215  *
//  216  *  返回值:
//  217  *      无
//  218  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  219 void LPLD_LPTMR_DelayMs(uint16 period_ms)
//  220 {
//  221   if(!period_ms)
LPLD_LPTMR_DelayMs:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BEQ.N    ??LPLD_LPTMR_DelayMs_0
//  222     return;
//  223   
//  224   /* 开启LPTMR时钟 */
//  225   SIM_SCGC5|=SIM_SCGC5_LPTIMER_MASK; 
??LPLD_LPTMR_DelayMs_1:
        LDR.N    R1,??DataTable6  ;; 0x40048038
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x1
        LDR.N    R2,??DataTable6  ;; 0x40048038
        STR      R1,[R2, #+0]
//  226   
//  227   /* 设置毫秒延时计数 */
//  228   LPTMR0_CMR = period_ms; 
        LDR.N    R1,??DataTable6_3  ;; 0x40040008
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        STR      R0,[R1, #+0]
//  229   
//  230   /* 设置LPTMR不分频采用1kHz LPO为时钟源 */
//  231   LPTMR0_PSR = LPTMR_PSR_PCS(1)|LPTMR_PSR_PBYP_MASK; 
        LDR.N    R0,??DataTable6_2  ;; 0x40040004
        MOVS     R1,#+5
        STR      R1,[R0, #+0]
//  232   
//  233   /* 开启定时器 */
//  234   LPTMR0_CSR |= LPTMR_CSR_TEN_MASK; 
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
//  235 
//  236   /* 等待计数达到设定值 */
//  237   while (!(LPTMR0_CSR & LPTMR_CSR_TCF_MASK));
??LPLD_LPTMR_DelayMs_2:
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??LPLD_LPTMR_DelayMs_2
//  238   
//  239   /*清除定值比较标志 */
//  240   LPTMR0_CSR &= ~LPTMR_CSR_TEN_MASK;
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
//  241   
//  242   return;
??LPLD_LPTMR_DelayMs_0:
        BX       LR               ;; return
//  243 }
//  244 
//  245 
//  246 /*
//  247  *  LPLD_LPTMR_Isr
//  248  *  低功耗定时器中断服务子程序
//  249  * 
//  250  *  参数:
//  251  *      无
//  252  *
//  253  *  返回值:
//  254  *      无
//  255  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  256 void LPLD_LPTMR_Isr(void)
//  257 {
LPLD_LPTMR_Isr:
        PUSH     {R7,LR}
//  258   LPTMR0_CSR|=LPTMR_CSR_TCF_MASK;  //清除LPT比较标志
        LDR.N    R0,??DataTable6_1  ;; 0x40040000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable6_1  ;; 0x40040000
        STR      R0,[R1, #+0]
//  259   LPTMR_ISR();
        LDR.N    R0,??DataTable6_4
        LDR      R0,[R0, #+0]
        BLX      R0
//  260 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0x40048038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     0x40040000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     0x40040004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     0x40040008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     LPTMR_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     0x4004904c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     0x4004b014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     0x4004000c

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
// 440 bytes in section .text
// 
// 440 bytes of CODE memory
//   4 bytes of DATA memory
//
//Errors: none
//Warnings: none
