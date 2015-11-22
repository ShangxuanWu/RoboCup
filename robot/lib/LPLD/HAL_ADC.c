/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_ADC.c
 * 用途: ADC底层模块相关函数
 * 最后修改日期: 20120323
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#include "common.h"
#include "HAL_ADC.h"

ADC_ISR_CALLBACK ADC_ISR[2];
//全局变量定义
tADC_Config Adc0_Config;  // ADC0 寄存器结构体
tADC_Config Adc1_Config;  // ADC0 寄存器结构体

//ADC映射地址数组
volatile ADC_MemMapPtr ADCx_Ptr[2] = {ADC0_BASE_PTR, 
                                      ADC1_BASE_PTR};


/*
 * LPLD_ADC_Init
 * ADC模块通用初始化函数--用于非中断模式、单次转换、软件触发
 * 
 * 参数:
 *    adcx--ADC模块号
 *      |__ADC0         -ADC0模块
 *      |__ADC1         -ADC1模块
 *    mode--AD转换精度
 *      |__MODE_8       --单端8位，差分9位
 *      |__MODE_12      --单端12位，差分13位
 *      |__MODE_10      --单端10位，差分11位
 *      |__MODE_16      --单端16位，差分16位
 *    diff--单端输入或差分输入
 *      |__CONV_SING    --单端
 *      |__CONV_DIFF    --差分
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_ADC_Init(ADCx adcx, uint8 mode, uint8 diff)
{
  tADC_ConfigPtr ADC_CfgPtr;
  
  if(adcx == ADC0)
  {
    SIM_SCGC6 |= (SIM_SCGC6_ADC0_MASK);   // 开启ADC0时钟
    ADC_CfgPtr = &Adc0_Config;
  }
  else if(adcx == ADC1)
  {
    SIM_SCGC3 |= (SIM_SCGC3_ADC1_MASK);   // 开启ADC1时钟
    ADC_CfgPtr = &Adc1_Config;
  }
  else
  {
    return 0;
  }
  
  // 初始化ADC
  ADC_CfgPtr->CONFIG1  = ADLPC_NORMAL                   // 重新为正常使用进行配置，4次硬件平均
                      | ADC_CFG1_ADIV(ADIV_8) //| ADC_CFG1_ADIV(ADIV_1) // ADC输入时钟分频为 1
                      | ADLSMP_LONG                     // 长采样时间设置 
                      | ADC_CFG1_ADICLK(ADICLK_BUS_2);  // ADC输入时钟源为 BusClk/2
  
  // 选择转换精度
  switch(mode)
  {
    case MODE_8:
       ADC_CfgPtr->CONFIG1 |= ADC_CFG1_MODE(MODE_8);
       break;
    case MODE_12:
       ADC_CfgPtr->CONFIG1 |= ADC_CFG1_MODE(MODE_12);
       break;
    case MODE_10:
       ADC_CfgPtr->CONFIG1 |= ADC_CFG1_MODE(MODE_10);
       break;
    case MODE_16:
       ADC_CfgPtr->CONFIG1 |= ADC_CFG1_MODE(MODE_16);
       break;
    default:
      return 0;
  }
  // 选择ADxxa为输入通道
  // 异步时钟输出使能
  // 高速转换
  // 长采样时间时钟周期选择 额外20个时钟周期，共24个ADCK周期
  // 总采样周期见K60技术文档 page:840
  ADC_CfgPtr->CONFIG2  = MUXSEL_ADCA 
                      | ADACKEN_DISABLED 
                      | ADHSC_HISPEED
                      | ADC_CFG2_ADLSTS(ADLSTS_20) ;
  //用于设定阈值
  ADC_CfgPtr->COMPARE1 = 0x1234u ; 
  ADC_CfgPtr->COMPARE2 = 0x5678u ;
  
  ADC_CfgPtr->STATUS2  = ADTRG_SW     //初始化设置成为软件触发
                      | ACFE_DISABLED 
                      | ACFGT_GREATER 
                      | ACREN_ENABLED
                      | DMAEN_DISABLED
                      | ADC_SC2_REFSEL(REFSEL_EXT);
  
  ADC_CfgPtr->STATUS3  = CAL_OFF    //关闭校准
                      | ADCO_SINGLE 
                      | AVGE_ENABLED 
                      | ADC_SC3_AVGS(AVGS_32);
  
  ADC_CfgPtr->PGA      = PGAEN_DISABLED 
                      | PGACHP_NOCHOP 
                      | PGALP_NORMAL 
                      | ADC_PGA_PGAG(PGAG_64);
  
  ADC_Config_Alt(ADCx_Ptr[adcx], ADC_CfgPtr);    //配置 ADC寄存器
  ADC_Cal(ADCx_Ptr[adcx]);                       //首先进行32次的硬件平均校准进行校准
  
  //选择单端或差分模式
  if(diff == CONV_SING)
  {
    ADC_CfgPtr->STATUS1A =  DIFF_SINGLE ;
  }  
  else if(diff == CONV_DIFF)
  {
    ADC_CfgPtr->STATUS1A =  DIFF_DIFFERENTIAL;
  } 
  else
  {
    return 0;
  }
  
  ADC_Config_Alt(ADCx_Ptr[adcx], ADC_CfgPtr);  //再校准后，再次初始化，配置ADC0
  
  return 1;
}

void ADC_Init(ADCx adcx)
{
  tADC_ConfigPtr ADC_CfgPtr;
  if(adcx == ADC0)
  {
    SIM_SCGC6 |= (SIM_SCGC6_ADC0_MASK);   // 开启ADC0时钟
    ADC_CfgPtr = &Adc0_Config;
  }
  else if(adcx == ADC1)
  {
    SIM_SCGC3 |= (SIM_SCGC3_ADC1_MASK);   // 开启ADC1时钟
    ADC_CfgPtr = &Adc1_Config;
  }
  else
  {
    return;
  }
  ADC_CfgPtr->CONFIG1 = ADLPC_NORMAL 
                      | ADC_CFG1_ADIV(ADIV_8) 
                      | ADLSMP_LONG 
                      | ADC_CFG1_MODE(MODE_10)
                      | ADC_CFG1_ADICLK(ADICLK_BUS_2);
  
  ADC_CfgPtr->CONFIG2 = MUXSEL_ADCA 
                      | ADACKEN_DISABLED
                      | ADHSC_HISPEED 
                      | ADC_CFG2_ADLSTS(ADLSTS_20) ;
  
  ADC_CfgPtr->COMPARE1 = 0x1234u ; 
  ADC_CfgPtr->COMPARE2 = 0x5678u ;
  
  ADC_CfgPtr->STATUS2  = ADTRG_SW 
                      |  ACFE_DISABLED 
                      |  ACFGT_GREATER 
                      |  ACREN_ENABLED 
                      |  DMAEN_ENABLED
                      |  ADC_SC2_REFSEL(REFSEL_EXT);
  
  ADC_CfgPtr->STATUS3  = CAL_OFF
                       | ADCO_SINGLE
                       | AVGE_ENABLED
                       | ADC_SC3_AVGS(AVGS_32);
  
  ADC_CfgPtr->PGA     = PGAEN_DISABLED 
                      | PGACHP_NOCHOP 
                      | PGALP_NORMAL 
                      | ADC_PGA_PGAG(PGAG_64);
  
  //ADC_CfgPtr->STATUS1A = AIEN_OFF | DIFF_SINGLE | ADC_SC1_ADCH(31);
  //ADC_CfgPtr->STATUS1B = AIEN_OFF | DIFF_SINGLE | ADC_SC1_ADCH(31);
  
  ADC_Config_Alt(ADC0_BASE_PTR, ADC_CfgPtr);   // config ADC
  ADC_Cal(ADC0_BASE_PTR);                      // do the calibration
  
  enable_irq(57);
  ADC_CfgPtr->STATUS1A = AIEN_OFF | DIFF_SINGLE | ADC_SC1_ADCH(0);
  ADC_CfgPtr->STATUS1B = AIEN_OFF | DIFF_SINGLE | ADC_SC1_ADCH(0);
  ADC_Config_Alt(ADC0_BASE_PTR, ADC_CfgPtr);   // config ADC0
}


/*
 * LPLD_ADC_SE_Get
 * 取得ADC模块单端输入转换值--软件触发
 * 
 * 参数:
 *    adcx--ADC模块号
 *      |__ADC0         -ADC0模块
 *      |__ADC1         -ADC0模块
 *    channel--ADC通道号，不同的通道号对应不同的引脚，注意有些通道并非都有ADC0或ADC1
 *      |__0            --ADC0:PGA0_DP;  ADC1:PGA1_DP
 *      |__1            --ADC0:PGA2_DP;  ADC1:PGA3_DP
 *      |__2            --ADC0:PGA0_DP;  ADC1:PGA1_DP
 *      |__3            --ADC0:ADC0_DP3; ADC1:PGA0_DP
 *      |__4            --ADC0:NC;       ADC1:PTE0
 *      |__5            --ADC0:NC;       ADC1:PTE1
 *      |__6            --ADC0:NC;       ADC1:PTE2
 *      |__7            --ADC0:NC;       ADC1:PTE3
 *      |__8            --ADC0:PTB0;     ADC1:PTB0
 *      |__9            --ADC0:PTB1;     ADC1:PTB1
 *      |__10           --ADC0:PTA7;    ADC1:PTB4
 *      |__11           --ADC0:PTA8;    ADC1:PTB5
 *      |__12           --ADC0:PTB2;    ADC1:PTB6
 *      |__13           --ADC0:PTB3;    ADC1:PTB7
 *      |__14           --ADC0:PTC0;    ADC1:PTB10
 *      |__15           --ADC0:PTC1;    ADC1:PTB11
 *      |__16           --ADC0:ADC0_SE16;ADC1:ADC1_SE16
 *      |__17           --ADC0:PTE24;   ADC1:PTA17
 *      |__18           --ADC0:PTE25;   ADC1:VREF Output
 *      |__19           --ADC0:PGA0_DM; ADC1:PGA1_DM
 *      |__20           --ADC0:PGA2_DM; ADC1:PGA3_DM
 *      |__23           --ADC0:DAC0_OUT;ADC1:DAC1_OUT
 *      |__26           --ADC0:Temperature Sensor;  ADC1:Temperature Sensor
 *      |__27           --ADC0:Bandgap; ADC1:Bandgap
 *      |__29           --ADC0:VREFH;   ADC1:VREFH
 *      |__30           --ADC0:VREFL;   ADC1:VREFL
 *
 * 输出:
 *    0--配置错误，或电压值为0
 *    其他--AD通道转换值，右对齐
 */
