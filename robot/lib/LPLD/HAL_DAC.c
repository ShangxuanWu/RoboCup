/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_DAC.c
 * 用途: DAC底层模块相关函数
 * 最后修改日期: 20120618
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
*/

#include "HAL_DAC.h"
#include "common.h"


//内部函数
uint8 LPLD_DAC_Config(LPLD_DAC_Cfg_t *);

//用户自定义中断服务函数数组
DAC_ISR_CALLBACK DAC_ISR[2];

/*******需用到DAC中断，请在isr.h中粘贴一下代码:*********

//DAC模块中断服务定义
#undef  VECTOR_097
#define VECTOR_097 LPLD_DAC_Isr
#undef  VECTOR_098
#define VECTOR_098 LPLD_DAC_Isr

//以下函数在LPLD_Kinetis底层包，不必修改
extern void LPLD_DAC_Isr(void);
*/



//DAC映射地址数组
volatile DAC_MemMapPtr DACx_Ptr[2] = {DAC0_BASE_PTR, 
                                      DAC1_BASE_PTR};
/*

 * LPLD_DAC_Set_Buffer
 * 设置DAC通道的缓冲区
 * 
 * 参数:
 *    dacx--DAC模块号
 *      |__DAC0           --DAC0模块
 *      |__DAC1           --DAC1模块
 *    DACx_DATn--DAC缓冲区号
 *      |__0~15           --缓冲区0~15号
 *    data16--DAC缓冲区数据
 *
 * 输出
 *    无
 */
void LPLD_DAC_Set_Buffer(DACx dacx, uint8 DACx_DATn, uint16 data16)
{
  DAC_MemMapPtr dacptr = DACx_Ptr[dacx];
  DAC_DATL_REG(dacptr, DACx_DATn) = (data16&0x0ff); 
  DAC_DATH_REG(dacptr, DACx_DATn) = (data16&0xf00)>>8;                                
}



/*
 * LPLD_DAC_Reset_Reg
 * 复位DAC通道以及各个寄存器
 * 
 * 参数:
 *    dacx--DAC模块号
 *      |__DAC0           --DAC0模块
 *      |__DAC1           --DAC1模块
 * 输出
 *    无
 */
void LPLD_DAC_Reset_Reg(DACx dacx)
{
  DAC_MemMapPtr dacptr = DACx_Ptr[dacx];
  uint8 i;   
  
  //复位16个通道缓存
  for (i=0; i<16;i++)
  {
    LPLD_DAC_Set_Buffer(dacx, i, 0x00); 
  }
  //DAC 缓存读指针清零
  DAC_SR_REG(dacptr) = DAC_SR_DACBFRPTF_MASK ;
  //清空 C0 寄存器 
  DAC_C0_REG(dacptr) = 0x00 ;
  //清空 C1 寄存器 
  DAC_C1_REG(dacptr) = 0x00 ;
  //将缓冲区的上限设置为最大
  DAC_C2_REG(dacptr) = 0x0F;
}

