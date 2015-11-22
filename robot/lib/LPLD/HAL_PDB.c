/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_PDB.c
 * 用途: PDB底层模块相关函数
 * 最后修改日期: 20120321
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
*/
#include "HAL_PDB.h"
#include "common.h"

/*
 *******需用到PDB中断，请在isr.h中粘贴一下代码:*********
#undef  VECTOR_088
#define VECTOR_088 LPLD_PDB_Isr
//以下函数在LPLD_Kinetis底层包，不必修改
extern void LPLD_PDB_Isr(void);
 ***********************代码结束*************************
*/


PDB_ISR_CALLBACK PDB_ISR[1];


/*
 * LPLD_PDB_Init
 * 用于初始化PDB
 * 设置PDB的prescale预分频值
 * 设置PDB的trgsel输入触发源
 * 设置PDB的ldmod加载模式
 * 设置PDB的cont持续工作模式和one-shot模式
 * 设置PDB的dma_en
 * 
 * 参数:
 *    prescale--PDB 分频系数
 *      PDB的计数器频率 等于 外设总线频率除以 prescale和mult的乘积\
 *      |__PDB_PRESC_1      -设置prescale = MULT * 1
 *      |__PDB_PRESC_2      -设置prescale = MULT * 2
 *      |__PDB_PRESC_4      -设置prescale = MULT * 4
 *      |__PDB_PRESC_8      -设置prescale = MULT * 8
 *      |__PDB_PRESC_16     -设置prescale = MULT * 16
 *      |__PDB_PRESC_32     -设置prescale = MULT * 32
 *      |__PDB_PRESC_64     -设置prescale = MULT * 64
 *      |__PDB_PRESC_128    -设置prescale = MULT * 128
 *
 *    mult--PDB 分频因子
 *      PDB的计数器频率 等于 外设总线频率除以 prescale和mult的乘积
 *      |__PDB_MULT_1       -设置MULT = 1
 *      |__PDB_MULT_10      -设置MULT = 10
 *      |__PDB_MULT_20      -设置MULT = 20
 *      |__PDB_MULT_40      -设置MULT = 40
 *
 *    mod--PDB 模计数器，
 *      当PDB计数器等于MOD的值，PDB计数器清零
 *
 *    trgsel-- PDB 触发源选择
 *      |__TRIGER_IN0        -输入触发源0
 *      |__...                  
 *      |__TRIGER_IN14       -输入触发源14
 *      |__SOFTWARE_TRIGER   -软件触发
 * 
 *    ldmod--设置PDB ADC通道x的预触发通道
 *      |__LDMOD0   -当LDOK=1后 MOD, IDLY, CHnDLYm, INTx, 和 POyDLY 寄存器立即加载
 *      |__LDMOD1   -当LDOK=1和PDB计数器到达MOD后 MOD, IDLY, CHnDLYm, INTx, 和 POyDLY 寄存器立即加载
 *      |__LDMOD2   -当LDOK=1和一个输入事件设置为1后 MOD, IDLY, CHnDLYm, INTx, 和 POyDLY 寄存器立即加载
 *      |__LDMOD3   -当LDOK=1后和一个输入事件设置为1或PDB计数器到达MOD后 MOD, IDLY, CHnDLYm, INTx, 和 POyDLY 寄存器立即加载
 *
 *    cont -- 设置PDB 工作模式
 *      |__PDB_ONESHOT   -单次模式
 *      |__PDB_CONTINUE  -连续模式
 * 
 *    dma_en -- 使能DMA功能
 *      |__PDB_DMA_OFF   -禁止DMA模式
 *      |__PDB_DMA_ON    -使能DMA模式
 *
 *    返回值:
 *       0 错误
 *       1 设置成功
 */