uint16 LPLD_ADC_SE_Get(ADCx adcx, uint8 channel)
{
  ADC_MemMapPtr adcptr = ADCx_Ptr[adcx];
  
  if(channel>30)
    return 0;
  
  //不同的通道对应不同的引脚，因此需要判断并配置
  if(adcx == ADC0)
  {
    switch(channel)
    {
      case 0:   //ADC0_DP0 -- PGA0_DP
      case 1:   //ADC0_DP1 -- PGA2_DP
      case 2:   //PGA0_DP
      case 3:   //ADC0_DP3 -- PGA1_DP
        break;
      case 8:  //ADC0_SE8 -- PTB0
      case 9:  //ADC0_SE9 -- PTB1
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-8) =  PORT_PCR_MUX(0);
        break;
      case 10:  //ADC0_SE10 -- PTA7
      case 11:  //ADC0_SE11 -- PTA8
        SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
        PORT_PCR_REG(PORTA_BASE_PTR, channel-3) =  PORT_PCR_MUX(0);
        break;
      case 12:  //ADC0_SE12 -- PTB2
      case 13:  //ADC0_SE13 -- PTB3
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-10) =  PORT_PCR_MUX(0);
        break;
      case 14:  //ADC0_SE14 -- PTC0
      case 15:  //ADC0_SE15 -- PTC1
        SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK; 
        PORT_PCR_REG(PORTC_BASE_PTR, channel-14) =  PORT_PCR_MUX(0);
        break;
      case 16:   //ADC0_SE16
        break;
      case 17:   //ADC0_SE17 -- PTE24
      case 18:   //ADC0_SE17 -- PTE25
        SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; 
        PORT_PCR_REG(PORTE_BASE_PTR, channel+7) =  PORT_PCR_MUX(0);
        break;
      case 19:   //ADC0_DM0 -- PGA0_DM
      case 20:   //ADC0_DM1 -- PGA2_DM
      case 23:   //ADC0_SE23 -- DAC0_OUT
      case 26:   //Temperature Sensor (S.E)
      case 27:   //Bandgap (S.E)
      case 29:   //VREFH (S.E)
      case 30:   //VREFL
        break;
      default:
        return 0;  
    }
  }
  else if(adcx == ADC1)
  {
    switch(channel)
    {
      case 0:   //ADC1_DP0 -- PGA1_DP
      case 1:   //ADC1_DP1 -- PGA3_DP
      case 2:   //PGA1_DP 
      case 3:   //ADC1_DP3 -- PGA0_DP
        break;
      case 4:   //ADC1_SE4a -- PTE0
      case 5:   //ADC1_SE5a -- PTE1
      case 6:   //ADC1_SE6a -- PTE2
      case 7:   //ADC1_SE7a -- PTE3
        SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; 
        PORT_PCR_REG(PORTE_BASE_PTR, channel-4) =  PORT_PCR_MUX(0);
        break;
      case 8:  //ADC1_SE8 -- PTB0
      case 9:  //ADC1_SE9 -- PTB1
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-8) =  PORT_PCR_MUX(0);
        break;
      case 10:  //ADC1_SE10 -- PTB4
      case 11:  //ADC1_SE11 -- PTB5
      case 12:  //ADC1_SE12 -- PTB6
      case 13:  //ADC1_SE13 -- PTB7
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-6) =  PORT_PCR_MUX(0);
        break;
      case 14:  //ADC1_SE14 -- PTB10
      case 15:  //ADC1_SE15 -- PTB11
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-4) =  PORT_PCR_MUX(0);
        break;
      case 16:   //ADC1_SE16
        break;
      case 17:  //ADC1_SE17 -- PTA17
        SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
        PORT_PCR_REG(PORTA_BASE_PTR, channel) =  PORT_PCR_MUX(0);
        break;
      case 18:   //VREF Output
      case 19:   //ADC1_DM0 -- PGA1_DM
      case 20:   //ADC1_DM1 -- PGA3_DM
      case 23:   //DAC1_OUT 
      case 26:   //Temperature Sensor (S.E)
      case 27:   //Bandgap (S.E)
      case 29:   //VREFH (S.E)
      case 30:   //VREFL
        break;
      default:
        return 0;  
    }
  }
  else
  {
    return 0;
  }
  
  ADC_SC1_REG(adcptr,0) &= ~(ADC_SC1_ADCH_MASK);
  ADC_SC1_REG(adcptr,0) |= ADC_SC1_ADCH(channel);
  
  while((ADC_SC1_REG(adcptr,0)&ADC_SC1_COCO_MASK) == 0);  //等待转换完成
  return ADC_R_REG(adcptr, 0);
}


