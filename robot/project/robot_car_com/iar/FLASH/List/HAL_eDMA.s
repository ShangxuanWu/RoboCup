///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:14:00 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\HAL_eDMA.c                /
//    Command line =  "F:\robot _init\robot\lib\LPLD\HAL_eDMA.c" -D IAR -D    /
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
//                    st\HAL_eDMA.s                                           /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_eDMA

        #define SHT_PROGBITS 0x1

        EXTERN enable_irq

        PUBLIC DMA_ISR
        PUBLIC LPLD_DMA_EnableReq
        PUBLIC LPLD_DMA_Init
        PUBLIC LPLD_DMA_Isr
        PUBLIC LPLD_DMA_Reload

// F:\robot _init\robot\lib\LPLD\HAL_eDMA.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: HAL_eDAM.c
//   10  * 用途: eDMA底层模块相关函数
//   11  * 最后修改日期: 20120321
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17 */
//   18 /*
//   19  *******需用到DMA中断，请在isr.h中粘贴一下代码:*********
//   20 
//   21 //DMA模块中断服务定义
//   22 #undef  VECTOR_016
//   23 #define VECTOR_016 LPLD_DMA_Isr
//   24 #undef  VECTOR_017
//   25 #define VECTOR_017 LPLD_DMA_Isr
//   26 #undef  VECTOR_018
//   27 #define VECTOR_018 LPLD_DMA_Isr
//   28 #undef  VECTOR_019
//   29 #define VECTOR_019 LPLD_DMA_Isr
//   30 #undef  VECTOR_020
//   31 #define VECTOR_020 LPLD_DMA_Isr
//   32 #undef  VECTOR_021
//   33 #define VECTOR_021 LPLD_DMA_Isr
//   34 #undef  VECTOR_022
//   35 #define VECTOR_022 LPLD_DMA_Isr
//   36 #undef  VECTOR_023
//   37 #define VECTOR_023 LPLD_DMA_Isr
//   38 #undef  VECTOR_024
//   39 #define VECTOR_024 LPLD_DMA_Isr
//   40 #undef  VECTOR_025
//   41 #define VECTOR_025 LPLD_DMA_Isr
//   42 #undef  VECTOR_026
//   43 #define VECTOR_026 LPLD_DMA_Isr
//   44 #undef  VECTOR_027
//   45 #define VECTOR_027 LPLD_DMA_Isr
//   46 #undef  VECTOR_028
//   47 #define VECTOR_028 LPLD_DMA_Isr
//   48 #undef  VECTOR_029
//   49 #define VECTOR_029 LPLD_DMA_Isr
//   50 #undef  VECTOR_030
//   51 #define VECTOR_030 LPLD_DMA_Isr
//   52 #undef  VECTOR_031
//   53 #define VECTOR_031 LPLD_DMA_Isr
//   54 #undef  VECTOR_032
//   55 #define VECTOR_032 LPLD_DMA_Isr
//   56 //以下函数在LPLD_Kinetis底层包，不必修改
//   57 extern void LPLD_DMA_Isr(void);
//   58 
//   59  ***********************代码结束*************************
//   60 */
//   61 
//   62 #include "common.h"
//   63 #include "HAL_eDMA.h"
//   64 
//   65 //内部函数
//   66 static uint8 LPLD_eDMA_Config(LPLD_eDMA_Cfg_t*);
//   67 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   68 DMA_ISR_CALLBACK DMA_ISR[16];
DMA_ISR:
        DS8 64
//   69 
//   70 /*
//   71  * LPLD_DMA_Init
//   72  * DMA模块通用初始化函数--用于源地址到目的地址之间的数据直接传输（不用通过CPU）
//   73  * 详细参数在LPLD_eDMA_Cfg_t 结构体中定义（在HAL_eDMA.h）头文件中定义
//   74  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   75 uint8 LPLD_DMA_Init(LPLD_eDMA_Cfg_t *DMA_Config)
//   76 { 
LPLD_DMA_Init:
        PUSH     {R4,LR}
        MOVS     R4,R0
