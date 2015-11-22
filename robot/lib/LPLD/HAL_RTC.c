/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_RTC.c
 * 用途: RTCC底层模块相关函数
 * 最后修改日期: 20120626
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#include "common.h"
#include "HAL_RTC.h"

/*
 *******需用到定时中断，请在isr.h中粘贴一下代码:*********

//RTC模块中断服务定义
#undef  VECTOR_082
#define VECTOR_082 LPLD_RTC_Isr

//以下函数在LPLD_Kinetis底层包，不必修改
extern void LPLD_RTC_Isr(void);

 ***********************代码结束*************************
*/

//用户自定义中断服务函数数组
RTC_ISR_CALLBACK RTC_ISR[1];


/*
 * LPLD_RTC_Init
 * RTC通用初始化函数
 * 
 * 参数:
 *    seconds--设置计数器起始值
 *      |__如果计数器设置为0，在不复位的情况下可计数2的32次方秒，约136年
 *    alarm--设置报警值，
 *      |__当报警值等于RTC_TSR，设置TAF标志位，可触发中断
 *    rtc_irqc--中断模式
 *      |__RTC_INT_DIS        -关闭RTC中断
 *      |__RTC_INT_INVALID    -开启RTC 无效数据 标志位中断
 *      |__RTC_INT_OVERFLOW   -开启RTC 计数器溢出 标志位中断
 *      |__RTC_INT_ALARM      -开启RTC 报警 标志位中断
 *    isr_func--用户中断程序入口地址
 *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */

uint8 LPLD_RTC_Init(uint32 seconds, uint32 alarm, uint8 rtc_irqc, RTC_ISR_CALLBACK isr_func)
{
  int i;
  
  SIM_SCGC6 |= SIM_SCGC6_RTC_MASK;
  //复位所有RTC寄存器 除了SWR位 RTC_WAR和RTC_RAR寄存器
  //清除SWR位在VBAT POR设置之后或者软件复位
  //复位RTC寄存器
  RTC_CR  = RTC_CR_SWR_MASK; 
  //清除RTC复位标志   
  RTC_CR  &= ~RTC_CR_SWR_MASK;  
  //使能RTC 32.768 kHzRTC时钟源
  //使能之后要延时一段时间等待
  //等待时钟稳定后在配置RTC时钟计数器.
  RTC_CR |= RTC_CR_OSCE_MASK;
  
  //等待32.768时钟起振
  for(i=0;i<0x600000;i++);
  
  if(rtc_irqc)
  {
    RTC_IER = (rtc_irqc & 0x07);
    
    RTC_ISR[0]=isr_func;
    
    enable_irq(66);//开启RTC中断
  }
  //设置时钟补偿寄存器
  RTC_TCR = RTC_TCR_CIR(0) | RTC_TCR_TCR(0);
  
  //配置秒计数器
  RTC_TSR = seconds;
    
  //配置闹铃  
  RTC_TAR = alarm;
  
  //使能秒计数器
  RTC_SR |= RTC_SR_TCE_MASK;
  
  return 1;
}

/*
 * LPLD_Get_RealTime
 * 获得RTC秒计数器的值
 * 
 * 输出
 *   秒累加的总和
 */
uint32 LPLD_RTC_GetRealTime(void)
{
  return RTC_TSR;//获得当前的秒累加的总和
}

/*
 * LPLD_RTC_Stop
 * 关闭RTC函数
 * 
 * 输出
 *   无
 */
void LPLD_RTC_Stop(void)
{
  RTC_SR &= (~RTC_SR_TCE_MASK);
}

/*
 * LPLD_RTC_Alarm
 * RTC重新设置报警寄存器
 * 
 * 参数:
 *    data--设置报警的时间，单位：秒
 * 
 * 输出
 *   无
 */
void LPLD_RTC_Alarm(uint32 data)
{
  RTC_TAR = data;
}

/*
 * LPLD_RTC_Alarm
 * RTC重新设置秒计数器
 * 
 * 参数:
 *    data--设置报警的时间，单位：秒
 * 
 * 输出
 *   无
 */
void LPLD_RTC_Seconds(uint32 data)
{
  RTC_TSR = data;
}

/*
 * LPLD_RTC_Isr
 * RTC通用中断底层入口函数
 * 
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void LPLD_RTC_Isr(void)
{ 
  if((RTC_SR & RTC_SR_TIF_MASK)== 0x01)
  {
    //调用用户自定义中断服务
    RTC_ISR[0](); 
    //清除中断标志位
    RTC_SR |= RTC_SR_TIF_MASK;
    
  }	
  else if((RTC_SR & RTC_SR_TOF_MASK) == 0x02)
  {
    //调用用户自定义中断服务
    RTC_ISR[0]();  
    //清除中断标志位
    RTC_SR |= RTC_SR_TOF_MASK;
  }	 	
  else if((RTC_SR & RTC_SR_TAF_MASK) == 0x04)
  {
    //调用用户自定义中断服务
    RTC_ISR[0]();  
    //清除中断标志位
    RTC_SR |= RTC_SR_TAF_MASK;
  }	
}