/*
 * LPLD_DAC_Init
 * DAC模块初始化函数，在此函数中设置默认参数以及调用LPLD_DAC_Config配置寄存器
 *
 * 参数 LPLD_DAC_Cfg_t *DAC_Config
 * 详细参数在LPLD_DAC_Cfg_t 结构体中定义
 * LPLD_DAC_Cfg_t 结构体在（在HAL_DAC.h）头文件中定义
 *
 * 输出：
 *   0 初始化失败
 *   1 初始化成功
*/
uint8 LPLD_DAC_Init(LPLD_DAC_Cfg_t *DAC_Config)
{ 
  
  if(DAC_Config -> dacx > DAC1)
  {
    return 0;
  }
  
  //如果用户没有设置 水印模式的字数 默认为1个字
  if(DAC_Config -> Water_Mark_Mode  == NULL)
  {
    DAC_Config -> Water_Mark_Mode = WATER_MODE_1WORD;
  }
  
  //如果用户没有设置 缓冲区使能 默认为禁用缓冲区
  if(DAC_Config -> Buffer_Enable == NULL)
  {
    DAC_Config -> Buffer_Enable = BUFFER_DISABLE;       
  }
  
  //如果用户没有设置 缓冲区的模式 默认为正常模式
  if(DAC_Config -> Buffer_Mode == NULL)
  {
    DAC_Config -> Buffer_Mode = BUFFER_MODE_NORMAL;       
  }
  
  //如果用户没有设置 触发模式 默认为无触发模式
  if(DAC_Config -> Triger_Mode == NULL)
  {
    DAC_Config -> Triger_Mode = TRIGER_MODE_NONE;   
  } 
  
  //如果用户没有设置 缓冲区的起始位置 默认为0
  if(DAC_Config -> Buffer_Init_Pos ==NULL)
  {
    DAC_Config -> Buffer_Init_Pos = 0;    
  }
  
  //如果用户没有设置 缓冲区的最大值 默认为16
  if(DAC_Config -> Buffer_Up_Limit == NULL)
  {
    DAC_Config -> Buffer_Up_Limit = 15;   
  }
    
  //如果用户没有设置 中断方式 默认为不开中断
  if(DAC_Config -> DAC_irqc == NULL)
  {
    DAC_Config -> DAC_irqc = 0;     
  } 

  //配置DAC寄存器
  return LPLD_DAC_Config(DAC_Config);

}

