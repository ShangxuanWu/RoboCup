///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:14:00 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\HAL_USB_Device.c          /
//    Command line =  "F:\robot _init\robot\lib\LPLD\HAL_USB_Device.c" -D     /
//                    IAR -D LPLD_K60 -lCN "F:\robot                          /
//                    _init\robot\project\robot_car_com\iar\FLASH\List\" -lB  /
//                    "F:\robot _init\robot\project\robot_car_com\iar\FLASH\L /
//                    ist\" -o "F:\robot _init\robot\project\robot_car_com\ia /
//                    r\FLASH\Obj\" --no_cse --no_unroll --no_inline          /
//                    --no_code_motion --no_tbaa --no_clustering              /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config "D:\IAR     /
//                    Systems\Embedded Workbench                              /
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
//                    st\HAL_USB_Device.s                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME HAL_USB_Device

        #define SHT_PROGBITS 0x1

        EXTERN BufferPointer
        EXTERN CDC_Init
        EXTERN EP_IN_Transfer
        EXTERN Setup_Pkt
        EXTERN USB_EP_OUT_SizeCheck
        EXTERN USB_Protocol_Handler
        EXTERN USB_Rev_SetIsr
        EXTERN enable_irq
        EXTERN gu8EP3_OUT_ODD_Buffer
        EXTERN gu8USB_Flags
        EXTERN gu8USB_State
        EXTERN tBDTtable

        PUBLIC LPLD_USB_Device_Enumed
        PUBLIC LPLD_USB_Device_Init
        PUBLIC LPLD_USB_Device_Isr
        PUBLIC LPLD_USB_Init
        PUBLIC LPLD_USB_SetRevIsr
        PUBLIC LPLD_USB_VirtualCom_Rx
        PUBLIC LPLD_USB_VirtualCom_Tx
        PUBLIC USB_ISR

// F:\robot _init\robot\lib\LPLD\HAL_USB_Device.c
//    1 /*
//    2  * --------------"��������K60�ײ��"-----------------
//    3  *
//    4  * ����Ӳ��ƽ̨:LPLD_K60 Card
//    5  * ��Ȩ����:�����������µ��Ӽ������޹�˾
//    6  * ��������:http://laplenden.taobao.com
//    7  * ��˾�Ż�:http://www.lpld.cn
//    8  *
//    9  * �ļ���: HAL_USB_Device.c
//   10  * ��;: �ڸ��ļ��ж�����USB�豸ģʽ�µ�Ӧ�ú���
//   11  *          ��ʱUSB�Ĺ�������ΪCDC��
//   12  *
//   13  * ������ʹ��Э��:
//   14  *  ��������������ʹ���߿���Դ���룬�����߿��������޸�Դ���롣�����μ�����ע��Ӧ
//   15  *  ���Ա��������ø��Ļ�ɾ��ԭ��Ȩ���������������ο����߿��Լ�ע���ΰ�Ȩ�����ߣ�
//   16  *  ��Ӧ�����ش�Э��Ļ����ϣ�����Դ���롢���ó��۴��뱾��
//   17  */
//   18 #include "common.h"     /* Common definitions */
//   19 #include "USB_CDC.h"    /* USB CDC support */
//   20 #include "HAL_USB_Device.h"
//   21 
//   22 /*
//   23  *******���õ�USB�жϣ�����isr.h��ճ��һ�´���:*********
//   24 
//   25 //USBģ���жϷ�����
//   26 #undef  VECTOR_089
//   27 #define VECTOR_089 LPLD_USB_Device_Isr
//   28 //���º�����LPLD_Kinetis�ײ���������޸�
//   29 extern void LPLD_USB_Device_Isr(void);
//   30 
//   31  ***********************�������*************************
//   32 */
//   33 //�û��Զ����жϷ���������

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   34 USB_ISR_CALLBACK USB_ISR[1];
USB_ISR:
        DS8 4
//   35 
//   36 /*
//   37 * LPLD_USB_Init
//   38 *   K60 USBģ���ʼ������
//   39 *   
//   40 */
//   41 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   42 void LPLD_USB_Init(void)
//   43 {  
LPLD_USB_Init:
        PUSH     {R7,LR}