uint8 LPLD_PDB_Init(uint8 prescale,uint8 mult,uint16 mod ,uint8 trgsel,uint8 ldmod,uint8 cont,uint8 dma_en)
{
  //使能PDB时钟
  SIM_SCGC6 |= SIM_SCGC6_PDB_MASK ;
  
  PDB0_SC = 0x00;
  //设置分频因子
  //f_PDB = f_perpherial_bus / (mult * prescale)
  //其中f_perpherial_bus在PLL锁相环中设置
  if( mult > 3)
    return 0;
  else
    PDB0_SC |=PDB_SC_MULT(mult);
  
  if(prescale >7)
    return 0;
  else
    PDB0_SC |=PDB_SC_PRESCALER(prescale);
  
  if(ldmod > 3)
    return 0;
  else
    //设置加载模式
    PDB0_SC |= PDB_SC_LDMOD(ldmod); 
  
  if(trgsel >15)
    return 0;
  else
    //设置触发模式
    PDB0_SC |= PDB_SC_TRGSEL(trgsel);
  
  //设置PDB工作模式
  if(cont)
  {
    //PDB 工作在连续模式
    PDB0_SC |= PDB_SC_CONT_MASK ;
  }
  else
  {
    //PDB 工作在连续模式
    PDB0_SC &=(~PDB_SC_CONT_MASK);
  }
  //设置DMA模式
  if(dma_en)
  {
    //PDB 工作在连续模式
    PDB0_SC |= PDB_SC_DMAEN_MASK ;
  }
  else
  {
    //PDB 工作在连续模式
    PDB0_SC &=(~PDB_SC_DMAEN_MASK);
  }
  
  PDB0_MOD = mod;
  
  return 1;
}

/*
 * LPLD_PDB_SetUp
 * 用于开启关闭PDB计数器
 * 开启的同时根据LMOD的配置加载MOD, IDLY, CHnDLYm, DACINTx, and POyDLY
 * 如果设置为软件触发，此时清零计数器
 *
 * 参数:
 *   is_operate -- 决定是否开启PDB
 *     |__PDB_STOP        -关闭PDB
 *     |__PDB_OPERATION   -开启PDB
 */
void LPLD_PDB_SetUp(uint8 is_operate)
{
  if(is_operate==PDB_OPERATION)
  {
    //开启PDB0
    PDB0_SC |= PDB_SC_PDBEN_MASK ; 
    //LDOK 只有在PDBEN = 1情况下才有用；
    //更细MOD, IDLY, CHnDLYm, DACINTx, and POyDLY中的值
    //将所有设置的时间值加载到相对应的缓冲区中。
    PDB0_SC |= PDB_SC_LDOK_MASK ;
    
    //PDB使能后且软件触发模式后
    //此时计数器会清零，复位计数器
    PDB0_SC |= PDB_SC_SWTRIG_MASK ;
  }
  else
  {
    //关闭PDB
    PDB0_SC &= (~PDB_SC_PDBEN_MASK); 
  }
}

/*
 * LPLD_PDB_ADC_Trigger_Congfig
 * 用于设置通过PDB设置ADC的触发信号，在该函数中
 * 设置PDB的adcx通道
 * 设置PDB的adcx预触发延时计数器的值
 * 设置PDB的adcx预触发通道
 * 设置PDB的adcx预触发通道bb模式
 * 
 * 参数:
 *    adcx--选择PDB ADC的通道
 *      |__ADC0       -选择PDB ADC通道0
 *      |__ADC1       -选择PDB ADC通道1
 * 
 *    *pre_dalay--PDB ADC的预触发延时器的计数值，该参数最大为65536
 *        PDB ADC的延时频率 等于 PDB计数器的频率 乘以 pre_dalay 
 *        因为每个通道有两个预触发延时器，需要两个延时值，所以定义为*pre_dalay
 * 
 *    pre_ch--设置PDB ADC通道x的预触发通道
 *      |__PDB_PRECH_DIS  -不选择预触发位
 *      |__PDB_PRECH_EN0  -选择预触发0  
 *      |__PDB_PRECH_EN1  -选择预触发1  
 *
 *    pre_bb_mode--设置PDB ADC通道x的预触发的back to back模式
 *      |__PDB_PREBB_DIS  -禁止PDB ADC通道x的预触发的b to b模式
 *      |__PDB_PREBB_EN0  -选择PDB ADC通道x的预触发0的的b to b模式
 *      |__PDB_PREBB_EN1  -选择PDB ADC通道x的预触发1的的b to b模式
 */

void LPLD_PDB_ADC_Trigger_Congfig(ADCx adcx, uint16 *pre_dalay, uint8 pre_ch, uint8 pre_bb_mode)
{
  PDB_C1_REG(PDB0_BASE_PTR,adcx) = (0 
                                    | PDB_C1_BB(pre_bb_mode)
                                    | PDB_C1_TOS(pre_ch)
                                    | PDB_C1_EN(pre_ch)
                                    );
  
  if(pre_ch) 
  {
    PDB_DLY_REG(PDB0_BASE_PTR,adcx,pre_ch-1) = *pre_dalay;
  }
}

