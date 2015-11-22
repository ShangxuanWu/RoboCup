/*
 * ����Ӳ��ƽ̨:  LPLD_K60 Card
 * ��Ȩ����:      �����������µ��Ӽ������޹�˾
 * ��������:      http://laplenden.taobao.com
 * ��˾�Ż�:      http://www.lpld.cn
 *
 * ˵��:    �����̻���Kintis K60��Դ�ײ㿪����������
 *          ���п�Դ�����������"LPLD"�ļ����£�����˵�����ĵ�[#LPLD-003-N]
 *
 * �ļ���:  isr.h
 * ��;:    �����жϷ����ӳ��򣬸�ͷ�ļ������������жϺ�����Ϊ�ײ��жϺ�����
 *	    �����ż���������ο��ĵ�[#LPLD-003-N]������ײ�ģ��".h"ͷ�ļ���
 * ע��:   ��ͷ�ļ�ֻ�ܱ�"vectors.c"��������
 *
 */


#ifndef __ISR_H
#define __ISR_H 1

/* �����ײ��жϷ����ӳ��� */
//PITģ���жϷ�����
#undef  VECTOR_084
#define VECTOR_084 LPLD_PIT_Isr
#undef  VECTOR_085
#define VECTOR_085 LPLD_PIT_Isr
#undef  VECTOR_086
#define VECTOR_086 LPLD_PIT_Isr
#undef  VECTOR_087
#define VECTOR_087 LPLD_PIT_Isr
#undef  VECTOR_101
#define VECTOR_101 LPLD_LPTMR_Isr
#undef  VECTOR_061
#define VECTOR_061 LPLD_UART_Isr
#undef  VECTOR_063
#define VECTOR_063 LPLD_UART_Isr
#undef  VECTOR_065
#define VECTOR_065 LPLD_UART_Isr
#undef  VECTOR_067
#define VECTOR_067 LPLD_UART_Isr
#undef  VECTOR_069
#define VECTOR_069 LPLD_UART_Isr
#undef  VECTOR_071
#define VECTOR_071 LPLD_UART_Isr

// GPIO ģ���жϷ����� 
#undef    VECTOR_103 
#define VECTOR_103 LPLD_GPIO_Isr 
#undef   VECTOR_104 
#define VECTOR_104 LPLD_GPIO_Isr 
#undef   VECTOR_105 
#define VECTOR_105 LPLD_GPIO_Isr 
#undef   VECTOR_106 
#define VECTOR_106 LPLD_GPIO_Isr 
#undef   VECTOR_107 
#define VECTOR_107 LPLD_GPIO_Isr 
//���º����� LPLD_Kinetis �ײ���������޸� 
extern void LPLD_GPIO_Isr(void);

//���º�����LPLD_OSKinetis�ײ���������޸�
extern void LPLD_PIT_Isr(void);
extern void LPLD_LPTMR_Isr(void);
extern void LPLD_UART_Isr(void);

#endif  //__ISR_H

/* End of "isr.h" */