//   44   Setup_Pkt=(tUSB_Setup*)BufferPointer[bEP0OUT_ODD];//��gu8EP0_OUT_ODD_Buffer�ĵ�ַ����Setup_Pkt
        LDR.N    R0,??DataTable4
        LDR.N    R1,??DataTable4_1
        LDR      R1,[R1, #+0]
        STR      R1,[R0, #+0]
//   45   gu8USB_State = uPOWER;
        LDR.N    R0,??DataTable4_2
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   46   /* MPU ���� */
//   47   MPU_CESR=0;                                     // MPU is disable. All accesses from all bus masters are allowed
        LDR.N    R0,??DataTable4_3  ;; 0x4000d000
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//   48   /* SIM ���� */
//   49   #ifdef USB_CLOCK_CLKIN
//   50   SIM_SCGC5 |=SIM_SCGC5_PORTE_MASK;
//   51   PORTE_PCR26=(0|PORT_PCR_MUX(7));                // Enabling PTE26 as CLK input    
//   52   #endif    
//   53   
//   54   #ifdef USB_CLOCK_PLL
//   55   SIM_SOPT2 |=SIM_SOPT2_PLLFLLSEL_MASK;           //��PLL��ΪUSB��ʱ��Դ����ʱ��PLL��Ƶ��Ϊ96Mhz
        LDR.N    R0,??DataTable4_4  ;; 0x40048004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x10000
        LDR.N    R1,??DataTable4_4  ;; 0x40048004
        STR      R0,[R1, #+0]
//   56   #endif
//   57   
//   58   #ifndef USB_CLOCK_CLKIN    
//   59   SIM_SOPT2 |=SIM_SOPT2_USBSRC_MASK;              //ѡ��PLL/FLL��Ϊʱ��Դ
        LDR.N    R0,??DataTable4_4  ;; 0x40048004
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40000
        LDR.N    R1,??DataTable4_4  ;; 0x40048004
        STR      R0,[R1, #+0]
//   60   #endif
//   61   
//   62   SIM_CLKDIV2|=USB_FARCTIONAL_VALUE;              //USB Freq Divider
        LDR.N    R0,??DataTable4_5  ;; 0x40048048
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x2
        LDR.N    R1,??DataTable4_5  ;; 0x40048048
        STR      R0,[R1, #+0]
//   63                                                   //����USB�ķ�Ƶֵ2,��PLL����2���ã���ǰUSB��Ƶ��Ϊ48Mhz
//   64   SIM_SCGC4|= SIM_SCGC4_USBOTG_MASK;              //USB Clock Gating 
        LDR.N    R0,??DataTable4_6  ;; 0x40048034
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x40000
        LDR.N    R1,??DataTable4_6  ;; 0x40048034
        STR      R0,[R1, #+0]
//   65                                                   //����USBģ���ʱ��Դ 
//   66   /* NVICģ������ */
//   67   enable_irq(73);                                 //ʹ��NVIC�е�USB OTG�ж�
        MOVS     R0,#+73
        BL       enable_irq
//   68   USB_ISR[0] = USB_Protocol_Handler;              //��USBЭ�鴦������ӵ��жϴ�����������
        LDR.N    R0,??DataTable4_7
        LDR.N    R1,??DataTable4_8
        STR      R1,[R0, #+0]
//   69   
//   70   /* USBģ������ */
//   71   USB0_USBTRC0|=USB_USBTRC0_USBRESET_MASK;          //��λUSBģ��
        LDR.N    R0,??DataTable4_9  ;; 0x4007210c
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x80
        LDR.N    R1,??DataTable4_9  ;; 0x4007210c
        STRB     R0,[R1, #+0]
//   72   while(USB0_USBTRC0 & USB_USBTRC0_USBRESET_MASK){};//�ȴ�USB��λ���
??LPLD_USB_Init_0:
        LDR.N    R0,??DataTable4_9  ;; 0x4007210c
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BMI.N    ??LPLD_USB_Init_0
//   73   USB0_BDTPAGE1=(UINT8)((UINT32)tBDTtable>>8);     //���õ�ǰ������������BDT
        LDR.N    R0,??DataTable4_10
        LSRS     R0,R0,#+8
        LDR.N    R1,??DataTable4_11  ;; 0x4007209c
        STRB     R0,[R1, #+0]
//   74   USB0_BDTPAGE2=(UINT8)((UINT32)tBDTtable>>16);
        LDR.N    R0,??DataTable4_10
        LSRS     R0,R0,#+16
        LDR.N    R1,??DataTable4_12  ;; 0x400720b0
        STRB     R0,[R1, #+0]
//   75   USB0_BDTPAGE3=(UINT8)((UINT32)tBDTtable>>24); 
        LDR.N    R0,??DataTable4_10
        LSRS     R0,R0,#+24
        LDR.N    R1,??DataTable4_13  ;; 0x400720b4
        STRB     R0,[R1, #+0]
//   76   USB0_ISTAT |= USB_ISTAT_USBRST_MASK;             //�����λ��־
        LDR.N    R0,??DataTable4_14  ;; 0x40072080
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_14  ;; 0x40072080
        STRB     R0,[R1, #+0]
//   77   USB0_INTEN |= USB_INTEN_USBRSTEN_MASK;           //ʹ��USB��λ�ж� 
        LDR.N    R0,??DataTable4_15  ;; 0x40072084
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_15  ;; 0x40072084
        STRB     R0,[R1, #+0]
//   78   USB0_USBCTRL =0x40;                              //ʹ��������                                                      
        LDR.N    R0,??DataTable4_16  ;; 0x40072100
        MOVS     R1,#+64
        STRB     R1,[R0, #+0]
//   79   USB0_USBTRC0|=0x40;                              //ʹ���첽�ָ��ж�
        LDR.N    R0,??DataTable4_9  ;; 0x4007210c
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x40
        LDR.N    R1,??DataTable4_9  ;; 0x4007210c
        STRB     R0,[R1, #+0]
//   80   USB0_CTL|=0x01;                                  //ʹ��USBģ��
        LDR.N    R0,??DataTable4_17  ;; 0x40072094
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x1
        LDR.N    R1,??DataTable4_17  ;; 0x40072094
        STRB     R0,[R1, #+0]
//   81   USB0_CONTROL |=USB_CONTROL_DPPULLUPNONOTG_MASK;  //�ڷ�USB OTGģʽ�£�ʹ����������
        LDR.N    R0,??DataTable4_18  ;; 0x40072108
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,#0x10
        LDR.N    R1,??DataTable4_18  ;; 0x40072108
        STRB     R0,[R1, #+0]
//   82 }
        POP      {R0,PC}          ;; return
//   83 
//   84 /*
//   85 *  LPLD_USB_Device_Init
//   86 *    USB�豸ģʽ��ʼ������
//   87 *       �ڸú����г�ʼ��USB��ѹģ��
//   88 *       ��ͣ��USB��ѹģ���Standbyģʽ
//   89 *       ��ʼ��USB��CDCģʽ
//   90 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   91 void LPLD_USB_Device_Init(void)
//   92 {
LPLD_USB_Device_Init:
        PUSH     {R7,LR}
//   93   SIM_SOPT1 |= SIM_SOPT1_USBREGEN_MASK;  //ʹ��USB��ѹģ��
        LDR.N    R0,??DataTable4_19  ;; 0x40047000
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,#0x80000000
        LDR.N    R1,??DataTable4_19  ;; 0x40047000
        STR      R0,[R1, #+0]
//   94   SIM_SOPT1 &= (~SIM_SOPT1_USBSTBY_MASK);//ֹͣUSB��ѹģ���standbyģʽ
        LDR.N    R0,??DataTable4_19  ;; 0x40047000
        LDR      R0,[R0, #+0]
        BICS     R0,R0,#0x40000000
        LDR.N    R1,??DataTable4_19  ;; 0x40047000
        STR      R0,[R1, #+0]
//   95   LPLD_USB_Init(); //��ʼ��USBģ��
        BL       LPLD_USB_Init
//   96 
//   97 #if(USB_DEVICE_CLASS == USB_DEVICE_CLASS_CDC)
//   98   CDC_Init(); //��ʼ��USB CDCģʽ
        BL       CDC_Init
//   99 #endif
//  100 }
        POP      {R0,PC}          ;; return
//  101 
//  102 /*
//  103 * LPLD_USB_Device_Enumed
//  104 *   �жϵ�ǰCDC�豸�Ƿ�����ö��
//  105 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  106 void LPLD_USB_Device_Enumed(void)
//  107 {
//  108   while(gu8USB_State != uENUMERATED);//�ȴ�USB�豸��ö��
LPLD_USB_Device_Enumed:
??LPLD_USB_Device_Enumed_0:
        LDR.N    R0,??DataTable4_2
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??LPLD_USB_Device_Enumed_0
//  109 }
        BX       LR               ;; return
//  110 
//  111 /*
//  112 *  LPLD_USB_VirtualCom_Rx
//  113 *    ��USB CDC��ģʽ����ɴ���ģʽ���ú����Ǵ��ڽ��պ���
//  114 *    ����
//  115 *      |__*rx_buf ָ���û����ݴ洢�������ڴ�����յ�������
//  116 *    ����ֵ���������ݵĳ��ȣ����ֽ�Ϊ��λ
//  117 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  118 uint8_t LPLD_USB_VirtualCom_Rx(uint8_t *rx_buf)
//  119 {
LPLD_USB_VirtualCom_Rx:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  120   uint8_t len;
//  121   uint8_t temp=0;
        MOVS     R0,#+0
//  122   uint8_t *pu8EPBuffer;
//  123   
//  124   if(FLAG_CHK(EP_OUT,gu8USB_Flags))// ��������ݵ���
        LDR.N    R1,??DataTable4_20
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+28
        BPL.N    ??LPLD_USB_VirtualCom_Rx_0
//  125   {
//  126     len = USB_EP_OUT_SizeCheck(EP_OUT);   
        MOVS     R0,#+3
        BL       USB_EP_OUT_SizeCheck
        MOVS     R1,R0
//  127     temp= len;
        MOVS     R0,R1
//  128     pu8EPBuffer = gu8EP3_OUT_ODD_Buffer;
        LDR.N    R2,??DataTable4_21
        B.N      ??LPLD_USB_VirtualCom_Rx_1
//  129     
//  130     while(len--)
//  131       *rx_buf++=*pu8EPBuffer++;
??LPLD_USB_VirtualCom_Rx_2:
        LDRB     R3,[R2, #+0]
        STRB     R3,[R4, #+0]
        ADDS     R2,R2,#+1
        ADDS     R4,R4,#+1
??LPLD_USB_VirtualCom_Rx_1:
        MOVS     R3,R1
        SUBS     R1,R3,#+1
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        CMP      R3,#+0
        BNE.N    ??LPLD_USB_VirtualCom_Rx_2
//  132       
//  133     usbEP_Reset(EP_OUT);
        LDR.N    R1,??DataTable4_10
        MOVS     R2,#+32
        STRH     R2,[R1, #+98]
//  134     usbSIE_CONTROL(EP_OUT);
        LDR.N    R1,??DataTable4_10
        MOVS     R2,#+128
        STRB     R2,[R1, #+96]
//  135     FLAG_CLR(EP_OUT,gu8USB_Flags);
        LDR.N    R1,??DataTable4_20
        LDRB     R1,[R1, #+0]
        ANDS     R1,R1,#0xF7
        LDR.N    R2,??DataTable4_20
        STRB     R1,[R2, #+0]
//  136   }  
//  137   return temp;
??LPLD_USB_VirtualCom_Rx_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4,PC}          ;; return
//  138 }
//  139 
//  140 /*
//  141 *  LPLD_USB_VirtualCom_Tx
//  142 *    ��USB CDC��ģʽ����ɴ���ģʽ���ú����Ǵ��ڷ��ͺ���
//  143 *    ����
//  144 *      |__*tx_buf ָ���û����ݴ洢�������ڴ���Ҫ���͵�����
//  145 *      |__len Ҫ���͵����ݳ���
//  146 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  147 void LPLD_USB_VirtualCom_Tx(uint8_t *tx_buf,uint8_t len)
//  148 {
LPLD_USB_VirtualCom_Tx:
        PUSH     {R7,LR}
//  149    EP_IN_Transfer(EP2,tx_buf,len);
        MOVS     R2,R1
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R1,R0
        MOVS     R0,#+2
        BL       EP_IN_Transfer
//  150 }
        POP      {R0,PC}          ;; return
//  151 
//  152 
//  153 /*
//  154 *  LPLD_USB_SetRevIsr
//  155 *    ���USB���������жϷ�����
//  156 *  ��
//  157 *  ��
//  158 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  159 void LPLD_USB_SetRevIsr(USB_REV_ISR_CALLBACK isr)
//  160 {
LPLD_USB_SetRevIsr:
        PUSH     {R7,LR}
//  161   USB_Rev_SetIsr(isr);
        BL       USB_Rev_SetIsr
//  162 }
        POP      {R0,PC}          ;; return
//  163 
//  164 
//  165 /*
//  166 *  LPLD_USB_Device_Isr
//  167 *    USB�жϴ�����
//  168 */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  169 void LPLD_USB_Device_Isr(void)
//  170 {
LPLD_USB_Device_Isr:
        PUSH     {R7,LR}
//  171   #define USB_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
//  172   uint8 USB_Isr_Num = USB_VECTORNUM - 89;
        LDR.N    R0,??DataTable4_22  ;; 0xe000ed04
        LDRB     R0,[R0, #+0]
        SUBS     R0,R0,#+89
//  173   //�����û��Զ����жϷ���
//  174   USB_ISR[USB_Isr_Num]();  
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.N    R1,??DataTable4_7
        LDR      R0,[R1, R0, LSL #+2]
        BLX      R0
//  175 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     Setup_Pkt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     BufferPointer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     gu8USB_State

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x4000d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x40048004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0x40048048

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     USB_ISR

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     USB_Protocol_Handler

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_9:
        DC32     0x4007210c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_10:
        DC32     tBDTtable

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_11:
        DC32     0x4007209c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_12:
        DC32     0x400720b0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_13:
        DC32     0x400720b4

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_14:
        DC32     0x40072080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_15:
        DC32     0x40072084

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_16:
        DC32     0x40072100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_17:
        DC32     0x40072094

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_18:
        DC32     0x40072108

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_19:
        DC32     0x40047000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_20:
        DC32     gu8USB_Flags

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_21:
        DC32     gu8EP3_OUT_ODD_Buffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_22:
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
//  176 
//  177 
// 
//   4 bytes in section .bss
// 454 bytes in section .text
// 
// 454 bytes of CODE memory
//   4 bytes of DATA memory
//
//Errors: none
//Warnings: none
