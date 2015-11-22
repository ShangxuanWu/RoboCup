/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_LPTMR.c
 * 用途: LPTMR底层模块相关函数
 * 最后修改日期: 20120326
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
/*
 *******需用到LPTMR中断，请在isr.h中粘贴一下代码:*********

//LPTMR模块中断服务定义
#undef  VECTOR_101
#define VECTOR_101 LPLD_LPTMR_Isr
//以下函数在LPLD_Kinetis底层包，不必修改
extern void LPLD_LPTMR_Isr(void);

 ***********************代码结束*************************
*/

#include "common.h"
#include "HAL_LPTMR.h"

LPTMR_ISR_CALLBACK LPTMR_ISR;

/*
 * LPLD_LPTMR_Init
 * LPTMR初始化函数
 * 
 * 参数:
 *    mode--选择LPTMR模式
 *      |__MODE_LPTMR           --低功耗定时器模式
 *      |__MODE_PLACC           --脉冲累加模式
 *    period_ms--设定定时器的定时值 单位ms
 *      |__0                    --设置脉冲累加模式时选择为0
 *      |__1~65535              --1ms<= 定时周期  <=65535ms 
 *    channel--选择累加输入通道
 *      |__0                    --设置为定时器时选择为0
 *      |__LPTMR_ALT1           --设置LPTMR_ALT1, PTA19为脉冲累加输入
 *      |__LPTMR_ALT2           --设置LPTMR_ALT2, PTC5 为脉冲累加输入
 *    irq_en--输入中断
 *      |__IRQ_DISABLE          --不使能中断
 *      |__IRQ_ENABLE           --使能中断
 *    isr_func
 *      |__低功耗定时器中断回调函数
 *  
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */

uint8 LPLD_LPTMR_Init(uint8 mode, uint16 period_ms, uint8 channel, uint8 irq_en, LPTMR_ISR_CALLBACK isr_func)
{
  SIM_SCGC5|=SIM_SCGC5_LPTIMER_MASK;//初始化LPTMR时钟
   
  LPTMR0_CSR=0x00;  //清空寄存器
  LPTMR0_PSR=0x00;
  LPTMR0_CMR=0x00;
   
  if(mode==MODE_LPTMR)// 配置成低功耗定时器功能
  {
      
    /* 配置LPTMR */
    // LPO 1Khz
    //设置比较的值
    //使用内部时钟 分频系数Prescale为 2^(X+1)
    //定时器的一个计数周期=时钟源(Clk_Src)/ 预分频值(Prescale)
    //定时器的定时值=设置的比较值(compare_value)/定时器的一个计数周期
    LPTMR0_CMR=LPTMR_CMR_COMPARE(period_ms);                 //设置比较值
    LPTMR0_PSR=LPTMR_PSR_PCS(0x1)|LPTMR_PSR_PBYP_MASK;  //采用LPO时钟旁路使能
        
  }
  else if(mode==MODE_PLACC)               //配置成脉冲捕获模式
  {
    if(channel==LPTMR_ALT1)               //LPTMR_ALT1
    {
      SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
      PORTA_PCR19=PORT_PCR_MUX(0x6);      //设置PTA19为脉冲累加
    }
    else if(channel==LPTMR_ALT2)          //LPTMR_ALT2
    {
      SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK;  //设置PTC5为脉冲累加
      PORTC_PCR5=PORT_PCR_MUX(0x4);      
    }
    else
    {
      return 0;
    }
    
    //与所用的内部时钟无关
    //外部输入的信号作为计数时钟
    LPTMR0_PSR =LPTMR_PSR_PCS(0x1)|LPTMR_PSR_PBYP_MASK; 
    LPTMR0_CSR =LPTMR_CSR_TPS(channel);
    LPTMR0_CSR|=LPTMR_CSR_TMS_MASK; //捕获模式
    LPTMR0_CSR|=LPTMR_CSR_TFC_MASK; //自由计数模式
  }
  else
  {
    return 0;
  }
  
  if(isr_func!=NULL)
  {
    LPTMR_ISR=isr_func;
    enable_irq(85);
  }
  
  if(irq_en==1)
  {
    LPTMR0_CSR|=LPTMR_CSR_TIE_MASK;
  }
  else if(irq_en==0)
  {
    LPTMR0_CSR&=~LPTMR_CSR_TIE_MASK;
  }
  else
  {
    return 0;
  }
  
  LPTMR0_CSR|=LPTMR_CSR_TEN_MASK; //开启LPTMR
  return 1;
}