/*
 * LPLD_PDB_DAC_Interval_Congfig
 * 该函数用于设置DAC的PDB触发周期，在该函数中
 * 设置PDB的dacx通道
 * 设置PDB的dacx的PDB0_DACINTx的计数值，
 * 设置PDB的dacx外部引脚触发模式
 * 
 * 参数:
 *    dacx--选择PDB DAC的通道
 *      |__DAC0       -选择PDB DAC通道0
 *      |__DAC1       -选择PDB DAC通道1
 * 
 *    interval -- DAC的触发间隔，该参数最大为65536
 *        DAC的触发频率 等于 PDB计数器的频率 乘以 interval 
 * 
 *    extrigger -- DAC外部触发输入使能，如果设置此位PDB0_DACINTx会被放弃
 *      |__PDB_EXTRG_DIS  -禁用外部触发输入
 *      |__PDB_EXTRG_EN   -使能外部触发输入   
 */
void LPLD_PDB_DAC_Interval_Congfig(DACx dacx,uint16 interval,uint8 extrigger)
{

  if(extrigger == PDB_EXTRG_EN)
  {
    //外部触发模式下，PDB0_DACINT0无用
    //DAC output delay from PDB Software trigger
    PDB_INTC_REG(PDB0_BASE_PTR,dacx) |= PDB_INTC_EXT_MASK ;
  }
  else
  {
    //设置PDB0_DACINT0时，必须保证PDSC_DACTOE = 1,意思是开启PDB内部DAC计数器
    //DAC output changes are base on the interval defined by this value
    PDB_INT_REG(PDB0_BASE_PTR,dacx) = interval;
    PDB_INTC_REG(PDB0_BASE_PTR,dacx) &= ~PDB_INTC_EXT_MASK ;
  }
  //使能DAC间隔计数器
  PDB_INTC_REG(PDB0_BASE_PTR,dacx) |= PDB_INTC_TOE_MASK ;
  
}

/*
 * LPLD_PDB_Delay_SetIsr
 * 该函数用于设定PDB延时中断
 * 
 * 参数:
 * 
 *    delay -- PDB的延时值，该参数最大为65536
 *        PDB的延时值频率 等于 PDB计数器的频率 乘以 delay 
 * 
 *    isr_func -- PDB延时中断服务函数
 */

void LPLD_PDB_SetDelayIsr(uint16 delay,PDB_ISR_CALLBACK isr_func)
{
  //设定定时器值
  PDB0_IDLY = delay;
  
  enable_irq(72);
  //使能定时中断
  PDB0_SC |= PDB_SC_PDBIE_MASK;
  //添加中断函数  
  PDB_ISR[0] = isr_func;

}

/*
 * LPLD_PDB_Delay
 * 该函数用查询标志位的方式等待延时完成
 * 
 * 参数:
 * 
 *    delay -- PDB的延时值，该参数最大为65536
 *        PDB的延时值频率 等于 PDB计数器单位的频率 乘以 delay 
 * 
 */
void LPLD_PDB_Delay(uint16 delay)
{
  //设定定时器值
  PDB0_IDLY = delay;
  //禁止定时器中断
  PDB0_SC &= (~PDB_SC_PDBIE_MASK);
  //延时等待直到标志位置1
  while(PDB0_SC & PDB_SC_PDBIF_MASK)
  {
    //清除标志位  
    PDB0_SC |= PDB_SC_PDBIF_MASK;
  }
}


/*
 * LPLD_PDB_Isr
 * PDB通用中断底层入口函数
 * PDB一共有两个中断，其一为定时中断，其二为错误中断
 * 这里仅设置定时中断处理函数
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void LPLD_PDB_Isr(void)
{
  #define PDB_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
  uint8 pdb_ch = PDB_VECTORNUM - 88;
    
  //调用用户自定义中断服务
  PDB_ISR[pdb_ch]();  
  
  //清除定时中断标志位  
  PDB0_SC &= ~PDB_SC_PDBIF_MASK;
}