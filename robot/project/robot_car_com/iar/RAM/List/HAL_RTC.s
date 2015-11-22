///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:06 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_RTC.c      /
//    Command line =  D:\中国机器人大赛\robot_project\lib\LPLD\HAL_RTC.c -D   /
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
//                    ar\RAM\List\HAL_RTC.s                                   /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_RTC

        #define SHT_PROGBITS 0x1

        EXTERN enable_irq

        PUBLIC LPLD_RTC_Alarm
        PUBLIC LPLD_RTC_GetRealTime
        PUBLIC LPLD_RTC_Init
        PUBLIC LPLD_RTC_Isr
        PUBLIC LPLD_RTC_Seconds
        PUBLIC LPLD_RTC_Stop
        PUBLIC RTC_ISR

// D:\中国机器人大赛\robot_project\lib\LPLD\HAL_RTC.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_RTC.c
//   10  * 用途: RTCC底层模块相关函数
//   11  * 最后修改日期: 20120626
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17  */
//   18 #include "common.h"
//   19 #include "HAL_RTC.h"
//   20 
//   21 /*
//   22  *******需用到定时中断，请在isr.h中粘贴一下代码:*********
//   23 
//   24 //RTC模块中断服务定义
//   25 #undef  VECTOR_082
//   26 #define VECTOR_082 LPLD_RTC_Isr
//   27 
//   28 //以下函数在LPLD_Kinetis底层包，不必修改
//   29 extern void LPLD_RTC_Isr(void);
//   30 
//   31  ***********************代码结束*************************
//   32 */
//   33 
//   34 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   35 RTC_ISR_CALLBACK RTC_ISR[1];
RTC_ISR:
        DS8 4
//   36 
//   37 
//   38 /*
//   39  * LPLD_RTC_Init
//   40  * RTC通用初始化函数
//   41  * 
//   42  * 参数:
//   43  *    seconds--设置计数器起始值
//   44  *      |__如果计数器设置为0，在不复位的情况下可计数2的32次方秒，约136年
//   45  *    alarm--设置报警值，
//   46  *      |__当报警值等于RTC_TSR，设置TAF标志位，可触发中断
//   47  *    rtc_irqc--中断模式
//   48  *      |__RTC_INT_DIS        -关闭RTC中断
//   49  *      |__RTC_INT_INVALID    -开启RTC 无效数据 标志位中断
//   50  *      |__RTC_INT_OVERFLOW   -开启RTC 计数器溢出 标志位中断
//   51  *      |__RTC_INT_ALARM      -开启RTC 报警 标志位中断
//   52  *    isr_func--用户中断程序入口地址
//   53  *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
//   54  *
//   55  * 输出:
//   56  *    0--配置错误
//   57  *    1--配置成功
//   58  */
//   59 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   60 uint8 LPLD_RTC_Init(uint32 seconds, uint32 alarm, uint8 rtc_irqc, RTC_ISR_CALLBACK isr_func)
//   61 {
LPLD_RTC_Init:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//   62   int i;
//   63   
//   64   SIM_SCGC6 |= SIM_SCGC6_RTC_MASK;
        LDR.N    R0,??DataTable5  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x20000000
        LDR.N    R1,??DataTable5  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   65   //复位所有RTC寄存器 除了SWR位 RTC_WAR和RTC_RAR寄存器
