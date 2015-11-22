///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:06 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\�й������˴���\robot_project\lib\LPLD\HAL_RTC.c      /
//    Command line =  D:\�й������˴���\robot_project\lib\LPLD\HAL_RTC.c -D   /
//                    IAR -D LPLD_K60 -lCN D:\�й������˴���\robot_project\pr /
//                    oject\LPLD_Template\iar\RAM\List\ -lB                   /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\ -o D:\�й������˴���\robot_project\project /
//                    \LPLD_Template\iar\RAM\Obj\ --no_cse --no_unroll        /
//                    --no_inline --no_code_motion --no_tbaa --no_clustering  /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config             /
//                    "D:\Program Files\IAR Systems\Embedded Workbench        /
//                    6.0\arm\INC\c\DLib_Config_Normal.h" -I                  /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\app\ -I D:\�й������˴���\robot_project\project\L /
//                    PLD_Template\iar\..\..\..\lib\common\ -I                /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\cpu\ -I D:\�й������˴���\robot_project /
//                    \project\LPLD_Template\iar\..\..\..\lib\cpu\headers\    /
//                    -I D:\�й������˴���\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\drivers\adc16\ -I                    /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\enet\ -I                        /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\lptmr\ -I                       /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\mcg\ -I                         /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\pmc\ -I                         /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\rtc\ -I                         /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\uart\ -I                        /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\wdog\ -I                        /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\platforms\ -I                           /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\LPLD\ -I D:\�й������˴���\robot_projec /
//                    t\project\LPLD_Template\iar\..\..\..\lib\LPLD\FatFs\    /
//                    -I D:\�й������˴���\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\LPLD\USB\ -I                         /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\iar_config_files\ -Ol                   /
//    List file    =  D:\�й������˴���\robot_project\project\LPLD_Template\i /
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

// D:\�й������˴���\robot_project\lib\LPLD\HAL_RTC.c
//    1 /*
//    2  * --------------"��������K60�ײ��"-----------------
//    3  *
//    4  * ����Ӳ��ƽ̨:LPLD_K60 Card
//    5  * ��Ȩ����:�����������µ��Ӽ������޹�˾
//    6  * ��������:http://laplenden.taobao.com
//    7  * ��˾�Ż�:http://www.lpld.cn
//    8  *
//    9  * �ļ���: HAL_RTC.c
//   10  * ��;: RTCC�ײ�ģ����غ���
//   11  * ����޸�����: 20120626
//   12  *
//   13  * ������ʹ��Э��:
//   14  *  ��������������ʹ���߿���Դ���룬�����߿��������޸�Դ���롣�����μ�����ע��Ӧ
//   15  *  ���Ա��������ø��Ļ�ɾ��ԭ��Ȩ���������������ο����߿��Լ�ע���ΰ�Ȩ�����ߣ�
//   16  *  ��Ӧ�����ش�Э��Ļ����ϣ�����Դ���롢���ó��۴��뱾��
//   17  */
//   18 #include "common.h"
//   19 #include "HAL_RTC.h"
//   20 
//   21 /*
//   22  *******���õ���ʱ�жϣ�����isr.h��ճ��һ�´���:*********
//   23 
//   24 //RTCģ���жϷ�����
//   25 #undef  VECTOR_082
//   26 #define VECTOR_082 LPLD_RTC_Isr
//   27 
//   28 //���º�����LPLD_Kinetis�ײ���������޸�
//   29 extern void LPLD_RTC_Isr(void);
//   30 
//   31  ***********************�������*************************
//   32 */
//   33 
//   34 //�û��Զ����жϷ���������

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   35 RTC_ISR_CALLBACK RTC_ISR[1];
RTC_ISR:
        DS8 4