/*
 * 内部函数，用户无需调用
 * LPLD_DAC_Config
 * 配置DAC寄存器函数
 *
 * 参数 LPLD_DAC_Cfg_t *DAC_Config
 * 详细参数在LPLD_DAC_Cfg_t 结构体中定义
 * LPLD_DAC_Cfg_t 结构体在（在HAL_DAC.h）头文件中定义
 *
 * 输出：
 *   0 配置失败
 *   1 配置成功
*/
static uint8 LPLD_DAC_Config(LPLD_DAC_Cfg_t *DAC_Config)
{
  DAC_MemMapPtr dacptr = DACx_Ptr[DAC_Config->dacx];
  
  //===========配置DAC_C0寄存器=================//
  if( dacptr == DAC0_BASE_PTR )
  {
    //开启DAC0时钟
    SIM_SCGC2 |= SIM_SCGC2_DAC0_MASK ; 
    
    if(DAC_Config -> DAC_irqc)
    {
      enable_irq(81);//开启DAC0 CPU级中断
      DAC_ISR[0]=DAC_Config -> isr_func;
    }
    
  }
  else if( dacptr == DAC1_BASE_PTR )
  {
    //开启DAC1时钟
    SIM_SCGC2 |= SIM_SCGC2_DAC1_MASK ; 
    
    if(DAC_Config->DAC_irqc)
    {
      enable_irq(82);//开启DAC1 CPU级中断
      DAC_ISR[1]=DAC_Config->isr_func;
    }
  }
  else
    return 0;
  
  //===========配置DAC_C0寄存器=================//
  DAC_C0_REG(dacptr)  =0;
  //禁止DAC模块所有中断
  if(DAC_Config->DAC_irqc == DAC_IRQ_DISABLE)
  {
    //The DAC buffer read pointer bottom flag interrupt is disabled.
    DAC_C0_REG(dacptr) &= (~DAC_C0_DACBBIEN_MASK);
    //The DAC buffer read pointer top flag interrupt is disabled.
    DAC_C0_REG(dacptr) &= (~DAC_C0_DACBTIEN_MASK);
    //The DAC buffer watermark interrupt is disabled.
    DAC_C0_REG(dacptr) &= (~DAC_C0_DACBWIEN_MASK); 
  }
  //开启DAC模块计数指针指底中断
  else if(DAC_Config->DAC_irqc == DAC_IRQ_POINTER_BOTTOM)
  {
    //The DAC buffer read pointer bottom flag interrupt is disabled.
    DAC_C0_REG(dacptr) |= DAC_C0_DACBBIEN_MASK; 
  }
  //开启DAC模块计数指针指顶中断
  else if(DAC_Config->DAC_irqc == DAC_IRQ_POINTER_TOP)
  {
    //The DAC buffer read pointer top flag interrupt is disabled.
    DAC_C0_REG(dacptr) |=  DAC_C0_DACBTIEN_MASK; 
  }
  //开启DAC模块计数水印中断
  else if(DAC_Config->DAC_irqc == DAC_IRQ_WATER_MARK)
  {
    //The DAC buffer watermark interrupt is disabled.
    DAC_C0_REG(dacptr) |=  DAC_C0_DACBWIEN_MASK;   
  }
  else 
    return 0;

  //设置DAC能耗模式：设置成为高功耗模式
  DAC_C0_REG(dacptr) &= (~DAC_C0_LPEN_MASK);
  
  //配置触发方式
  //无触发方式，DAC根据BUFFER0的数值从DAC0通道输出
  if(DAC_Config->Triger_Mode == TRIGER_MODE_NONE)
  {
    //设置DAC触发方式：软件触发禁止
    DAC_C0_REG(dacptr) &= (~DAC_C0_DACTRGSEL_MASK);
    //设置DAC软件触发方式是否有效：=1 有效 =0 无效
    DAC_C0_REG(dacptr) |=  DAC_C0_DACSWTRG_MASK;
  }
  //软件触发方式，DAC根据DAC_C0_DACSWTRG_MASK 产生软件触发信号
  else if(DAC_Config->Triger_Mode == TRIGER_MODE_SOFTWARE)
  {
    //设置DAC触发方式：软件触发开启
    DAC_C0_REG(dacptr) |=  DAC_C0_DACTRGSEL_MASK;
    //设置DAC软件触发方式是否有效：=1 有效 =0 无效
    DAC_C0_REG(dacptr) |=  DAC_C0_DACSWTRG_MASK;
  }
  //软件触发方式，DAC根据硬件产生的信号 产生触发
  else if(DAC_Config->Triger_Mode == TRIGER_MODE_HARDWARE)
  {
    //设置DAC触发方式：硬件出发开启
    DAC_C0_REG(dacptr) &= (~DAC_C0_DACTRGSEL_MASK);
    //设置DAC软件触发方式是否有效：=1 有效 =0 无效
    DAC_C0_REG(dacptr) &= (~DAC_C0_DACSWTRG_MASK );
  }
  else 
    return 0;
  //选择DAC电压参考源
  //0 The DAC selets DACREF_1 as the reference voltage.
  //  VREF_OUT = DACREF_1
  //1 The DAC selets DACREF_2 as the reference voltage.
  //  VDDA = DACREF_2
  //选择VDDA作为参考电压
  DAC_C0_REG(dacptr) |=  DAC_C0_DACRFS_MASK;
  //使能DAC模块
  DAC_C0_REG(dacptr) |=  DAC_C0_DACEN_MASK;
  //===========DAC_C0配置完毕====================//
  
  //===========配置DAC_C1寄存器=================//
  DAC_C1_REG(dacptr)  = 0;
  //禁止DAC的DMA模式 
  DAC_C1_REG(dacptr) &= (~DAC_C1_DMAEN_MASK);
  //DAC buffer watermark select
  
  //DAC 水印缓冲设置为 1个word 
  if(DAC_Config->Water_Mark_Mode == WATER_MODE_1WORD)
  {
    DAC_C1_REG(dacptr) |= DAC_C1_DACBFWM(WATER_MODE_1WORD);
  }
   //DAC 水印缓冲设置为 2个word 
  else if(DAC_Config->Water_Mark_Mode == WATER_MODE_2WORD)
  {
    DAC_C1_REG(dacptr) |= DAC_C1_DACBFWM(WATER_MODE_2WORD);  
  }
   //DAC 水印缓冲设置为 3word 
  else if(DAC_Config->Water_Mark_Mode == WATER_MODE_3WORD)
  {
    DAC_C1_REG(dacptr) |= DAC_C1_DACBFWM(WATER_MODE_3WORD);   
  }
  //DAC 水印缓冲设置为 4个word 
  else if(DAC_Config->Water_Mark_Mode == WATER_MODE_4WORD)
  {
    DAC_C1_REG(dacptr) |= DAC_C1_DACBFWM(WATER_MODE_4WORD);   
  }
  else
    return 0;
  
  //DAC 选择为正常模式
  //DAC Buffer 指针从零开始++ 直到等于 DAC Buffer Limit
  //然后DAC Buffer 指针清零
  //设置成为正常模式
  if(DAC_Config->Buffer_Mode == BUFFER_MODE_NORMAL)
  {
    DAC_C1_REG(dacptr) |= DAC_C1_DACBFMD(BUFFER_MODE_NORMAL);
  }
  //设置成为反转模式
  else if(DAC_Config->Buffer_Mode == BUFFER_MODE_SWING)
  {
    DAC_C1_REG(dacptr) |= DAC_C1_DACBFMD(BUFFER_MODE_SWING);  
  }
  //设置成为一次扫描模式
  else if(DAC_Config->Buffer_Mode == BUFFER_MODE_ONETIMESCAN)
  {
    DAC_C1_REG(dacptr) |= DAC_C1_DACBFMD(BUFFER_MODE_ONETIMESCAN);   
  }
  else
    return 0;
  
  //是否使能DAC Buffer  
  if(DAC_Config->Buffer_Enable == BUFFER_ENABLE)
  {
    DAC_C1_REG(dacptr) |= DAC_C1_DACBFEN_MASK;
  }
  else
  {
    DAC_C1_REG(dacptr) &= (~DAC_C1_DACBFEN_MASK);
  }
  //===========DAC_C1配置完毕====================//  
    
  //===========配置DAC_C2寄存器=================//
  //设置Buffer上限 
  DAC_C2_REG(dacptr) = DAC_C2_DACBFUP((DAC_Config->Buffer_Up_Limit & 0x0f)); 
  //设置Buffer指针位置
  DAC_C2_REG(dacptr) |=DAC_C2_DACBFRP((DAC_Config->Buffer_Init_Pos & 0xf0));
  //===========DAC_C2配置完毕====================//  
  
  return 1;
}


