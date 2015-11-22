///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:54 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\HAL_CAN.c                 /
//    Command line =  "F:\robot _init\robot\lib\LPLD\HAL_CAN.c" -D IAR -D     /
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
//                    st\HAL_CAN.s                                            /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_CAN

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed
        EXTERN enable_irq

        PUBLIC CAN_ISR
        PUBLIC CANx_Ptr
        PUBLIC LPLD_CAN_ClearAllFlag
        PUBLIC LPLD_CAN_ClearFlag
        PUBLIC LPLD_CAN_Disable_Interrupt
        PUBLIC LPLD_CAN_Enable_Interrupt
        PUBLIC LPLD_CAN_Enable_RX_Buf
        PUBLIC LPLD_CAN_GetFlag
        PUBLIC LPLD_CAN_Init
        PUBLIC LPLD_CAN_Isr
        PUBLIC LPLD_CAN_RecvData
        PUBLIC LPLD_CAN_SendData
        PUBLIC LPLD_CAN_SetIsr
        PUBLIC LPLD_CAN_Unlock_MBx

// F:\robot _init\robot\lib\LPLD\HAL_CAN.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 该函数代码部分参考苏大程序
//    7  * 网络销售:http://laplenden.taobao.com
//    8  * 公司门户:http://www.lpld.cn
//    9  *
//   10  * 文件名: HAL_CAN.h
//   11  * 用途: CAN底层模块相关函数
//   12  * 最后修改日期: 20120711
//   13  *
//   14  * 开发者使用协议:
//   15  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   16  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   17  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   18  */
//   19 
//   20 /*
//   21  *******需用到FTM中断，请在isr.h中粘贴一下代码:*********
//   22 
//   23 //FTM模块中断服务定义
//   24 
//   25 #undef  VECTOR_045
//   26 #define VECTOR_045 LPLD_CAN_Isr
//   27 #undef  VECTOR_046
//   28 #define VECTOR_046 LPLD_CAN_Isr
//   29 #undef  VECTOR_047
//   30 #define VECTOR_047 LPLD_CAN_Isr
//   31 #undef  VECTOR_048
//   32 #define VECTOR_048 LPLD_CAN_Isr
//   33 #undef  VECTOR_049
//   34 #define VECTOR_049 LPLD_CAN_Isr
//   35 #undef  VECTOR_050
//   36 #define VECTOR_050 LPLD_CAN_Isr
//   37 #undef  VECTOR_051
//   38 #define VECTOR_051 LPLD_CAN_Isr
//   39 #undef  VECTOR_052
//   40 #define VECTOR_052 LPLD_CAN_Isr
//   41 #undef  VECTOR_053
//   42 #define VECTOR_053 LPLD_CAN_Isr
//   43 
//   44 //以下函数在LPLD_Kinetis底层包，不必修改
//   45 extern void LPLD_CAN_Isr(void);
//   46 
//   47  ***********************代码结束*************************
//   48 */
//   49 
//   50 #include "HAL_CAN.h"
//   51 //#include "common.h"
//   52 //#include "arm_cm4.h"
//   53 
//   54 
//   55 //用户自定义中断服务函数数组

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   56 CAN_ISR_CALLBACK CAN_ISR[16];
CAN_ISR:
        DS8 64
