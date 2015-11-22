///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:56 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\HAL_I2C.c                 /
//    Command line =  "F:\robot _init\robot\lib\LPLD\HAL_I2C.c" -D IAR -D     /
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
//                    st\HAL_I2C.s                                            /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_I2C

        #define SHT_PROGBITS 0x1

        EXTERN assert_failed

        PUBLIC I2Cx_Ptr
        PUBLIC LPLD_I2C_Init
        PUBLIC LPLD_I2C_ReStart
        PUBLIC LPLD_I2C_Read
        PUBLIC LPLD_I2C_SetMasterWR
        PUBLIC LPLD_I2C_Start
        PUBLIC LPLD_I2C_StartTrans
        PUBLIC LPLD_I2C_Stop
        PUBLIC LPLD_I2C_WaitAck
        PUBLIC LPLD_I2C_Write

// F:\robot _init\robot\lib\LPLD\HAL_I2C.c
//    1 /*
//    2  * --------------"��������K60�ײ��"-----------------
//    3  *
//    4  * ����Ӳ��ƽ̨:LPLD_K60 Card
//    5  * ��Ȩ����:�����������µ��Ӽ������޹�˾
//    6  * ��������:http://laplenden.taobao.com
//    7  * ��˾�Ż�:http://www.lpld.cn
//    8  *
//    9  * �ļ���: HAL_I2C.c
//   10  * ��;: I2C�ײ�ģ����غ���
//   11  * ����޸�����: 20120402
//   12  *
//   13  * ������ʹ��Э��:
//   14  *  ��������������ʹ���߿���Դ���룬�����߿��������޸�Դ���롣�����μ�����ע��Ӧ
//   15  *  ���Ա��������ø��Ļ�ɾ��ԭ��Ȩ���������������ο����߿��Լ�ע���ΰ�Ȩ�����ߣ�
//   16  *  ��Ӧ�����ش�Э��Ļ����ϣ�����Դ���롢���ó��۴��뱾��
//   17  */
//   18 
//   19 #include "common.h"
//   20 #include "HAL_I2C.h"
//   21 
//   22 
//   23 
//   24 //I2Cӳ���ַ����

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   25 volatile I2C_MemMapPtr I2Cx_Ptr[2] = {I2C0_BASE_PTR, 
I2Cx_Ptr:
        DATA
        DC32 40066000H, 40067000H
//   26                                       I2C1_BASE_PTR};
//   27 
//   28 /*
//   29  * LPLD_I2C_Init
//   30  * I2Cͨ�ó�ʼ������
//   31  * 
//   32  * ����:
//   33  *    i2cx--ѡ��I2Cģ���
//   34  *      |__I2C0           --I2C0��ģ��
//   35  *      |__I2C1           --I2C1��ģ��
//   36  *    port--ͨ���˿�λѡ��
//   37  *      |__0              --I2C0(PTB2-I2C0_SCL PTB3-I2C0_SDA)
//   38  *      |                 --I2C1(PTE0-I2C1_SDA PTE1-I2C1_SCL)
//   39  *      |__1              --I2C0(PTD8-I2C0_SCL PTD9-I2C0_SDA)
//   40  *      |                 --I2C1(PTC10-I2C1_SCL PTC11-I2C1_SDA)
//   41  *    scl_frq--ѡ��IIC SCLƵ��
//   42  *      |__I2C_SCL_50KHZ  --50khz
//   43  *      |__I2C_SCL_100KHZ --100khz
//   44  *      |__I2C_SCL_150KHZ --150khz
//   45  *      |__I2C_SCL_200KHZ --200khz
//   46  *      |__I2C_SCL_250KHZ --250khz
//   47  *      |__I2C_SCL_300KHZ --300khz
//   48  * ���:
//   49  *    0--���ô���
//   50  *    1--���óɹ�
//   51  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   52 uint8 LPLD_I2C_Init(I2Cx i2cx, uint8 port, uint8 scl_frq)
//   53 {
LPLD_I2C_Init:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//   54   uint8 ps; 
//   55   
//   56   //�������
//   57   ASSERT( i2cx <= I2C1);                            //�ж�I2Cxģ���
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+2
        BCC.N    ??LPLD_I2C_Init_0
        MOVS     R1,#+57
        LDR.N    R0,??DataTable7
        BL       assert_failed
//   58   ASSERT( scl_frq <= I2C_SCL_300KHZ);               //�ж�SCLƵ��
??LPLD_I2C_Init_0:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+6
        BCC.N    ??LPLD_I2C_Init_1
        MOVS     R1,#+58
        LDR.N    R0,??DataTable7
        BL       assert_failed
//   59   ASSERT( port <= 1);                               //�ж϶˿�ѡ��
??LPLD_I2C_Init_1:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+2
        BCC.N    ??LPLD_I2C_Init_2
        MOVS     R1,#+59
        LDR.N    R0,??DataTable7
        BL       assert_failed
//   60   
//   61   //����Ƶ��50mhz
//   62   //scl_frq=50mhz/(mul * scl div)
//   63   if(scl_frq == I2C_SCL_50KHZ)
??LPLD_I2C_Init_2:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??LPLD_I2C_Init_3
//   64   {
//   65     ps=0x33;
        MOVS     R0,#+51
//   66   }
//   67   else if(scl_frq == I2C_SCL_100KHZ)
//   68   {
//   69     ps=0x2B;
//   70   }
//   71   else if(scl_frq == I2C_SCL_150KHZ)
//   72   {
//   73     ps=0x28;
//   74   }
//   75   else if(scl_frq == I2C_SCL_200KHZ)
//   76   {
//   77     ps=0x23;
//   78   }
//   79   else if(scl_frq == I2C_SCL_250KHZ)
//   80   {
//   81     ps=0x21;
//   82   }
//   83   else if(scl_frq == I2C_SCL_300KHZ)
//   84   {
//   85     ps=0x20;
//   86   }
//   87   else
//   88     return 0;
//   89 
//   90   if(i2cx==I2C0)
??LPLD_I2C_Init_4:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??LPLD_I2C_Init_5
//   91   {
//   92     if(!port)
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??LPLD_I2C_Init_6
//   93     {
//   94       /* configure GPIO for I2C0 function */
//   95       PORTB_PCR2 = PORT_PCR_MUX(2);
        LDR.N    R1,??DataTable7_1  ;; 0x4004a008
        MOV      R2,#+512
        STR      R2,[R1, #+0]
//   96       PORTB_PCR3 = PORT_PCR_MUX(2);   
        LDR.N    R1,??DataTable7_2  ;; 0x4004a00c
        MOV      R2,#+512
        STR      R2,[R1, #+0]
//   97     }
//   98     else if(port==1)
//   99     {
//  100       /* configure GPIO for I2C0 function */
//  101       PORTD_PCR8 = PORT_PCR_MUX(2);
//  102       PORTD_PCR9 = PORT_PCR_MUX(2);   
//  103     }
//  104     else
//  105       return 0;
//  106     
//  107     SIM_SCGC4 |= SIM_SCGC4_I2C0_MASK; //����I2C0ʱ��
??LPLD_I2C_Init_7:
        LDR.N    R1,??DataTable7_3  ;; 0x40048034
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x40
        LDR.N    R2,??DataTable7_3  ;; 0x40048034
        STR      R1,[R2, #+0]
//  108   }
//  109   else if(i2cx==I2C1)
//  110   {
//  111     if(!port)
//  112     {
//  113       /* configure GPIO for I2C0 function */
//  114       PORTE_PCR0 = PORT_PCR_MUX(6);
//  115       PORTE_PCR1 = PORT_PCR_MUX(6);   
//  116     }
//  117     else if(port==1)
//  118     {
//  119       /* configure GPIO for I2C0 function */
//  120       PORTC_PCR10 = PORT_PCR_MUX(2);
//  121       PORTC_PCR11 = PORT_PCR_MUX(2);   
//  122     }
//  123     else
//  124       return 0;
//  125     
//  126     SIM_SCGC4 |= SIM_SCGC4_I2C1_MASK; //����IIC1ʱ��
//  127   }
//  128   else
//  129     return 0;
//  130   
//  131   I2C_F_REG(I2Cx_Ptr[i2cx]) = ps;
??LPLD_I2C_Init_8:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R1,??DataTable7_4
        LDR      R1,[R1, R4, LSL #+2]
        STRB     R0,[R1, #+1]
//  132   I2C_C1_REG(I2Cx_Ptr[i2cx]) = I2C_C1_IICEN_MASK;      //ʹ��I2Cx
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.N    R0,??DataTable7_4
        LDR      R0,[R0, R4, LSL #+2]
        MOVS     R1,#+128
        STRB     R1,[R0, #+2]
//  133   
//  134   return 1;
        MOVS     R0,#+1
??LPLD_I2C_Init_9:
        POP      {R4-R6,PC}       ;; return
??LPLD_I2C_Init_3:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+1
        BNE.N    ??LPLD_I2C_Init_10
        MOVS     R0,#+43
        B.N      ??LPLD_I2C_Init_4
??LPLD_I2C_Init_10:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+2
        BNE.N    ??LPLD_I2C_Init_11
        MOVS     R0,#+40
        B.N      ??LPLD_I2C_Init_4
??LPLD_I2C_Init_11:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??LPLD_I2C_Init_12
        MOVS     R0,#+35
        B.N      ??LPLD_I2C_Init_4
??LPLD_I2C_Init_12:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??LPLD_I2C_Init_13
        MOVS     R0,#+33
        B.N      ??LPLD_I2C_Init_4
??LPLD_I2C_Init_13:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+5
        BNE.N    ??LPLD_I2C_Init_14
        MOVS     R0,#+32
        B.N      ??LPLD_I2C_Init_4
??LPLD_I2C_Init_14:
        MOVS     R0,#+0
        B.N      ??LPLD_I2C_Init_9
??LPLD_I2C_Init_6:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+1
        BNE.N    ??LPLD_I2C_Init_15
        LDR.N    R1,??DataTable7_5  ;; 0x4004c020
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        LDR.N    R1,??DataTable7_6  ;; 0x4004c024
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        B.N      ??LPLD_I2C_Init_7
??LPLD_I2C_Init_15:
        MOVS     R0,#+0
        B.N      ??LPLD_I2C_Init_9
??LPLD_I2C_Init_5:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BNE.N    ??LPLD_I2C_Init_16
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??LPLD_I2C_Init_17
        LDR.N    R1,??DataTable7_7  ;; 0x4004d000
        MOV      R2,#+1536
        STR      R2,[R1, #+0]
        LDR.N    R1,??DataTable7_8  ;; 0x4004d004
        MOV      R2,#+1536
        STR      R2,[R1, #+0]
??LPLD_I2C_Init_18:
        LDR.N    R1,??DataTable7_3  ;; 0x40048034
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,#0x80
        LDR.N    R2,??DataTable7_3  ;; 0x40048034
        STR      R1,[R2, #+0]
        B.N      ??LPLD_I2C_Init_8
??LPLD_I2C_Init_17:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+1
        BNE.N    ??LPLD_I2C_Init_19
        LDR.N    R1,??DataTable7_9  ;; 0x4004b028
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        LDR.N    R1,??DataTable7_10  ;; 0x4004b02c
        MOV      R2,#+512
        STR      R2,[R1, #+0]
        B.N      ??LPLD_I2C_Init_18
??LPLD_I2C_Init_19:
        MOVS     R0,#+0
        B.N      ??LPLD_I2C_Init_9
??LPLD_I2C_Init_16:
        MOVS     R0,#+0
        B.N      ??LPLD_I2C_Init_9
//  135 }
//  136 
//  137 
//  138 /*
//  139  * LPLD_I2C_Start
//  140  * I2C��ʼ�źŲ���
//  141  * 
//  142  * ����:
//  143  *    i2cx--ѡ��I2Cģ���
//  144  *      |__I2C0           --I2C0��ģ��
//  145  *      |__I2C1           --I2C1��ģ��
//  146  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  147 void LPLD_I2C_Start(I2Cx i2cx)
//  148 {
//  149   I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
LPLD_I2C_Start:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable7_4
        LDR      R0,[R1, R0, LSL #+2]
//  150   I2C_C1_REG(i2cptr) |= I2C_C1_TX_MASK ;
        LDRB     R1,[R0, #+2]
        ORRS     R1,R1,#0x10
        STRB     R1,[R0, #+2]
//  151   I2C_C1_REG(i2cptr) |= I2C_C1_MST_MASK ;
        LDRB     R1,[R0, #+2]
        ORRS     R1,R1,#0x20
        STRB     R1,[R0, #+2]
//  152 }
        BX       LR               ;; return
//  153 
//  154 
//  155 /*
//  156  * LPLD_ReStart
//  157  * I2C�ٴβ�����ʼ�ź�
//  158  * 
//  159  * ����:
//  160  *    i2cx--ѡ��I2Cģ���
//  161  *      |__I2C0           --I2C0��ģ��
//  162  *      |__I2C1           --I2C1��ģ��
//  163 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  164 void LPLD_I2C_ReStart(I2Cx i2cx)
//  165 {
//  166   I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
LPLD_I2C_ReStart:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable7_4
        LDR      R0,[R1, R0, LSL #+2]
//  167   I2C_C1_REG(i2cptr) |= I2C_C1_RSTA_MASK ;
        LDRB     R1,[R0, #+2]
        ORRS     R1,R1,#0x4
        STRB     R1,[R0, #+2]
//  168 }
        BX       LR               ;; return
//  169 
//  170 
//  171 /*
//  172  * LPLD_I2C_Stop
//  173  * I2Cֹͣ�źŲ���
//  174  * 
//  175  * ����:
//  176  *    i2cx--ѡ��I2Cģ���
//  177  *      |__I2C0           --I2C0��ģ��
//  178  *      |__I2C1           --I2C1��ģ��
//  179  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  180 void LPLD_I2C_Stop(I2Cx i2cx)
//  181 {
//  182   I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
LPLD_I2C_Stop:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable7_4
        LDR      R0,[R1, R0, LSL #+2]
//  183   I2C_C1_REG(i2cptr) &=(~I2C_C1_MST_MASK);
        LDRB     R1,[R0, #+2]
        ANDS     R1,R1,#0xDF
        STRB     R1,[R0, #+2]
//  184   I2C_C1_REG(i2cptr) &=(~I2C_C1_TX_MASK); 
        LDRB     R1,[R0, #+2]
        ANDS     R1,R1,#0xEF
        STRB     R1,[R0, #+2]
//  185 }
        BX       LR               ;; return
//  186 
//  187 
//  188 /*
//  189  * LPLD_I2C_WaitAck
//  190  * I2C���õȴ�Ӧ���źţ�������ȴ����ر��򲻵ȴ�
//  191  * 
//  192  * ����:
//  193  *    i2cx--ѡ��I2Cģ���
//  194  *      |__I2C0           --I2C0��ģ��
//  195  *      |__I2C1           --I2C1��ģ��
//  196  *    is_wait--ѡ���Ƿ�ȴ�Ӧ��
//  197  *      |__I2C_ACK_OFF    --�رյȴ�Ack
//  198  *      |__I2C_ACK_ON     --�����ȴ�Ack�����ȴ�ACK�ź�
//  199  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  200 void LPLD_I2C_WaitAck(I2Cx i2cx, uint8 is_wait)
//  201 {
//  202   I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
LPLD_I2C_WaitAck:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable7_4
        LDR      R2,[R2, R0, LSL #+2]
//  203   uint16 time_out;
//  204   if(is_wait == I2C_ACK_ON)
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+1
        BEQ.N    ??LPLD_I2C_WaitAck_0
//  205   {
//  206     while(!(I2C_S_REG(I2Cx_Ptr[i2cx]) & I2C_S_IICIF_MASK))
//  207     {
//  208       if(time_out>60000) //����ȴ���ʱ��ǿ���˳�
//  209         break;
//  210       else time_out++;
//  211     }
//  212     I2C_S_REG(i2cptr) |= I2C_S_IICIF_MASK;
//  213   }
//  214   else
//  215   {
//  216     //�ر�I2C��ACK
//  217     I2C_C1_REG(i2cptr) |= I2C_C1_TXAK_MASK; 
        LDRB     R0,[R2, #+2]
        ORRS     R0,R0,#0x8
        STRB     R0,[R2, #+2]
//  218   }
//  219 }
??LPLD_I2C_WaitAck_1:
        BX       LR               ;; return
??LPLD_I2C_WaitAck_2:
        ADDS     R3,R3,#+1
??LPLD_I2C_WaitAck_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable7_4
        LDR      R1,[R1, R0, LSL #+2]
        LDRB     R1,[R1, #+3]
        LSLS     R1,R1,#+30
        BMI.N    ??LPLD_I2C_WaitAck_3
        MOVW     R1,#+60001
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        CMP      R3,R1
        BCC.N    ??LPLD_I2C_WaitAck_2
??LPLD_I2C_WaitAck_3:
        LDRB     R0,[R2, #+3]
        ORRS     R0,R0,#0x2
        STRB     R0,[R2, #+3]
        B.N      ??LPLD_I2C_WaitAck_1
//  220 
//  221 
//  222 /*
//  223  * LPLD_I2C_Write
//  224  * I2C����һ���ֽ����ݸ�Ŀ�ĵ�ַ�豸
//  225  * 
//  226  * ����:
//  227  *    i2cx--ѡ��I2Cģ���
//  228  *      |__I2C0           --I2C0��ģ��
//  229  *      |__I2C1           --I2C1��ģ��
//  230  *    data8--Ҫ���͵��ֽ�����
//  231  *
//  232  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  233 void LPLD_I2C_Write(I2Cx i2cx, uint8 data8)
//  234 {
//  235   I2C_D_REG(I2Cx_Ptr[i2cx]) = data8; 
LPLD_I2C_Write:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable7_4
        LDR      R0,[R2, R0, LSL #+2]
        STRB     R1,[R0, #+4]
//  236 }
        BX       LR               ;; return
//  237 
//  238 
//  239 /*
//  240  * LPLD_I2C_Read
//  241  * I2C���ⲿ�豸��һ���ֽ�����
//  242  * 
//  243  * ����:
//  244  *    i2cx--ѡ��I2Cģ���
//  245  *      |__I2C0           --I2C0��ģ��
//  246  *      |__I2C1           --I2C1��ģ��
//  247  * ����ֵ:
//  248  *    I2C��ȡ������ 
//  249  */
//  250 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  251 uint8 LPLD_I2C_Read(I2Cx i2cx)
//  252 {
//  253   uint8 temp;
//  254   temp = I2C_D_REG(I2Cx_Ptr[i2cx]); 
LPLD_I2C_Read:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable7_4
        LDR      R0,[R1, R0, LSL #+2]
        LDRB     R0,[R0, #+4]
//  255   return temp;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  256 }
//  257 
//  258 /*
//  259  * LPLD_I2C_SetMasterWR
//  260  * I2C������дģʽ����
//  261  * 
//  262  * ����:
//  263  *    IICx--ѡ��I2Cģ���ͨ��
//  264  *      |__0 I2C0
//  265  *      |__1 I2C1
//  266  *    mode--��дģʽѡ��
//  267  *      |__I2C_MWSR         --����д
//  268  *      |__I2C_MRSW         --������
//  269  */
//  270 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  271 void LPLD_I2C_SetMasterWR(I2Cx i2cx, uint8 mode)
//  272 {
//  273   I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
LPLD_I2C_SetMasterWR:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R2,??DataTable7_4
        LDR      R0,[R2, R0, LSL #+2]
//  274   if(mode==I2C_MRSW) 
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+1
        BNE.N    ??LPLD_I2C_SetMasterWR_0
//  275     I2C_C1_REG(i2cptr) &= (~I2C_C1_TX_MASK);
        LDRB     R1,[R0, #+2]
        ANDS     R1,R1,#0xEF
        STRB     R1,[R0, #+2]
        B.N      ??LPLD_I2C_SetMasterWR_1
//  276   else
//  277     I2C_C1_REG(i2cptr) |= ( I2C_C1_TX_MASK);
??LPLD_I2C_SetMasterWR_0:
        LDRB     R1,[R0, #+2]
        ORRS     R1,R1,#0x10
        STRB     R1,[R0, #+2]
//  278 }
??LPLD_I2C_SetMasterWR_1:
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC32     `?<Constant "F:\\\\robot _init\\\\robot\\\\...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_1:
        DC32     0x4004a008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_2:
        DC32     0x4004a00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_3:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_4:
        DC32     I2Cx_Ptr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_5:
        DC32     0x4004c020

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_6:
        DC32     0x4004c024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_7:
        DC32     0x4004d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_8:
        DC32     0x4004d004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_9:
        DC32     0x4004b028

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_10:
        DC32     0x4004b02c
//  279 
//  280 /*
//  281  * LPLD_IIC_StartTrans
//  282  * I2C��ʼ���亯������Ҫ������Χ�豸��ַ�Ͷ�дģʽ
//  283  * 
//  284  * ����:
//  285  *    IICx--ѡ��I2Cģ���ͨ��
//  286  *      |__0 I2C0
//  287  *      |__1 I2C1
//  288  *    addr--��Χ�豸��ַ     
//  289  *    mode--��дģʽѡ��
//  290  *      |__I2C_MWSR         --����д
//  291  *      |__I2C_MRSW         --������
//  292  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  293 void LPLD_I2C_StartTrans(I2Cx i2cx, uint8 addr, uint8 mode)
//  294 {
LPLD_I2C_StartTrans:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  295   //I2C����start�ź�
//  296   LPLD_I2C_Start(i2cx);
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_I2C_Start
//  297   //���ӻ���ַ��������дλ�ϳ�һ���ֽ�д��
//  298   LPLD_I2C_Write(i2cx, (addr<<1)|mode );
        ORRS     R1,R6,R5, LSL #+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       LPLD_I2C_Write
//  299 }
        POP      {R4-R6,PC}       ;; return

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
        DC8 "F:\\robot _init\\robot\\lib\\LPLD\\HAL_I2C.c"

        END
//  300 
//  301 
//  302 
//  303 
// 
//   8 bytes in section .data
//  40 bytes in section .rodata
// 546 bytes in section .text
// 
// 546 bytes of CODE  memory
//  40 bytes of CONST memory
//   8 bytes of DATA  memory
//
//Errors: none
//Warnings: none
