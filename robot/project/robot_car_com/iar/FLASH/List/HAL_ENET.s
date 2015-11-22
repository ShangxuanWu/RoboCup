///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:55 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\HAL_ENET.c                /
//    Command line =  "F:\robot _init\robot\lib\LPLD\HAL_ENET.c" -D IAR -D    /
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
//                    st\HAL_ENET.s                                           /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_ENET

        #define SHT_PROGBITS 0x1

        EXTERN enable_irq
        EXTERN memcpy
        EXTERN periph_clk_khz
        EXTERN printf
        EXTERN set_irq_priority

        PUBLIC ENET_ISR
        PUBLIC LPLD_ENET_HashAddress
        PUBLIC LPLD_ENET_Init
        PUBLIC LPLD_ENET_MacRecv
        PUBLIC LPLD_ENET_MacSend
        PUBLIC LPLD_ENET_MiiInit
        PUBLIC LPLD_ENET_MiiRead
        PUBLIC LPLD_ENET_MiiWrite
        PUBLIC LPLD_ENET_RXF_Isr
        PUBLIC LPLD_ENET_SetAddress
        PUBLIC LPLD_ENET_SetIsr
        PUBLIC LPLD_ENET_TXF_Isr

// F:\robot _init\robot\lib\LPLD\HAL_ENET.c
//    1 /*
//    2  * --------------"��������K60�ײ��"-----------------
//    3  *
//    4  * ����Ӳ��ƽ̨:LPLD_K60 Card
//    5  * ��Ȩ����:�����������µ��Ӽ������޹�˾
//    6  * ��������:http://laplenden.taobao.com
//    7  * ��˾�Ż�:http://www.lpld.cn
//    8  *
//    9  * �ļ���: HAL_ENET.c
//   10  * ��;: ENET�ײ�ģ����غ���
//   11  * ����޸�����: 20120920
//   12  *
//   13  * ������ʹ��Э��:
//   14  *  ��������������ʹ���߿���Դ���룬�����߿��������޸�Դ���롣�����μ�����ע��Ӧ
//   15  *  ���Ա��������ø��Ļ�ɾ��ԭ��Ȩ���������������ο����߿��Լ�ע���ΰ�Ȩ�����ߣ�
//   16  *  ��Ӧ�����ش�Э��Ļ����ϣ�����Դ���롢���ó��۴��뱾��
//   17  */
//   18 /*
//   19  *******���õ�ENET�жϣ�����isr.h��ճ��һ�´���:*********
//   20 
//   21 //ENETģ���жϷ�����
//   22 #undef  VECTOR_092
//   23 #define VECTOR_092 LPLD_ENET_TXF_Isr
//   24 #undef  VECTOR_093
//   25 #define VECTOR_093 LPLD_ENET_RXF_Isr
//   26 //���º�����LPLD_Kinetis�ײ���������޸�
//   27 extern void LPLD_ENET_TXF_Isr(void);
//   28 extern void LPLD_ENET_RXF_Isr(void);
//   29 
//   30  ***********************�������*************************
//   31 */
//   32 #include "common.h"
//   33 #include "HAL_ENET.h"

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// static __absolute unsigned char xENETTxDescriptors_unaligned[24U]
xENETTxDescriptors_unaligned:
        DS8 24

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// static __absolute unsigned char xENETRxDescriptors_unaligned[80U]
xENETRxDescriptors_unaligned:
        DS8 80

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// static __absolute unsigned char ucENETRxBuffers[2064]
ucENETRxBuffers:
        DS8 2064

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// static __absolute NBUF *xENETTxDescriptors
xENETTxDescriptors:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// static __absolute NBUF *xENETRxDescriptors
xENETRxDescriptors:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// static __absolute unsigned long uxNextRxBuffer
uxNextRxBuffer:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
// static __absolute unsigned long uxNextTxBuffer
uxNextTxBuffer:
        DS8 4
//   34 
//   35 //�����ⲿ����
//   36 extern int periph_clk_khz;;
//   37 
//   38 //�û��Զ����жϷ���������

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   39 ENET_ISR_CALLBACK ENET_ISR[4]={NULL, NULL, NULL, NULL};
ENET_ISR:
        DS8 16