//   36 
//   37 
//   38 /*
//   39  * LPLD_RTC_Init
//   40  * RTCͨ�ó�ʼ������
//   41  * 
//   42  * ����:
//   43  *    seconds--���ü�������ʼֵ
//   44  *      |__�������������Ϊ0���ڲ���λ������¿ɼ���2��32�η��룬Լ136��
//   45  *    alarm--���ñ���ֵ��
//   46  *      |__������ֵ����RTC_TSR������TAF��־λ���ɴ����ж�
//   47  *    rtc_irqc--�ж�ģʽ
//   48  *      |__RTC_INT_DIS        -�ر�RTC�ж�
//   49  *      |__RTC_INT_INVALID    -����RTC ��Ч���� ��־λ�ж�
//   50  *      |__RTC_INT_OVERFLOW   -����RTC ��������� ��־λ�ж�
//   51  *      |__RTC_INT_ALARM      -����RTC ���� ��־λ�ж�
//   52  *    isr_func--�û��жϳ�����ڵ�ַ
//   53  *      |__�û��ڹ����ļ��¶�����жϺ���������������Ϊ:�޷���ֵ,�޲���(eg. void isr(void);)
//   54  *
//   55  * ���:
//   56  *    0--���ô���
//   57  *    1--���óɹ�
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
//   65   //��λ����RTC�Ĵ��� ����SWRλ RTC_WAR��RTC_RAR�Ĵ���
//   66   //���SWRλ��VBAT POR����֮����������λ
//   67   //��λRTC�Ĵ���
//   68   RTC_CR  = RTC_CR_SWR_MASK; 
        LDR.N    R0,??DataTable5_1  ;; 0x4003d010
        MOVS     R1,#+1
        STR      R1,[R0, #+0]
//   69   //���RTC��λ��־   
//   70   RTC_CR  &= ~RTC_CR_SWR_MASK;  
        LDR.N    R0,??DataTable5_1  ;; 0x4003d010
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+1
        LSLS     R0,R0,#+1
        LDR.N    R1,??DataTable5_1  ;; 0x4003d010
        STR      R0,[R1, #+0]
//   71   //ʹ��RTC 32.768 kHzRTCʱ��Դ
//   72   //ʹ��֮��Ҫ��ʱһ��ʱ��ȴ�
//   73   //�ȴ�ʱ���ȶ���������RTCʱ�Ӽ�����.
//   74   RTC_CR |= RTC_CR_OSCE_MASK;
        LDR.N    R0,??DataTable5_1  ;; 0x4003d010
        LDR      R0,[R0, #+0]
        MOV      R1,#+256
        ORRS     R0,R1,R0
        LDR.N    R1,??DataTable5_1  ;; 0x4003d010
        STR      R0,[R1, #+0]
//   75   
//   76   //�ȴ�32.768ʱ������
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
//   85     enable_irq(66);//����RTC�ж�
        MOVS     R0,#+66
        BL       enable_irq
//   86   }
//   87   //����ʱ�Ӳ����Ĵ���
//   88   RTC_TCR = RTC_TCR_CIR(0) | RTC_TCR_TCR(0);
??LPLD_RTC_Init_2:
        LDR.N    R0,??DataTable5_4  ;; 0x4003d00c
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//   89   
//   90   //�����������
//   91   RTC_TSR = seconds;
        LDR.N    R0,??DataTable5_5  ;; 0x4003d000
        STR      R4,[R0, #+0]
//   92     
//   93   //��������  
//   94   RTC_TAR = alarm;
        LDR.N    R0,??DataTable5_6  ;; 0x4003d008
        STR      R5,[R0, #+0]
//   95   
//   96   //ʹ���������
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
//  104  * ���RTC���������ֵ
//  105  * 
//  106  * ���
//  107  *   ���ۼӵ��ܺ�
//  108  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  109 uint32 LPLD_RTC_GetRealTime(void)
//  110 {
//  111   return RTC_TSR;//��õ�ǰ�����ۼӵ��ܺ�
LPLD_RTC_GetRealTime:
        LDR.N    R0,??DataTable5_5  ;; 0x4003d000
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
//  112 }
//  113 
//  114 /*
//  115  * LPLD_RTC_Stop
//  116  * �ر�RTC����
//  117  * 
//  118  * ���
//  119  *   ��
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
//  128  * RTC�������ñ����Ĵ���
//  129  * 
//  130  * ����:
//  131  *    data--���ñ�����ʱ�䣬��λ����
//  132  * 
//  133  * ���
//  134  *   ��
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
//  143  * RTC���������������
//  144  * 
//  145  * ����:
//  146  *    data--���ñ�����ʱ�䣬��λ����
//  147  * 
//  148  * ���
//  149  *   ��
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
//  158  * RTCͨ���жϵײ���ں���
//  159  * 
//  160  * �û������޸ģ������Զ������Ӧͨ���жϺ���
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
//  166     //�����û��Զ����жϷ���
//  167     RTC_ISR[0](); 
        LDR.N    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        BLX      R0
//  168     //����жϱ�־λ
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
//  174     //�����û��Զ����жϷ���
//  175     RTC_ISR[0]();  
        LDR.N    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        BLX      R0
//  176     //����жϱ�־λ
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
//  181     //�����û��Զ����жϷ���
//  182     RTC_ISR[0]();  
        LDR.N    R0,??DataTable5_3
        LDR      R0,[R0, #+0]
        BLX      R0
//  183     //����жϱ�־λ
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
