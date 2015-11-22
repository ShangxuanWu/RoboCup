/* 文件名: bsp_int.h
 * 用途: 包括UCOS系统的BSP（板级支持包）函数,本文件用于处理UCOS系统
 * 与K60中断之间的关系
 * 最后修改日期: 20120715
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */

#ifndef __BSP_INT_H__
#define __BSP_INT_H__ 1

typedef  void (*CPU_FNCT_VOID)(void); 
//定义K60的中断参数
#define  BSP_INT_SRC_NBR                                 120    //K60最大有120个中断
#define  BSP_INTC_IRQS                                    91    //有效中断91个
#define  BSP_INTC_LEVELS                                  15    //优先级15等级
#define  ARM_INTERRUPT_LEVEL_BITS                          4


#undef  VECTOR_014
#define VECTOR_014 OS_CPU_PendSVHandler  // 0x0000_0038 14 -         ARM core         Pendable request for system service (PendableSrvReq)

#undef  VECTOR_015
#define VECTOR_015 OS_CPU_SysTickHandler // 0x0000_003C 15 -         ARM core         System tick timer (SysTick)

extern void OS_CPU_SysTickHandler (void);
extern void OS_CPU_PendSVHandler (void);

//重新链接lib/cpu/vector.c的中断向量表 
#undef  VECTOR_016
#define VECTOR_016 BSP_IntHandlerDMA0

#undef  VECTOR_017
#define VECTOR_017 BSP_IntHandlerDMA1

#undef  VECTOR_018
#define VECTOR_018 BSP_IntHandlerDMA2

#undef  VECTOR_019
#define VECTOR_019 BSP_IntHandlerDMA3

#undef  VECTOR_020
#define VECTOR_020 BSP_IntHandlerDMA4

#undef  VECTOR_021
#define VECTOR_021 BSP_IntHandlerDMA5

#undef  VECTOR_022
#define VECTOR_022 BSP_IntHandlerDMA6

#undef  VECTOR_023
#define VECTOR_023 BSP_IntHandlerDMA7

#undef  VECTOR_024
#define VECTOR_024 BSP_IntHandlerDMA8

#undef  VECTOR_025
#define VECTOR_025 BSP_IntHandlerDMA9

#undef  VECTOR_026
#define VECTOR_026 BSP_IntHandlerDMA10

#undef  VECTOR_027
#define VECTOR_027 BSP_IntHandlerDMA11

#undef  VECTOR_028
#define VECTOR_028 BSP_IntHandlerDMA12

#undef  VECTOR_029
#define VECTOR_029 BSP_IntHandlerDMA13

#undef  VECTOR_030
#define VECTOR_030 BSP_IntHandlerDMA14

#undef  VECTOR_031
#define VECTOR_031 BSP_IntHandlerDMA15

#undef  VECTOR_032
#define VECTOR_032 BSP_IntHandlerDMAError

#undef  VECTOR_033
#define VECTOR_033 BSP_IntHandlerMCM

#undef  VECTOR_034
#define VECTOR_034 BSP_IntHandlerFTFL

#undef  VECTOR_035
#define VECTOR_035 BSP_IntHandlerReadCollision

#undef  VECTOR_036
#define VECTOR_036 BSP_IntHandlerLVDLVW

#undef  VECTOR_037
#define VECTOR_037 BSP_IntHandlerLLW

#undef  VECTOR_038
#define VECTOR_038 BSP_IntHandlerWatchdog

#undef  VECTOR_039
#define VECTOR_039 BSP_IntHandlerRNGB

#undef  VECTOR_040
#define VECTOR_040 BSP_IntHandlerI2C0

#undef  VECTOR_041
#define VECTOR_041 BSP_IntHandlerI2C1

#undef  VECTOR_042
#define VECTOR_042 BSP_IntHandlerSPI0

#undef  VECTOR_043
#define VECTOR_043 BSP_IntHandlerSPI1

#undef  VECTOR_044
#define VECTOR_044 BSP_IntHandlerSPI2

#undef  VECTOR_045
#define VECTOR_045 BSP_IntHandlerCAN0ORedMessageBuffer

#undef  VECTOR_046
#define VECTOR_046 BSP_IntHandlerCAN0BusOff

#undef  VECTOR_047
#define VECTOR_047 BSP_IntHandlerCAN0Error