/*
 * LPLD_DAC_Soft_Trig
 * 设置软件触发信号
 * 
 * 参数:
 *    dacx--DAC模块号
 *      |__DAC0           --DAC0模块
 *      |__DAC1           --DAC1模块
 * 输出：
 *    无
 */
void LPLD_DAC_Soft_Trig(DACx dacx)
{
  DAC_MemMapPtr dacptr = DACx_Ptr[dacx];
  DAC_C0_REG(dacptr) |= DAC_C0_DACSWTRG_MASK;
}

/*
 * LPLD_DAC_Isr
 * DAC通用中断底层入口函数
 * 
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void LPLD_DAC_Isr(void)
{
  #define DAC_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
  uint8 dac_ch = DAC_VECTORNUM - 97;
  DAC_MemMapPtr DACx_Base_Ptr = (DAC_MemMapPtr)((0x400CC+dac_ch)<<12);
  
  if ((DAC_SR_REG(DACx_Base_Ptr)&DAC_SR_DACBFRPBF_MASK) ) 
  {
    DAC_ISR[dac_ch]();
    DAC_SR_REG(DACx_Base_Ptr)=0x06; //清除中断标志位
  }
  else if ((DAC_SR_REG(DACx_Base_Ptr)&DAC_SR_DACBFRPTF_MASK))
  {
    DAC_ISR[dac_ch]();
    DAC_SR_REG(DACx_Base_Ptr)=0x05 ;//清除中断标志位
  }
  else if ((DAC_SR_REG(DACx_Base_Ptr)&DAC_SR_DACBFWMF_MASK))
  {
    DAC_ISR[dac_ch]();
    DAC_SR_REG(DACx_Base_Ptr)=0x03 ;//清除中断标志位
  }
}