/*
 * LPLD_ADC_Channel_Init
 * ADC通道初始化,在该函数中配置ADC的输入通道，配置ADC中断、DMA请求，和相应的中断服务函数
 * 
 * 参数:
 *    adcx--ADC模块号
 *      |__ADC0         -ADC0模块
 *      |__ADC1         -ADC0模块
 *    channel--ADC通道号，不同的通道号对应不同的引脚，注意有些通道并非都有ADC0或ADC1
 *      |__0            --ADC0:PGA0_DP;  ADC1:PGA1_DP
 *      |__1            --ADC0:PGA2_DP;  ADC1:PGA3_DP
 *      |__2            --ADC0:PGA0_DP;  ADC1:PGA1_DP
 *      |__3            --ADC0:ADC0_DP3; ADC1:PGA0_DP
 *      |__4            --ADC0:NC;       ADC1:PTE0
 *      |__5            --ADC0:NC;       ADC1:PTE1
 *      |__6            --ADC0:NC;       ADC1:PTE2
 *      |__7            --ADC0:NC;       ADC1:PTE3
 *      |__8            --ADC0:PTB0;     ADC1:PTB0
 *      |__9            --ADC0:PTB1;     ADC1:PTB1
 *      |__10           --ADC0:PTA7;    ADC1:PTB4
 *      |__11           --ADC0:PTA8;    ADC1:PTB5
 *      |__12           --ADC0:PTB2;    ADC1:PTB6
 *      |__13           --ADC0:PTB3;    ADC1:PTB7
 *      |__14           --ADC0:PTC0;    ADC1:PTB10
 *      |__15           --ADC0:PTC1;    ADC1:PTB11
 *      |__16           --ADC0:ADC0_SE16;ADC1:ADC1_SE16
 *      |__17           --ADC0:PTE24;   ADC1:PTA17
 *      |__18           --ADC0:PTE25;   ADC1:VREF Output
 *      |__19           --ADC0:PGA0_DM; ADC1:PGA1_DM
 *      |__20           --ADC0:PGA2_DM; ADC1:PGA3_DM
 *      |__23           --ADC0:DAC0_OUT;ADC1:DAC1_OUT
 *      |__26           --ADC0:Temperature Sensor;  ADC1:Temperature Sensor
 *      |__27           --ADC0:Bandgap; ADC1:Bandgap
 *      |__29           --ADC0:VREFH;   ADC1:VREFH
 *      |__30           --ADC0:VREFL;   ADC1:VREFL
 *  ad_event--ADC事件，包括ADC中断禁止、使能，DMA请求禁止、使能。
 *      |__ADC_INT_DISABLE    --中断禁止
 *      |__ADC_INT_ENABLE     --中断使能
 *      |__ADC_DMA_DISABLE    --DMA请求禁止
 *      |__ADC_DMA_ENABLE     --DMA请求使能
 *
 *  ADC_ISR_CALLBACK
 *      |__isr                --如果使能中断，设置中断服务函数的路径，
 *                              如果没有设置中断，将其设置成为NULL
 * 输出:
 *    0--配置错误，或电压值为0
 *    其他--AD通道转换值，右对齐
 */