#undef  VECTOR_048
#define VECTOR_048 BSP_IntHandlerCAN0TxWarning

#undef  VECTOR_049
#define VECTOR_049 BSP_IntHandlerCAN0RxWarning

#undef  VECTOR_050
#define VECTOR_050 BSP_IntHandlerCAN0WakeUp

#undef  VECTOR_051
#define VECTOR_051 BSP_IntHandlerCAN0IMEU

#undef  VECTOR_052
#define VECTOR_052 BSP_IntHandlerCAN0LostRx

#undef  VECTOR_053
#define VECTOR_053 BSP_IntHandlerCAN1ORedMessageBuffer

#undef  VECTOR_054
#define VECTOR_054 BSP_IntHandlerCAN1BusOff

#undef  VECTOR_055
#define VECTOR_055 BSP_IntHandlerCAN1Error

#undef  VECTOR_056
#define VECTOR_056 BSP_IntHandlerCAN1TxWarning

#undef  VECTOR_057
#define VECTOR_057 BSP_IntHandlerCAN1RxWarning

#undef  VECTOR_058
#define VECTOR_058 BSP_IntHandlerCAN1WakeUp

#undef  VECTOR_059
#define VECTOR_059 BSP_IntHandlerCAN1IMEU

#undef  VECTOR_060
#define VECTOR_060 BSP_IntHandlerCAN1LostRx

#undef  VECTOR_061
#define VECTOR_061 BSP_IntHandlerUART0RxTx

#undef  VECTOR_062
#define VECTOR_062 BSP_IntHandlerUART0Err

#undef  VECTOR_063
#define VECTOR_063 BSP_IntHandlerUART1RxTx

#undef  VECTOR_064
#define VECTOR_064 BSP_IntHandlerUART1Err

#undef  VECTOR_065
#define VECTOR_065 BSP_IntHandlerUART2RxTx

#undef  VECTOR_066
#define VECTOR_066 BSP_IntHandlerUART2Err

#undef  VECTOR_067
#define VECTOR_067 BSP_IntHandlerUART3RxTx

#undef  VECTOR_068
#define VECTOR_068 BSP_IntHandlerUART3Err

#undef  VECTOR_069
#define VECTOR_069 BSP_IntHandlerUART4RxTx

#undef  VECTOR_070
#define VECTOR_070 BSP_IntHandlerUART4Err

#undef  VECTOR_071
#define VECTOR_071 BSP_IntHandlerUART5RxTx

#undef  VECTOR_072
#define VECTOR_072 BSP_IntHandlerUART5Err

#undef  VECTOR_073
#define VECTOR_073 BSP_IntHandlerADC0

#undef  VECTOR_074
#define VECTOR_074 BSP_IntHandlerADC1

#undef  VECTOR_075
#define VECTOR_075 BSP_IntHandlerHSCMP0

#undef  VECTOR_076
#define VECTOR_076 BSP_IntHandlerHSCMP1

#undef  VECTOR_077
#define VECTOR_077 BSP_IntHandlerHSCMP2

#undef  VECTOR_078
#define VECTOR_078 BSP_IntHandlerFTM0

#undef  VECTOR_079
#define VECTOR_079 BSP_IntHandlerFTM1

#undef  VECTOR_080
#define VECTOR_080 BSP_IntHandlerFTM2

#undef  VECTOR_081
#define VECTOR_081 BSP_IntHandlerCMT

#undef  VECTOR_082
#define VECTOR_082 BSP_IntHandlerRTC

#undef  VECTOR_083
#define VECTOR_083 BSP_IntHandlerReserved83

#undef  VECTOR_084
#define VECTOR_084 BSP_IntHandlerPIT0

#undef  VECTOR_085
#define VECTOR_085 BSP_IntHandlerPIT1

#undef  VECTOR_086
#define VECTOR_086 BSP_IntHandlerPIT2

#undef  VECTOR_087
#define VECTOR_087 BSP_IntHandlerPIT3

#undef  VECTOR_088
#define VECTOR_088 BSP_IntHandlerPDB0

#undef  VECTOR_089
#define VECTOR_089 BSP_IntHandlerUDB0

#undef  VECTOR_090
#define VECTOR_090 BSP_IntHandlerUSBDCD