//   77     //如果用户没有设置 每一次传输字节的个数 默认为每次传输一个字节
//   78     if(DMA_Config->Trans_bytesNum  == NULL)
        LDR      R0,[R4, #+4]
        CMP      R0,#+0
        BNE.N    ??LPLD_DMA_Init_0
//   79     {
//   80        DMA_Config->Trans_bytesNum =1;
        MOVS     R0,#+1
        STR      R0,[R4, #+4]
//   81     }
//   82     
//   83     //如果用户没有设置 源地址增加 默认为执行一次DMA请求后源地址不增加
//   84     if(DMA_Config->Source_Addr_inc == NULL)
??LPLD_DMA_Init_0:
        LDRB     R0,[R4, #+13]
        CMP      R0,#+0
        BNE.N    ??LPLD_DMA_Init_1
//   85     {
//   86        DMA_Config->Source_Addr_inc  =ADDR_HOLD;       //源地址不增加
        MOVS     R0,#+0
        STRB     R0,[R4, #+13]
//   87     }
//   88     //如果用户没有设置 源数据长度 默认为8位数据长度
//   89     if(DMA_Config->Source_Size ==NULL)
??LPLD_DMA_Init_1:
        LDRB     R0,[R4, #+12]
        CMP      R0,#+0
        BNE.N    ??LPLD_DMA_Init_2
//   90     {
//   91        DMA_Config->Source_Size       =DMA_SRC_8BIT;    //源数据宽度8bit 一个字节
        MOVS     R0,#+0
        STRB     R0,[R4, #+12]
//   92     } 
//   93     //如果用户没有设置 主循环计数器完成以后 源地址是否调整 默认为设置为源地址不调整
//   94     if(DMA_Config->Source_Adj_Addr ==NULL)
??LPLD_DMA_Init_2:
        LDR      R0,[R4, #+16]
        CMP      R0,#+0
        BNE.N    ??LPLD_DMA_Init_3
//   95     {
//   96         DMA_Config->Source_Adj_Addr  =0;    
        MOVS     R0,#+0
        STR      R0,[R4, #+16]
//   97     }
//   98     
//   99     //如果用户没有设置 目的地址增加 默认为执行一次DMA请求后目的地址加一
//  100     if(DMA_Config->Dest_Addr_inc ==NULL)
??LPLD_DMA_Init_3:
        LDRB     R0,[R4, #+25]
        CMP      R0,#+0
        BNE.N    ??LPLD_DMA_Init_4
//  101     {
//  102         DMA_Config->Dest_Addr_inc     =ADDR_INCREASE;    //针对目的地址的操作执行完毕后加1
        MOVS     R0,#+1
        STRB     R0,[R4, #+25]
//  103     } 
//  104     //如果用户没有设置 源数据长度 默认为8位数据长度
//  105     if(DMA_Config->Dest_Size ==NULL)
??LPLD_DMA_Init_4:
        LDRB     R0,[R4, #+24]
        CMP      R0,#+0
        BNE.N    ??LPLD_DMA_Init_5
//  106     {
//  107         DMA_Config->Dest_Size         =DMA_DST_8BIT;     //目的数据宽度8bit 一个字节
        MOVS     R0,#+0
        STRB     R0,[R4, #+24]
//  108     } 
//  109     //如果用户没有设置 主循环计数器完成以后 目的地址是否调整 默认为设置为目的地址不调整
//  110     if(DMA_Config->Dest_Adj_Addr ==NULL)
??LPLD_DMA_Init_5:
        LDR      R0,[R4, #+28]
        CMP      R0,#+0
        BNE.N    ??LPLD_DMA_Init_6
//  111     {
//  112         DMA_Config->Dest_Adj_Addr     =0;    
        MOVS     R0,#+0
        STR      R0,[R4, #+28]
//  113     }
//  114     //如果用户没有设置 中断模式 默认关闭中断
//  115     if(DMA_Config->Dma_irqc ==NULL)
??LPLD_DMA_Init_6:
        LDRB     R0,[R4, #+32]
        CMP      R0,#+0
        BNE.N    ??LPLD_DMA_Init_7
//  116     {
//  117        DMA_Config->Dma_irqc          =0;                //关闭中断
        MOVS     R0,#+0
        STRB     R0,[R4, #+32]
//  118     }
//  119     //如果用户没有设置 DMA自动关闭方式 默认开启主循环计数器减为0自动关闭DMA功能
//  120     if(DMA_Config->Dma_AutoClose ==NULL)
??LPLD_DMA_Init_7:
        LDRB     R0,[R4, #+33]
        CMP      R0,#+0
        BNE.N    ??LPLD_DMA_Init_8
//  121     {
//  122        DMA_Config->Dma_AutoClose     =0;                //开启主循环计数器减为0自动关闭DMA功能
        MOVS     R0,#+0
        STRB     R0,[R4, #+33]
//  123     } 
//  124     
//  125     if(DMA_Config->isr_func!=NULL)
??LPLD_DMA_Init_8:
        LDR      R0,[R4, #+36]
        CMP      R0,#+0
        BEQ.N    ??LPLD_DMA_Init_9
//  126     {
//  127         DMA_ISR[DMA_Config->Channelx] = DMA_Config->isr_func;
        LDRB     R0,[R4, #+0]
        LDR.N    R1,??DataTable3
        LDR      R2,[R4, #+36]
        STR      R2,[R1, R0, LSL #+2]
//  128         //在NVIC中使能DMA中断
//  129         enable_irq(DMA_Config->Channelx); 
        LDRB     R0,[R4, #+0]
        BL       enable_irq
//  130     }
//  131     //配置DMA寄存器
//  132     return LPLD_eDMA_Config(DMA_Config);
??LPLD_DMA_Init_9:
        MOVS     R0,R4
        BL       LPLD_eDMA_Config
        POP      {R4,PC}          ;; return
//  133 }
//  134 
//  135 
//  136 /*
//  137  * 内部函数，用户无需调用
//  138  * LPLD_eDMA_Config
//  139  * 配置eDMA寄存器函数
//  140  *
//  141  * 参数 LPLD_eDMA_Cfg_t *eDMA_Config
//  142  * 详细参数在LPLD_eDMA_Cfg 结构体中定义
//  143  * LPLD_eDMA_Cfg_t 结构体在（在HAL_eDMA.h）头文件中定义
//  144  *
//  145  * 输出：
//  146  *   0 配置失败
//  147  *   1 配置成功
//  148 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  149 static uint8 LPLD_eDMA_Config(LPLD_eDMA_Cfg_t *DMA_Config)
//  150 {
//  151     //=====配置eDMA模块时钟===========
//  152     SIM_SCGC6|=SIM_SCGC6_DMAMUX_MASK; //打开DMA通道多路复用器时钟
LPLD_eDMA_Config:
        LDR.N    R1,??DataTable3_1  ;; 0x4004803c
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x2
        LDR.N    R2,??DataTable3_1  ;; 0x4004803c
        STR      R1,[R2, #+0]
//  153         
//  154     SIM_SCGC7|=SIM_SCGC7_DMA_MASK;    //打开DMA模块时钟
        LDR.N    R1,??DataTable3_2  ;; 0x40048040
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x2
        LDR.N    R2,??DataTable3_2  ;; 0x40048040
        STR      R1,[R2, #+0]
//  155     //================================
//  156     if(DMA_Config->Channelx>15) 
        LDRB     R1,[R0, #+0]
        CMP      R1,#+16
        BCC.N    ??LPLD_eDMA_Config_0
//  157     {
//  158         return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_eDMA_Config_1
//  159     }
//  160     else
//  161     {
//  162         //选择 通道x 配置外设的DMA source requestNumber
//  163         DMAMUX_BASE_PTR->CHCFG[DMA_Config->Channelx]=DMAMUX_CHCFG_SOURCE(DMA_Config->Peri_DmaReq);
??LPLD_eDMA_Config_0:
        LDRB     R1,[R0, #+0]
        LDR.N    R2,??DataTable3_3  ;; 0x40021000
        LDRB     R3,[R0, #+1]
        ANDS     R3,R3,#0x3F
        STRB     R3,[R1, R2]
//  164     }
//  165     /*设置源地址信息*/
//  166     //设置源地址   
//  167     DMA_BASE_PTR->TCD[DMA_Config->Channelx].SADDR=DMA_Config->Source_Addr;
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        LDR.N    R2,??DataTable3_4  ;; 0x40009000
        LDR      R3,[R0, #+8]
        STR      R3,[R1, R2]
//  168     //在执行完针对源地址的操作之后，是否在原地址的基础上累加
//  169     DMA_BASE_PTR->TCD[DMA_Config->Channelx].SOFF =DMA_Config->Source_Addr_inc;
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRB     R2,[R0, #+13]
        STRH     R2,[R1, #+4]
//  170     //先清零数据长度寄存器
//  171     DMA_BASE_PTR->TCD[DMA_Config->Channelx].ATTR=0;
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        MOVS     R2,#+0
        STRH     R2,[R1, #+6]
//  172     //设置源地址的传输宽度
//  173     DMA_BASE_PTR->TCD[DMA_Config->Channelx].ATTR |=DMA_Config->Source_Size;
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R1,[R1, #+6]
        LDRB     R2,[R0, #+12]
        ORRS     R1,R2,R1
        LDRB     R2,[R0, #+0]
        LSLS     R2,R2,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+6]
//  174     //主的计数次数（major iteration count）达到后，是否重新更改源地址
//  175     DMA_BASE_PTR->TCD[DMA_Config->Channelx].SLAST =DMA_Config->Source_Adj_Addr;
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDR      R2,[R0, #+16]
        STR      R2,[R1, #+12]
//  176     
//  177     /*设置目的地址信息*/ 
//  178     //设置目的地址 
//  179     DMA_BASE_PTR->TCD[DMA_Config->Channelx].DADDR=DMA_Config->Dest_Addr;
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDR      R2,[R0, #+20]
        STR      R2,[R1, #+16]
//  180     //在执行完针对目的地址的操作之后，是否在原地址的基础上累加
//  181     DMA_BASE_PTR->TCD[DMA_Config->Channelx].DOFF =DMA_Config->Dest_Addr_inc;
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRB     R2,[R0, #+25]
        STRH     R2,[R1, #+20]
//  182     //设置源地址的传输宽度
//  183     DMA_BASE_PTR->TCD[DMA_Config->Channelx].ATTR |=DMA_Config->Dest_Size;
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R1,[R1, #+6]
        LDRB     R2,[R0, #+24]
        ORRS     R1,R2,R1
        LDRB     R2,[R0, #+0]
        LSLS     R2,R2,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+6]
//  184     //主的计数次数（major iteration count）达到后，是否重新更改目的地址
//  185     DMA_BASE_PTR->TCD[DMA_Config->Channelx].DLAST_SGA =DMA_Config->Dest_Adj_Addr;
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDR      R2,[R0, #+28]
        STR      R2,[R1, #+24]
//  186     
//  187     if(DMA_Config->Minor_loop_Length>32767) //主循环计数器的次数在0---32767之间
        LDRH     R1,[R0, #+2]
        CMP      R1,#+32768
        BCC.N    ??LPLD_eDMA_Config_2
//  188     {
//  189         return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_eDMA_Config_1
//  190     }
//  191     else
//  192     {
//  193         //===============设置主计数器长度，循环次数====================================
//  194         //设置数据长度，长度每次递减。也可以称为 当前主循环计数器 current major loop count
//  195         DMA_BASE_PTR->TCD[DMA_Config->Channelx].CITER_ELINKNO=DMA_CITER_ELINKNO_CITER(DMA_Config->Minor_loop_Length);
??LPLD_eDMA_Config_2:
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R2,[R0, #+2]
        LSLS     R2,R2,#+17       ;; ZeroExtS R2,R2,#+17,#+17
        LSRS     R2,R2,#+17
        STRH     R2,[R1, #+22]
//  196         //起始循环计数器，当主循环计数器为零的时候，将装载起始循环计数器的值
//  197         DMA_BASE_PTR->TCD[DMA_Config->Channelx].BITER_ELINKNO=DMA_CITER_ELINKNO_CITER(DMA_Config->Minor_loop_Length);
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R2,[R0, #+2]
        LSLS     R2,R2,#+17       ;; ZeroExtS R2,R2,#+17,#+17
        LSRS     R2,R2,#+17
        STRH     R2,[R1, #+30]
//  198         //设置每一次传输字节的个数，个数达到上限时，DMA便将数据存入memory
//  199         DMA_BASE_PTR->TCD[DMA_Config->Channelx].NBYTES_MLNO=DMA_NBYTES_MLNO_NBYTES(DMA_Config->Trans_bytesNum);
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDR      R2,[R0, #+4]
        STR      R2,[R1, #+8]
//  200     }
//  201     
//  202     //============设置DMA TCD控制寄存器==========================//  
//  203     DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR =0;     //清空CSR的设置                   
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        MOVS     R2,#+0
        STRH     R2,[R1, #+28]
//  204     //===========设置DMA中断===================================//
//  205     if(!DMA_Config->Dma_irqc)
        LDRB     R1,[R0, #+32]
        CMP      R1,#+0
        BNE.N    ??LPLD_eDMA_Config_3
//  206     {
//  207        DMA_INT &=~(1<<DMA_Config->Channelx); //关闭相应通道的中断请求  
        LDR.N    R1,??DataTable3_5  ;; 0x40008024
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LDRSB    R3,[R0, #+0]
        LSLS     R2,R2,R3
        BICS     R1,R1,R2
        LDR.N    R2,??DataTable3_5  ;; 0x40008024
        STR      R1,[R2, #+0]
        B.N      ??LPLD_eDMA_Config_4
//  208     }
//  209     else if(DMA_Config->Dma_irqc==1)
??LPLD_eDMA_Config_3:
        LDRB     R1,[R0, #+32]
        CMP      R1,#+1
        BNE.N    ??LPLD_eDMA_Config_5
//  210     {
//  211        DMA_INT |=(1<<DMA_Config->Channelx); //开启相应通道的中断请求
        LDR.N    R1,??DataTable3_5  ;; 0x40008024
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LDRSB    R3,[R0, #+0]
        LSLS     R2,R2,R3
        ORRS     R1,R2,R1
        LDR.N    R2,??DataTable3_5  ;; 0x40008024
        STR      R1,[R2, #+0]
//  212        DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR  |=DMA_CSR_INTHALF_MASK;//使能DMA 主循环计数器减到一半 中断
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R1,[R1, #+28]
        ORRS     R1,R1,#0x4
        LDRB     R2,[R0, #+0]
        LSLS     R2,R2,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+28]
        B.N      ??LPLD_eDMA_Config_4
//  213     }
//  214     else if(DMA_Config->Dma_irqc==2)
??LPLD_eDMA_Config_5:
        LDRB     R1,[R0, #+32]
        CMP      R1,#+2
        BNE.N    ??LPLD_eDMA_Config_4
//  215     {
//  216        DMA_INT |=(1<<DMA_Config->Channelx); //开启相应通道的中断请求
        LDR.N    R1,??DataTable3_5  ;; 0x40008024
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LDRSB    R3,[R0, #+0]
        LSLS     R2,R2,R3
        ORRS     R1,R2,R1
        LDR.N    R2,??DataTable3_5  ;; 0x40008024
        STR      R1,[R2, #+0]
//  217        DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR  |=DMA_CSR_INTMAJOR_MASK;//使能DMA 主循环计数器减到零 中断
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R1,[R1, #+28]
        ORRS     R1,R1,#0x2
        LDRB     R2,[R0, #+0]
        LSLS     R2,R2,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+28]
//  218     }
//  219     
//  220     if(!DMA_Config->Dma_AutoClose)
??LPLD_eDMA_Config_4:
        LDRB     R1,[R0, #+33]
        CMP      R1,#+0
        BNE.N    ??LPLD_eDMA_Config_6
//  221     {
//  222        DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR  |=DMA_CSR_DREQ_MASK; //主循环计数器等于零后，自动关闭DMA 
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R1,[R1, #+28]
        ORRS     R1,R1,#0x8
        LDRB     R2,[R0, #+0]
        LSLS     R2,R2,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+28]
        B.N      ??LPLD_eDMA_Config_7
//  223     }
//  224     else
//  225     {
//  226        DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR  &=(~DMA_CSR_DREQ_MASK); //主循环计数器等于零后，不关闭DMA
??LPLD_eDMA_Config_6:
        LDRB     R1,[R0, #+0]
        LSLS     R1,R1,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LDRH     R1,[R1, #+28]
        MOVW     R2,#+65527
        ANDS     R1,R2,R1
        LDRB     R2,[R0, #+0]
        LSLS     R2,R2,#+5
        ADD      R2,R2,#+1073741824
        ADDS     R2,R2,#+36864
        STRH     R1,[R2, #+28]
//  227     }
//  228     //注：使能此寄存器DMA开始工作
//  229     //关闭通道x硬件DMA请求 
//  230     DMA_ERQ&=~(1<<DMA_Config->Channelx);
??LPLD_eDMA_Config_7:
        LDR.N    R1,??DataTable3_6  ;; 0x4000800c
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LDRSB    R3,[R0, #+0]
        LSLS     R2,R2,R3
        BICS     R1,R1,R2
        LDR.N    R2,??DataTable3_6  ;; 0x4000800c
        STR      R1,[R2, #+0]
//  231     //DMA通道使能
//  232     DMAMUX_BASE_PTR->CHCFG[DMA_Config->Channelx]|=DMAMUX_CHCFG_ENBL_MASK;
        LDRB     R1,[R0, #+0]
        LDR.N    R2,??DataTable3_3  ;; 0x40021000
        LDRB     R1,[R1, R2]
        ORRS     R1,R1,#0x80
        LDRB     R0,[R0, #+0]
        LDR.N    R2,??DataTable3_3  ;; 0x40021000
        STRB     R1,[R0, R2]
//  233     
//  234     return 1;
        MOVS     R0,#+1
??LPLD_eDMA_Config_1:
        BX       LR               ;; return
//  235 }
//  236 
//  237 
//  238 /*
//  239  * LPLD_DMA_EnableReq
//  240  * 此函数根据enable的值，开启或关闭通道x的DMA请求，
//  241  * 一旦开启通道x的DMA请求，DMA模块就开始工作
//  242  * 
//  243  * 参数:
//  244  *    chx--DMA通道值  一共16个DMA通道
//  245  *      |__0  DMA_Channel_0
//  246  *      |__1  DMA_Channel_1
//  247  *      .....
//  248  *      |__15 DMA_Channel_15
//  249  *
//  250  *    enable--开启或关闭DMA请求
//  251  *      |__0  关闭通道x的外设DMA请求
//  252  *      |__1  开启通道x的外设DMA请求     
//  253  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  254 void LPLD_DMA_EnableReq(uint8 chx,uint8 enable)
//  255 {
//  256     if(enable)
LPLD_DMA_EnableReq:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??LPLD_DMA_EnableReq_0
//  257     {
//  258         //开启通道x的外设DMA请求 
//  259         DMA_ERQ|=(1<<chx);
        LDR.N    R1,??DataTable3_6  ;; 0x4000800c
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R0,R2,R0
        ORRS     R0,R0,R1
        LDR.N    R1,??DataTable3_6  ;; 0x4000800c
        STR      R0,[R1, #+0]
        B.N      ??LPLD_DMA_EnableReq_1
//  260     }
//  261     else
//  262     {
//  263         //关闭通道x的外设DMA请求 
//  264         DMA_ERQ&=~(1<<chx);
??LPLD_DMA_EnableReq_0:
        LDR.N    R1,??DataTable3_6  ;; 0x4000800c
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R0,R2,R0
        BICS     R0,R1,R0
        LDR.N    R1,??DataTable3_6  ;; 0x4000800c
        STR      R0,[R1, #+0]
//  265     }
//  266 }
??LPLD_DMA_EnableReq_1:
        BX       LR               ;; return
//  267 
//  268 /*
//  269  * LPLD_DMA_Reload
//  270  * 当完成一次DMA主循环之后，调用此函数可以调整目的地址，并重新设置主循环计数器的次数
//  271  * 调整之后 新的目的地址=原来目的地址+下一次主循环的次数
//  272  * 
//  273  * 参数:
//  274  *    chx--DMA通道值  一共16个DMA通道 
//  275  *      |__0  DMA_Channel_0
//  276  *      |__1  DMA_Channel_1
//  277  *      .....
//  278  *      |__15 DMA_Channel_15
//  279  *
//  280  *    dest_base_addr--  目的存储区的首地址，可以是数组的首地址，也可以是数据寄存器的地址
//  281  *      
//  282  *    dest_offset_addr--目的地址的偏移量，一般情况下目的地址的偏移量等于主循环计数器的次数
//  283  *    
//  284  *    loop_length--主循环计数器的次数
//  285  *     
//  286  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  287 void LPLD_DMA_Reload(uint8 chx, uint32 dest_base_addr, uint32 dest_offset_addr, uint16 loop_length)
//  288 {
LPLD_DMA_Reload:
        PUSH     {R4}
//  289     //重新设置目的地址
//  290     DMA_BASE_PTR->TCD[chx].DADDR =(uint32)(dest_base_addr+dest_offset_addr);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R4,R0,#+5
        ADD      R4,R4,#+1073741824
        ADDS     R4,R4,#+36864
        ADDS     R1,R2,R1
        STR      R1,[R4, #+16]
//  291     //设置数据长度，长度每次递减。也可以称为 当前主循环计数器 current major loop count
//  292     DMA_BASE_PTR->TCD[chx].CITER_ELINKNO=DMA_CITER_ELINKNO_CITER(loop_length);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R1,R0,#+5
        ADD      R1,R1,#+1073741824
        ADDS     R1,R1,#+36864
        LSLS     R2,R3,#+17       ;; ZeroExtS R2,R3,#+17,#+17
        LSRS     R2,R2,#+17
        STRH     R2,[R1, #+22]
//  293     //起始循环计数器，当主循环计数器为零的时候，将装载起始循环计数器的值
//  294     DMA_BASE_PTR->TCD[chx].BITER_ELINKNO=DMA_CITER_ELINKNO_CITER(loop_length);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LSLS     R0,R0,#+5
        ADD      R0,R0,#+1073741824
        ADDS     R0,R0,#+36864
        LSLS     R1,R3,#+17       ;; ZeroExtS R1,R3,#+17,#+17
        LSRS     R1,R1,#+17
        STRH     R1,[R0, #+30]
//  295 }
        POP      {R4}
        BX       LR               ;; return
//  296 
//  297 
//  298 /*
//  299  * LPLD_DMA_Isr
//  300  * DMA中断底层入口函数
//  301  * 
//  302  * 用户无需修改，程序自动进入对应通道中断函数
//  303  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  304 void LPLD_DMA_Isr(void)
//  305 {
LPLD_DMA_Isr:
        PUSH     {R4,LR}
//  306   #define DMA_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
//  307   uint8 dma_ch = DMA_VECTORNUM - 16;
        LDR.N    R0,??DataTable3_7  ;; 0xe000ed04
        LDRB     R0,[R0, #+0]
        SUBS     R4,R0,#+16
//  308   
//  309   //调用用户自定义中断服务
//  310   DMA_ISR[dma_ch]();
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable3
        LDR      R0,[R0, R4, LSL #+2]
        BLX      R0
//  311   //清除中断标志位
//  312   DMA_INT |= 0x1u<<dma_ch; 
        LDR.N    R0,??DataTable3_5  ;; 0x40008024
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        LSLS     R1,R1,R4
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable3_5  ;; 0x40008024
        STR      R0,[R1, #+0]
//  313 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     DMA_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     0x40048040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     0x40021000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     0x40009000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     0x40008024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     0x4000800c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
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
//  64 bytes in section .bss
// 862 bytes in section .text
// 
// 862 bytes of CODE memory
//  64 bytes of DATA memory
//
//Errors: none
//Warnings: none