//   66   //清除SWR位在VBAT POR设置之后或者软件复位
//   67   //复位RTC寄存器
//   68   RTC_CR  = RTC_CR_SWR_MASK; 
        LDR.N    R0,??DataTable5_1  ;; 0x4003d010
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//   69   //清除RTC复位标志   
//   70   RTC_CR  &= ~RTC_CR_SWR_MASK;  
        LDR.N    R0,??DataTable5_1  ;; 0x4003d010
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable5_1  ;; 0x4003d010
        STR      R0,[R1, #+0]
//   71   //使能RTC 32.768 kHzRTC时钟源
//   72   //使能之后要延时一段时间等待
//   73   //等待时钟稳定后在配置RTC时钟计数器.
//   74   RTC_CR |= RTC_CR_OSCE_MASK;
        LDR.N    R0,??DataTable5_1  ;; 0x4003d010
        LDR      R0,[R0, #+0]
        MOV      R1,#+256
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable5_1  ;; 0x4003d010
        STR      R0,[R1, #+0]
//   75   
//   76   //等待32.768时钟起振
//   77   for(i=0;i<0x600000;i++);
        MOVS     R0,#+0
        B.N      ??LPLD_RTC_Init_0
??LPLD_RTC_Init_1:
        ADDS     R0,R0,#+1
??LPLD_RTC_Init_0:
        CMP      R0,#+6291456
        BLT.N    ??LPLD_RTC_Init_1
//   78   
//   79   if(rtc_irqc)
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??LPLD_RTC_Init_2
//   80   {
//   81     RTC_IER = (rtc_irqc & 0x07);
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        ANDS     R0,R2,#0x7
        LDR.N    R1,??DataTable5_2  ;; 0x4003d01c
        STR      R0,[R1, #+0]
//   82     
//   83     RTC_ISR[0]=isr_func;
        LDR.N    R0,??DataTable5_3
        STR      R3,[R0, #+0]
//   84     
//   85     enable_irq(66);//开启RTC中断
        MOVS     R0,#+66
        BL       enable_irq
//   86   }
//   87   //设置时钟补偿寄存器
//   88   RTC_TCR = RTC_TCR_CIR(0) | RTC_TCR_TCR(0);
??LPLD_RTC_Init_2:
        LDR.N    R0,??DataTable5_4  ;; 0x4003d00c
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//   89   
//   90   //配置秒计数器
//   91   RTC_TSR = seconds;
        LDR.N    R0,??DataTable5_5  ;; 0x4003d000
        STR      R4,[R0, #+0]
//   92     
//   93   //配置闹铃  
//   94   RTC_TAR = alarm;
        LDR.N    R0,??DataTable5_6  ;; 0x4003d008
        STR      R5,[R0, #+0]
//   95   
//   96   //使能秒计数器
//   97   RTC_SR |= RTC_SR_TCE_MASK;
        LDR.N    R0,??DataTable5_7  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable5_7  ;; 0x4003d014
        STR      R0,[R1, #+0]
//   98   
//   99   return 1;
        MOVS     R0,#+1
        POP      {R1,R4,R5,PC}    ;; return
//  100 }
//  101 
//  102 /*
//  103  * LPLD_Get_RealTime
//  104  * 获得RTC秒计数器的值
//  105  * 
//  106  * 输出
//  107  *   秒累加的总和
//  108  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  109 uint32 LPLD_RTC_GetRealTime(void)
//  110 {
//  111   return RTC_TSR;//获得当前的秒累加的总和
LPLD_RTC_GetRealTime:
        LDR.N    R0,??DataTable5_5  ;; 0x4003d000
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
//  112 }
//  113 
//  114 /*
//  115  * LPLD_RTC_Stop
//  116  * 关闭RTC函数
//  117  * 
//  118  * 输出
//  119  *   无
//  120  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  121 void LPLD_RTC_Stop(void)
//  122 {
//  123   RTC_SR &= (~RTC_SR_TCE_MASK);
LPLD_RTC_Stop:
        LDR.N    R0,??DataTable5_7  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x10
        LDR.N    R1,??DataTable5_7  ;; 0x4003d014
        STR      R0,[R1, #+0]
//  124 }
        BX       LR               ;; return
//  125 
//  126 /*
//  127  * LPLD_RTC_Alarm
//  128  * RTC重新设置报警寄存器
//  129  * 
//  130  * 参数:
//  131  *    data--设置报警的时间，单位：秒
//  132  * 
//  133  * 输出
//  134  *   无
//  135  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  136 void LPLD_RTC_Alarm(uint32 data)
//  137 {
//  138   RTC_TAR = data;
LPLD_RTC_Alarm:
        LDR.N    R1,??DataTable5_6  ;; 0x4003d008
        STR      R0,[R1, #+0]
//  139 }
        BX       LR               ;; return
//  140 
//  141 /*
//  142  * LPLD_RTC_Alarm
//  143  * RTC重新设置秒计数器
//  144  * 
//  145  * 参数:
//  146  *    data--设置报警的时间，单位：秒
//  147  * 
//  148  * 输出
//  149  *   无
//  150  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  151 void LPLD_RTC_Seconds(uint32 data)
//  152 {
//  153   RTC_TSR = data;
LPLD_RTC_Seconds:
        LDR.N    R1,??DataTable5_5  ;; 0x4003d000
        STR      R0,[R1, #+0]
//  154 }
        BX       LR               ;; return
//  155 
//  156 /*
//  157  * LPLD_RTC_Isr
//  158  * RTC通用中断底层入口函数
//  159  * 
//  160  * 用户无需修改，程序自动进入对应通道中断函数
//  161  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  162 void LPLD_RTC_Isr(void)
//  163 { 
LPLD_RTC_Isr:
        PUSH     {R7,LR}
//  164   if((RTC_SR & RTC_SR_TIF_MASK)== 0x01)
        LDR.N    R0,??DataTable5_7  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??LPLD_RTC_Isr_0
//  165   {
//  166     //调用用户自定义中断服务
//  167     RTC_ISR[0](); 
        LDR.N    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        BLX      R0
//  168     //清除中断标志位
//  169     RTC_SR |= RTC_SR_TIF_MASK;
        LDR.N    R0,??DataTable5_7  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable5_7  ;; 0x4003d014
        STR      R0,[R1, #+0]
        B.N      ??LPLD_RTC_Isr_1
//  170     
//  171   }	
//  172   else if((RTC_SR & RTC_SR_TOF_MASK) == 0x02)
??LPLD_RTC_Isr_0:
        LDR.N    R0,??DataTable5_7  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??LPLD_RTC_Isr_2
//  173   {
//  174     //调用用户自定义中断服务
//  175     RTC_ISR[0]();  
        LDR.N    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        BLX      R0
//  176     //清除中断标志位
//  177     RTC_SR |= RTC_SR_TOF_MASK;
        LDR.N    R0,??DataTable5_7  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable5_7  ;; 0x4003d014
        STR      R0,[R1, #+0]
        B.N      ??LPLD_RTC_Isr_1
//  178   }	 	
//  179   else if((RTC_SR & RTC_SR_TAF_MASK) == 0x04)
??LPLD_RTC_Isr_2:
        LDR.N    R0,??DataTable5_7  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??LPLD_RTC_Isr_1
//  180   {
//  181     //调用用户自定义中断服务
//  182     RTC_ISR[0]();  
        LDR.N    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        BLX      R0
//  183     //清除中断标志位
//  184     RTC_SR |= RTC_SR_TAF_MASK;
        LDR.N    R0,??DataTable5_7  ;; 0x4003d014
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.N    R1,??DataTable5_7  ;; 0x4003d014
        STR      R0,[R1, #+0]
//  185   }	
//  186 }
??LPLD_RTC_Isr_1:
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_1:
        DC32     0x4003d010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_2:
        DC32     0x4003d01c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_3:
        DC32     RTC_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_4:
        DC32     0x4003d00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_5:
        DC32     0x4003d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_6:
        DC32     0x4003d008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5_7:
        DC32     0x4003d014

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
// 268 bytes in section .text
// 
// 268 bytes of CODE memory
//   4 bytes of DATA memory
//
//Errors: none
//Warnings: none