#undef  VECTOR_091
#define VECTOR_091 BSP_IntHandlerEnet1588Timer

#undef  VECTOR_092
#define VECTOR_092 BSP_IntHandlerEnetTransmit

#undef  VECTOR_093
#define VECTOR_093 BSP_IntHandlerEnetReceive

#undef  VECTOR_094
#define VECTOR_094 BSP_IntHandlerEnetError

#undef  VECTOR_095
#define VECTOR_095 BSP_IntHandlerI2S0

#undef  VECTOR_096
#define VECTOR_096 BSP_IntHandlerSDHC

#undef  VECTOR_097
#define VECTOR_097 BSP_IntHandlerDAC0

#undef  VECTOR_098
#define VECTOR_098 BSP_IntHandlerDAC1

#undef  VECTOR_099
#define VECTOR_099 BSP_IntHandlerTSI0

#undef  VECTOR_100
#define VECTOR_100 BSP_IntHandlerMCG

#undef  VECTOR_101
#define VECTOR_101 BSP_IntHandlerLPTimer

#undef  VECTOR_102
#define VECTOR_102 BSP_IntHandlerReserved102

#undef  VECTOR_103
#define VECTOR_103 BSP_IntHandlerPortA

#undef  VECTOR_104
#define VECTOR_104 BSP_IntHandlerPortB

#undef  VECTOR_105
#define VECTOR_105 BSP_IntHandlerPortC

#undef  VECTOR_106
#define VECTOR_106 BSP_IntHandlerPortD

#undef  VECTOR_107
#define VECTOR_107 BSP_IntHandlerPortE

//重新定义中断标志位