uint8_t LPLD_ADC_Channel_Init(ADCx adcx, uint8_t channel ,uint8_t ad_event,ADC_ISR_CALLBACK isr)
{
  ADC_MemMapPtr adcptr = ADCx_Ptr[adcx];
  
  if(channel>30)
    return 0;
  
  //不同的通道对应不同的引脚，因此需要判断并配置
  if(adcx == ADC0)
  {
    switch(channel)
    {
      case 0:   //ADC0_DP0 -- PGA0_DP
      case 1:   //ADC0_DP1 -- PGA2_DP
      case 2:   //PGA0_DP
      case 3:   //ADC0_DP3 -- PGA1_DP
        break;
      case 8:  //ADC0_SE8 -- PTB0
      case 9:  //ADC0_SE9 -- PTB1
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-8) =  PORT_PCR_MUX(0);
        break;
      case 10:  //ADC0_SE10 -- PTA7
      case 11:  //ADC0_SE11 -- PTA8
        SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
        PORT_PCR_REG(PORTA_BASE_PTR, channel-3) =  PORT_PCR_MUX(0);
        break;
      case 12:  //ADC0_SE12 -- PTB2
      case 13:  //ADC0_SE13 -- PTB3
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-10) =  PORT_PCR_MUX(0);
        break;
      case 14:  //ADC0_SE14 -- PTC0
      case 15:  //ADC0_SE15 -- PTC1
        SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK; 
        PORT_PCR_REG(PORTC_BASE_PTR, channel-14) =  PORT_PCR_MUX(0);
        break;
      case 16:   //ADC0_SE16
        break;
      case 17:   //ADC0_SE17 -- PTE24
      case 18:   //ADC0_SE17 -- PTE25
        SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; 
        PORT_PCR_REG(PORTE_BASE_PTR, channel+7) =  PORT_PCR_MUX(0);
        break;
      case 19:   //ADC0_DM0 -- PGA0_DM
      case 20:   //ADC0_DM1 -- PGA2_DM
      case 23:   //ADC0_SE23 -- DAC0_OUT
      case 26:   //Temperature Sensor (S.E)
      case 27:   //Bandgap (S.E)
      case 29:   //VREFH (S.E)
      case 30:   //VREFL
        break;
      default:
        return 0;  
    }
  }
  else if(adcx == ADC1)
  {
    switch(channel)
    {
      case 0:   //ADC1_DP0 -- PGA1_DP
      case 1:   //ADC1_DP1 -- PGA3_DP
      case 2:   //PGA1_DP 
      case 3:   //ADC1_DP3 -- PGA0_DP
        break;
      case 4:   //ADC1_SE4a -- PTE0
      case 5:   //ADC1_SE5a -- PTE1
      case 6:   //ADC1_SE6a -- PTE2
      case 7:   //ADC1_SE7a -- PTE3
        SIM_SCGC5 |= SIM_SCGC5_PORTE_MASK; 
        PORT_PCR_REG(PORTE_BASE_PTR, channel-4) =  PORT_PCR_MUX(0);
        break;
      case 8:  //ADC1_SE8 -- PTB0
      case 9:  //ADC1_SE9 -- PTB1
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-8) =  PORT_PCR_MUX(0);
        break;
      case 10:  //ADC1_SE10 -- PTB4
      case 11:  //ADC1_SE11 -- PTB5
      case 12:  //ADC1_SE12 -- PTB6
      case 13:  //ADC1_SE13 -- PTB7
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-6) =  PORT_PCR_MUX(0);
        break;
      case 14:  //ADC1_SE14 -- PTB10
      case 15:  //ADC1_SE15 -- PTB11
        SIM_SCGC5 |= SIM_SCGC5_PORTB_MASK; 
        PORT_PCR_REG(PORTB_BASE_PTR, channel-4) =  PORT_PCR_MUX(0);
        break;
      case 16:   //ADC1_SE16
        break;
      case 17:  //ADC1_SE17 -- PTA17
        SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK; 
        PORT_PCR_REG(PORTA_BASE_PTR, channel) =  PORT_PCR_MUX(0);
        break;
      case 18:   //VREF Output
      case 19:   //ADC1_DM0 -- PGA1_DM
      case 20:   //ADC1_DM1 -- PGA3_DM
      case 23:   //DAC1_OUT 
      case 26:   //Temperature Sensor (S.E)
      case 27:   //Bandgap (S.E)
      case 29:   //VREFH (S.E)
      case 30:   //VREFL
        break;
      default:
        return 0;  
    }
  }
  else
  {
    return 0;
  }
  
  if(ad_event & ADC_INT_DISABLE)
  {
    ADC_SC1_REG(adcptr,0) &= ~(ADC_SC1_AIEN_MASK); //禁止中断
  }
  else if(ad_event & ADC_INT_ENABLE)
  {
    ADC_SC1_REG(adcptr,0) |= ADC_SC1_AIEN_MASK;   //使能中断
    if(adcx == ADC0)
    {
      enable_irq(57);      //使能ADC0 NVIC中断
      ADC_ISR[ADC0] = isr; //添加中断路径 
    }
    else
    {
      enable_irq(58);      //使能ADC1 NVIC中断
      ADC_ISR[ADC1] = isr; //添加中断路径 
    }
  }
  if(ad_event & ADC_DMA_DISABLE)
  {
    ADC_SC2_REG(adcptr)  &= ~( ADC_SC2_DMAEN_MASK ); //禁止DMA
  }
  else if(ad_event & ADC_DMA_ENABLE)
  {
    ADC_SC2_REG(adcptr)  |= ADC_SC2_DMAEN_MASK;     //使能DMA
  }
  ADC_SC1_REG(adcptr,0) &= ~(ADC_SC1_ADCH_MASK);   
  ADC_SC1_REG(adcptr,0) |= ADC_SC1_ADCH(channel);   //设置通道
  
  return 1;
}
/*
 * LPLD_ADC_SetHWTrg
 * 设置ADC为硬件触发方式
 * 
 * 参数:
 *    adcx--ADC模块号
 *      |__ADC0         -ADC0模块
 *      |__ADC1         -ADC0模块
 *
 * 输出:
 *    无
 */
void LPLD_ADC_SetHWTrg(ADCx adcx)
{
  ADC_MemMapPtr adcptr = ADCx_Ptr[adcx];
  //选择ADC为硬件触发方式
  ADC_SC2_REG(adcptr)  |= ADC_SC2_ADTRG_MASK;
}

/*
 * LPLD_ADC_Isr
 * ADC中断服务函数
 */
void LPLD_ADC_Isr(void)
{
  #define ADC_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
  uint8 adc_ch = ADC_VECTORNUM - 73;
    
  //调用用户自定义中断服务
  if(ADC_ISR[adc_ch] != (ADC_ISR_CALLBACK)0)
    ADC_ISR[adc_ch](); 
  if(!adc_ch)
    ADC_SC1_REG(ADC0_BASE_PTR,0) |= ADC_SC1_COCO_MASK;
  else
    ADC_SC1_REG(ADC1_BASE_PTR,0) |= ADC_SC1_COCO_MASK;
}