//   40 
//   41 //�ڲ���������
//   42 static void LPLD_ENET_BDInit( void );
//   43 static void LPLD_ENET_Delay(uint32 time);
//   44 
//   45 
//   46 /*******************************************************************
//   47  *
//   48  *                ENETģ�麯��
//   49  *
//   50 *******************************************************************/
//   51 
//   52 /*
//   53  * LPLD_ENET_Init
//   54  * ENETģ���ʼ��������PHY�շ�����ʼ����MAC��ʼ����BD��ʼ��
//   55  * 
//   56  * ����:
//   57  *    *MACAddress--MAC��ַָ��
//   58  *
//   59  * ���:
//   60  *    ��
//   61  */

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   62 void LPLD_ENET_Init(const uint8* MACAddress)
//   63 {
LPLD_ENET_Init:
        PUSH     {R4,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
//   64  
//   65   uint16 usData;
//   66  
//   67   //ʹ��ENETʱ��
//   68   SIM_SCGC2 |= SIM_SCGC2_ENET_MASK;
        LDR.W    R0,??DataTable11  ;; 0x4004802c
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.W    R1,??DataTable11  ;; 0x4004802c
        STR      R0,[R1, #+0]
//   69 
//   70   //����������MPU������
//   71   MPU_CESR = 0;         
        LDR.W    R0,??DataTable11_1  ;; 0x4000d000
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//   72         
//   73   //��������������ʼ��
//   74   LPLD_ENET_BDInit();
        BL       LPLD_ENET_BDInit
//   75   
//   76   //��λENET
//   77   ENET_ECR = ENET_ECR_RESET_MASK;
        LDR.W    R0,??DataTable11_2  ;; 0x400c0024
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//   78 
//   79   //�ȴ�����8��ʱ������
//   80   for( usData = 0; usData < 10; usData++ )
        MOVS     R0,#+0
        STRH     R0,[SP, #+0]
        B.N      ??LPLD_ENET_Init_0
//   81   {
//   82     asm( "NOP" );
??LPLD_ENET_Init_1:
        NOP
//   83   }
        LDRH     R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STRH     R0,[SP, #+0]
??LPLD_ENET_Init_0:
        LDRH     R0,[SP, #+0]
        CMP      R0,#+10
        BCC.N    ??LPLD_ENET_Init_1
//   84     
//   85   //��ʼ��MII�ӿ�
//   86   LPLD_ENET_MiiInit(periph_clk_khz/1000/*MHz*/);       
        LDR.W    R0,??DataTable11_3
        LDR      R0,[R0, #+0]
        MOV      R1,#+1000
        SDIV     R0,R0,R1
        BL       LPLD_ENET_MiiInit
//   87         
//   88   //ʹ���жϲ��������ȼ�
//   89   set_irq_priority (76, 6);
        MOVS     R1,#+6
        MOVS     R0,#+76
        BL       set_irq_priority
//   90   enable_irq(76);           //ENET�����ж�
        MOVS     R0,#+76
        BL       enable_irq
//   91   set_irq_priority (77, 6);
        MOVS     R1,#+6
        MOVS     R0,#+77
        BL       set_irq_priority
//   92   enable_irq(77);           //ENET�����ж�
        MOVS     R0,#+77
        BL       enable_irq
//   93   //set_irq_priority (78, 6);
//   94   //enable_irq(78);           //ENET���������ж�
//   95 
//   96   //ʹ��GPIO���Ÿ��ù���
//   97   PORTB_PCR0  = PORT_PCR_MUX(4);  //GPIO;//RMII0_MDIO/MII0_MDIO
        LDR.W    R0,??DataTable11_4  ;; 0x4004a000
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
//   98   PORTB_PCR1  = PORT_PCR_MUX(4);  //GPIO;//RMII0_MDC/MII0_MDC    
        LDR.W    R0,??DataTable11_5  ;; 0x4004a004
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
//   99   PORTA_PCR14 = PORT_PCR_MUX(4);  //RMII0_CRS_DV/MII0_RXDV
        LDR.W    R0,??DataTable11_6  ;; 0x40049038
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
//  100   PORTA_PCR12 = PORT_PCR_MUX(4);  //RMII0_RXD1/MII0_RXD1
        LDR.W    R0,??DataTable11_7  ;; 0x40049030
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
//  101   PORTA_PCR13 = PORT_PCR_MUX(4);  //RMII0_RXD0/MII0_RXD0
        LDR.W    R0,??DataTable11_8  ;; 0x40049034
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
//  102   PORTA_PCR15 = PORT_PCR_MUX(4);  //RMII0_TXEN/MII0_TXEN
        LDR.W    R0,??DataTable11_9  ;; 0x4004903c
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
//  103   PORTA_PCR16 = PORT_PCR_MUX(4);  //RMII0_TXD0/MII0_TXD0
        LDR.W    R0,??DataTable11_10  ;; 0x40049040
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
//  104   PORTA_PCR17 = PORT_PCR_MUX(4);  //RMII0_TXD1/MII0_TXD1
        LDR.W    R0,??DataTable11_11  ;; 0x40049044
        MOV      R1,#+1024
        STR      R1,[R0, #+0]
//  105   
//  106     
//  107   //�ȴ�PHY�շ�����λ���
//  108   do
//  109   {
//  110     LPLD_ENET_Delay( ENET_LINK_DELAY );
??LPLD_ENET_Init_2:
        MOVW     R0,#+5000
        BL       LPLD_ENET_Delay
//  111     usData = 0xffff;
        MOVW     R0,#+65535
        STRH     R0,[SP, #+0]
//  112     LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_PHYIDR1, &usData );
        ADD      R2,SP,#+0
        MOVS     R1,#+2
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  113         
//  114   } while( usData == 0xffff );
        LDRH     R0,[SP, #+0]
        MOVW     R1,#+65535
        CMP      R0,R1
        BEQ.N    ??LPLD_ENET_Init_2
//  115 
//  116 #ifdef PHY_PRINT_REG
//  117   printf("PHY_PHYIDR1=0x%X\r\n",usData);
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_12
        BL       printf
//  118   LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_PHYIDR2, &usData );
        ADD      R2,SP,#+0
        MOVS     R1,#+3
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  119   printf("PHY_PHYIDR2=0x%X\r\n",usData); 
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_13
        BL       printf
//  120   LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_ANLPAR, &usData );
        ADD      R2,SP,#+0
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  121   printf("PHY_ANLPAR=0x%X\r\n",usData);
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_14
        BL       printf
//  122   LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_ANLPARNP, &usData );
        ADD      R2,SP,#+0
        MOVS     R1,#+5
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  123   printf("PHY_ANLPARNP=0x%X\r\n",usData);
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_15
        BL       printf
//  124   LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_PHYSTS, &usData );
        ADD      R2,SP,#+0
        MOVS     R1,#+16
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  125   printf("PHY_PHYSTS=0x%X\r\n",usData);
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_16
        BL       printf
//  126   LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_MICR, &usData );
        ADD      R2,SP,#+0
        MOVS     R1,#+17
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  127   printf("PHY_MICR=0x%X\r\n",usData);
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_17
        BL       printf
//  128   LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_MISR, &usData );
        ADD      R2,SP,#+0
        MOVS     R1,#+18
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  129   printf("PHY_MISR=0x%X\r\n",usData);
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_18
        BL       printf
//  130 #endif 
//  131   
//  132   //��ʼ�Զ�Э��
//  133   LPLD_ENET_MiiWrite(CFG_PHY_ADDRESS, PHY_BMCR, ( PHY_BMCR_AN_RESTART | PHY_BMCR_AN_ENABLE ) );
        MOV      R2,#+4608
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiWrite
//  134 
//  135 #ifdef PHY_PRINT_REG
//  136   LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_BMCR, &usData );
        ADD      R2,SP,#+0
        MOVS     R1,#+0
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  137   printf("PHY_BMCR=0x%X\r\n",usData);
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_19
        BL       printf
//  138 #endif 
//  139   
//  140   //�ȴ��Զ�Э�����
//  141   do
//  142   {
//  143     LPLD_ENET_Delay( ENET_LINK_DELAY );
??LPLD_ENET_Init_3:
        MOVW     R0,#+5000
        BL       LPLD_ENET_Delay
//  144     LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_BMSR, &usData );
        ADD      R2,SP,#+0
        MOVS     R1,#+1
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  145 
//  146   } while( !( usData & PHY_BMSR_AN_COMPLETE ) );
        LDRH     R0,[SP, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??LPLD_ENET_Init_3
//  147 
//  148 #ifdef PHY_PRINT_REG
//  149     printf("PHY_BMSR=0x%X\r\n",usData);
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_20
        BL       printf
//  150 #endif 
//  151     
//  152   //����Э�̽������ENETģ��
//  153   LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_STATUS, &usData );  
        ADD      R2,SP,#+0
        MOVS     R1,#+16
        MOVS     R0,#+1
        BL       LPLD_ENET_MiiRead
//  154 
//  155 #ifdef PHY_PRINT_REG
//  156   printf("PHY_STATUS=0x%X\r\n",usData);
        LDRH     R1,[SP, #+0]
        LDR.W    R0,??DataTable11_21
        BL       printf
//  157 #endif 
//  158   
//  159   //������������ַ��ϣ�Ĵ���
//  160   ENET_IALR = 0;
        LDR.W    R0,??DataTable11_22  ;; 0x400c011c
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  161   ENET_IAUR = 0;
        LDR.W    R0,??DataTable11_23  ;; 0x400c0118
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  162   ENET_GALR = 0;
        LDR.W    R0,??DataTable11_24  ;; 0x400c0124
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  163   ENET_GAUR = 0;
        LDR.W    R0,??DataTable11_25  ;; 0x400c0120
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  164   
//  165   //����ENETģ��MAC��ַ
//  166   LPLD_ENET_SetAddress(MACAddress);
        MOVS     R0,R4
        BL       LPLD_ENET_SetAddress
//  167     
//  168   //���ý��տ��ƼĴ�������󳤶ȡ�RMIIģʽ������CRCУ���
//  169   ENET_RCR = ENET_RCR_MAX_FL(CFG_ENET_MAX_PACKET_SIZE) | ENET_RCR_MII_MODE_MASK | ENET_RCR_CRCFWD_MASK | ENET_RCR_RMII_MODE_MASK;
        LDR.W    R0,??DataTable11_26  ;; 0x400c0084
        LDR.W    R1,??DataTable11_27  ;; 0x5f04104
        STR      R1,[R0, #+0]
//  170 
//  171   //������ͽ��տ���
//  172   ENET_TCR = 0;
        LDR.W    R0,??DataTable11_28  ;; 0x400c00c4
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  173         
//  174   //ͨѶ��ʽ����
//  175   if( usData & PHY_DUPLEX_STATUS )
        LDRH     R0,[SP, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??LPLD_ENET_Init_4
//  176   {
//  177     //ȫ˫��
//  178     ENET_RCR &= (unsigned long)~ENET_RCR_DRT_MASK;
        LDR.W    R0,??DataTable11_26  ;; 0x400c0084
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x2
        LDR.W    R1,??DataTable11_26  ;; 0x400c0084
        STR      R0,[R1, #+0]
//  179     ENET_TCR |= ENET_TCR_FDEN_MASK;
        LDR.W    R0,??DataTable11_28  ;; 0x400c00c4
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x4
        LDR.W    R1,??DataTable11_28  ;; 0x400c00c4
        STR      R0,[R1, #+0]
        B.N      ??LPLD_ENET_Init_5
//  180   }
//  181   else
//  182   {
//  183     //��˫��
//  184     ENET_RCR |= ENET_RCR_DRT_MASK;
??LPLD_ENET_Init_4:
        LDR.W    R0,??DataTable11_26  ;; 0x400c0084
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.W    R1,??DataTable11_26  ;; 0x400c0084
        STR      R0,[R1, #+0]
//  185     ENET_TCR &= (unsigned long)~ENET_TCR_FDEN_MASK;
        LDR.W    R0,??DataTable11_28  ;; 0x400c00c4
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x4
        LDR.W    R1,??DataTable11_28  ;; 0x400c00c4
        STR      R0,[R1, #+0]
//  186   }
//  187   
//  188   //ͨ����������
//  189   if( usData & PHY_SPEED_STATUS )
??LPLD_ENET_Init_5:
        LDRH     R0,[SP, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??LPLD_ENET_Init_6
//  190   {
//  191     //10Mbps
//  192     ENET_RCR |= ENET_RCR_RMII_10T_MASK;
        LDR.W    R0,??DataTable11_26  ;; 0x400c0084
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x200
        LDR.W    R1,??DataTable11_26  ;; 0x400c0084
        STR      R0,[R1, #+0]
//  193   }
//  194 
//  195   //ʹ�÷���ǿ�ͻ�����������
//  196   ENET_ECR = 0;
??LPLD_ENET_Init_6:
        LDR.W    R0,??DataTable11_2  ;; 0x400c0024
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  197   
//  198   
//  199   //���ý��ջ���������
//  200   ENET_MRBR = (unsigned short) CFG_ENET_RX_BUFFER_SIZE;
        LDR.W    R0,??DataTable11_29  ;; 0x400c0188
        MOV      R1,#+256
        STR      R1,[R0, #+0]
//  201 
//  202   //ָ���ν��ջ��������������е�ͷ��ַ
//  203   ENET_RDSR = ( unsigned long ) &( xENETRxDescriptors[ 0 ] );
        LDR.W    R0,??DataTable11_30  ;; 0x400c0180
        LDR.W    R1,??DataTable11_31
        LDR      R1,[R1, #+0]
        STR      R1,[R0, #+0]
//  204 
//  205   //ָ���η��ͻ��������������е�ͷ��ַ
//  206   ENET_TDSR = ( unsigned long ) xENETTxDescriptors;
        LDR.W    R0,??DataTable11_32  ;; 0x400c0184
        LDR.W    R1,??DataTable11_33
        LDR      R1,[R1, #+0]
        STR      R1,[R0, #+0]
//  207 
//  208   //���ENET�ж��¼�
//  209   ENET_EIR = ( unsigned long ) -1;
        LDR.W    R0,??DataTable11_34  ;; 0x400c0004
        MOVS     R1,#-1
        STR      R1,[R0, #+0]
//  210 
//  211   //ʹ���ж�
//  212   ENET_EIMR = 0 
//  213             | ENET_EIMR_RXF_MASK  //�����ж�
//  214             | ENET_EIMR_TXF_MASK  //�����ж�
//  215             //ENET�ж�
//  216             | ENET_EIMR_UN_MASK | ENET_EIMR_RL_MASK | ENET_EIMR_LC_MASK | ENET_EIMR_BABT_MASK | ENET_EIMR_BABR_MASK | ENET_EIMR_EBERR_MASK
//  217             | ENET_EIMR_RXB_MASK
//  218             ;
        LDR.W    R0,??DataTable11_35  ;; 0x400c0008
        LDR.W    R1,??DataTable11_36  ;; 0x6b780000
        STR      R1,[R0, #+0]
//  219 
//  220   //ʹ��ENETģ��
//  221   ENET_ECR |= ENET_ECR_ETHEREN_MASK;
        LDR.W    R0,??DataTable11_2  ;; 0x400c0024
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.W    R1,??DataTable11_2  ;; 0x400c0024
        STR      R0,[R1, #+0]
//  222 
//  223   //�������ջ�����Ϊ��
//  224   ENET_RDAR = ENET_RDAR_RDAR_MASK;
        LDR.W    R0,??DataTable11_37  ;; 0x400c0010
        MOVS     R1,#+16777216
        STR      R1,[R0, #+0]
//  225 }
        POP      {R0,R1,R4,PC}    ;; return
//  226 
//  227 
//  228 /*
//  229  * LPLD_ENET_SetIsr
//  230  * ENETģ���жϺ�������
//  231  * 
//  232  * ����:
//  233  *    type--�ж�����
//  234  *      |__ENET_RXF_ISR   -�����ж�
//  235  *      |__ENET_TXF_ISR   -�����ж�
//  236  *    isr_func--�û��жϳ�����ڵ�ַ
//  237  *      |__�û��ڹ����ļ��¶�����жϺ���������������Ϊ:�޷���ֵ,�޲���(eg. void isr(void);)
//  238  *
//  239  * ���:
//  240  *    0--���ô���
//  241  *    1--���óɹ�
//  242  *
//  243  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  244 uint8 LPLD_ENET_SetIsr(uint8 type, ENET_ISR_CALLBACK isr_func)
//  245 {
//  246   if(type>4)
LPLD_ENET_SetIsr:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+5
        BCC.N    ??LPLD_ENET_SetIsr_0
//  247     return 0;
        MOVS     R0,#+0
        B.N      ??LPLD_ENET_SetIsr_1
//  248   
//  249   ENET_ISR[type] = isr_func;
??LPLD_ENET_SetIsr_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R2,??DataTable11_38
        STR      R1,[R2, R0, LSL #+2]
//  250   return 1;
        MOVS     R0,#+1
??LPLD_ENET_SetIsr_1:
        BX       LR               ;; return
//  251 }
//  252 
//  253 
//  254 /*
//  255  * LPLD_ENET_RXF_Isr
//  256  * ENET�����жϵײ���ں���
//  257  * 
//  258  * �û������޸ģ������Զ������Ӧͨ���жϺ���
//  259  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  260 void LPLD_ENET_RXF_Isr(void)
//  261 {   
LPLD_ENET_RXF_Isr:
        PUSH     {R7,LR}
//  262   ENET_EIR |= ENET_EIMR_RXF_MASK; 
        LDR.W    R0,??DataTable11_34  ;; 0x400c0004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2000000
        LDR.W    R1,??DataTable11_34  ;; 0x400c0004
        STR      R0,[R1, #+0]
//  263     
//  264   //�����û��Զ����жϷ���
//  265   if(ENET_ISR[ENET_RXF_ISR])
        LDR.W    R0,??DataTable11_38
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??LPLD_ENET_RXF_Isr_0
//  266   {
//  267     ENET_ISR[ENET_RXF_ISR]();  
        LDR.W    R0,??DataTable11_38
        LDR      R0,[R0, #+0]
        BLX      R0
//  268   }
//  269 }
??LPLD_ENET_RXF_Isr_0:
        POP      {R0,PC}          ;; return
//  270 
//  271 
//  272 /*
//  273  * LPLD_ENET_TXF_Isr
//  274  * ENET�����жϵײ���ں���
//  275  * 
//  276  * �û������޸ģ������Զ������Ӧͨ���жϺ���
//  277  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  278 void LPLD_ENET_TXF_Isr(void)
//  279 {  
LPLD_ENET_TXF_Isr:
        PUSH     {R7,LR}
//  280   ENET_EIR |= ENET_EIMR_TXF_MASK; 
        LDR.W    R0,??DataTable11_34  ;; 0x400c0004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x8000000
        LDR.W    R1,??DataTable11_34  ;; 0x400c0004
        STR      R0,[R1, #+0]
//  281     
//  282   //�����û��Զ����жϷ���
//  283   if(ENET_ISR[ENET_TXF_ISR])
        LDR.W    R0,??DataTable11_38
        LDR      R0,[R0, #+4]
        CMP      R0,#+0
        BEQ.N    ??LPLD_ENET_TXF_Isr_0
//  284   {
//  285     ENET_ISR[ENET_TXF_ISR]();  
        LDR.W    R0,??DataTable11_38
        LDR      R0,[R0, #+4]
        BLX      R0
//  286   }
//  287 }
??LPLD_ENET_TXF_Isr_0:
        POP      {R0,PC}          ;; return
//  288 
//  289 /*
//  290  * LPLD_ENET_Delay
//  291  * ENETģ���ڲ���ʱ����
//  292  * 
//  293  * ����:
//  294  *    time--�ӳٴ�С
//  295  *
//  296  * ���:
//  297  *    ��
//  298  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  299 static void LPLD_ENET_Delay(uint32 time)
//  300 {
//  301   uint32 i = 0,j = 0;
LPLD_ENET_Delay:
        MOVS     R1,#+0
        MOVS     R2,#+0
//  302   
//  303   for(i = 0;i < time;i++)
        MOVS     R3,#+0
        MOVS     R1,R3
        B.N      ??LPLD_ENET_Delay_0
//  304   {
//  305     for(j = 0;j < 50000;j++);
??LPLD_ENET_Delay_1:
        ADDS     R2,R2,#+1
??LPLD_ENET_Delay_2:
        MOVW     R3,#+50000
        CMP      R2,R3
        BCC.N    ??LPLD_ENET_Delay_1
        ADDS     R1,R1,#+1
??LPLD_ENET_Delay_0:
        CMP      R1,R0
        BCS.N    ??LPLD_ENET_Delay_3
        MOVS     R2,#+0
        B.N      ??LPLD_ENET_Delay_2
//  306   }
//  307 }
??LPLD_ENET_Delay_3:
        BX       LR               ;; return
//  308 
//  309 
//  310 /*
//  311  * LPLD_ENET_BDInit
//  312  * ��������������ʼ��
//  313  * 
//  314  * ����:
//  315  *    ��
//  316  *
//  317  * ���:
//  318  *    ��
//  319  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  320 static void LPLD_ENET_BDInit( void )
//  321 {
//  322   unsigned long ux;
//  323   uint8 *pcBufPointer;
//  324   
//  325   //Ѱ��<��������������ռ�>�е�16�ֽڶ���ĵ�ַ��������λΪ0����ʼ��ַ
//  326   pcBufPointer = &( xENETTxDescriptors_unaligned[ 0 ] );
LPLD_ENET_BDInit:
        LDR.W    R1,??DataTable11_39
        B.N      ??LPLD_ENET_BDInit_0
//  327   while( ( ( unsigned long ) pcBufPointer & 0x0fUL ) != 0 )
//  328   {
//  329     pcBufPointer++;
??LPLD_ENET_BDInit_1:
        ADDS     R1,R1,#+1
//  330   }
??LPLD_ENET_BDInit_0:
        ANDS     R0,R1,#0xF
        CMP      R0,#+0
        BNE.N    ??LPLD_ENET_BDInit_1
//  331   xENETTxDescriptors = ( NBUF * ) pcBufPointer;
        LDR.W    R0,??DataTable11_33
        STR      R1,[R0, #+0]
//  332   
//  333   //Ѱ��<��������������ռ�>�е�16�ֽڶ���ĵ�ַ
//  334   pcBufPointer = &( xENETRxDescriptors_unaligned[ 0 ] );
        LDR.W    R1,??DataTable11_40
        B.N      ??LPLD_ENET_BDInit_2
//  335   while( ( ( unsigned long ) pcBufPointer & 0x0fUL ) != 0 )
//  336   {
//  337     pcBufPointer++;
??LPLD_ENET_BDInit_3:
        ADDS     R1,R1,#+1
//  338   }
??LPLD_ENET_BDInit_2:
        ANDS     R0,R1,#0xF
        CMP      R0,#+0
        BNE.N    ??LPLD_ENET_BDInit_3
//  339   xENETRxDescriptors = ( NBUF * ) pcBufPointer;
        LDR.W    R0,??DataTable11_31
        STR      R1,[R0, #+0]
//  340   
//  341   //���ͻ�������������ʼ��
//  342   for( ux = 0; ux < CFG_NUM_ENET_TX_BUFFERS; ux++ )
        MOVS     R0,#+0
        B.N      ??LPLD_ENET_BDInit_4
//  343   {
//  344     xENETTxDescriptors[ ux ].status = 0;
??LPLD_ENET_BDInit_5:
        LDR.W    R1,??DataTable11_33
        LDR      R1,[R1, #+0]
        MOVS     R2,#+0
        STRH     R2,[R1, R0, LSL #+3]
//  345     xENETTxDescriptors[ ux ].data = 0;
        LDR.W    R1,??DataTable11_33
        LDR      R1,[R1, #+0]
        ADDS     R1,R1,R0, LSL #+3
        MOVS     R2,#+0
        STR      R2,[R1, #+4]
//  346     xENETTxDescriptors[ ux ].length = 0;
        LDR.W    R1,??DataTable11_33
        LDR      R1,[R1, #+0]
        ADDS     R1,R1,R0, LSL #+3
        MOVS     R2,#+0
        STRH     R2,[R1, #+2]
//  347   }
        ADDS     R0,R0,#+1
??LPLD_ENET_BDInit_4:
        CMP      R0,#+0
        BEQ.N    ??LPLD_ENET_BDInit_5
//  348   
//  349   //Ѱ��<���ջ������ռ�>�е�16�ֽڶ���ĵ�ַ
//  350   pcBufPointer = &( ucENETRxBuffers[ 0 ] );
        LDR.W    R1,??DataTable11_41
        B.N      ??LPLD_ENET_BDInit_6
//  351   while( ( ( unsigned long ) pcBufPointer & 0x0fUL ) != 0 )
//  352   {
//  353     pcBufPointer++;
??LPLD_ENET_BDInit_7:
        ADDS     R1,R1,#+1
//  354   }
??LPLD_ENET_BDInit_6:
        ANDS     R0,R1,#0xF
        CMP      R0,#+0
        BNE.N    ??LPLD_ENET_BDInit_7
//  355   
//  356   //���ջ�������������ʼ��
//  357   for( ux = 0; ux < CFG_NUM_ENET_RX_BUFFERS; ux++ )
        MOVS     R0,#+0
        B.N      ??LPLD_ENET_BDInit_8
//  358   {
//  359     xENETRxDescriptors[ ux ].status = RX_BD_E;
??LPLD_ENET_BDInit_9:
        LDR.N    R2,??DataTable11_31
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        STRH     R3,[R2, R0, LSL #+3]
//  360     xENETRxDescriptors[ ux ].length = 0;
        LDR.N    R2,??DataTable11_31
        LDR      R2,[R2, #+0]
        ADDS     R2,R2,R0, LSL #+3
        MOVS     R3,#+0
        STRH     R3,[R2, #+2]
//  361     xENETRxDescriptors[ ux ].data = (uint8 *)__REV((uint32)pcBufPointer);
        REV      R2,R1
        LDR.N    R3,??DataTable11_31
        LDR      R3,[R3, #+0]
        ADDS     R3,R3,R0, LSL #+3
        STR      R2,[R3, #+4]
//  362     pcBufPointer += CFG_ENET_RX_BUFFER_SIZE;
        ADDS     R1,R1,#+256
//  363   
//  364   }
        ADDS     R0,R0,#+1
??LPLD_ENET_BDInit_8:
        CMP      R0,#+8
        BCC.N    ??LPLD_ENET_BDInit_9
//  365   
//  366   //���û��������������������е����һ��״̬λΪWrap
//  367   xENETTxDescriptors[ CFG_NUM_ENET_TX_BUFFERS - 1 ].status |= TX_BD_W;
        LDR.N    R0,??DataTable11_33
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+0]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable11_33
        LDR      R1,[R1, #+0]
        STRH     R0,[R1, #+0]
//  368   xENETRxDescriptors[ CFG_NUM_ENET_RX_BUFFERS - 1 ].status |= RX_BD_W;
        LDR.N    R0,??DataTable11_31
        LDR      R0,[R0, #+0]
        LDRH     R0,[R0, #+56]
        ORRS     R0,R0,#0x20
        LDR.N    R1,??DataTable11_31
        LDR      R1,[R1, #+0]
        STRH     R0,[R1, #+56]
//  369   
//  370   uxNextRxBuffer = 0;
        LDR.N    R0,??DataTable11_42
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  371   uxNextTxBuffer = 0;
        LDR.N    R0,??DataTable11_43
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  372 }
        BX       LR               ;; return
//  373 
//  374 /*
//  375  * LPLD_ENET_MacSend
//  376  * ��̫֡���ͺ���
//  377  * 
//  378  * ����:
//  379  *    *ch--����֡ͷ��ַ��������֡Ϊ��̫֡���������Ŀ�ĵ�ַ��Դ��ַ�����͵ȡ�
//  380  *    len--����֡���ȡ�
//  381  *
//  382  * ���:
//  383  *    ��
//  384  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  385 void LPLD_ENET_MacSend(uint8 *ch, uint16 len)
//  386 {
//  387   
//  388   //��鵱ǰ���ͻ������������Ƿ����
//  389   while( xENETTxDescriptors[ uxNextTxBuffer ].status & TX_BD_R);
LPLD_ENET_MacSend:
??LPLD_ENET_MacSend_0:
        LDR.N    R2,??DataTable11_43
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable11_33
        LDR      R3,[R3, #+0]
        LDRB     R2,[R3, R2, LSL #+3]
        LSLS     R2,R2,#+24
        BMI.N    ??LPLD_ENET_MacSend_0
//  390   
//  391   //���÷��ͻ�����������
//  392   xENETTxDescriptors[ uxNextTxBuffer ].data = (uint8 *)__REV((uint32)ch);
        REV      R0,R0
        LDR.N    R2,??DataTable11_43
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable11_33
        LDR      R3,[R3, #+0]
        ADDS     R2,R3,R2, LSL #+3
        STR      R0,[R2, #+4]
//  393   xENETTxDescriptors[ uxNextTxBuffer ].length = __REVSH(len);
        REVSH    R0,R1
        LDR.N    R1,??DataTable11_43
        LDR      R1,[R1, #+0]
        LDR.N    R2,??DataTable11_33
        LDR      R2,[R2, #+0]
        ADDS     R1,R2,R1, LSL #+3
        STRH     R0,[R1, #+2]
//  394   xENETTxDescriptors[ uxNextTxBuffer ].status = ( TX_BD_R | TX_BD_L | TX_BD_TC | TX_BD_W );
        LDR.N    R0,??DataTable11_43
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable11_33
        LDR      R1,[R1, #+0]
        MOVS     R2,#+172
        STRH     R2,[R1, R0, LSL #+3]
//  395   
//  396   uxNextTxBuffer++;
        LDR.N    R0,??DataTable11_43
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable11_43
        STR      R0,[R1, #+0]
//  397   if( uxNextTxBuffer >= CFG_NUM_ENET_TX_BUFFERS )
        LDR.N    R0,??DataTable11_43
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ.N    ??LPLD_ENET_MacSend_1
//  398   {
//  399     uxNextTxBuffer = 0;
        LDR.N    R0,??DataTable11_43
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  400   }
//  401   
//  402   //ʹ�ܷ���
//  403   ENET_TDAR = ENET_TDAR_TDAR_MASK;
??LPLD_ENET_MacSend_1:
        LDR.N    R0,??DataTable11_44  ;; 0x400c0014
        MOVS     R1,#+16777216
        STR      R1,[R0, #+0]
//  404   
//  405 }
        BX       LR               ;; return
//  406 
//  407 
//  408 /*
//  409  * LPLD_ENET_MacRecv
//  410  * ��̫֡���պ���
//  411  * 
//  412  * ����:
//  413  *    *ch--��������֡ͷ��ַ��
//  414  *    *len--����֡���ȵ�ַ��
//  415  *
//  416  * ���:
//  417  *    ��
//  418  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  419 uint8 LPLD_ENET_MacRecv(uint8 *ch, uint16 *len)
//  420 {
LPLD_ENET_MacRecv:
        PUSH     {R7,LR}
//  421   uint8 *prvRxd;
//  422   *len = 0;
        MOVS     R2,#+0
        STRH     R2,[R1, #+0]
//  423   uxNextRxBuffer = 0; 
        LDR.N    R2,??DataTable11_42
        MOVS     R3,#+0
        STR      R3,[R2, #+0]
//  424   
//  425   //Ѱ��Ϊ�ǿյĽ��ջ����������� 
//  426   while( (xENETRxDescriptors[ uxNextRxBuffer ].status & RX_BD_E)!=0 )
??LPLD_ENET_MacRecv_0:
        LDR.N    R2,??DataTable11_42
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable11_31
        LDR      R3,[R3, #+0]
        LDRB     R2,[R3, R2, LSL #+3]
        LSLS     R2,R2,#+24
        BPL.N    ??LPLD_ENET_MacRecv_1
//  427   {
//  428     uxNextRxBuffer++; 
        LDR.N    R2,??DataTable11_42
        LDR      R2,[R2, #+0]
        ADDS     R2,R2,#+1
        LDR.N    R3,??DataTable11_42
        STR      R2,[R3, #+0]
//  429     if( uxNextRxBuffer >= CFG_NUM_ENET_RX_BUFFERS )
        LDR.N    R2,??DataTable11_42
        LDR      R2,[R2, #+0]
        CMP      R2,#+8
        BCC.N    ??LPLD_ENET_MacRecv_0
//  430     {
//  431       uxNextRxBuffer = 0; 
        LDR.N    R0,??DataTable11_42
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  432       return 1;
        MOVS     R0,#+1
        B.N      ??LPLD_ENET_MacRecv_2
//  433     } 
//  434     
//  435   }
//  436   
//  437   //��ȡ���ջ�����������
//  438   *len  =  __REVSH(xENETRxDescriptors[ uxNextRxBuffer ].length);
??LPLD_ENET_MacRecv_1:
        LDR.N    R2,??DataTable11_42
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable11_31
        LDR      R3,[R3, #+0]
        ADDS     R2,R3,R2, LSL #+3
        LDRSH    R2,[R2, #+2]
        REVSH    R2,R2
        STRH     R2,[R1, #+0]
//  439   prvRxd =  (uint8 *)__REV((uint32)xENETRxDescriptors[ uxNextRxBuffer ].data);      
        LDR.N    R2,??DataTable11_42
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable11_31
        LDR      R3,[R3, #+0]
        ADDS     R2,R3,R2, LSL #+3
        LDR      R2,[R2, #+4]
        REV      R3,R2
//  440   memcpy((void *)ch, (void *)prvRxd, *len);      
        LDRH     R2,[R1, #+0]
        MOVS     R1,R3
        BL       memcpy
//  441   
//  442   //������ջ�����������״̬��־Empty
//  443   xENETRxDescriptors[ uxNextRxBuffer ].status |= RX_BD_E;
        LDR.N    R0,??DataTable11_42
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable11_31
        LDR      R1,[R1, #+0]
        LDRH     R0,[R1, R0, LSL #+3]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable11_42
        LDR      R1,[R1, #+0]
        LDR.N    R2,??DataTable11_31
        LDR      R2,[R2, #+0]
        STRH     R0,[R2, R1, LSL #+3]
//  444   ENET_RDAR = ENET_RDAR_RDAR_MASK;	
        LDR.N    R0,??DataTable11_37  ;; 0x400c0010
        MOVS     R1,#+16777216
        STR      R1,[R0, #+0]
//  445   return 0;
        MOVS     R0,#+0
??LPLD_ENET_MacRecv_2:
        POP      {R1,PC}          ;; return
//  446 }
//  447 
//  448 
//  449 /*
//  450  * LPLD_ENET_HashAddress
//  451  * ���ɸ�����MAC��ַ�Ĺ�ϣ��
//  452  * 
//  453  * ����:
//  454  *    *addr--6�ֽڵ�ַָ�롣
//  455  *
//  456  * ���:
//  457  *    32λCRCУ��ĸ�6λ
//  458  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  459 uint8 LPLD_ENET_HashAddress(const uint8* addr)
//  460 {
LPLD_ENET_HashAddress:
        PUSH     {R4-R6}
//  461   uint32 crc;
//  462   uint8 byte;
//  463   int i, j;
//  464   
//  465   crc = 0xFFFFFFFF;
        MOVS     R1,#-1
//  466   for(i=0; i<6; ++i)
        MOVS     R3,#+0
        B.N      ??LPLD_ENET_HashAddress_0
??LPLD_ENET_HashAddress_1:
        ADDS     R3,R3,#+1
??LPLD_ENET_HashAddress_0:
        CMP      R3,#+6
        BGE.N    ??LPLD_ENET_HashAddress_2
//  467   {
//  468     byte = addr[i];
        LDRB     R2,[R3, R0]
//  469     for(j=0; j<8; ++j)
        MOVS     R4,#+0
        B.N      ??LPLD_ENET_HashAddress_3
//  470     {
//  471       if((byte & 0x01)^(crc & 0x01))
//  472       {
//  473         crc >>= 1;
//  474         crc = crc ^ 0xEDB88320;
//  475       }
//  476       else
//  477         crc >>= 1;
??LPLD_ENET_HashAddress_4:
        LSRS     R1,R1,#+1
//  478       byte >>= 1;
??LPLD_ENET_HashAddress_5:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LSRS     R2,R2,#+1
        ADDS     R4,R4,#+1
??LPLD_ENET_HashAddress_3:
        CMP      R4,#+8
        BGE.N    ??LPLD_ENET_HashAddress_1
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        ANDS     R5,R2,#0x1
        ANDS     R6,R1,#0x1
        TEQ      R6,R5
        BEQ.N    ??LPLD_ENET_HashAddress_4
        LSRS     R1,R1,#+1
        LDR.N    R5,??DataTable11_45  ;; 0xedb88320
        EORS     R1,R5,R1
        B.N      ??LPLD_ENET_HashAddress_5
//  479     }
//  480   }
//  481   return (uint8)(crc >> 26);
??LPLD_ENET_HashAddress_2:
        LSRS     R0,R1,#+26
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4-R6}
        BX       LR               ;; return
//  482 }
//  483 
//  484 
//  485 /*
//  486  * LPLD_ENET_SetAddress
//  487  * ����MAC�����ַ
//  488  * 
//  489  * ����:
//  490  *    *pa--6�ֽڵ������ַָ�롣
//  491  *
//  492  * ���:
//  493  *    ��
//  494  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  495 void LPLD_ENET_SetAddress(const uint8 *pa)
//  496 {
LPLD_ENET_SetAddress:
        PUSH     {R7,LR}
//  497   uint8 crc;
//  498   
//  499   //���������ַ
//  500   ENET_PALR = (uint32)((pa[0]<<24) | (pa[1]<<16) | (pa[2]<<8) | pa[3]);
        LDRB     R1,[R0, #+0]
        LDRB     R2,[R0, #+1]
        LSLS     R2,R2,#+16
        ORRS     R1,R2,R1, LSL #+24
        LDRB     R2,[R0, #+2]
        ORRS     R1,R1,R2, LSL #+8
        LDRB     R2,[R0, #+3]
        ORRS     R1,R2,R1
        LDR.N    R2,??DataTable11_46  ;; 0x400c00e4
        STR      R1,[R2, #+0]
//  501   ENET_PAUR = (uint32)((pa[4]<<24) | (pa[5]<<16));
        LDRB     R1,[R0, #+4]
        LDRB     R2,[R0, #+5]
        LSLS     R2,R2,#+16
        ORRS     R1,R2,R1, LSL #+24
        LDR.N    R2,??DataTable11_47  ;; 0x400c00e8
        STR      R1,[R2, #+0]
//  502   
//  503   //���������ַ���㲢���ö�����ַ��ϣ�Ĵ�����ֵ
//  504   crc = LPLD_ENET_HashAddress(pa);
        BL       LPLD_ENET_HashAddress
//  505   if(crc >= 32)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+32
        BCC.N    ??LPLD_ENET_SetAddress_0
//  506     ENET_IAUR |= (uint32)(1 << (crc - 32));
        LDR.N    R1,??DataTable11_23  ;; 0x400c0118
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        SUBS     R0,R0,#+32
        LSLS     R0,R2,R0
        ORRS     R0,R0,R1
        LDR.N    R1,??DataTable11_23  ;; 0x400c0118
        STR      R0,[R1, #+0]
        B.N      ??LPLD_ENET_SetAddress_1
//  507   else
//  508     ENET_IALR |= (uint32)(1 << crc);
??LPLD_ENET_SetAddress_0:
        LDR.N    R1,??DataTable11_22  ;; 0x400c011c
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        LSLS     R0,R2,R0
        ORRS     R0,R0,R1
        LDR.N    R1,??DataTable11_22  ;; 0x400c011c
        STR      R0,[R1, #+0]
//  509 }
??LPLD_ENET_SetAddress_1:
        POP      {R0,PC}          ;; return
//  510 
//  511 
//  512 
//  513 /*******************************************************************
//  514  *
//  515  *                PHY�豸MII�ӿں���
//  516  *
//  517 *******************************************************************/
//  518 
//  519 /*
//  520  * LPLD_ENET_MiiInit
//  521  * ����ENETģ���MII�ӿ�ʱ�ӣ�����Ƶ��Ϊ2.5MHz
//  522  * MII_SPEED = ϵͳʱ�� / (2.5MHz * 2)
//  523  * 
//  524  * ����:
//  525  *    sys_clk_mhz--ϵͳ��Ƶ
//  526  *
//  527  * ���:
//  528  *    ��
//  529  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  530 void LPLD_ENET_MiiInit(int sys_clk_mhz)
//  531 {
//  532   ENET_MSCR = 0 | ENET_MSCR_MII_SPEED((2*sys_clk_mhz/5)+1);
LPLD_ENET_MiiInit:
        LSLS     R0,R0,#+1
        MOVS     R1,#+5
        SDIV     R0,R0,R1
        ADDS     R0,R0,#+1
        LSLS     R0,R0,#+1
        ANDS     R0,R0,#0x7E
        LDR.N    R1,??DataTable11_48  ;; 0x400c0044
        STR      R0,[R1, #+0]
//  533 }
        BX       LR               ;; return
//  534 
//  535 
//  536 /*
//  537  * LPLD_ENET_MiiWrite
//  538  * MII�ӿ�д
//  539  * 
//  540  * ����:
//  541  *    phy_addr--�����շ�����ַ
//  542  *    reg_addr--�Ĵ�����ַ
//  543  *    data--д�������
//  544  *
//  545  * ���:
//  546  *    1--д��ʱ
//  547  *    0--д��ɹ�
//  548  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  549 uint8 LPLD_ENET_MiiWrite(uint16 phy_addr, uint16 reg_addr, uint16 data)
//  550 {
LPLD_ENET_MiiWrite:
        PUSH     {R4}
//  551   uint32 timeout;
//  552   
//  553   //���MII�ж��¼�
//  554   ENET_EIR = ENET_EIR_MII_MASK;
        LDR.N    R3,??DataTable11_34  ;; 0x400c0004
        MOVS     R4,#+8388608
        STR      R4,[R3, #+0]
//  555   
//  556   //��ʼ��MII����֡�Ĵ���
//  557   ENET_MMFR = 0
//  558             | ENET_MMFR_ST(0x01)
//  559             | ENET_MMFR_OP(0x01)
//  560             | ENET_MMFR_PA(phy_addr)
//  561             | ENET_MMFR_RA(reg_addr)
//  562             | ENET_MMFR_TA(0x02)
//  563             | ENET_MMFR_DATA(data);
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSLS     R0,R0,#+23
        ANDS     R0,R0,#0xF800000
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSLS     R1,R1,#+18
        ANDS     R1,R1,#0x7C0000
        ORRS     R0,R1,R0
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ORRS     R0,R2,R0
        LDR.N    R1,??DataTable11_49  ;; 0x50020000
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable11_50  ;; 0x400c0040
        STR      R0,[R1, #+0]
//  564   
//  565   //�ȴ�MII��������ж��¼�
//  566   for (timeout = 0; timeout < MII_TIMEOUT; timeout++)
        MOVS     R0,#+0
        B.N      ??LPLD_ENET_MiiWrite_0
??LPLD_ENET_MiiWrite_1:
        ADDS     R0,R0,#+1
??LPLD_ENET_MiiWrite_0:
        LDR.N    R1,??DataTable11_51  ;; 0x1ffff
        CMP      R0,R1
        BCS.N    ??LPLD_ENET_MiiWrite_2
//  567   {
//  568     if (ENET_EIR & ENET_EIR_MII_MASK)
        LDR.N    R1,??DataTable11_34  ;; 0x400c0004
        LDR      R1,[R1, #+0]
        LSLS     R1,R1,#+8
        BPL.N    ??LPLD_ENET_MiiWrite_1
//  569       break;
//  570   }
//  571   
//  572   if(timeout == MII_TIMEOUT) 
??LPLD_ENET_MiiWrite_2:
        LDR.N    R1,??DataTable11_51  ;; 0x1ffff
        CMP      R0,R1
        BNE.N    ??LPLD_ENET_MiiWrite_3
//  573     return 1;
        MOVS     R0,#+1
        B.N      ??LPLD_ENET_MiiWrite_4
//  574   
//  575   //���MII�ж��¼�
//  576   ENET_EIR = ENET_EIR_MII_MASK;
??LPLD_ENET_MiiWrite_3:
        LDR.N    R0,??DataTable11_34  ;; 0x400c0004
        MOVS     R1,#+8388608
        STR      R1,[R0, #+0]
//  577   
//  578   return 0;
        MOVS     R0,#+0
??LPLD_ENET_MiiWrite_4:
        POP      {R4}
        BX       LR               ;; return
//  579 }
//  580 
//  581 
//  582 /*
//  583  * LPLD_ENET_MiiRead
//  584  * MII�ӿڶ�
//  585  * 
//  586  * ����:
//  587  *    phy_addr--�����շ�����ַ
//  588  *    reg_addr--�Ĵ�����ַ
//  589  *    *data--���������ݵ�ַָ��
//  590  *
//  591  * ���:
//  592  *    1--����ʱ
//  593  *    0--��ȡ�ɹ�
//  594  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  595 uint8 LPLD_ENET_MiiRead(uint16 phy_addr, uint16 reg_addr, uint16 *data)
//  596 {
LPLD_ENET_MiiRead:
        PUSH     {R4}
//  597   uint32 timeout;
//  598   
//  599   //���MII�ж��¼�
//  600   ENET_EIR = ENET_EIR_MII_MASK;
        LDR.N    R3,??DataTable11_34  ;; 0x400c0004
        MOVS     R4,#+8388608
        STR      R4,[R3, #+0]
//  601   
//  602   //��ʼ��MII����֡�Ĵ���
//  603   ENET_MMFR = 0
//  604             | ENET_MMFR_ST(0x01)
//  605             | ENET_MMFR_OP(0x2)
//  606             | ENET_MMFR_PA(phy_addr)
//  607             | ENET_MMFR_RA(reg_addr)
//  608             | ENET_MMFR_TA(0x02);
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSLS     R0,R0,#+23
        ANDS     R0,R0,#0xF800000
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSLS     R1,R1,#+18
        ANDS     R1,R1,#0x7C0000
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable11_52  ;; 0x60020000
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable11_50  ;; 0x400c0040
        STR      R0,[R1, #+0]
//  609   
//  610   //�ȴ�MII��������ж��¼�
//  611   for (timeout = 0; timeout < MII_TIMEOUT; timeout++)
        MOVS     R0,#+0
        B.N      ??LPLD_ENET_MiiRead_0
??LPLD_ENET_MiiRead_1:
        ADDS     R0,R0,#+1
??LPLD_ENET_MiiRead_0:
        LDR.N    R1,??DataTable11_51  ;; 0x1ffff
        CMP      R0,R1
        BCS.N    ??LPLD_ENET_MiiRead_2
//  612   {
//  613     if (ENET_EIR & ENET_EIR_MII_MASK)
        LDR.N    R1,??DataTable11_34  ;; 0x400c0004
        LDR      R1,[R1, #+0]
        LSLS     R1,R1,#+8
        BPL.N    ??LPLD_ENET_MiiRead_1
//  614       break;
//  615   }
//  616   
//  617   if(timeout == MII_TIMEOUT) 
??LPLD_ENET_MiiRead_2:
        LDR.N    R1,??DataTable11_51  ;; 0x1ffff
        CMP      R0,R1
        BNE.N    ??LPLD_ENET_MiiRead_3
//  618     return 1;
        MOVS     R0,#+1
        B.N      ??LPLD_ENET_MiiRead_4
//  619   
//  620   //���MII�ж��¼�
//  621   ENET_EIR = ENET_EIR_MII_MASK;
??LPLD_ENET_MiiRead_3:
        LDR.N    R0,??DataTable11_34  ;; 0x400c0004
        MOVS     R1,#+8388608
        STR      R1,[R0, #+0]
//  622   
//  623   *data = ENET_MMFR & 0x0000FFFF;
        LDR.N    R0,??DataTable11_50  ;; 0x400c0040
        LDR      R0,[R0, #+0]
        STRH     R0,[R2, #+0]
//  624   
//  625   return 0;
        MOVS     R0,#+0
??LPLD_ENET_MiiRead_4:
        POP      {R4}
        BX       LR               ;; return
//  626 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11:
        DC32     0x4004802c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_1:
        DC32     0x4000d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_2:
        DC32     0x400c0024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_3:
        DC32     periph_clk_khz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_4:
        DC32     0x4004a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_5:
        DC32     0x4004a004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_6:
        DC32     0x40049038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_7:
        DC32     0x40049030

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_8:
        DC32     0x40049034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_9:
        DC32     0x4004903c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_10:
        DC32     0x40049040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_11:
        DC32     0x40049044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_12:
        DC32     `?<Constant "PHY_PHYIDR1=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_13:
        DC32     `?<Constant "PHY_PHYIDR2=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_14:
        DC32     `?<Constant "PHY_ANLPAR=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_15:
        DC32     `?<Constant "PHY_ANLPARNP=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_16:
        DC32     `?<Constant "PHY_PHYSTS=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_17:
        DC32     `?<Constant "PHY_MICR=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_18:
        DC32     `?<Constant "PHY_MISR=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_19:
        DC32     `?<Constant "PHY_BMCR=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_20:
        DC32     `?<Constant "PHY_BMSR=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_21:
        DC32     `?<Constant "PHY_STATUS=0x%X\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_22:
        DC32     0x400c011c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_23:
        DC32     0x400c0118

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_24:
        DC32     0x400c0124

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_25:
        DC32     0x400c0120

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_26:
        DC32     0x400c0084

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_27:
        DC32     0x5f04104

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_28:
        DC32     0x400c00c4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_29:
        DC32     0x400c0188

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_30:
        DC32     0x400c0180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_31:
        DC32     xENETRxDescriptors

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_32:
        DC32     0x400c0184

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_33:
        DC32     xENETTxDescriptors

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_34:
        DC32     0x400c0004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_35:
        DC32     0x400c0008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_36:
        DC32     0x6b780000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_37:
        DC32     0x400c0010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_38:
        DC32     ENET_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_39:
        DC32     xENETTxDescriptors_unaligned

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_40:
        DC32     xENETRxDescriptors_unaligned

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_41:
        DC32     ucENETRxBuffers

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_42:
        DC32     uxNextRxBuffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_43:
        DC32     uxNextTxBuffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_44:
        DC32     0x400c0014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_45:
        DC32     0xedb88320

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_46:
        DC32     0x400c00e4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_47:
        DC32     0x400c00e8

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_48:
        DC32     0x400c0044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_49:
        DC32     0x50020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_50:
        DC32     0x400c0040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_51:
        DC32     0x1ffff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_52:
        DC32     0x60020000

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_PHYIDR1=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_PHYIDR1=0x%X\015\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_PHYIDR2=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_PHYIDR2=0x%X\015\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_ANLPAR=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_ANLPAR=0x%X\015\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_ANLPARNP=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_ANLPARNP=0x%X\015\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_PHYSTS=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_PHYSTS=0x%X\015\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_MICR=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_MICR=0x%X\015\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_MISR=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_MISR=0x%X\015\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_BMCR=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_BMCR=0x%X\015\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_BMSR=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_BMSR=0x%X\015\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "PHY_STATUS=0x%X\\r\\n">`:
        DATA
        DC8 "PHY_STATUS=0x%X\015\012"
        DC8 0, 0

        END
// 
// 2 200 bytes in section .bss
//   184 bytes in section .rodata
// 1 846 bytes in section .text
// 
// 1 846 bytes of CODE  memory
//   184 bytes of CONST memory
// 2 200 bytes of DATA  memory
//
//Errors: none
//Warnings: none
