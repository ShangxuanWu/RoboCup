///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:49 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\HAL_GPIO.c                /
//    Command line =  "F:\robot _init\robot\lib\LPLD\HAL_GPIO.c" -D IAR -D    /
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
//                    st\HAL_GPIO.s                                           /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_GPIO

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed
        EXTERN disable_irq
        EXTERN enable_irq

        PUBLIC GPIO_ISR
        PUBLIC GPIOx_Ptr
        PUBLIC LPLD_GPIO_ClearIsr
        PUBLIC LPLD_GPIO_Get
        PUBLIC LPLD_GPIO_Get_b
        PUBLIC LPLD_GPIO_Init
        PUBLIC LPLD_GPIO_Isr
        PUBLIC LPLD_GPIO_Set
        PUBLIC LPLD_GPIO_SetIsr
        PUBLIC LPLD_GPIO_Set_b
        PUBLIC LPLD_GPIO_Toggle
        PUBLIC LPLD_GPIO_Toggle_b
        PUBLIC PORTx_Ptr

// F:\robot _init\robot\lib\LPLD\HAL_GPIO.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_GPIO.c
//   10  * 用途: GPIO底层模块相关函数
//   11  * 最后修改日期: 20120321
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17  */
//   18 /*
//   19  *******需用到GPIO中断，请在isr.h中粘贴一下代码:*********
//   20 
//   21 //GPIO模块中断服务定义
//   22 #undef  VECTOR_103
//   23 #define VECTOR_103 LPLD_GPIO_Isr
//   24 #undef  VECTOR_104
//   25 #define VECTOR_104 LPLD_GPIO_Isr
//   26 #undef  VECTOR_105
//   27 #define VECTOR_105 LPLD_GPIO_Isr
//   28 #undef  VECTOR_106
//   29 #define VECTOR_106 LPLD_GPIO_Isr
//   30 #undef  VECTOR_107
//   31 #define VECTOR_107 LPLD_GPIO_Isr
//   32 //以下函数在LPLD_Kinetis底层包，不必修改
//   33 extern void LPLD_GPIO_Isr(void);
//   34 
//   35  ***********************代码结束*************************
//   36 */
//   37 
//   38 #include "common.h"
//   39 #include "HAL_GPIO.h"
//   40 
//   41 
//   42 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   43 GPIO_ISR_CALLBACK GPIO_ISR[5];
GPIO_ISR:
        DS8 20