//   57 
//   58 //GPIO映射地址数组

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   59 volatile CAN_MemMapPtr CANx_Ptr[5] = {CAN0_BASE_PTR, 
CANx_Ptr:
        DATA
        DC32 40024000H, 400A4000H
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
//   60                                       CAN1_BASE_PTR};
//   61 
//   62 //定义内部函数
//   63 static uint8 LPLD_CAN_SetBaud(CANx, uint32);
//   64 
//   65 
//   66 
//   67 /*
//   68  * LPLD_CAN_Init
//   69  * 该函数用于Flex_CAN模块初始化
//   70  * 参数:
//   71  *    canx--设置CAN模块号
//   72  *      |__CAN0             --CAN0号模块
//   73  *      |__CAN1             --CAN1号模块
//   74  *    baud_khz--设置CAN总线波特率
//   75  *      |__0
//   76  *      |__....
//   77  *    selfloop--设置CAN总线自循环模式
//   78  *      |__CAN_NOSELFLOOP   --不循环
//   79  *      |__CAN_SELFLOOP     --循环 
//   80  * 输出:
//   81  *    0:配置出现错误
//   82  *    1:配置成功
//   83  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   84 uint8 LPLD_CAN_Init(CANx canx, uint32 baud_khz, uint8 selfloop)
//   85 {
LPLD_CAN_Init:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//   86     int8 i;
//   87     CAN_MemMapPtr canptr = CANx_Ptr[canx];
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.W    R0,??DataTable12
        LDR      R5,[R0, R4, LSL #+2]
//   88   
//   89     //使能FlexCAN外部时钟
//   90     OSC_CR |= OSC_CR_ERCLKEN_MASK | OSC_CR_EREFSTEN_MASK;
        LDR.W    R0,??DataTable12_1  ;; 0x40065000
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0xA0
        LDR.W    R3,??DataTable12_1  ;; 0x40065000
        STRB     R0,[R3, #+0]
//   91     
//   92     //使能CAN模块时钟
//   93     if(canx == CAN0)
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_CAN_Init_0
//   94         SIM_SCGC6 |= SIM_SCGC6_FLEXCAN0_MASK;//使能CAN0的时钟模块 
        LDR.W    R0,??DataTable12_2  ;; 0x4004803c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.W    R3,??DataTable12_2  ;; 0x4004803c
        STR      R0,[R3, #+0]
        B.N      ??LPLD_CAN_Init_1
//   95     else
//   96         SIM_SCGC3 |= SIM_SCGC3_FLEXCAN1_MASK;//使能CAN1的时钟模块
??LPLD_CAN_Init_0:
        LDR.W    R0,??DataTable12_3  ;; 0x40048030
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.W    R3,??DataTable12_3  ;; 0x40048030
        STR      R0,[R3, #+0]
//   97     
//   98     //配置CAN_RX/TX复用引脚功能
//   99     if(canx == CAN0)
??LPLD_CAN_Init_1:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_CAN_Init_2
//  100     {
//  101 	//CAN0_TX
//  102         PORTA_PCR12 = PORT_PCR_MUX(2) | PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; //Tx上拉
        LDR.W    R0,??DataTable12_4  ;; 0x40049030
        MOVW     R3,#+515
        STR      R3,[R0, #+0]
//  103         //CAN0_RX
//  104 	PORTA_PCR13 = PORT_PCR_MUX(2) | PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; //RX上拉
        LDR.W    R0,??DataTable12_5  ;; 0x40049034
        MOVW     R3,#+515
        STR      R3,[R0, #+0]
        B.N      ??LPLD_CAN_Init_3
//  105     }
//  106     else
//  107     {
//  108     	PORTE_PCR24 = PORT_PCR_MUX(2) | PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; //Tx上拉
??LPLD_CAN_Init_2:
        LDR.W    R0,??DataTable12_6  ;; 0x4004d060
        MOVW     R3,#+515
        STR      R3,[R0, #+0]
//  109     	PORTE_PCR25 = PORT_PCR_MUX(2) | PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; //Rx上拉
        LDR.W    R0,??DataTable12_7  ;; 0x4004d064
        MOVW     R3,#+515
        STR      R3,[R0, #+0]
//  110     } 
//  111     //注：CTRL1不能在FRZ（冻结）模式下设置
//  112     //选择时钟源，外设时钟48MHz，内部时钟：12MHz
//  113     //选择内部时钟
//  114     CAN_CTRL1_REG(canptr)|= CAN_CTRL1_CLKSRC_MASK;    
??LPLD_CAN_Init_3:
        LDR      R0,[R5, #+4]
        ORRS     R0,R0,#0x2000
        STR      R0,[R5, #+4]
//  115      
//  116     //使能CAN模块
//  117     CAN_MCR_REG(canptr) &= ~CAN_MCR_MDIS_MASK;
        LDR      R0,[R5, #+0]
        LSLS     R0,R0,#+1        ;; ZeroExtS R0,R0,#+1,#+1
        LSRS     R0,R0,#+1
        STR      R0,[R5, #+0]
//  118     
//  119     //在时钟初始化完毕和CAN总线使能完毕后，
//  120     //单片机自动进入冻结模式
//  121     //只有在冻结模式下才能配置大多数CAN总线寄存器
//  122     //使能冻结模式
//  123     CAN_MCR_REG(canptr) |= CAN_MCR_FRZ_MASK; 
        LDR      R0,[R5, #+0]
        ORRS     R0,R0,#0x40000000
        STR      R0,[R5, #+0]
//  124     //确认不在低功耗模式，如果在低功耗模式下软件复位无法完成
//  125     while((CAN_MCR_REG(canptr) & CAN_MCR_LPMACK_MASK ));
??LPLD_CAN_Init_4:
        LDR      R0,[R5, #+0]
        LSLS     R0,R0,#+11
        BMI.N    ??LPLD_CAN_Init_4
//  126     
//  127     //软件复位
//  128     //受影响的registers： MCR (except the MDIS bit), TIMER, ECR, ESR1, ESR2,
//  129     //                    IMASK1, IMASK2, IFLAG1, IFLAG2 and CRCR.
//  130     //不受影响的registers：CTRL1, CTRL2, RXIMR0–RXIMR63, RXMGMASK, RX14MASK,
//  131     //                     RX15MASK, RXFGMASK, RXFIR, all Message Buffers
//  132     //复位后MCR中RFEN=0，因而Rx FIFO并没有使能  --------重要
//  133     //因而“使能冻结模式位”被复位
//  134     
//  135     //CAN 总线软件复位，复位后该自动清零
//  136     CAN_MCR_REG(canptr) |= CAN_MCR_SOFTRST_MASK; 
        LDR      R0,[R5, #+0]
        ORRS     R0,R0,#0x2000000
        STR      R0,[R5, #+0]
//  137     //等待复位完成
//  138     while(CAN_MCR_SOFTRST_MASK & CAN_MCR_REG(canptr)); 
??LPLD_CAN_Init_5:
        LDR      R0,[R5, #+0]
        LSLS     R0,R0,#+6
        BMI.N    ??LPLD_CAN_Init_5
//  139     
//  140     //退出正常模式，再次使能冻结模式 ,因为软件复位使冻结模式退出 
//  141     CAN_MCR_REG(canptr) |= CAN_MCR_FRZ_MASK;  
        LDR      R0,[R5, #+0]
        ORRS     R0,R0,#0x40000000
        STR      R0,[R5, #+0]
//  142     //等待进入冻结模式 
//  143     while(!(CAN_MCR_REG(canptr) & CAN_MCR_FRZACK_MASK));
??LPLD_CAN_Init_6:
        LDR      R0,[R5, #+0]
        LSLS     R0,R0,#+7
        BPL.N    ??LPLD_CAN_Init_6
//  144     
//  145     //=================Initialize the Module Configuration Register=============
//  146     //1 Enable the individual filtering per MB and reception queue features by setting the IRMQ bit
//  147     //1设置全匹配蔽位，并配置与之相关的寄存器
//  148     CAN_CTRL2_REG(canptr) &= ~CAN_CTRL2_EACEN_MASK;//接收邮箱过滤IDE匹配，RTR不匹配
        LDR      R0,[R5, #+52]
        BICS     R0,R0,#0x10000
        STR      R0,[R5, #+52]
//  149     CAN_CTRL2_REG(canptr) &= ~CAN_CTRL2_RRS_MASK;  //不自动产生远程请求帧产生
        LDR      R0,[R5, #+52]
        BICS     R0,R0,#0x20000
        STR      R0,[R5, #+52]
//  150     CAN_MCR_REG(canptr)   &= ~CAN_MCR_IRMQ_MASK;   //使能全局匹配寄存器      
        LDR      R0,[R5, #+0]
        BICS     R0,R0,#0x10000
        STR      R0,[R5, #+0]
//  151     CAN_CTRL2_REG(canptr) |= CAN_CTRL2_MRP_MASK;   //ID首先从邮箱中匹配
        LDR      R0,[R5, #+52]
        ORRS     R0,R0,#0x40000
        STR      R0,[R5, #+52]
//  152     CAN_CTRL1_REG(canptr) |= CAN_CTRL1_LBUF_MASK;  //发送的时候从低优先级发送
        LDR      R0,[R5, #+4]
        ORRS     R0,R0,#0x10
        STR      R0,[R5, #+4]
//  153     CAN_RXMGMASK_REG(canptr) = 0x1FFFFFFF;         //28位ID全部匹配
        MVNS     R0,#-536870912
        STR      R0,[R5, #+16]
//  154     CAN_RX14MASK_REG(canptr) = 0x00000000;
        MOVS     R0,#+0
        STR      R0,[R5, #+20]
//  155     CAN_RX15MASK_REG(canptr) = 0x00000000;
        MOVS     R0,#+0
        STR      R0,[R5, #+24]
//  156     //2 WRN_EN bit
//  157     //2设置是否产生警告中断
//  158     CAN_MCR_REG(canptr)  &= ~CAN_MCR_WRNEN_MASK;    //不产生警告中断
        LDR      R0,[R5, #+0]
        BICS     R0,R0,#0x200000
        STR      R0,[R5, #+0]
//  159     //3 SRX_DIS bit
//  160     //3设置是否自我接受
//  161     //CAN_MCR_REG(canptr)  |= CAN_MCR_SRXDIS_MASK;  //禁止CAN自我接收
//  162     //4 Enable the Rx FIFO by setting the RFEN bit
//  163     //4 设置是否使能RX FIFO
//  164     CAN_MCR_REG(canptr)  &= ~CAN_MCR_RFEN_MASK ;    //禁止接收FIFO
        LDR      R0,[R5, #+0]
        BICS     R0,R0,#0x20000000
        STR      R0,[R5, #+0]
//  165     //5 Enable the abort mechanism by setting the AEN bit
//  166     CAN_MCR_REG(canptr)  &= ~CAN_MCR_AEN_MASK;   
        LDR      R0,[R5, #+0]
        BICS     R0,R0,#0x1000
        STR      R0,[R5, #+0]
//  167     //6 Enable the local priority feature by setting the LPRIO_EN bit
//  168     CAN_MCR_REG(canptr)  &= ~CAN_MCR_LPRIOEN_MASK;
        LDR      R0,[R5, #+0]
        BICS     R0,R0,#0x2000
        STR      R0,[R5, #+0]
//  169     
//  170 
//  171     //模式选择：回环模式或正常模式
//  172     if(selfloop)
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??LPLD_CAN_Init_7
//  173       CAN_CTRL1_REG(canptr) |= CAN_CTRL1_LPB_MASK;   //使用回环模式
        LDR      R0,[R5, #+4]
        ORRS     R0,R0,#0x1000
        STR      R0,[R5, #+4]
        B.N      ??LPLD_CAN_Init_8
//  174     else
//  175       CAN_CTRL1_REG(canptr) &= ~CAN_CTRL1_LPB_MASK;  //使用正常模式
??LPLD_CAN_Init_7:
        LDR      R0,[R5, #+4]
        BICS     R0,R0,#0x1000
        STR      R0,[R5, #+4]
//  176     //->Initialize the Control Register
//  177     //Determine the bit timing parameters: PROPSEG, PSEG1, PSEG2, RJW
//  178     //Determine the bit rate by programming the PRESDIV field
//  179     //Determine the internal arbitration mode (LBUF bit)
//  180     //设置波特率
//  181     if(LPLD_CAN_SetBaud(canx,baud_khz))//若设置错误
??LPLD_CAN_Init_8:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_SetBaud
        CMP      R0,#+0
        BEQ.N    ??LPLD_CAN_Init_9
//  182     {
//  183         return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_CAN_Init_10
//  184     }
//  185     //“SYNC” message 使能同步功能
//  186     CAN_MCR_REG(canptr)  |= CAN_CTRL1_TSYN_MASK;
??LPLD_CAN_Init_9:
        LDR      R0,[R5, #+0]
        ORRS     R0,R0,#0x20
        STR      R0,[R5, #+0]
//  187     CAN_TIMER_REG(canptr) = 0x0000;
        MOVS     R0,#+0
        STR      R0,[R5, #+8]
//  188     //->Initialize the Message Buffers
//  189     //The Control and Status word of all Message Buffers must be initialized
//  190     //If Rx FIFO was enabled, the ID filter table must be initialized
//  191     //Other entries in each Message Buffer should be initialized as required
//  192     //将16个邮箱缓冲区内容清0
//  193     for(i=0;i<16;i++)
        MOVS     R0,#+0
        B.N      ??LPLD_CAN_Init_11
//  194     {
//  195       canptr->MB[i].CS    = 0x00000000;
??LPLD_CAN_Init_12:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R5,R0, LSL #+4
        MOVS     R2,#+0
        STR      R2,[R1, #+128]
//  196       canptr->MB[i].ID    = 0x00000000;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R5,R0, LSL #+4
        MOVS     R2,#+0
        STR      R2,[R1, #+132]
//  197       canptr->MB[i].WORD0 = 0x00000000;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R5,R0, LSL #+4
        MOVS     R2,#+0
        STR      R2,[R1, #+136]
//  198       canptr->MB[i].WORD1 = 0x00000000;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R1,R5,R0, LSL #+4
        MOVS     R2,#+0
        STR      R2,[R1, #+140]
//  199     }
        ADDS     R0,R0,#+1
??LPLD_CAN_Init_11:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+16
        BCC.N    ??LPLD_CAN_Init_12
//  200     //初始化所需要的接受邮箱，设置邮箱的ID，即filter的ID值
//  201     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_1,FILTER_SLAVEA_ID);//1
        MOVS     R2,#+1
        MOVS     R1,#+1
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  202     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_2,FILTER_SLAVEB_ID);//2
        MOVS     R2,#+2
        MOVS     R1,#+2
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  203     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_3,FILTER_SLAVEC_ID);//3
        MOVS     R2,#+3
        MOVS     R1,#+3
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  204     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_4,FILTER_SLAVED_ID);//4
        MOVS     R2,#+4
        MOVS     R1,#+4
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  205     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_5,FILTER_SLAVEE_ID);//5
        MOVS     R2,#+5
        MOVS     R1,#+5
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  206     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_6,FILTER_SLAVEF_ID);//6
        MOVS     R2,#+6
        MOVS     R1,#+6
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  207     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_7,FILTER_SLAVEG_ID);//7
        MOVS     R2,#+7
        MOVS     R1,#+7
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  208     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_8,FILTER_SLAVEH_ID);//8
        MOVS     R2,#+8
        MOVS     R1,#+8
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  209     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_9,FILTER_SLAVEI_ID);//9
        MOVS     R2,#+9
        MOVS     R1,#+9
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  210     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_10,FILTER_SLAVEJ_ID);//10
        MOVS     R2,#+10
        MOVS     R1,#+10
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  211     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_11,FILTER_SLAVEK_ID);//11
        MOVS     R2,#+11
        MOVS     R1,#+11
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  212     LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_12,FILTER_SLAVEL_ID);//12
        MOVS     R2,#+12
        MOVS     R1,#+12
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_RX_Buf
//  213     //->Initialize the Rx Individual Mask Registers
//  214     //设置每个邮箱的匹配寄存器，用到那个邮箱设置哪给
//  215     canptr->RXIMR[0]  = 0x00000000;
        MOVS     R0,#+0
        STR      R0,[R5, #+2176]
//  216     canptr->RXIMR[1]  = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2180]
//  217     canptr->RXIMR[2]  = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2184]
//  218     canptr->RXIMR[3]  = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2188]
//  219     canptr->RXIMR[4]  = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2192]
//  220     canptr->RXIMR[5]  = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2196]
//  221     canptr->RXIMR[6]  = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2200]
//  222     canptr->RXIMR[7]  = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2204]
//  223     canptr->RXIMR[8]  = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2208]
//  224     canptr->RXIMR[9]  = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2212]
//  225     canptr->RXIMR[10] = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2216]
//  226     canptr->RXIMR[11] = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2220]
//  227     canptr->RXIMR[12] = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2224]
//  228     canptr->RXIMR[13] = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2228]
//  229     canptr->RXIMR[14] = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2232]
//  230     canptr->RXIMR[15] = 0x1FFFFFFF; //设置28位屏蔽位
        MVNS     R0,#-536870912
        STR      R0,[R5, #+2236]
//  231     //Set required interrupt mask bits in the IMASK Registers (for all MB interrupts), in
//  232     //CTRL Register (for Bus Off and Error interrupts) and in MCR Register for Wake-Up interrupt
//  233     //清除所有邮箱的标志位
//  234     LPLD_CAN_ClearAllFlag(canx);
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_ClearAllFlag
//  235     //使能接受邮箱中断
//  236     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_1);
        MOVS     R1,#+1
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  237     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_2);
        MOVS     R1,#+2
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  238     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_3);
        MOVS     R1,#+3
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  239     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_4);
        MOVS     R1,#+4
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  240     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_5);
        MOVS     R1,#+5
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  241     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_6);
        MOVS     R1,#+6
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  242     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_7);
        MOVS     R1,#+7
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  243     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_8);
        MOVS     R1,#+8
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  244     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_9);
        MOVS     R1,#+9
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  245     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_10);
        MOVS     R1,#+10
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  246     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_11);
        MOVS     R1,#+11
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  247     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_12);
        MOVS     R1,#+12
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  248     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_13);
        MOVS     R1,#+13
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  249     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_14);
        MOVS     R1,#+14
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  250     LPLD_CAN_Enable_Interrupt(canx,MB_NUM_15);
        MOVS     R1,#+15
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_CAN_Enable_Interrupt
//  251     //Negate the HALT bit in MCR
//  252     
//  253     //只有在冻结模式下才能配置，配置完推出冻结模式
//  254     CAN_MCR_REG(canptr) &= ~(CAN_MCR_HALT_MASK);
        LDR      R0,[R5, #+0]
        BICS     R0,R0,#0x10000000
        STR      R0,[R5, #+0]
//  255     //等待直到退出冻结模式
//  256     while( CAN_MCR_REG(canptr) & CAN_MCR_FRZACK_MASK);    
??LPLD_CAN_Init_13:
        LDR      R0,[R5, #+0]
        LSLS     R0,R0,#+7
        BMI.N    ??LPLD_CAN_Init_13
//  257     //等到不在冻结模式，休眠模式或者停止模式
//  258     while((CAN_MCR_REG(canptr) & CAN_MCR_NOTRDY_MASK));
??LPLD_CAN_Init_14:
        LDR      R0,[R5, #+0]
        LSLS     R0,R0,#+4
        BMI.N    ??LPLD_CAN_Init_14
//  259     //Starting with the last event, FlexCAN attempts to synchronize to the CAN bus.
//  260     return 1;
        MOVS     R0,#+1
??LPLD_CAN_Init_10:
        POP      {R1,R4,R5,PC}    ;; return
//  261 }
//  262 
//  263 /*
//  264  * LPLD_CAN_SetIsr
//  265  * 该函数用于Flex_CAN模块的16个中断源配置
//  266  * 参数:
//  267  *    canx--设置CAN模块号
//  268  *      |__CAN0             -CAN0号模块
//  269  *      |__CAN1             -CAN1号模块
//  270  *    can_int_type--配置中断方式
//  271  *      |__FLEXCAN_MB_INT               -邮箱中断
//  272  *      |__FLEXCAN_BUS_OFF_INT          -总线关闭
//  273  *      |__FLEXCAN_ERROR_INT            -错误中断
//  274  *      |__FLEXCAN_TRANS_WARNING_INT    -发送警告中断
//  275  *      |__FLEXCAN_RECV_WARNING_INT     -接收警告中断
//  276  *      |__FLEXCAN_WAKEUP_INT           -唤醒中断
//  277  *      |__FLEXCAN_IMEU_INT             -独立匹配元素更新
//  278  *      |__FLEXCAN_LOST_RECV_INT        -接收丢失中断 
//  279  *    isr_func--用户中断程序入口地址
//  280  *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
//  281  * 输出:
//  282  *    无
//  283  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  284 void LPLD_CAN_SetIsr(CANx canx, uint8 can_int_type, CAN_ISR_CALLBACK isr_func)
//  285 {
LPLD_CAN_SetIsr:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  286   //参数检查
//  287   ASSERT( canx <=  CAN0);                                 //模块号
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BCC.N    ??LPLD_CAN_SetIsr_0
        MOVW     R1,#+287
        LDR.W    R0,??DataTable12_8
        BL       assert_failed
//  288   ASSERT( can_int_type <= FLEXCAN_LOST_RECV_INT);         //中断类型
??LPLD_CAN_SetIsr_0:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+8
        BCC.N    ??LPLD_CAN_SetIsr_1
        MOV      R1,#+288
        LDR.W    R0,??DataTable12_8
        BL       assert_failed
//  289   
//  290   enable_irq(29 + canx*8 + can_int_type);
??LPLD_CAN_SetIsr_1:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+3
        UXTAB    R0,R0,R5
        ADDS     R0,R0,#+29
        BL       enable_irq
//  291   CAN_ISR[canx*8 + can_int_type] = isr_func;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LSLS     R0,R4,#+3
        UXTAB    R0,R0,R5
        LDR.W    R1,??DataTable12_9
        STR      R6,[R1, R0, LSL #+2]
//  292   
//  293 }
        POP      {R4-R6,PC}       ;; return
//  294 
//  295 
//  296 /*
//  297  * LPLD_CAN_SendData
//  298  * 该函数用于Flex_CAN模块向总线发送数据
//  299  * 参数:
//  300  *    canx--设置CAN总线通道
//  301  *      |__CAN0             -CAN0号模块
//  302  *      |__CAN1             -CAN1号模块
//  303  *    mbx--对应的邮箱号
//  304  *      |__MB_NUM_0         --邮箱0
//  305  *      |__...              --...
//  306  *      |__MB_NUM_15        --邮箱15
//  307  *    id--目标位置的id号  
//  308  *    len--发送数据的字节数，最大8个字节   
//  309  *    *data--发送数据的缓冲区
//  310  * 输出:
//  311  *    0:配置出现错误
//  312  *    1:配置成功
//  313  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  314 uint8 LPLD_CAN_SendData(CANx canx, uint16 mbx, uint32 id, uint8 len, uint8 *data)
//  315 {
LPLD_CAN_SendData:
        PUSH     {R2-R8,LR}
//  316     int16  i,j,k;
//  317     uint32 word[2] = {0};
        ADD      R4,SP,#+0
        MOVS     R5,#+0
        MOVS     R6,#+0
        STM      R4!,{R5,R6}
        SUBS     R4,R4,#+8
//  318     CAN_MemMapPtr canptr = CANx_Ptr[canx];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R4,??DataTable12
        LDR      R0,[R4, R0, LSL #+2]
//  319     
//  320     //判断缓冲区和数据长度设置错误
//  321     if(mbx >= MB_MAX_NO || len > MB_MAX_DATA)
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+16
        BCS.N    ??LPLD_CAN_SendData_0
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R3,#+9
        BCC.N    ??LPLD_CAN_SendData_1
//  322         return 0; //超出范围
??LPLD_CAN_SendData_0:
        MOVS     R0,#+0
        B.N      ??LPLD_CAN_SendData_2
//  323     
//  324     //将8个字节转换成32位的word存储
//  325     //首先判断当前数据包含字节数
//  326     j = (len-1)/4; //是否超过4字节
??LPLD_CAN_SendData_1:
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        SUBS     R4,R3,#+1
        MOVS     R5,#+4
        SDIV     R4,R4,R5
//  327     k = (len-1)%4; //
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        SUBS     R6,R3,#+1
        MOVS     R7,#+4
        SDIV     R5,R6,R7
        MLS      R5,R5,R7,R6
        LDR      R6,[SP, #+32]
//  328     if(j > 0)         //长度大于4(即发送数据超过4字节)
        SXTH     R4,R4            ;; SignExt  R4,R4,#+16,#+16
        CMP      R4,#+1
        BLT.N    ??LPLD_CAN_SendData_3
//  329     {
//  330       word[0] = ((data[0]<<24) | (data[1]<<16) | (data[2]<< 8) |  data[3] );
        LDRB     R7,[R6, #+0]
        LDRB     R12,[R6, #+1]
        LSLS     R12,R12,#+16
        ORRS     R7,R12,R7, LSL #+24
        LDRB     R12,[R6, #+2]
        ORRS     R7,R7,R12, LSL #+8
        LDRB     R12,[R6, #+3]
        ORRS     R7,R12,R7
        STR      R7,[SP, #+0]
//  331     }
//  332     for(i = 0; i <= k ; i++)
??LPLD_CAN_SendData_3:
        MOVS     R7,#+0
        B.N      ??LPLD_CAN_SendData_4
//  333     {
//  334        word[j] |= data[(j<<2)+i] << (24-(i<<3)); 
??LPLD_CAN_SendData_5:
        SXTH     R4,R4            ;; SignExt  R4,R4,#+16,#+16
        ADD      R12,SP,#+0
        LDR      R12,[R12, R4, LSL #+2]
        SXTH     R4,R4            ;; SignExt  R4,R4,#+16,#+16
        LSLS     LR,R4,#+2
        SXTAH    LR,LR,R7
        LDRB     LR,[LR, R6]
        SXTH     R7,R7            ;; SignExt  R7,R7,#+16,#+16
        LSLS     R8,R7,#+3
        RSBS     R8,R8,#+24
        LSLS     LR,LR,R8
        ORRS     R12,LR,R12
        SXTH     R4,R4            ;; SignExt  R4,R4,#+16,#+16
        ADD      LR,SP,#+0
        STR      R12,[LR, R4, LSL #+2]
//  335     }
        ADDS     R7,R7,#+1
??LPLD_CAN_SendData_4:
        SXTH     R5,R5            ;; SignExt  R5,R5,#+16,#+16
        SXTH     R7,R7            ;; SignExt  R7,R7,#+16,#+16
        CMP      R5,R7
        BGE.N    ??LPLD_CAN_SendData_5
//  336     
//  337     //通过id判断帧类型——扩展帧
//  338     j = (id &  CAN_MSG_IDE_MASK)>>CAN_MSG_IDE_BIT_NO;  //IDE
        LSRS     R4,R2,#+31
//  339     //通过id判断帧类型——远程帧
//  340     k = (id &  CAN_MSG_TYPE_MASK)>>CAN_MSG_TYPE_BIT_NO;//RTR
        LSRS     R5,R2,#+30
        ANDS     R5,R5,#0x1
//  341     
//  342     //获得ID位数
//  343     i =  j? 0: FLEXCAN_MB_ID_STD_BIT_NO;
        SXTH     R4,R4            ;; SignExt  R4,R4,#+16,#+16
        CMP      R4,#+0
        BEQ.N    ??LPLD_CAN_SendData_6
        MOVS     R7,#+0
        B.N      ??LPLD_CAN_SendData_7
??LPLD_CAN_SendData_6:
        MOVS     R7,#+18
//  344     
//  345     if(canptr->IFLAG1 & (1<<mbx))
??LPLD_CAN_SendData_7:
        LDR      R6,[R0, #+48]
        MOVS     R12,#+1
        LSLS     R12,R12,R1
        TST      R6,R12
        BEQ.N    ??LPLD_CAN_SendData_8
//  346       canptr->IFLAG1 = (1<<mbx);
        MOVS     R6,#+1
        LSLS     R6,R6,R1
        STR      R6,[R0, #+48]
//  347     //以下四步骤为发送过程
//  348     //先缓冲区写激活码
//  349     canptr->MB[mbx].CS = FLEXCAN_MB_CS_CODE(FLEXCAN_MB_CODE_TX_INACTIVE);
??LPLD_CAN_SendData_8:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R6,R0,R1, LSL #+4
        MOVS     R12,#+134217728
        STR      R12,[R6, #+128]
//  350     
//  351     //向缓冲区写目标ID
//  352     canptr->MB[mbx].ID = (1 << FLEXCAN_MB_ID_PRIO_BIT_NO) | ((id & ~(CAN_MSG_IDE_MASK|CAN_MSG_TYPE_MASK))<<i);  
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R6,R0,R1, LSL #+4
        LSLS     R2,R2,#+2        ;; ZeroExtS R2,R2,#+2,#+2
        LSRS     R2,R2,#+2
        LSLS     R2,R2,R7
        ORRS     R2,R2,#0x20000000
        STR      R2,[R6, #+132]
//  353     
//  354     //向缓冲区写数据
//  355     canptr->MB[mbx].WORD0 = word[0];
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R2,R0,R1, LSL #+4
        LDR      R6,[SP, #+0]
        STR      R6,[R2, #+136]
//  356     canptr->MB[mbx].WORD1 = word[1];  
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R2,R0,R1, LSL #+4
        LDR      R6,[SP, #+4]
        STR      R6,[R2, #+140]
//  357     
//  358     //通过制定的发送代码开始发送
//  359     canptr->MB[mbx].CS = FLEXCAN_MB_CS_CODE(FLEXCAN_MB_CODE_TX_ONCE)//写激活代码
//  360                                | (j<<FLEXCAN_MB_CS_IDE_BIT_NO)          //缓冲区写IDE位
//  361 			       | (k<<FLEXCAN_MB_CS_RTR_BIT_NO)          //缓冲区写RTR位
//  362                                | FLEXCAN_MB_CS_LENGTH(len);            //缓冲区写数据长度
        SXTH     R4,R4            ;; SignExt  R4,R4,#+16,#+16
        SXTH     R5,R5            ;; SignExt  R5,R5,#+16,#+16
        LSLS     R2,R5,#+20
        ORRS     R2,R2,R4, LSL #+21
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        ANDS     R3,R3,#0xF
        ORRS     R2,R2,R3, LSL #+16
        ORRS     R2,R2,#0xC000000
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R3,R0,R1, LSL #+4
        STR      R2,[R3, #+128]
//  363     for(i = 0;i <1000;i++); //等待缓冲区装载完成
        MOVS     R7,#+0
        B.N      ??LPLD_CAN_SendData_9
??LPLD_CAN_SendData_10:
        ADDS     R7,R7,#+1
??LPLD_CAN_SendData_9:
        SXTH     R7,R7            ;; SignExt  R7,R7,#+16,#+16
        CMP      R7,#+1000
        BLT.N    ??LPLD_CAN_SendData_10
//  364 							
//  365     //限时等待发送完成（如果使用中断则限时等待语句可删除）
//  366     i=0;
        MOVS     R7,#+0
//  367     while(!(canptr->IFLAG1 & (1<<mbx)))
??LPLD_CAN_SendData_11:
        LDR      R2,[R0, #+48]
        MOVS     R3,#+1
        LSLS     R3,R3,R1
        TST      R2,R3
        BNE.N    ??LPLD_CAN_SendData_12
//  368     {
//  369     	if((i++)>0x1000)
        MOVS     R2,R7
        ADDS     R7,R2,#+1
        MOVW     R3,#+4097
        SXTH     R2,R2            ;; SignExt  R2,R2,#+16,#+16
        CMP      R2,R3
        BLT.N    ??LPLD_CAN_SendData_11
//  370           return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_CAN_SendData_2
//  371     }
//  372     //清报文缓冲区中断标志
//  373     canptr->IFLAG1 = (1<<mbx);
??LPLD_CAN_SendData_12:
        MOVS     R2,#+1
        LSLS     R1,R2,R1
        STR      R1,[R0, #+48]
//  374     return 1;
        MOVS     R0,#+1
??LPLD_CAN_SendData_2:
        POP      {R1,R2,R4-R8,PC}  ;; return
//  375 }
//  376 
//  377 /*
//  378  * LPLD_CAN_Enable_RX_Buf
//  379  * 该函数用于使能Flex_CAN模块的接收缓冲区
//  380  * 参数:
//  381  *    canx--设置CAN总线通道
//  382  *      |__CAN0             --CAN0号模块
//  383  *      |__CAN1             --CAN1号模块
//  384  *    mbx--对应的邮箱号
//  385  *      |__MB_NUM_0         --邮箱0
//  386  *      |__...              --...
//  387  *      |__MB_NUM_15        --邮箱15
//  388  *    id--接收缓冲的ID，用于和接收到的ID进行匹配。
//  389  * 输出:
//  390  *    无
//  391  *
//  392  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  393 void LPLD_CAN_Enable_RX_Buf(CANx canx, uint16 mbx, uint32 id)
//  394 {
LPLD_CAN_Enable_RX_Buf:
        PUSH     {R4,R5}
//  395     uint32 idemp;
//  396     //获得当前缓冲区的CODE值0X0100
//  397     uint32 cs = FLEXCAN_MB_CS_CODE(FLEXCAN_MB_CODE_RX_EMPTY); 
        MOVS     R3,#+67108864
//  398     CAN_MemMapPtr canptr = CANx_Ptr[canx];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R4,??DataTable12
        LDR      R4,[R4, R0, LSL #+2]
//  399 
//  400     //将MB配置为非激活状态
//  401     canptr->MB[mbx].CS = FLEXCAN_MB_CS_CODE(FLEXCAN_MB_CODE_RX_INACTIVE); 	
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R0,R4,R1, LSL #+4
        MOVS     R5,#+0
        STR      R5,[R0, #+128]
//  402     
//  403     //取出29位单独的ID
//  404     idemp = id & 0x1FFFFFFF;
        LSLS     R0,R2,#+3        ;; ZeroExtS R0,R2,#+3,#+3
        LSRS     R0,R0,#+3
//  405     
//  406     //设置ID用于接收的数据帧和邮箱的ID进行匹配
//  407     if(id & CAN_MSG_IDE_MASK)//扩展帧
        CMP      R2,#+0
        BPL.N    ??LPLD_CAN_Enable_RX_Buf_0
//  408     {
//  409         canptr->MB[mbx].ID = idemp;
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R2,R4,R1, LSL #+4
        STR      R0,[R2, #+132]
//  410         cs |= FLEXCAN_MB_CS_IDE;//置位IDE位，设置为扩展帧
        ORRS     R3,R3,#0x200000
        B.N      ??LPLD_CAN_Enable_RX_Buf_1
//  411     }
//  412     else//标准帧
//  413     {
//  414         //将ID左移18位存储在标准帧的ID位置
//  415         canptr->MB[mbx].ID = (idemp << FLEXCAN_MB_ID_STD_BIT_NO); //取标准帧的ID号          
??LPLD_CAN_Enable_RX_Buf_0:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R2,R4,R1, LSL #+4
        LSLS     R0,R0,#+18
        STR      R0,[R2, #+132]
//  416     }
//  417     
//  418     //激活接收缓冲区，code写0100
//  419     canptr->MB[mbx].CS = cs;  //设置为接受缓冲区，用于接受数据    
??LPLD_CAN_Enable_RX_Buf_1:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ADDS     R0,R4,R1, LSL #+4
        STR      R3,[R0, #+128]
//  420 }
        POP      {R4,R5}
        BX       LR               ;; return
//  421 
//  422 /*
//  423  * LPLD_CAN_RecvData
//  424  * 该函数用于接收Flex_CAN模块从总线获取的数据
//  425  * 参数:
//  426  *    canx--设置CAN总线通道
//  427  *      |__CAN0             --CAN0号模块
//  428  *      |__CAN1             --CAN1号模块
//  429  *    mbx--对应的邮箱号
//  430  *      |__MB_NUM_0         --邮箱0
//  431  *      |__...              --...
//  432  *      |__MB_NUM_15        --邮箱15
//  433  *    *id--接收到的ID   
//  434  *    *len--接收到的数据长度指针
//  435  *    *data--接收到的数据缓冲区指针
//  436  * 输出:
//  437  *    0:配置时出现错误
//  438  *    1:配置时成功
//  439  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  440 uint8 LPLD_CAN_RecvData(CANx canx, uint16 mbx, uint32 *id, uint8 *len, uint8 *data)  
//  441 {
LPLD_CAN_RecvData:
        PUSH     {R4-R8,LR}
        MOVS     R6,R1
        MOV      R8,R2
        MOVS     R4,R3
        LDR      R5,[SP, #+24]
//  442     int8   i,j,k;
//  443     int8   format;
//  444     uint16 code;
//  445     int16  length;   
//  446     uint8  *pMBData;
//  447     uint8  *pBytes = data;
//  448     CAN_MemMapPtr canptr = CANx_Ptr[canx];
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable12
        LDR      R7,[R1, R0, LSL #+2]
//  449     
//  450     //读timer值解除邮箱自锁
//  451     //在一般模式（相对于FIFO接收）下，必须首先解锁邮箱
//  452     LPLD_CAN_Unlock_MBx(CAN0);
        MOVS     R0,#+0
        BL       LPLD_CAN_Unlock_MBx
//  453     
//  454     code = FLEXCAN_GET_CODE(canptr->MB[mbx].CS);
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        ADDS     R0,R7,R6, LSL #+4
        LDR      R0,[R0, #+128]
        LSRS     R0,R0,#+24
        ANDS     R0,R0,#0xF
//  455     //如果是 FULL 或 OVERRUN状态 证明接受到数据
//  456     if(code != RX_BUF_STATUS_FULL && code != RX_BUF_STATUS_OVERRUN)
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+2
        BEQ.N    ??LPLD_CAN_RecvData_0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+6
        BEQ.N    ??LPLD_CAN_RecvData_0
//  457     {
//  458       *len = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  459       return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_CAN_RecvData_1
//  460     }
//  461     length = FLEXCAN_GET_LENGTH(canptr->MB[mbx].CS);  //取MB结构中CS的DLC值
??LPLD_CAN_RecvData_0:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        ADDS     R0,R7,R6, LSL #+4
        LDR      R0,[R0, #+128]
        LSRS     R0,R0,#+16
        ANDS     R0,R0,#0xF
//  462     
//  463     if(length <1)//接收到的数据长度小于1，返回错误
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        CMP      R0,#+1
        BGE.N    ??LPLD_CAN_RecvData_2
//  464     {
//  465       *len = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
//  466       return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_CAN_RecvData_1
//  467     }
//  468    
//  469     //判断是标准帧还是扩展帧
//  470     format = (canptr->MB[mbx].CS & FLEXCAN_MB_CS_IDE)? 1:0;//判断IDE位
??LPLD_CAN_RecvData_2:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        ADDS     R1,R7,R6, LSL #+4
        LDR      R1,[R1, #+128]
        UBFX     R1,R1,#+21,#+1
        ANDS     R1,R1,#0x1
//  471     *id    = (canptr->MB[mbx].ID & FLEXCAN_MB_ID_EXT_MASK); //在接受回来的帧中，先按扩展帧提取ID，之后根据format判断后，进一步处理ID
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        ADDS     R2,R7,R6, LSL #+4
        LDR      R2,[R2, #+132]
        LSLS     R2,R2,#+3        ;; ZeroExtS R2,R2,#+3,#+3
        LSRS     R2,R2,#+3
        STR      R2,[R8, #+0]
//  472  
//  473     if(!format) //format=0,标准帧
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BNE.N    ??LPLD_CAN_RecvData_3
//  474     {
//  475       *id >>= FLEXCAN_MB_ID_STD_BIT_NO; // 获得标准帧号
        LDR      R1,[R8, #+0]
        LSRS     R1,R1,#+18
        STR      R1,[R8, #+0]
        B.N      ??LPLD_CAN_RecvData_4
//  476     }
//  477     else   
//  478     { 
//  479       *id |= CAN_MSG_IDE_MASK; //标记扩展的ID        
??LPLD_CAN_RecvData_3:
        LDR      R1,[R8, #+0]
        ORRS     R1,R1,#0x80000000
        STR      R1,[R8, #+0]
//  480     }
//  481    //判断是远程帧or数据帧
//  482     format = (canptr->MB[mbx].CS & FLEXCAN_MB_CS_RTR)? 1:0;  
??LPLD_CAN_RecvData_4:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        ADDS     R1,R7,R6, LSL #+4
        LDR      R1,[R1, #+128]
        UBFX     R1,R1,#+20,#+1
        ANDS     R1,R1,#0x1
//  483     if(format)
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??LPLD_CAN_RecvData_5
//  484     {
//  485       *id |= CAN_MSG_TYPE_MASK; //标记为远程帧类型       
        LDR      R1,[R8, #+0]
        ORRS     R1,R1,#0x40000000
        STR      R1,[R8, #+0]
//  486     }
//  487     //读取报文数据
//  488     j = (length-1)>>2; //1
??LPLD_CAN_RecvData_5:
        SXTH     R0,R0            ;; SignExt  R0,R0,#+16,#+16
        SUBS     R1,R0,#+1
        ASRS     R1,R1,#+2
//  489     k = length-1;      //7
        MOVS     R2,R0
        SUBS     R2,R2,#+1
//  490     if(j > 0)//如果接收的是8字节数据
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+1
        BCC.N    ??LPLD_CAN_RecvData_6
//  491     {  
//  492       //将word0中的数据提取出来
//  493       (*(uint32*)pBytes) = canptr->MB[mbx].WORD0;
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        ADDS     R3,R7,R6, LSL #+4
        LDR      R3,[R3, #+136]
        STR      R3,[R5, #+0]
//  494       //调换顺序0 1 2 3-->3 2 1 0
//  495       swap_bytes(pBytes);    
        LDRB     R3,[R5, #+0]
        LDRB     R12,[R5, #+3]
        STRB     R12,[R5, #+0]
        STRB     R3,[R5, #+3]
        LDRB     R3,[R5, #+1]
        LDRB     R12,[R5, #+2]
        STRB     R12,[R5, #+1]
        STRB     R3,[R5, #+2]
//  496       k -= 4;
        SUBS     R2,R2,#+4
//  497       //将WORD1的最高字节地址付给pMBData
//  498       pMBData = (uint8*)&canptr->MB[mbx].WORD1+3;
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        ADDS     R3,R7,R6, LSL #+4
        ADDW     R6,R3,#+143
        B.N      ??LPLD_CAN_RecvData_7
//  499     }
//  500     else
//  501     {
//  502       pMBData = (uint8*)&canptr->MB[mbx].WORD0+3;
??LPLD_CAN_RecvData_6:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        ADDS     R3,R7,R6, LSL #+4
        ADDW     R6,R3,#+139
//  503     }
//  504  
//  505     for(i = 0; i <= k; i++)
??LPLD_CAN_RecvData_7:
        MOVS     R3,#+0
        B.N      ??LPLD_CAN_RecvData_8
//  506     {
//  507       pBytes[i+(j<<2)] = *pMBData--;	
??LPLD_CAN_RecvData_9:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R7,R1,#+2
        UXTAB    R7,R7,R3
        LDRB     R12,[R6, #+0]
        STRB     R12,[R7, R5]
        SUBS     R6,R6,#+1
//  508     }
        ADDS     R3,R3,#+1
??LPLD_CAN_RecvData_8:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R2,R3
        BCS.N    ??LPLD_CAN_RecvData_9
//  509     *len = length;
        STRB     R0,[R4, #+0]
//  510     return 1;
        MOVS     R0,#+1
??LPLD_CAN_RecvData_1:
        POP      {R4-R8,PC}       ;; return
//  511 }
//  512 
//  513 /*
//  514  * LPLD_CAN_Enable_Interrupt
//  515  * 该函数用于按位使能Flex_CAN模块的邮箱中断
//  516  * 
//  517  * 参数:
//  518  *    canx--设置CAN总线通道
//  519  *      |__CAN0             --CAN0号模块
//  520  *      |__CAN1             --CAN1号模块
//  521  *    mbx--对应的邮箱号
//  522  *      |__MB_NUM_0         --邮箱0
//  523  *      |__...              --...
//  524  *      |__MB_NUM_15        --邮箱15
//  525  * 输出:
//  526  *    无
//  527  *
//  528  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  529 void LPLD_CAN_Enable_Interrupt(CANx canx, uint16 mbx)
//  530 {
//  531     CAN_MemMapPtr canptr = CANx_Ptr[canx];
LPLD_CAN_Enable_Interrupt:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable12
        LDR      R0,[R2, R0, LSL #+2]
//  532 
//  533     //使能相应通道的中断
//  534     CAN_IMASK1_REG(canptr) |= (1<<mbx); 
        LDR      R2,[R0, #+40]
        MOVS     R3,#+1
        LSLS     R1,R3,R1
        ORRS     R1,R1,R2
        STR      R1,[R0, #+40]
//  535 }
        BX       LR               ;; return
//  536 
//  537 /*
//  538  * LPLD_CAN_Disable_Interrupt
//  539  * 该函数用于按位禁止Flex_CAN模块的邮箱中断
//  540  * 
//  541  * 参数:
//  542  *    canx--设置CAN总线通道
//  543  *      |__CAN0             --CAN0号模块
//  544  *      |__CAN1             --CAN1号模块
//  545  *    mbx--对应的邮箱号
//  546  *      |__MB_NUM_0         --邮箱0
//  547  *      |__...              --...
//  548  *      |__MB_NUM_15        --邮箱15
//  549  * 输出:
//  550  *    无
//  551  *
//  552  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  553 void LPLD_CAN_Disable_Interrupt(CANx canx, uint16 mbx)
//  554 {
//  555     CAN_MemMapPtr canptr = CANx_Ptr[canx];
LPLD_CAN_Disable_Interrupt:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable12
        LDR      R0,[R2, R0, LSL #+2]
//  556     
//  557     CAN_IMASK1_REG(canptr) &= ~CAN_IMASK1_BUFLM(mbx);
        LDR      R2,[R0, #+40]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        BICS     R1,R2,R1
        STR      R1,[R0, #+40]
//  558 }
        BX       LR               ;; return
//  559 
//  560 /*
//  561  * LPLD_CAN_ClearFlag
//  562  * 该函数用于按位清除Flex_CAN模块的邮箱中断标志位
//  563  * 
//  564  * 参数:
//  565  *    canx--设置CAN总线通道
//  566  *      |__CAN0             --CAN0号模块
//  567  *      |__CAN1             --CAN1号模块
//  568  *    mbx--对应的邮箱号
//  569  *      |__MB_NUM_0         --邮箱0
//  570  *      |__...              --...
//  571  *      |__MB_NUM_15        --邮箱15
//  572  * 输出:
//  573  *    无
//  574  *
//  575  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  576 void LPLD_CAN_ClearFlag(CANx canx, uint16 mbx)
//  577 {
//  578     CAN_MemMapPtr canptr = CANx_Ptr[canx];
LPLD_CAN_ClearFlag:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable12
        LDR      R0,[R2, R0, LSL #+2]
//  579     
//  580     canptr->IFLAG1= (1<<mbx);
        MOVS     R2,#+1
        LSLS     R1,R2,R1
        STR      R1,[R0, #+48]
//  581 }
        BX       LR               ;; return
//  582 
//  583 
//  584 /*
//  585  * LPLD_CAN_ClearAllFlag
//  586  * 该函数用于清除所有Flex_CAN模块的邮箱中断标志位
//  587  * 
//  588  * 参数:
//  589  *    canx--设置CAN总线通道
//  590  *      |__CAN0             --CAN0号模块
//  591  *      |__CAN1             --CAN1号模块
//  592  * 输出:
//  593  *    无
//  594  *
//  595  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  596 void LPLD_CAN_ClearAllFlag(CANx canx)
//  597 {
//  598     CAN_MemMapPtr canptr = CANx_Ptr[canx];
LPLD_CAN_ClearAllFlag:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable12
        LDR      R0,[R1, R0, LSL #+2]
//  599     
//  600     canptr->IFLAG1= 0xFFFF;
        MOVW     R1,#+65535
        STR      R1,[R0, #+48]
//  601     canptr->IFLAG2= 0xFFFF;
        MOVW     R1,#+65535
        STR      R1,[R0, #+44]
//  602 }
        BX       LR               ;; return
//  603 
//  604 
//  605 /*
//  606  * LPLD_CAN_Unlock_MBx
//  607  * 该函数用于解锁Flex_CAN模块中的接收邮箱，通过读取自由计数器的值
//  608  * 
//  609  * 参数:
//  610  *    canx--设置CAN总线通道
//  611  *      |__CAN0             --CAN0号模块
//  612  *      |__CAN1             --CAN1号模块
//  613  *
//  614  * 输出:
//  615  *    返自由计数器的值
//  616  *
//  617  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  618 uint16 LPLD_CAN_Unlock_MBx(CANx canx)
//  619 {
//  620   CAN_MemMapPtr canptr = CANx_Ptr[canx];
LPLD_CAN_Unlock_MBx:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable12
        LDR      R0,[R1, R0, LSL #+2]
//  621   uint16 timer;
//  622 
//  623   timer = CAN_TIMER_REG(canptr);
        LDR      R0,[R0, #+8]
//  624   return timer;
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BX       LR               ;; return
//  625 }
//  626 
//  627 /*
//  628  * LPLD_CAN_GetFlag
//  629  * 该函数用于获得Flex_CAN模块的邮箱中断标志位
//  630  * 
//  631  * 参数:
//  632  *    canx--设置CAN总线通道
//  633  *      |__CAN0             --CAN0号模块
//  634  *      |__CAN1             --CAN1号模块
//  635  *    mbx--对应的邮箱号
//  636  *      |__MB_NUM_0         --邮箱0
//  637  *      |__...              --...
//  638  *      |__MB_NUM_15        --邮箱15
//  639  * 输出:
//  640  *    邮箱所对应的中断标志位
//  641  *
//  642  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  643 uint32 LPLD_CAN_GetFlag(CANx canx, uint16 mbx)
//  644 {
//  645   CAN_MemMapPtr canptr = CANx_Ptr[canx];
LPLD_CAN_GetFlag:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable12
        LDR      R0,[R2, R0, LSL #+2]
//  646   
//  647   return (canptr->IFLAG1 & (1<<mbx));
        LDR      R0,[R0, #+48]
        MOVS     R2,#+1
        LSLS     R1,R2,R1
        ANDS     R0,R1,R0
        BX       LR               ;; return
//  648 }
//  649 
//  650 /*
//  651  * LPLD_CAN_SetBaud
//  652  * 设置指定CAN模块波特率
//  653  * 参数:
//  654  *    canx--设置CAN总线通道
//  655  *      |__CAN0             --CAN0号模块
//  656  *      |__CAN1             --CAN1号模块
//  657  *    baud_khz--设置CAN总线波特率
//  658  *      |__设置波特率的值，单位Khz
//  659  *
//  660  * 输出:
//  661  *    0--配置错误
//  662  *    1--配置成功
//  663  *
//  664  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  665 static uint8 LPLD_CAN_SetBaud(CANx canx, uint32 baud_khz)
//  666 {    
//  667   CAN_MemMapPtr canptr = CANx_Ptr[canx];
LPLD_CAN_SetBaud:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable12
        LDR      R0,[R2, R0, LSL #+2]
//  668   
//  669   switch (baud_khz)
        CMP      R1,#+33
        BEQ.N    ??LPLD_CAN_SetBaud_0
        CMP      R1,#+50
        BEQ.N    ??LPLD_CAN_SetBaud_1
        CMP      R1,#+83
        BEQ.N    ??LPLD_CAN_SetBaud_2
        CMP      R1,#+100
        BEQ.N    ??LPLD_CAN_SetBaud_3
        CMP      R1,#+125
        BEQ.N    ??LPLD_CAN_SetBaud_4
        CMP      R1,#+250
        BEQ.N    ??LPLD_CAN_SetBaud_5
        CMP      R1,#+500
        BEQ.N    ??LPLD_CAN_SetBaud_6
        CMP      R1,#+1000
        BEQ.N    ??LPLD_CAN_SetBaud_7
        B.N      ??LPLD_CAN_SetBaud_8
//  670   {
//  671     case (33):	// 33.33K
//  672       if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
??LPLD_CAN_SetBaud_0:
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+18
        BPL.N    ??LPLD_CAN_SetBaud_9
//  673       { 
//  674          // 48M/120= 400k sclock, 12Tq
//  675          // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  676          // RJW = 3, PSEG1 = 4, PSEG2 = 4,PRESDIV = 120
//  677         CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  678                                           | CAN_CTRL1_RJW(2)
//  679                                           | CAN_CTRL1_PSEG1(3) 
//  680                                           | CAN_CTRL1_PSEG2(3)
//  681                                           | CAN_CTRL1_PRESDIV(119));
        LDR.N    R1,??DataTable12_10  ;; 0x779b0002
        STR      R1,[R0, #+4]
        B.N      ??LPLD_CAN_SetBaud_10
//  682       }
//  683       else
//  684       { 
//  685          // 12M/20= 600k sclock, 18Tq
//  686          // PROPSEG = 1, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  687          // RJW = 4, PSEG1 = 8, PSEG2 = 8,PRESDIV = 20
//  688         CAN_CTRL1_REG(canptr) = (0  | CAN_CTRL1_PROPSEG(0) 
//  689                                           | CAN_CTRL1_PROPSEG(3)
//  690                                           | CAN_CTRL1_PSEG1(7) 
//  691                                           | CAN_CTRL1_PSEG2(7)
//  692                                           | CAN_CTRL1_PRESDIV(19));
??LPLD_CAN_SetBaud_9:
        LDR.N    R1,??DataTable12_11  ;; 0x133f0003
        STR      R1,[R0, #+4]
//  693       }
//  694     break;
//  695   case (83):	// 83.33K
//  696     if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
//  697     {
//  698      // 48M/48= 1M sclock, 12Tq
//  699      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  700      // RJW = 3, PSEG1 = 4, PSEG2 = 4,PRESDIV = 48
//  701       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  702                                       | CAN_CTRL1_RJW(2)
//  703                                       | CAN_CTRL1_PSEG1(3)
//  704                                       | CAN_CTRL1_PSEG2(3)
//  705                                       | CAN_CTRL1_PRESDIV(47));
//  706     }
//  707     else
//  708     { 
//  709      // 12M/12= 1M sclock, 12Tq
//  710      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  711      // RJW = 3, PSEG1 = 4, PSEG2 = 4,PRESDIV = 12
//  712       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  713                                       | CAN_CTRL1_RJW(2)
//  714                                       | CAN_CTRL1_PSEG1(3) 
//  715                                       | CAN_CTRL1_PSEG2(3)
//  716                                       | CAN_CTRL1_PRESDIV(11));
//  717     }
//  718     break;
//  719   case (50):
//  720     if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
//  721     {                
//  722      // 48M/80= 0.6M sclock, 12Tq
//  723      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  724      // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 40
//  725       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  726                                       | CAN_CTRL1_RJW(1)
//  727                                       | CAN_CTRL1_PSEG1(3) 
//  728                                       | CAN_CTRL1_PSEG2(3)
//  729                                       | CAN_CTRL1_PRESDIV(79));
//  730     }
//  731     else
//  732     {
//  733      // 12M/20= 0.6M sclock, 12Tq
//  734      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  735      // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 20                 
//  736       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2)
//  737                                       | CAN_CTRL1_RJW(2)
//  738                                       | CAN_CTRL1_PSEG1(3) 
//  739                                       | CAN_CTRL1_PSEG2(3)
//  740                                       | CAN_CTRL1_PRESDIV(19));                   
//  741     }
//  742     break;
//  743   case (100):
//  744     if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
//  745     { 
//  746      // 48M/40= 1.2M sclock, 12Tq
//  747      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  748      // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 40
//  749       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2)
//  750                                       | CAN_CTRL1_RJW(2)
//  751                                       | CAN_CTRL1_PSEG1(3) 
//  752                                       | CAN_CTRL1_PSEG2(3)
//  753                                       | CAN_CTRL1_PRESDIV(39));
//  754     }
//  755     else
//  756     {
//  757      // 12M/10= 1.2M sclock, 12Tq
//  758      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  759      // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 10
//  760       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  761                                       | CAN_CTRL1_RJW(2)
//  762                                       | CAN_CTRL1_PSEG1(3) 
//  763                                       | CAN_CTRL1_PSEG2(3)
//  764                                       | CAN_CTRL1_PRESDIV(9));                   
//  765     }
//  766     break;
//  767   case (125):
//  768     if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
//  769     {                 
//  770      // 48M/32= 1.5M sclock, 12Tq
//  771      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  772      // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 32
//  773       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  774                                       | CAN_CTRL1_RJW(2)
//  775                                       | CAN_CTRL1_PSEG1(3) 
//  776                                       | CAN_CTRL1_PSEG2(3)
//  777                                       | CAN_CTRL1_PRESDIV(31));
//  778     }
//  779     else
//  780     {
//  781      // 12M/8= 1.5M sclock, 12Tq
//  782      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  783      // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 8
//  784       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  785                                       | CAN_CTRL1_RJW(2)
//  786                                       | CAN_CTRL1_PSEG1(3) 
//  787                                       | CAN_CTRL1_PSEG2(3)
//  788                                       | CAN_CTRL1_PRESDIV(7));                  
//  789     }
//  790     break;
//  791   case (250):
//  792     if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
//  793     {                
//  794      // 48M/16= 3M sclock, 12Tq
//  795      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  796      // RJW = 2, PSEG1 = 4, PSEG2 = 4, PRESDIV = 16
//  797       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2)
//  798                                       | CAN_CTRL1_RJW(1)
//  799                                       | CAN_CTRL1_PSEG1(3) 
//  800                                       | CAN_CTRL1_PSEG2(3)
//  801                                       | CAN_CTRL1_PRESDIV(15));
//  802     }
//  803     else
//  804     {
//  805      // 12M/4= 3M sclock, 12Tq
//  806      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  807      // RJW = 2, PSEG1 = 4, PSEG2 = 4, PRESDIV = 4
//  808       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  809                                       | CAN_CTRL1_RJW(1)
//  810                                       | CAN_CTRL1_PSEG1(3)
//  811                                       | CAN_CTRL1_PSEG2(3)
//  812                                       | CAN_CTRL1_PRESDIV(3));                   
//  813     }
//  814     break;
//  815   case (500):
//  816     if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
//  817     {                
//  818      // 48M/8=6M sclock, 12Tq
//  819      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  820      // RJW = 2, PSEG1 = 4, PSEG2 = 4, PRESDIV = 6
//  821       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  822                                       | CAN_CTRL1_RJW(1)
//  823                                       | CAN_CTRL1_PSEG1(3) 
//  824                                       | CAN_CTRL1_PSEG2(3)
//  825                                       | CAN_CTRL1_PRESDIV(7));
//  826     }
//  827     else
//  828     {
//  829      // 12M/2=6M sclock, 12Tq
//  830      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  831      // RJW = 2, PSEG1 = 4, PSEG2 = 4, PRESDIV = 2
//  832       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  833                                       | CAN_CTRL1_RJW(1)
//  834                                       | CAN_CTRL1_PSEG1(3) 
//  835                                       | CAN_CTRL1_PSEG2(3)
//  836                                       | CAN_CTRL1_PRESDIV(1));                   
//  837     }
//  838     break;
//  839   case (1000): 
//  840     if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
//  841     {                  
//  842      // 48M/6=8M sclock
//  843      // PROPSEG = 4, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  844      // RJW = 1, PSEG1 = 1, PSEG2 = 2, PRESCALER = 6
//  845       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(3) 
//  846                                       | CAN_CTRL1_RJW(0)
//  847                                       | CAN_CTRL1_PSEG1(0)
//  848                                       | CAN_CTRL1_PSEG2(1)
//  849                                       | CAN_CTRL1_PRESDIV(5));
//  850     }
//  851     else
//  852     {  
//  853      // 12M/1=12M sclock,12Tq
//  854      // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
//  855      // RJW = 4, PSEG1 = 4, PSEG2 = 4, PRESCALER = 1
//  856       CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
//  857                                       | CAN_CTRL1_RJW(3)
//  858                                       | CAN_CTRL1_PSEG1(3) 
//  859                                       | CAN_CTRL1_PSEG2(3)
//  860                                       | CAN_CTRL1_PRESDIV(0));
//  861     }
//  862     break;
//  863   default: 
//  864     return 0;
//  865   }
//  866   return 1;
??LPLD_CAN_SetBaud_10:
??LPLD_CAN_SetBaud_11:
        MOVS     R0,#+1
??LPLD_CAN_SetBaud_12:
        BX       LR               ;; return
??LPLD_CAN_SetBaud_2:
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+18
        BPL.N    ??LPLD_CAN_SetBaud_13
        LDR.N    R1,??DataTable12_12  ;; 0x2f9b0002
        STR      R1,[R0, #+4]
        B.N      ??LPLD_CAN_SetBaud_14
??LPLD_CAN_SetBaud_13:
        LDR.N    R1,??DataTable12_13  ;; 0xb9b0002
        STR      R1,[R0, #+4]
??LPLD_CAN_SetBaud_14:
        B.N      ??LPLD_CAN_SetBaud_11
??LPLD_CAN_SetBaud_1:
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+18
        BPL.N    ??LPLD_CAN_SetBaud_15
        LDR.N    R1,??DataTable12_14  ;; 0x4f5b0002
        STR      R1,[R0, #+4]
        B.N      ??LPLD_CAN_SetBaud_16
??LPLD_CAN_SetBaud_15:
        LDR.N    R1,??DataTable12_15  ;; 0x139b0002
        STR      R1,[R0, #+4]
??LPLD_CAN_SetBaud_16:
        B.N      ??LPLD_CAN_SetBaud_11
??LPLD_CAN_SetBaud_3:
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+18
        BPL.N    ??LPLD_CAN_SetBaud_17
        LDR.N    R1,??DataTable12_16  ;; 0x279b0002
        STR      R1,[R0, #+4]
        B.N      ??LPLD_CAN_SetBaud_18
??LPLD_CAN_SetBaud_17:
        LDR.N    R1,??DataTable12_17  ;; 0x99b0002
        STR      R1,[R0, #+4]
??LPLD_CAN_SetBaud_18:
        B.N      ??LPLD_CAN_SetBaud_11
??LPLD_CAN_SetBaud_4:
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+18
        BPL.N    ??LPLD_CAN_SetBaud_19
        LDR.N    R1,??DataTable12_18  ;; 0x1f9b0002
        STR      R1,[R0, #+4]
        B.N      ??LPLD_CAN_SetBaud_20
??LPLD_CAN_SetBaud_19:
        LDR.N    R1,??DataTable12_19  ;; 0x79b0002
        STR      R1,[R0, #+4]
??LPLD_CAN_SetBaud_20:
        B.N      ??LPLD_CAN_SetBaud_11
??LPLD_CAN_SetBaud_5:
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+18
        BPL.N    ??LPLD_CAN_SetBaud_21
        LDR.N    R1,??DataTable12_20  ;; 0xf5b0002
        STR      R1,[R0, #+4]
        B.N      ??LPLD_CAN_SetBaud_22
??LPLD_CAN_SetBaud_21:
        LDR.N    R1,??DataTable12_21  ;; 0x35b0002
        STR      R1,[R0, #+4]
??LPLD_CAN_SetBaud_22:
        B.N      ??LPLD_CAN_SetBaud_11
??LPLD_CAN_SetBaud_6:
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+18
        BPL.N    ??LPLD_CAN_SetBaud_23
        LDR.N    R1,??DataTable12_22  ;; 0x75b0002
        STR      R1,[R0, #+4]
        B.N      ??LPLD_CAN_SetBaud_24
??LPLD_CAN_SetBaud_23:
        LDR.N    R1,??DataTable12_23  ;; 0x15b0002
        STR      R1,[R0, #+4]
??LPLD_CAN_SetBaud_24:
        B.N      ??LPLD_CAN_SetBaud_11
??LPLD_CAN_SetBaud_7:
        LDR      R1,[R0, #+4]
        LSLS     R1,R1,#+18
        BPL.N    ??LPLD_CAN_SetBaud_25
        LDR.N    R1,??DataTable12_24  ;; 0x5010003
        STR      R1,[R0, #+4]
        B.N      ??LPLD_CAN_SetBaud_26
??LPLD_CAN_SetBaud_25:
        LDR.N    R1,??DataTable12_25  ;; 0xdb0002
        STR      R1,[R0, #+4]
??LPLD_CAN_SetBaud_26:
        B.N      ??LPLD_CAN_SetBaud_11
??LPLD_CAN_SetBaud_8:
        MOVS     R0,#+0
        B.N      ??LPLD_CAN_SetBaud_12
//  867 }
//  868 
//  869 /*
//  870  * LPLD_CAN_Isr
//  871  * CAN通用中断底层入口函数
//  872  * 
//  873  * 用户无需修改，程序自动进入对应通道中断函数
//  874  */
//  875 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  876 void LPLD_CAN_Isr(void)
//  877 {
LPLD_CAN_Isr:
        PUSH     {R7,LR}
//  878   #define CAN_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
//  879   uint8 can_active_int = CAN_VECTORNUM - 45;
        LDR.N    R0,??DataTable12_26  ;; 0xe000ed04
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+45
//  880   CAN_ISR[can_active_int]();
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable12_9
        LDR      R0,[R1, R0, LSL #+2]
        BLX      R0
//  881 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12:
        DC32     CANx_Ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_1:
        DC32     0x40065000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_2:
        DC32     0x4004803c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_3:
        DC32     0x40048030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_4:
        DC32     0x40049030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_5:
        DC32     0x40049034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_6:
        DC32     0x4004d060

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_7:
        DC32     0x4004d064

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_8:
        DC32     `?<Constant "F:\\\\robot _init\\\\robot\\\\...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_9:
        DC32     CAN_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_10:
        DC32     0x779b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_11:
        DC32     0x133f0003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_12:
        DC32     0x2f9b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_13:
        DC32     0xb9b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_14:
        DC32     0x4f5b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_15:
        DC32     0x139b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_16:
        DC32     0x279b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_17:
        DC32     0x99b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_18:
        DC32     0x1f9b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_19:
        DC32     0x79b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_20:
        DC32     0xf5b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_21:
        DC32     0x35b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_22:
        DC32     0x75b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_23:
        DC32     0x15b0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_24:
        DC32     0x5010003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_25:
        DC32     0xdb0002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12_26:
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
        DC8 "F:\\robot _init\\robot\\lib\\LPLD\\HAL_CAN.c"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC32 0
        DC8 0, 0, 0, 0

        END
// 
//    64 bytes in section .bss
//    20 bytes in section .data
//    48 bytes in section .rodata
// 2 090 bytes in section .text
// 
// 2 090 bytes of CODE  memory
//    48 bytes of CONST memory
//    84 bytes of DATA  memory
//
//Errors: none
//Warnings: none