#define  BSP_INT_ID_INITIAL_STACK_POINTER                  0    /* Initial stack pointer                                */
#define  BSP_INT_ID_INITIAL_PROGRAM_COUNTER                1    /* Initial program counter                              */
#define  BSP_INT_ID_NMI                                    2    /* Non-maskable interrupt                               */
#define  BSP_INT_ID_HARD_FAULT                             3    /* Hard fault exception                                 */
#define  BSP_INT_ID_RESERVED4                              4    /* Reserved interrupt 4                                 */
#define  BSP_INT_ID_BUS_FAULT                              5    /* Bus fault exception                                  */
#define  BSP_INT_ID_USAGE_FAULT                            6    /* Usage fault exception                                */
#define  BSP_INT_ID_RESERVED7                              7    /* Reserved interrupt 7                                 */
#define  BSP_INT_ID_RESERVED8                              8    /* Reserved interrupt 8                                 */
#define  BSP_INT_ID_RESERVED9                              9    /* Reserved interrupt 9                                 */
#define  BSP_INT_ID_RESERVED10                            10    /* Reserved interrupt 10                                */
#define  BSP_INT_ID_SVCALL                                11    /* A supervisor call exception                          */
#define  BSP_INT_ID_DEBUG_MONITOR                         12    /* Debug Monitor                                        */
#define  BSP_INT_ID_RESERVED13                            13    /* Reserved interrupt 13                                */
#define  BSP_INT_ID_PENDABLE_SRV_REQ                      14    /* PendSV exception - request for system level service  */
#define  BSP_INT_ID_SYSTICK                               15    /* SysTick Interrupt                                    */
#define  BSP_INT_ID_DMA0                                  16    /* DMA Channel 0 Transfer Complete                      */
#define  BSP_INT_ID_DMA1                                  17    /* DMA Channel 1 Transfer Complete                      */
#define  BSP_INT_ID_DMA2                                  18    /* DMA Channel 2 Transfer Complete                      */
#define  BSP_INT_ID_DMA3                                  19    /* DMA Channel 3 Transfer Complete                      */
#define  BSP_INT_ID_DMA4                                  20    /* DMA Channel 4 Transfer Complete                      */
#define  BSP_INT_ID_DMA5                                  21    /* DMA Channel 5 Transfer Complete                      */
#define  BSP_INT_ID_DMA6                                  22    /* DMA Channel 6 Transfer Complete                      */
#define  BSP_INT_ID_DMA7                                  23    /* DMA Channel 7 Transfer Complete                      */
#define  BSP_INT_ID_DMA8                                  24    /* DMA Channel 8 Transfer Complete                      */
#define  BSP_INT_ID_DMA9                                  25    /* DMA Channel 9 Transfer Complete                      */
#define  BSP_INT_ID_DMA10                                 26    /* DMA Channel 10 Transfer Complete                     */
#define  BSP_INT_ID_DMA11                                 27    /* DMA Channel 11 Transfer Complete                     */
#define  BSP_INT_ID_DMA12                                 28    /* DMA Channel 12 Transfer Complete                     */
#define  BSP_INT_ID_DMA13                                 29    /* DMA Channel 13 Transfer Complete                     */
#define  BSP_INT_ID_DMA14                                 30    /* DMA Channel 14 Transfer Complete                     */
#define  BSP_INT_ID_DMA15                                 31    /* DMA Channel 15 Transfer Complete                     */
#define  BSP_INT_ID_DMA_ERROR                             32    /* DMA Error Interrupt                                  */
#define  BSP_INT_ID_MCM                                   33    /* Normal Interrupt                                     */
#define  BSP_INT_ID_FTFL                                  34    /* FTFL Interrupt                                       */
#define  BSP_INT_ID_READ_COLLISION                        35    /* Read Collision Interrupt                             */
#define  BSP_INT_ID_LVD_LVW                               36    /* Low Voltage Detect, Low Voltage Warning              */
#define  BSP_INT_ID_LLW                                   37    /* Low Leakage Wakeup                                   */
#define  BSP_INT_ID_WATCHDOG                              38    /* WDOG Interrupt                                       */
#define  BSP_INT_ID_RNGB                                  39    /* RNGB Interrupt                                       */
#define  BSP_INT_ID_I2C0                                  40    /* I2C0 interrupt                                       */
#define  BSP_INT_ID_I2C1                                  41    /* I2C1 interrupt                                       */
#define  BSP_INT_ID_SPI0                                  42    /* SPI0 Interrupt                                       */
#define  BSP_INT_ID_SPI1                                  43    /* SPI1 Interrupt                                       */
#define  BSP_INT_ID_SPI2                                  44    /* SPI2 Interrupt                                       */
#define  BSP_INT_ID_CAN0_ORED_MESSAGE_BUFFER              45    /* CAN0 OR'd Message Buffers Interrupt                  */
#define  BSP_INT_ID_CAN0_BUS_OFF                          46    /* CAN0 Bus Off Interrupt                               */
#define  BSP_INT_ID_CAN0_ERROR                            47    /* CAN0 Error Interrupt                                 */
#define  BSP_INT_ID_CAN0_TX_WARNING                       48    /* CAN0 Tx Warning Interrupt                            */
#define  BSP_INT_ID_CAN0_RX_WARNING                       49    /* CAN0 Rx Warning Interrupt                            */
#define  BSP_INT_ID_CAN0_WAKE_UP                          50    /* CAN0 Wake Up Interrupt                               */
#define  BSP_INT_ID_CAN0_IMEU                             51    /* CAN0 Individual Matching Elements Update (IMEU) Int  */
#define  BSP_INT_ID_CAN0_LOST_RX                          52    /* CAN0 Lost Receive Interrupt                          */
#define  BSP_INT_ID_CAN1_ORED_MESSAGE_BUFFER              53    /* CAN1 OR'd Message Buffers Interrupt                  */
#define  BSP_INT_ID_CAN1_BUS_OFF                          54    /* CAN1 Bus Off Interrupt                               */
#define  BSP_INT_ID_CAN1_ERROR                            55    /* CAN1 Error Interrupt                                 */
#define  BSP_INT_ID_CAN1_TX_WARNING                       56    /* CAN1 Tx Warning Interrupt                            */
#define  BSP_INT_ID_CAN1_RX_WARNING                       57    /* CAN1 Rx Warning Interrupt                            */
#define  BSP_INT_ID_CAN1_WAKE_UP                          58    /* CAN1 Wake Up Interrupt                               */
#define  BSP_INT_ID_CAN1_IMEU                             59    /* CAN1 Individual Matching Elements Update (IMEU) Int  */
#define  BSP_INT_ID_CAN1_LOST_RX                          60    /* CAN1 Lost Receive Interrupt                          */
#define  BSP_INT_ID_UART0_RX_TX                           61    /* UART0 Receive/Transmit interrupt                     */
#define  BSP_INT_ID_UART0_ERR                             62    /* UART0 Error interrupt                                */
#define  BSP_INT_ID_UART1_RX_TX                           63    /* UART1 Receive/Transmit interrupt                     */
#define  BSP_INT_ID_UART1_ERR                             64    /* UART1 Error interrupt                                */
#define  BSP_INT_ID_UART2_RX_TX                           65    /* UART2 Receive/Transmit interrupt                     */
#define  BSP_INT_ID_UART2_ERR                             66    /* UART2 Error interrupt                                */
#define  BSP_INT_ID_UART3_RX_TX                           67    /* UART3 Receive/Transmit interrupt                     */
#define  BSP_INT_ID_UART3_ERR                             68    /* UART3 Error interrupt                                */
#define  BSP_INT_ID_UART4_RX_TX                           69    /* UART4 Receive/Transmit interrupt                     */
#define  BSP_INT_ID_UART4_ERR                             70    /* UART4 Error interrupt                                */
#define  BSP_INT_ID_UART5_RX_TX                           71    /* UART5 Receive/Transmit interrupt                     */
#define  BSP_INT_ID_UART5_ERR                             72    /* UART5 Error interrupt                                */
#define  BSP_INT_ID_ADC0                                  73    /* ADC0 interrupt                                       */
#define  BSP_INT_ID_ADC1                                  74    /* ADC1 interrupt                                       */
#define  BSP_INT_ID_HSCMP0                                75    /* HSCMP0 interrupt                                     */
#define  BSP_INT_ID_HSCMP1                                76    /* HSCMP1 interrupt                                     */
#define  BSP_INT_ID_HSCMP2                                77    /* HSCMP2 interrupt                                     */
#define  BSP_INT_ID_FTM0                                  78    /* FTM0 fault, overflow and channels interrupt          */
#define  BSP_INT_ID_FTM1                                  79    /* FTM1 fault, overflow and channels interrupt          */
#define  BSP_INT_ID_FTM2                                  80    /* FTM2 fault, overflow and channels interrupt          */
#define  BSP_INT_ID_CMT                                   81    /* CMT interrupt                                        */
#define  BSP_INT_ID_RTC                                   82    /* RTC interrupt                                        */
#define  BSP_INT_ID_RESERVED83                            83    /* Reserved interrupt 83                                */
#define  BSP_INT_ID_PIT0                                  84    /* PIT timer channel 0 interrupt                        */
#define  BSP_INT_ID_PIT1                                  85    /* PIT timer channel 1 interrupt                        */
#define  BSP_INT_ID_PIT2                                  86    /* PIT timer channel 2 interrupt                        */
#define  BSP_INT_ID_PIT3                                  87    /* PIT timer channel 3 interrupt                        */
#define  BSP_INT_ID_PDB0                                  88    /* PDB0 Interrupt                                       */
#define  BSP_INT_ID_USB0                                  89    /* USB0 interrupt                                       */
#define  BSP_INT_ID_USBDCD                                90    /* USBDCD Interrupt                                     */
#define  BSP_INT_ID_ENET_1588_TIMER                       91    /* Ethernet MAC IEEE 1588 Timer Interrupt               */
#define  BSP_INT_ID_ENET_TRANSMIT                         92    /* Ethernet MAC Transmit Interrupt                      */
#define  BSP_INT_ID_ENET_RECEIVE                          93    /* Ethernet MAC Receive Interrupt                       */
#define  BSP_INT_ID_ENET_ERROR                            94    /* Ethernet MAC Error and miscelaneous Interrupt        */
#define  BSP_INT_ID_I2S0                                  95    /* I2S0 Interrupt                                       */
#define  BSP_INT_ID_SDHC                                  96    /* SDHC Interrupt                                       */
#define  BSP_INT_ID_DAC0                                  97    /* DAC0 interrupt                                       */
#define  BSP_INT_ID_DAC1                                  98    /* DAC1 interrupt                                       */
#define  BSP_INT_ID_TSI0                                  99    /* TSI0 Interrupt                                       */
#define  BSP_INT_ID_MCG                                  100    /* MCG Interrupt                                        */
#define  BSP_INT_ID_LPTIMER                              101    /* LPTimer interrupt                                    */
#define  BSP_INT_ID_RESERVED102                          102    /* Reserved interrupt 102                               */
#define  BSP_INT_ID_PORTA                                103    /* Port A interrupt                                     */
#define  BSP_INT_ID_PORTB                                104    /* Port B interrupt                                     */
#define  BSP_INT_ID_PORTC                                105    /* Port C interrupt                                     */
#define  BSP_INT_ID_PORTD                                106    /* Port D interrupt                                     */
#define  BSP_INT_ID_PORTE                                107    /* Port E interrupt                                     */
#define  BSP_INT_ID_RESERVED108                          108    /* Reserved interrupt 108                               */
#define  BSP_INT_ID_RESERVED109                          109    /* Reserved interrupt 109                               */
#define  BSP_INT_ID_RESERVED110                          110    /* Reserved interrupt 110                               */
#define  BSP_INT_ID_RESERVED111                          111    /* Reserved interrupt 111                               */
#define  BSP_INT_ID_RESERVED112                          112    /* Reserved interrupt 112                               */
#define  BSP_INT_ID_RESERVED113                          113    /* Reserved interrupt 113                               */
#define  BSP_INT_ID_RESERVED114                          114    /* Reserved interrupt 114                               */
#define  BSP_INT_ID_RESERVED115                          115    /* Reserved interrupt 115                               */
#define  BSP_INT_ID_RESERVED116                          116    /* Reserved interrupt 116                               */
#define  BSP_INT_ID_RESERVED117                          117    /* Reserved interrupt 117                               */
#define  BSP_INT_ID_RESERVED118                          118    /* Reserved interrupt 118                               */
#define  BSP_INT_ID_RESERVED119                          119    /* Reserved interrupt 119                               */

