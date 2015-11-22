///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:57 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\HAL_PIT.c                 /
//    Command line =  "F:\robot _init\robot\lib\LPLD\HAL_PIT.c" -D IAR -D     /
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
//                    st\HAL_PIT.s                                            /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_PIT

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed
        EXTERN disable_irq
        EXTERN enable_irq
        EXTERN periph_clk_khz

        PUBLIC LPLD_PIT_ClearIsr
        PUBLIC LPLD_PIT_Init
        PUBLIC LPLD_PIT_Isr
        PUBLIC LPLD_PIT_SetIsr
        PUBLIC PIT_ISR

// F:\robot _init\robot\lib\LPLD\HAL_PIT.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_PIT.c
//   10  * 用途: PIT底层模块相关函数
//   11  * 最后修改日期: 20120321
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17  */
//   18 
//   19 /*
//   20  *******需用到定时中断，请在isr.h中粘贴一下代码:*********
//   21 
//   22 //PIT模块中断服务定义
//   23 #undef  VECTOR_084
//   24 #define VECTOR_084 LPLD_PIT_Isr
//   25 #undef  VECTOR_085
//   26 #define VECTOR_085 LPLD_PIT_Isr
//   27 #undef  VECTOR_086
//   28 #define VECTOR_086 LPLD_PIT_Isr
//   29 #undef  VECTOR_087
//   30 #define VECTOR_087 LPLD_PIT_Isr
//   31 //以下函数在LPLD_Kinetis底层包，不必修改
//   32 extern void LPLD_PIT_Isr(void);
//   33 
//   34  ***********************代码结束*************************
//   35 */
//   36 
//   37 #include "common.h"
//   38 #include "HAL_PIT.h"
//   39 
//   40 
//   41 //引用总线时钟频率，该值在sysinit.c文件中取得
//   42 extern int periph_clk_khz;
//   43 
//   44 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   45 PIT_ISR_CALLBACK PIT_ISR[4];
PIT_ISR:
        DS8 16
//   46 
//   47 /*
//   48  * LPLD_PIT_Init
//   49  * PIT通用初始化函数
//   50  * 
//   51  * 参数:
//   52  *    pitx--PIT模块号
//   53  *      |__PIT0        --周期中断定时器0
//   54  *      |__PIT1        --周期中断定时器0
//   55  *      |__PIT2        --周期中断定时器0
//   56  *      |__PIT3        --周期中断定时器0
//   57  *    period_us--中断周期
//   58  *      |__单位为微妙
//   59  *    isr_func--用户中断程序入口地址
//   60  *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
//   61  *
//   62  * 输出:
//   63  *    0--配置错误
//   64  *    1--配置成功
//   65  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   66 uint8 LPLD_PIT_Init(PITx pitx, uint32 period_us, PIT_ISR_CALLBACK isr_func)
//   67 { 
LPLD_PIT_Init:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R6,R1
        MOVS     R5,R2
//   68   uint32 ldval;
//   69   uint32 periph_clk_mhz;
//   70   
//   71   //参数检查
//   72   ASSERT( pitx <= PIT3);                  //判断模块号
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BCC.N    ??LPLD_PIT_Init_0
        MOVS     R1,#+72
        LDR.N    R0,??DataTable3
        BL       assert_failed
//   73   
//   74   //计算定时加载值
//   75   periph_clk_mhz = periph_clk_khz/1000;
??LPLD_PIT_Init_0:
        LDR.N    R0,??DataTable3_1
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        SDIV     R0,R0,R1
//   76   ldval = period_us*periph_clk_mhz;
        MULS     R6,R0,R6
//   77   
//   78   ASSERT( ldval > 0);                    
        CMP      R6,#+0
        BNE.N    ??LPLD_PIT_Init_1
        MOVS     R1,#+78
        LDR.N    R0,??DataTable3
        BL       assert_failed