//   44 //GPIO映射地址数组

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   45 volatile GPIO_MemMapPtr GPIOx_Ptr[5] = {PTA_BASE_PTR, 
GPIOx_Ptr:
        DATA
        DC32 400FF000H, 400FF040H, 400FF080H, 400FF0C0H, 400FF100H
//   46                                         PTB_BASE_PTR, 
//   47                                         PTC_BASE_PTR, 
//   48                                         PTD_BASE_PTR, 
//   49                                         PTE_BASE_PTR};
//   50 //PORT映射地址数组

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   51 volatile PORT_MemMapPtr PORTx_Ptr[5] = {PORTA_BASE_PTR, 
PORTx_Ptr:
        DATA
        DC32 40049000H, 4004A000H, 4004B000H, 4004C000H, 4004D000H
//   52                                         PORTB_BASE_PTR, 
//   53                                         PORTC_BASE_PTR, 
//   54                                         PORTD_BASE_PTR, 
//   55                                         PORTE_BASE_PTR};
//   56 
//   57 /*
//   58  * LPLD_GPIO_Init
//   59  * GPIO通用初始化函数
//   60  * 
//   61  * 参数:
//   62  *    ptx--端口号
//   63  *      |__PTA        --Port A
//   64  *      |__PTB        --Port B
//   65  *      |__PTC        --Port C
//   66  *      |__PTD        --Port D
//   67  *      |__PTE        --Port E
//   68  *    port_bit--端口位数
//   69  *      |__0~31
//   70  *    dir--端口数据方向
//   71  *      |__DIR_INPUT  --输入
//   72  *      |__DIR_OUTPUT --输出
//   73  *    data1--输出初始电平/输入上拉或下拉
//   74  *      |__INPUT_PDOWN--如果dir=DIR_INPUT,输入内部下拉
//   75  *      |__INPUT_PUP  --如果dir=DIR_INPUT,输入内部上拉
//   76  *      |__OUTPUT_L   --如果dir=DIR_OUTPUT,输出低电平
//   77  *      |__OUTPUT_H   --如果dir=DIR_OUTPUT,输出高电平
//   78  *    irqc--输入中断
//   79  *      |__IRQC_DIS   --不使能中断
//   80  *      |__IRQC_DMARI --上升沿触发DMA
//   81  *      |__IRQC_DMAFA --下降沿触发DMA
//   82  *      |__IRQC_DMAET --上升/下降沿触发DMA
//   83  *      |__IRQC_L     --逻辑低触发中断
//   84  *      |__IRQC_RI    --上升沿触发中断
//   85  *      |__IRQC_FA    --下降沿触发中断
//   86  *      |__IRQC_ET    --上升/下降沿触发中断
//   87  *      |__IRQC_H     --逻辑高触发中断
//   88  *
//   89  * 输出:
//   90  *    0--配置错误
//   91  *    1--配置成功
//   92  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   93 uint8 LPLD_GPIO_Init(PTx ptx, uint8 port_bit, uint8 dir, uint8 data1, uint8 irqc)
//   94 {
LPLD_GPIO_Init:
        PUSH     {R3-R9,LR}
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R7,R3
//   95   GPIO_MemMapPtr gpio_ptr = GPIOx_Ptr[ptx];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable9
        LDR      R8,[R1, R0, LSL #+2]
//   96   PORT_MemMapPtr port_ptr = PORTx_Ptr[ptx];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable9_1
        LDR      R9,[R1, R0, LSL #+2]
//   97   
//   98   //参数检查
//   99   ASSERT( ptx <= PTE);                  //判断端口
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+5
        BCC.N    ??LPLD_GPIO_Init_0
        MOVS     R1,#+99
        LDR.N    R0,??DataTable9_2
        BL       assert_failed
//  100   ASSERT( port_bit <= 31 );             //判断端口位数
??LPLD_GPIO_Init_0:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+32
        BCC.N    ??LPLD_GPIO_Init_1
        MOVS     R1,#+100
        LDR.N    R0,??DataTable9_2
        BL       assert_failed
//  101   ASSERT( dir <= 1 );                   //判断方向
??LPLD_GPIO_Init_1:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+2
        BCC.N    ??LPLD_GPIO_Init_2
        MOVS     R1,#+101
        LDR.N    R0,??DataTable9_2
        BL       assert_failed
//  102   ASSERT( data1 <= 1 );                 //判断输出初始电平/输入上拉或下拉
??LPLD_GPIO_Init_2:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+2
        BCC.N    ??LPLD_GPIO_Init_3
        MOVS     R1,#+102
        LDR.N    R0,??DataTable9_2
        BL       assert_failed
??LPLD_GPIO_Init_3:
        LDR      R4,[SP, #+32]
//  103   ASSERT( irqc <= IRQC_H);              //判断端中断配置
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+13
        BCC.N    ??LPLD_GPIO_Init_4
        MOVS     R1,#+103
        LDR.N    R0,??DataTable9_2
        BL       assert_failed
//  104 
//  105   //配置为GPIO功能
//  106   PORT_PCR_REG(port_ptr, port_bit) = PORT_PCR_MUX(1);
??LPLD_GPIO_Init_4:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        MOV      R0,#+256
        STR      R0,[R9, R5, LSL #+2]
//  107   
//  108   //输入或输出设置
//  109   if(dir==DIR_OUTPUT)
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+1
        BNE.N    ??LPLD_GPIO_Init_5
//  110   {
//  111     GPIO_PDDR_REG(gpio_ptr) |= 0x1u<<port_bit;
        LDR      R0,[R8, #+20]
        MOVS     R1,#+1
        LSLS     R1,R1,R5
        ORRS     R0,R1,R0
        STR      R0,[R8, #+20]
//  112     //设置初始输出
//  113     if(data1==OUTPUT_H)
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+1
        BNE.N    ??LPLD_GPIO_Init_6
//  114     {
//  115       GPIO_PSOR_REG(gpio_ptr) = 0x1u<<port_bit; 
        MOVS     R0,#+1
        LSLS     R0,R0,R5
        STR      R0,[R8, #+4]
        B.N      ??LPLD_GPIO_Init_7
//  116     }
//  117     else
//  118     {
//  119       GPIO_PCOR_REG(gpio_ptr) = 0x1u<<port_bit;  
??LPLD_GPIO_Init_6:
        MOVS     R0,#+1
        LSLS     R0,R0,R5
        STR      R0,[R8, #+8]
        B.N      ??LPLD_GPIO_Init_7
//  120     }
//  121   }
//  122   else
//  123   { 
//  124     GPIO_PDDR_REG(gpio_ptr) &= ~(0x1u<<port_bit);
??LPLD_GPIO_Init_5:
        LDR      R0,[R8, #+20]
        MOVS     R1,#+1
        LSLS     R1,R1,R5
        BICS     R0,R0,R1
        STR      R0,[R8, #+20]
//  125     PORT_PCR_REG(port_ptr, port_bit) |= PORT_PCR_IRQC(irqc); 
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R9, R5, LSL #+2]
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R1,R4,#+16
        ANDS     R1,R1,#0xF0000
        ORRS     R0,R1,R0
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        STR      R0,[R9, R5, LSL #+2]
//  126     //配置内部上拉或下拉或不使能
//  127     if(data1==INPUT_PUP)
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+1
        BNE.N    ??LPLD_GPIO_Init_8
//  128     {
//  129       //上拉
//  130       PORT_PCR_REG(port_ptr, port_bit) |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK ; 
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R9, R5, LSL #+2]
        ORRS     R0,R0,#0x3
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        STR      R0,[R9, R5, LSL #+2]
        B.N      ??LPLD_GPIO_Init_7
//  131     }
//  132     else if(data1==INPUT_PDOWN)
??LPLD_GPIO_Init_8:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??LPLD_GPIO_Init_9
//  133     {
//  134       //下拉
//  135       PORT_PCR_REG(port_ptr, port_bit) |= PORT_PCR_PE_MASK ; 
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R9, R5, LSL #+2]
        ORRS     R0,R0,#0x2
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        STR      R0,[R9, R5, LSL #+2]
        B.N      ??LPLD_GPIO_Init_7
//  136     }
//  137     else
//  138     {
//  139       //不使能上下拉
//  140       PORT_PCR_REG(port_ptr, port_bit) &= ~PORT_PCR_PE_MASK ; 
??LPLD_GPIO_Init_9:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        LDR      R0,[R9, R5, LSL #+2]
        BICS     R0,R0,#0x2
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        STR      R0,[R9, R5, LSL #+2]
//  141     }
//  142  
//  143   }
//  144   
//  145   return 1;
??LPLD_GPIO_Init_7:
        MOVS     R0,#+1
        POP      {R1,R4-R9,PC}    ;; return
//  146 }
//  147 
//  148 /*
//  149  * LPLD_GPIO_SetIsr
//  150  * 设置GPIO通道用户定义的中断服务函数，并使能中断
//  151  * 
//  152  * 参数:
//  153  *    ptx--端口号
//  154  *      |__PTA        --Port A
//  155  *      |__PTB        --Port B
//  156  *      |__PTC        --Port C
//  157  *      |__PTD        --Port D
//  158  *      |__PTE        --Port E
//  159  *    isr_func--用户中断程序入口地址
//  160  *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
//  161  *
//  162  * 输出:
//  163  *    0--配置错误
//  164  *    1--配置成功
//  165  *
//  166  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  167 uint8 LPLD_GPIO_SetIsr(PTx ptx, GPIO_ISR_CALLBACK isr_func)
//  168 {
LPLD_GPIO_SetIsr:
        PUSH     {R7,LR}
//  169   GPIO_ISR[ptx] = isr_func;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable9_3
        STR      R1,[R2, R0, LSL #+2]
//  170   enable_irq(ptx + 87);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R0,R0,#+87
        BL       enable_irq
//  171   
//  172   return 1;
        MOVS     R0,#+1
        POP      {R1,PC}          ;; return
//  173 }
//  174 
//  175 /*
//  176  * LPLD_GPIO_ClearIsr
//  177  * 清除GPIO通道用户定义的中断服务函数，并禁用中断
//  178  * 
//  179  * 参数:
//  180  *    ptx--端口号
//  181  *      |__PTA        --Port A
//  182  *      |__PTB        --Port B
//  183  *      |__PTC        --Port C
//  184  *      |__PTD        --Port D
//  185  *      |__PTE        --Port E
//  186  *
//  187  * 输出:
//  188  *    0--配置错误
//  189  *    1--配置成功
//  190  *
//  191  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  192 uint8 LPLD_GPIO_ClearIsr(PTx ptx)
//  193 {
LPLD_GPIO_ClearIsr:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  194   disable_irq(ptx + 87);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        ADDS     R0,R4,#+87
        BL       disable_irq
//  195   GPIO_ISR[ptx] = NULL;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable9_3
        MOVS     R1,#+0
        STR      R1,[R0, R4, LSL #+2]
//  196   
//  197   return 1;
        MOVS     R0,#+1
        POP      {R4,PC}          ;; return
//  198 }
//  199 
//  200 /*
//  201  * LPLD_GPIO_Set
//  202  * 设置GPIO端口0~31位输出
//  203  * 
//  204  * 参数:
//  205  *    ptx--端口号
//  206  *      |__PTA        --Port A
//  207  *      |__PTB        --Port B
//  208  *      |__PTC        --Port C
//  209  *      |__PTD        --Port D
//  210  *      |__PTE        --Port E
//  211  *    data32--输出数据
//  212  *      |__0x00000000~0xFFFFFFFF--低到高代表GPIO口的第0~31位数据
//  213  *
//  214  * 输出:
//  215  *
//  216  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  217 void LPLD_GPIO_Set(PTx ptx, uint32 data32)
//  218 { 
//  219   GPIO_PDOR_REG(GPIOx_Ptr[ptx]) = data32;
LPLD_GPIO_Set:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable9
        LDR      R0,[R2, R0, LSL #+2]
        STR      R1,[R0, #+0]
//  220 }
        BX       LR               ;; return
//  221 
//  222 /*
//  223  * LPLD_GPIO_Set_b
//  224  * 设置GPIO端口一位的输出
//  225  * 
//  226  * 参数:
//  227  *    ptx--端口号
//  228  *      |__PTA        --Port A
//  229  *      |__PTB        --Port B
//  230  *      |__PTC        --Port C
//  231  *      |__PTD        --Port D
//  232  *      |__PTE        --Port E
//  233  *    port_bit--位数
//  234  *      |__0~31       --GPIO口的第0~31位
//  235  *    data1--输出数据
//  236  *      |__OUTPUT_L   --输出低电平
//  237  *      |__OUTPUT_H   --输出高电平
//  238  *
//  239  * 输出:
//  240  *
//  241  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  242 void LPLD_GPIO_Set_b(PTx ptx, uint8 port_bit, uint8 data1)
//  243 {
//  244   if(data1==OUTPUT_L)
LPLD_GPIO_Set_b:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??LPLD_GPIO_Set_b_0
//  245     GPIO_PCOR_REG(GPIOx_Ptr[ptx]) = 0x1u<<port_bit;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable9
        LDR      R0,[R2, R0, LSL #+2]
        MOVS     R2,#+1
        LSLS     R1,R2,R1
        STR      R1,[R0, #+8]
        B.N      ??LPLD_GPIO_Set_b_1
//  246   else
//  247     GPIO_PSOR_REG(GPIOx_Ptr[ptx]) = 0x1u<<port_bit;
??LPLD_GPIO_Set_b_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable9
        LDR      R0,[R2, R0, LSL #+2]
        MOVS     R2,#+1
        LSLS     R1,R2,R1
        STR      R1,[R0, #+4]
//  248 }
??LPLD_GPIO_Set_b_1:
        BX       LR               ;; return
//  249 
//  250 /*
//  251  * LPLD_GPIO_Toggle
//  252  * 设置GPIO端口0~31的电平翻转
//  253  * 
//  254  * 参数:
//  255  *    ptx--端口号
//  256  *      |__PTA        --Port A
//  257  *      |__PTB        --Port B
//  258  *      |__PTC        --Port C
//  259  *      |__PTD        --Port D
//  260  *      |__PTE        --Port E
//  261  *    data32--翻转数据
//  262  *      |__0x00000000~0xFFFFFFFF--低到高代表GPIO口的第0~31位的翻转，1为反转，0为保持不变。
//  263  *
//  264  * 输出:
//  265  *
//  266  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  267 void LPLD_GPIO_Toggle(PTx ptx, uint32 data32)
//  268 {
//  269   GPIO_PTOR_REG(GPIOx_Ptr[ptx]) = data32;
LPLD_GPIO_Toggle:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable9
        LDR      R0,[R2, R0, LSL #+2]
        STR      R1,[R0, #+12]
//  270 }
        BX       LR               ;; return
//  271 
//  272 /*
//  273  * LPLD_GPIO_Toggle_b
//  274  * 设置GPIO端口一位的翻转
//  275  * 
//  276  * 参数:
//  277  *    ptx--端口号
//  278  *      |__PTA        --Port A
//  279  *      |__PTB        --Port B
//  280  *      |__PTC        --Port C
//  281  *      |__PTD        --Port D
//  282  *      |__PTE        --Port E
//  283  *    port_bit--位数
//  284  *      |__0~31       --设置GPIO口的一位翻转
//  285  *
//  286  * 输出:
//  287  *
//  288  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  289 void LPLD_GPIO_Toggle_b(PTx ptx, uint8 port_bit)
//  290 {
//  291   GPIO_PTOR_REG(GPIOx_Ptr[ptx]) = 0x1u<<port_bit;
LPLD_GPIO_Toggle_b:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable9
        LDR      R0,[R2, R0, LSL #+2]
        MOVS     R2,#+1
        LSLS     R1,R2,R1
        STR      R1,[R0, #+12]
//  292 }
        BX       LR               ;; return
//  293 
//  294 /*
//  295  * LPLD_GPIO_Get
//  296  * 取得GPIO口的数据
//  297  * 
//  298  * 参数:
//  299  *    ptx--端口号
//  300  *      |__PTA        --Port A
//  301  *      |__PTB        --Port B
//  302  *      |__PTC        --Port C
//  303  *      |__PTD        --Port D
//  304  *      |__PTE        --Port E
//  305  *
//  306  * 输出:
//  307  *    指定GPIO口的32位输入
//  308  *
//  309  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  310 uint32 LPLD_GPIO_Get(PTx ptx)
//  311 {
//  312   return GPIO_PDIR_REG(GPIOx_Ptr[ptx]);
LPLD_GPIO_Get:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable9
        LDR      R0,[R1, R0, LSL #+2]
        LDR      R0,[R0, #+16]
        BX       LR               ;; return
//  313 }
//  314 
//  315 /*
//  316  * LPLD_GPIO_Get_b
//  317  * 取得GPIO口某一位的数据
//  318  * 
//  319  * 参数:
//  320  *    ptx--端口号
//  321  *      |__PTA        --Port A
//  322  *      |__PTB        --Port B
//  323  *      |__PTC        --Port C
//  324  *      |__PTD        --Port D
//  325  *      |__PTE        --Port E
//  326  *    port_bit--位数
//  327  *      |__0~31--GPIO口的第0~31位
//  328  *
//  329  * 输出:
//  330  *    指定GPIO口的指定位数的电平
//  331  *
//  332  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  333 uint8 LPLD_GPIO_Get_b(PTx ptx, uint8 port_bit)
//  334 {
//  335   return (GPIO_PDIR_REG(GPIOx_Ptr[ptx])>>port_bit)&0x1u;
LPLD_GPIO_Get_b:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable9
        LDR      R0,[R2, R0, LSL #+2]
        LDR      R0,[R0, #+16]
        LSRS     R0,R0,R1
        ANDS     R0,R0,#0x1
        BX       LR               ;; return
//  336 }
//  337 
//  338 /*
//  339  * LPLD_GPIO_Isr
//  340  * GPIO通用中断底层入口函数
//  341  * 
//  342  * 用户无需修改，程序自动进入对应通道中断函数
//  343  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  344 void LPLD_GPIO_Isr(void)
//  345 {
LPLD_GPIO_Isr:
        PUSH     {R4,LR}
//  346   #define GPIO_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
//  347   uint8 gpio_port = GPIO_VECTORNUM - 103;
        LDR.N    R0,??DataTable9_4  ;; 0xe000ed04
        LDRB     R0,[R0, #+0]
        SUBS     R4,R0,#+103
//  348     
//  349   //调用用户自定义中断服务
//  350   GPIO_ISR[gpio_port]();  
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable9_3
        LDR      R0,[R0, R4, LSL #+2]
        BLX      R0
//  351   
//  352   //清除中断标志位
//  353   PORT_ISFR_REG((PORT_MemMapPtr)((0x40049+gpio_port)<<12))=0xFFFFFFFF;
        LDR.N    R0,??DataTable9_5  ;; 0x40049
        UXTAB    R0,R0,R4
        LSLS     R0,R0,#+12
        MOVS     R1,#-1
        STR      R1,[R0, #+160]
//  354 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     GPIOx_Ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     PORTx_Ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_2:
        DC32     `?<Constant "F:\\\\robot _init\\\\robot\\\\...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_3:
        DC32     GPIO_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_4:
        DC32     0xe000ed04

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_5:
        DC32     0x40049

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
        DC8 "F:\\robot _init\\robot\\lib\\LPLD\\HAL_GPIO.c"
        DC8 0, 0, 0

        END
// 
//  20 bytes in section .bss
//  40 bytes in section .data
//  44 bytes in section .rodata
// 486 bytes in section .text
// 
// 486 bytes of CODE  memory
//  44 bytes of CONST memory
//  60 bytes of DATA  memory
//
//Errors: none
//Warnings: none