//声明中断处理函数
void         BSP_IntHandlerInitialStackPointer	          (void);
void         BSP_IntHandlerInitialProgramCounter          (void);
void         BSP_IntHandlerNMI				  (void);
void         BSP_IntHandlerHardFault			  (void);
void         BSP_IntHandlerReserved4			  (void);
void         BSP_IntHandlerBusFault			  (void);
void         BSP_IntHandlerUsageFault			  (void);
void         BSP_IntHandlerReserved7			  (void);
void         BSP_IntHandlerReserved8			  (void);
void         BSP_IntHandlerReserved9			  (void);
void         BSP_IntHandlerReserved10			  (void);
void         BSP_IntHandlerSVCall			  (void);
void         BSP_IntHandlerDebugMonitor			  (void);
void         BSP_IntHandlerReserved13			  (void);
void         BSP_IntHandlerPendableSrvReq		  (void);
void         BSP_IntHandlerSysTick			  (void);
void         BSP_IntHandlerDMA0				  (void);
void         BSP_IntHandlerDMA1				  (void);
void         BSP_IntHandlerDMA2				  (void);
void         BSP_IntHandlerDMA3				  (void);
void         BSP_IntHandlerDMA4				  (void);
void         BSP_IntHandlerDMA5				  (void);
void         BSP_IntHandlerDMA6				  (void);
void         BSP_IntHandlerDMA7				  (void);
void         BSP_IntHandlerDMA8				  (void);
void         BSP_IntHandlerDMA9				  (void);
void         BSP_IntHandlerDMA10			  (void);
void         BSP_IntHandlerDMA11			  (void);
void         BSP_IntHandlerDMA12			  (void);
void         BSP_IntHandlerDMA13			  (void);
void         BSP_IntHandlerDMA14			  (void);
void         BSP_IntHandlerDMA15			  (void);
void         BSP_IntHandlerDMAError			  (void);
void         BSP_IntHandlerMCM				  (void);
void         BSP_IntHandlerFTFL				  (void);
void         BSP_IntHandlerReadCollision		  (void);
void         BSP_IntHandlerLVDLVW			  (void);
void         BSP_IntHandlerLLW				  (void);
void         BSP_IntHandlerWatchdog			  (void);
void         BSP_IntHandlerRNGB				  (void);
void         BSP_IntHandlerI2C0				  (void);
void         BSP_IntHandlerI2C1				  (void);
void         BSP_IntHandlerSPI0				  (void);
void         BSP_IntHandlerSPI1				  (void);
void         BSP_IntHandlerSPI2		                  (void);
void         BSP_IntHandlerCAN0ORedMessageBuffer          (void);
void         BSP_IntHandlerCAN0BusOff			  (void);
void         BSP_IntHandlerCAN0Error			  (void);
void         BSP_IntHandlerCAN0TxWarning		  (void);
void         BSP_IntHandlerCAN0RxWarning		  (void);
void         BSP_IntHandlerCAN0WakeUp			  (void);
void         BSP_IntHandlerCAN0IMEU			  (void);
void         BSP_IntHandlerCAN0LostRx			  (void);
void         BSP_IntHandlerCAN1ORedMessageBuffer          (void);
void         BSP_IntHandlerCAN1BusOff			  (void);
void         BSP_IntHandlerCAN1Error			  (void);
void         BSP_IntHandlerCAN1TxWarning		  (void);
void         BSP_IntHandlerCAN1RxWarning		  (void);
void         BSP_IntHandlerCAN1WakeUp			  (void);
void         BSP_IntHandlerCAN1IMEU			  (void);
void         BSP_IntHandlerCAN1LostRx			  (void);
void         BSP_IntHandlerUART0RxTx			  (void);
void         BSP_IntHandlerUART0Err			  (void);
void         BSP_IntHandlerUART1RxTx			  (void);
void         BSP_IntHandlerUART1Err			  (void);
void         BSP_IntHandlerUART2RxTx			  (void);
void         BSP_IntHandlerUART2Err			  (void);
void         BSP_IntHandlerUART3RxTx			  (void);
void         BSP_IntHandlerUART3Err			  (void);
void         BSP_IntHandlerUART4RxTx			  (void);
void         BSP_IntHandlerUART4Err			  (void);
void         BSP_IntHandlerUART5RxTx			  (void);
void         BSP_IntHandlerUART5Err			  (void);
void         BSP_IntHandlerADC0				  (void);
void         BSP_IntHandlerADC1				  (void);
void         BSP_IntHandlerHSCMP0			  (void);
void         BSP_IntHandlerHSCMP1			  (void);
void         BSP_IntHandlerHSCMP2			  (void);
void         BSP_IntHandlerFTM0				  (void);
void         BSP_IntHandlerFTM1				  (void);
void         BSP_IntHandlerFTM2				  (void);
void         BSP_IntHandlerCMT				  (void);
void         BSP_IntHandlerRTC				  (void);
void         BSP_IntHandlerReserved83			  (void);
void         BSP_IntHandlerPIT0				  (void);
void         BSP_IntHandlerPIT1				  (void);
void         BSP_IntHandlerPIT2				  (void);
void         BSP_IntHandlerPIT3				  (void);
void         BSP_IntHandlerPDB0				  (void);
void         BSP_IntHandlerUDB0				  (void);
void         BSP_IntHandlerUSBDCD			  (void);
void         BSP_IntHandlerEnet1588Timer		  (void);
void         BSP_IntHandlerEnetTransmit			  (void);
void         BSP_IntHandlerEnetReceive			  (void);
void         BSP_IntHandlerEnetError			  (void);
void         BSP_IntHandlerI2S0				  (void);
void         BSP_IntHandlerSDHC				  (void);
void         BSP_IntHandlerDAC0				  (void);
void         BSP_IntHandlerDAC1				  (void);
void         BSP_IntHandlerTSI0				  (void);
void         BSP_IntHandlerMCG				  (void);
void         BSP_IntHandlerLPTimer			  (void);
void         BSP_IntHandlerReserved102			  (void);
void         BSP_IntHandlerPortA			  (void);
void         BSP_IntHandlerPortB			  (void);
void         BSP_IntHandlerPortC			  (void);
void         BSP_IntHandlerPortD			  (void);
void         BSP_IntHandlerPortE			  (void);
void         BSP_IntHandlerReserved108			  (void);
void         BSP_IntHandlerReserved109			  (void);
void         BSP_IntHandlerReserved110			  (void);
void         BSP_IntHandlerReserved111			  (void);
void         BSP_IntHandlerReserved112			  (void);
void         BSP_IntHandlerReserved113			  (void);
void         BSP_IntHandlerReserved114			  (void);
void         BSP_IntHandlerReserved115			  (void);
void         BSP_IntHandlerReserved116			  (void);
void         BSP_IntHandlerReserved117			  (void);
void         BSP_IntHandlerReserved118			  (void);
void         BSP_IntHandlerReserved119			  (void);

#endif