//   79   
//   80   //开启定时模块时钟
//   81   SIM_SCGC6 |= SIM_SCGC6_PIT_MASK;
??LPLD_PIT_Init_1:
        LDR.N    R0,??DataTable3_2  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x800000
        LDR.N    R1,??DataTable3_2  ;; 0x4004803c
        STR      R0,[R1, #+0]
//   82   
//   83   // 开启 PIT
//   84   PIT_MCR = 0x00;
        LDR.N    R0,??DataTable3_3  ;; 0x40037000
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//   85  
//   86   if(isr_func!=NULL){
        MOVS     R0,R5
        CMP      R0,#+0
        BEQ.N    ??LPLD_PIT_Init_2
//   87     PIT_ISR[pitx] = isr_func;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable3_4
        STR      R5,[R0, R4, LSL #+2]
//   88     //在NVIC中使能PIT中断
//   89     enable_irq(68+pitx); 
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R4,#+68
        BL       enable_irq
//   90   }
//   91   
//   92   //period = (period_ns/bus_period_ns)-1
//   93   PIT_LDVAL_REG(PIT_BASE_PTR,pitx) = ldval-1;
??LPLD_PIT_Init_2:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+4
        LDR.N    R1,??DataTable3_5  ;; 0x40037100
        SUBS     R2,R6,#+1
        STR      R2,[R0, R1]
//   94   
//   95   //使能中断
//   96   PIT_TCTRL_REG(PIT_BASE_PTR,pitx) = PIT_TCTRL_TIE_MASK;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable3_5  ;; 0x40037100
        ADDS     R0,R0,R4, LSL #+4
        MOVS     R1,#+2
        STR      R1,[R0, #+8]
//   97   //开始定时
//   98   PIT_TCTRL_REG(PIT_BASE_PTR,pitx) |= PIT_TCTRL_TEN_MASK;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable3_5  ;; 0x40037100
        ADDS     R0,R0,R4, LSL #+4
        LDR      R0,[R0, #+8]
        ORRS     R0,R0,#0x1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R1,??DataTable3_5  ;; 0x40037100
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+8]
//   99   
//  100   return 1;
        MOVS     R0,#+1
        POP      {R4-R6,PC}       ;; return
//  101 }
//  102 
//  103 /*
//  104  * LPLD_PIT_SetIsr
//  105  * 设置PIT通道用户定义的中断服务函数，并使能中断
//  106  * 
//  107  * 参数:
//  108  *    pitx--PIT模块号
//  109  *      |__PIT0        --周期中断定时器0
//  110  *      |__PIT1        --周期中断定时器0
//  111  *      |__PIT2        --周期中断定时器0
//  112  *      |__PIT3        --周期中断定时器0
//  113  *    isr_func--用户中断程序入口地址
//  114  *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
//  115  *
//  116  * 输出:
//  117  *    0--配置错误
//  118  *    1--配置成功
//  119  *
//  120  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  121 uint8 LPLD_PIT_SetIsr(PITx pitx, PIT_ISR_CALLBACK isr_func)
//  122 {
LPLD_PIT_SetIsr:
        PUSH     {R7,LR}
//  123   PIT_ISR[pitx] = isr_func;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable3_4
        STR      R1,[R2, R0, LSL #+2]
//  124   enable_irq(68+pitx); 
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R0,R0,#+68
        BL       enable_irq
//  125   
//  126   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  127 }
//  128 
//  129 /*
//  130  * LPLD_PIT_ClearIsr
//  131  * 清除PIT通道用户定义的中断服务函数，并禁用中断
//  132  * 
//  133  * 参数:
//  134  *    pitx--PIT模块号
//  135  *      |__PIT0        --周期中断定时器0
//  136  *      |__PIT1        --周期中断定时器0
//  137  *      |__PIT2        --周期中断定时器0
//  138  *      |__PIT3        --周期中断定时器0
//  139  *
//  140  * 输出:
//  141  *    0--配置错误
//  142  *    1--配置成功
//  143  *
//  144  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  145 uint8 LPLD_PIT_ClearIsr(PITx pitx)
//  146 {
LPLD_PIT_ClearIsr:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  147   disable_irq(68+pitx); 
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R4,#+68
        BL       disable_irq
//  148   PIT_ISR[pitx] = NULL;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable3_4
        MOVS     R1,#+0
        STR      R1,[R0, R4, LSL #+2]
//  149   
//  150   return 1;
        MOVS     R0,#+1
        POP      {R4,PC}          ;; return
//  151 }
//  152 
//  153 
//  154 /*
//  155  * LPLD_PIT_Isr
//  156  * PIT通用中断底层入口函数
//  157  * 
//  158  * 用户无需修改，程序自动进入对应通道中断函数
//  159  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  160 void LPLD_PIT_Isr(void)
//  161 {
LPLD_PIT_Isr:
        PUSH     {R4,LR}
//  162   #define PIT_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
//  163   uint8 pit_ch = PIT_VECTORNUM - 84;
        LDR.N    R0,??DataTable3_6  ;; 0xe000ed04
        LDRB     R0,[R0, #+0]
        SUBS     R4,R0,#+84
//  164     
//  165   //调用用户自定义中断服务
//  166   PIT_ISR[pit_ch]();  
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable3_4
        LDR      R0,[R0, R4, LSL #+2]
        BLX      R0
//  167   //清除中断标志位
//  168   PIT_TFLG_REG(PIT_BASE_PTR,pit_ch) |= PIT_TFLG_TIF_MASK;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable3_5  ;; 0x40037100
        ADDS     R0,R0,R4, LSL #+4
        LDR      R0,[R0, #+12]
        ORRS     R0,R0,#0x1
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R1,??DataTable3_5  ;; 0x40037100
        ADDS     R1,R1,R4, LSL #+4
        STR      R0,[R1, #+12]
//  169 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     `?<Constant "F:\\\\robot _init\\\\robot\\\\...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     periph_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     0x40037000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     PIT_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     0x40037100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     0xe000ed04

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "F:\\\\robot _init\\\\robot\\\\...">`:
        DATA
        DC8 "F:\\robot _init\\robot\\lib\\LPLD\\HAL_PIT.c"

        END
// 
//  16 bytes in section .bss
//  40 bytes in section .rodata
// 264 bytes in section .text
// 
// 264 bytes of CODE  memory
//  40 bytes of CONST memory
//  16 bytes of DATA  memory
//
//Errors: none
//Warnings: none