/*
 * LPLD_LPTMR_SetIsr
 * 设置LPTMR通道用户定义的中断服务函数，并使能中断
 * 
 * 参数:
 *    isr_func--用户中断程序入口地址
 *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 *
 */
uint8 LPLD_LPTMR_SetIsr(LPTMR_ISR_CALLBACK isr_func)
{
  LPTMR_ISR=isr_func;
  LPTMR0_CSR|=LPTMR_CSR_TIE_MASK;
  enable_irq(85);
  
  return 1;
}

/*
 * LPLD_LPTMR_ClearIsr
 * 清除LPTMR通道用户定义的中断服务函数，并禁用中断
 * 
 * 参数:
 *    isr_func--用户中断程序入口地址
 *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 *
 */
uint8 LPLD_LPTMR_ClearIsr(void)
{
  LPTMR0_CSR&=~LPTMR_CSR_TIE_MASK;
  disable_irq(85);
  LPTMR_ISR=NULL;
  
  return 1;
}

/*
 *  LPLD_LPTMR_Reset
 *  低功耗定时器复位，复位以后清空低功耗定时器Counter
 * 
 *  参数:
 *      无
 *  返回值:
 *      无
 */
void LPLD_LPTMR_Reset(void)
{
  LPTMR0_CSR&=(~LPTMR_CSR_TEN_MASK);       //Reset LPTMR0 
}


/*
 *  LPLD_LPTMR_GetPulseAcc
 *  得到脉冲累加的值
 * 
 *  参数:
 *      无
 *  返回值:
 *      脉冲累加值
 */
uint16 LPLD_LPTMR_GetPulseAcc(void)
{
   return (uint16)LPTMR0_CNR;
}

/*
 *  LPLD_LPTMR_DelayMs
 *  低功耗定时器延时n个ms
 * 
 * 参数:
 *    period_ms--设定定时器的定时值 单位ms
 *    最大65535ms
 *
 *  返回值:
 *      无
 */
void LPLD_LPTMR_DelayMs(uint16 period_ms)
{
  if(!period_ms)
    return;
  
  /* 开启LPTMR时钟 */
  SIM_SCGC5|=SIM_SCGC5_LPTIMER_MASK; 
  
  /* 设置毫秒延时计数 */
  LPTMR0_CMR = period_ms; 
  
  /* 设置LPTMR不分频采用1kHz LPO为时钟源 */
  LPTMR0_PSR = LPTMR_PSR_PCS(1)|LPTMR_PSR_PBYP_MASK; 
  
  /* 开启定时器 */
  LPTMR0_CSR |= LPTMR_CSR_TEN_MASK; 

  /* 等待计数达到设定值 */
  while (!(LPTMR0_CSR & LPTMR_CSR_TCF_MASK));
  
  /*清除定值比较标志 */
  LPTMR0_CSR &= ~LPTMR_CSR_TEN_MASK;
  
  return;
}


/*
 *  LPLD_LPTMR_Isr
 *  低功耗定时器中断服务子程序
 * 
 *  参数:
 *      无
 *
 *  返回值:
 *      无
 */
void LPLD_LPTMR_Isr(void)
{
  LPTMR0_CSR|=LPTMR_CSR_TCF_MASK;  //清除LPT比较标志
  LPTMR_ISR();
}
