/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_FTM.h
 * 用途: FlexTimer底层模块相关函数
 * 最后修改日期: 20120329
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
/*
 *******需用到FTM中断，请在isr.h中粘贴一下代码:*********

//FTM模块中断服务定义
#undef  VECTOR_078
#define VECTOR_078 LPLD_FTM_Isr
#undef  VECTOR_079
#define VECTOR_079 LPLD_FTM_Isr
#undef  VECTOR_080
#define VECTOR_080 LPLD_FTM_Isr
//以下函数在LPLD_Kinetis底层包，不必修改
extern void LPLD_FTM_Isr(void);

 ***********************代码结束*************************
*/

#include "common.h"
#include "HAL_FTM.h"

//引用总线时钟频率，该值在sysinit.c文件中取得
extern int periph_clk_khz;

//全局变量定义
uint32 LPLD_FTM0_MOD;
uint32 LPLD_FTM1_MOD;
uint32 LPLD_FTM2_MOD;
uint8 LPLD_FTM0_Divider;
uint8 LPLD_FTM1_Divider;
uint8 LPLD_FTM2_Divider;

//用户自定义中断服务函数数组
FTM_ISR_CALLBACK FTM_ISR[3];

/*
 * LPLD_FTM0_PWM_Init
 * FTM0模块PWM功能初始化函数
 * 
 * 参数:
 *    freq--期望频率，单位Hz
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM0_PWM_Init(uint32 freq)
{
  uint32 bus_clk_hz;
  uint32 mod;
  uint8 ps;

  bus_clk_hz = periph_clk_khz*1000;
  
  if(freq>bus_clk_hz) return 0;
  
  if((mod=bus_clk_hz/(freq*128)) < 0xFFFFu)
  {
    ps = 7;
    LPLD_FTM0_MOD = mod;
    if((mod=bus_clk_hz/(freq*64)) < 0xFFFFu)
    {
      ps = 6;   
      LPLD_FTM0_MOD = mod;  
      if((mod=bus_clk_hz/(freq*32)) < 0xFFFFu)
      {
        ps = 5; 
        LPLD_FTM0_MOD = mod;  
        if((mod=bus_clk_hz/(freq*16)) < 0xFFFFu)
        {
          ps = 4;  
          LPLD_FTM0_MOD = mod;    
          if((mod=bus_clk_hz/(freq*8)) < 0xFFFFu)
          {
            ps = 3;
            LPLD_FTM0_MOD = mod;
            if((mod=bus_clk_hz/(freq*4)) < 0xFFFFu)
            {
              ps = 2;
              LPLD_FTM0_MOD = mod;
              if((mod=bus_clk_hz/(freq*2)) < 0xFFFFu)
              {
                ps = 1;
                LPLD_FTM0_MOD = mod;
                if((mod=bus_clk_hz/(freq*1)) < 0xFFFFu)
                {
                  ps = 0;
                  LPLD_FTM0_MOD = mod;
                }
              }
            }
          }
        }  
      }
    }
  }
  else
  {
    return 0;
  }
  
  // 使能FTM时钟模块
  SIM_SCGC6 |= SIM_SCGC6_FTM0_MASK;
  
  // 配置FTM控制寄存器
  // 禁用中断, 加计数模式, 时钟源:System clock（Bus Clk）, 分频系数:8
  // 假设SysClk = 50MHz, SC_PS=3, FTM Clk = 50MHz/2^3 = 6.25MHz
  FTM0_SC = FTM_SC_CLKS(1)|FTM_SC_PS(ps);
  
  // 设置PWM周期及占空比
  //    PWM周期 = (MOD-CNTIN+1)*FTM时钟周期 :
  // 配置FTM计数初始值
  FTM0_CNT = 0;
  FTM0_CNTIN = 0;
  // 配置FTM计数MOD值
  FTM0_MOD = LPLD_FTM0_MOD;
  
  return 1;
}

/*
 * LPLD_FTM0_PWM_Open
 * FTM0模块PWM输出通道及占空比配置
 * 
 * 说明: 其他GPIO也可配置为FTM0输出,本函数只考虑PTC和PTD,如需改变请自行修改 
 * 
 * 参数:
 *    channel - PWM输出通道
 *      |__0--PTC1
 *      |__1--PTC2
 *      |__2--PTC3
 *      |__3--PTC4
 *      |__4--PTD4
 *      |__5--PTD5
 *      |__6--PTD6
 *      |__7--PTD7
 *    duty - PWM输出占空比
 *      |__0~10000--占空比0.00%~100.00%
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM0_PWM_Open(uint8 channel, uint32 duty)
{
  uint32 cv;
  volatile uint32 mod;
  
  if(duty>10000) return 0;
  //占空比 = (CnV-CNTIN)/(MOD-CNTIN+1)
  mod = LPLD_FTM0_MOD;
  cv = (duty*(mod-0+1)+0)/10000;
  
  //选择并开启通道
  switch(channel)
  {
    case 0:
    case 1:
    case 2:
    case 3:
      SIM_SCGC5 |= SIM_SCGC5_PORTC_MASK;
      PORT_PCR_REG(PORTC_BASE_PTR, channel+1) = PORT_PCR_MUX(4);
      break;
    case 4:
    case 5:
    case 6:
    case 7:
      SIM_SCGC5 |= SIM_SCGC5_PORTD_MASK;
      PORT_PCR_REG(PORTD_BASE_PTR, channel) = PORT_PCR_MUX(4);
      break;
    default:
       return 0;
  }  
  
  // 配置FTM通道控制寄存器 
  // 通道模式 MSB:MSA-1X, 通道边缘选择 ELSB:ELSA-10
  FTM_CnSC_REG(FTM0_BASE_PTR, channel) = FTM_CnSC_MSB_MASK|FTM_CnSC_ELSB_MASK;
  // 配置FTM通道值
  FTM_CnV_REG(FTM0_BASE_PTR, channel) = cv;
  
  return 1;
}

/*
 * LPLD_FTM0_PWM_ChangeDuty
 * 改变FTM0模块PWM输出通道占空比
 *
 * 参数:
 *    channel - PWM输出通道
 *      |__0--PTC1
 *      |__1--PTC2
 *      |__2--PTC3
 *      |__3--PTC4
 *      |__4--PTD4
 *      |__5--PTD5
 *      |__6--PTD6
 *      |__7--PTD7
 *    duty - PWM输出占空比
 *      |__0~10000--占空比0.00%~100.00%
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM0_PWM_ChangeDuty(uint8 channel, uint32 duty)
{
  uint32 cv;
  volatile uint32 mod;
  
  if(duty>10000) return 0;
  //占空比 = (CnV-CNTIN)/(MOD-CNTIN+1)
  mod = LPLD_FTM0_MOD;
  cv = (duty*(mod-0+1)+0)/10000;
 
  // 配置FTM通道值
  FTM_CnV_REG(FTM0_BASE_PTR, channel) = cv;
  
  return 1;
}

/*
 * LPLD_FTM1_PWM_Init
 * FTM1模块PWM功能初始化函数
 * 
 * 参数:
 *    freq--期望频率，单位Hz
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM1_PWM_Init(uint32 freq)
{
  uint32 bus_clk_hz;
  uint32 mod;
  uint8 ps;

  bus_clk_hz = periph_clk_khz*1000;
  
  if(freq>bus_clk_hz) return 0;
  
  if((mod=bus_clk_hz/(freq*128)) < 0xFFFFu)
  {
    ps = 7;
    LPLD_FTM1_MOD = mod;
    if((mod=bus_clk_hz/(freq*64)) < 0xFFFFu)
    {
      ps = 6;   
      LPLD_FTM1_MOD = mod;  
      if((mod=bus_clk_hz/(freq*32)) < 0xFFFFu)
      {
        ps = 5; 
        LPLD_FTM1_MOD = mod;  
        if((mod=bus_clk_hz/(freq*16)) < 0xFFFFu)
        {
          ps = 4;  
          LPLD_FTM1_MOD = mod;    
          if((mod=bus_clk_hz/(freq*8)) < 0xFFFFu)
          {
            ps = 3;
            LPLD_FTM1_MOD = mod;
            if((mod=bus_clk_hz/(freq*4)) < 0xFFFFu)
            {
              ps = 2;
              LPLD_FTM1_MOD = mod;
              if((mod=bus_clk_hz/(freq*2)) < 0xFFFFu)
              {
                ps = 1;
                LPLD_FTM1_MOD = mod;
                if((mod=bus_clk_hz/(freq*1)) < 0xFFFFu)
                {
                  ps = 0;
                  LPLD_FTM1_MOD = mod;
                }
              }
            }
          }
        }  
      }
    }
  }
  else
  {
    return 0;
  }
  
  // 使能FTM时钟模块
  SIM_SCGC6 |= SIM_SCGC6_FTM1_MASK;
  
  // 配置FTM控制寄存器
  // 禁用中断, 加计数模式, 时钟源:System clock（Bus Clk）, 分频系数:8
  // 假设SysClk = 50MHz, SC_PS=3, FTM Clk = 50MHz/2^3 = 6.25MHz
  FTM1_SC = FTM_SC_CLKS(1)|FTM_SC_PS(ps);
  
  // 设置PWM周期及占空比
  //    PWM周期 = (MOD-CNTIN+1)*FTM时钟周期 :
  // 配置FTM计数初始值
  FTM1_CNT = 0;
  FTM1_CNTIN = 0;
  // 配置FTM计数MOD值
  FTM1_MOD = LPLD_FTM1_MOD;
  
  return 1;
}

/*
 * LPLD_FTM1_PWM_Open
 * FTM1模块PWM输出通道及占空比配置
 *  
 * 说明: 其他GPIO也可配置为FTM1输出,本函数只考虑PTA,如需改变请自行修改 
 * 
 * 参数:
 *    channel - PWM输出通道
 *      |__0--PTA8
 *      |__1--PTA9
 *    duty - PWM输出占空比
 *      |__0~10000--占空比0.00%~100.00%
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM1_PWM_Open(uint8 channel, uint32 duty)
{
  uint32 cv;
  volatile uint32 mod;
  
  if(duty>10000) return 0;
  //占空比 = (CnV-CNTIN)/(MOD-CNTIN+1)
  mod = LPLD_FTM1_MOD;
  cv = (duty*(mod-0+1)+0)/10000;
  
  //选择并开启通道
  switch(channel)
  {
    case 0:
    case 1:
      SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;
      PORT_PCR_REG(PORTA_BASE_PTR, channel+8) = PORT_PCR_MUX(3);
      break;
    default:
       return 0;
  }  
  
  // 配置FTM通道控制寄存器 
  // 通道模式 MSB:MSA-1X, 通道边缘选择 ELSB:ELSA-10
  FTM_CnSC_REG(FTM1_BASE_PTR, channel) = FTM_CnSC_MSB_MASK|FTM_CnSC_ELSB_MASK;
  // 配置FTM通道值
  FTM_CnV_REG(FTM1_BASE_PTR, channel) = cv;
  
  return 1;
}

/*
 * LPLD_FTM1_PWM_ChangeDuty
 * 改变FTM1模块PWM输出通道占空比
 *
 * 参数:
 *    channel - PWM输出通道
 *      |__0--PTA8
 *      |__1--PTA9
 *    duty - PWM输出占空比
 *      |__0~10000--占空比0.00%~100.00%
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM1_PWM_ChangeDuty(uint8 channel, uint32 duty)
{
  uint32 cv;
  volatile uint32 mod;
  
  if(duty>10000) return 0;
  //占空比 = (CnV-CNTIN)/(MOD-CNTIN+1)
  mod = LPLD_FTM1_MOD;
  cv = (duty*(mod-0+1)+0)/10000;
 
  // 配置FTM通道值
  FTM_CnV_REG(FTM1_BASE_PTR, channel) = cv;
  
  return 1;
}


/*
 * LPLD_FTM2_PWM_Init
 * FTM2模块PWM功能初始化函数
 * 
 * 参数:
 *    freq--期望频率，单位Hz
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM2_PWM_Init(uint32 freq)
{
  uint32 bus_clk_hz;
  uint32 mod;
  uint8 ps;

  bus_clk_hz = periph_clk_khz*1000;
  
  if(freq>bus_clk_hz) return 0;
  
  if((mod=bus_clk_hz/(freq*128)) < 0xFFFFu)
  {
    ps = 7;
    LPLD_FTM2_MOD = mod;
    if((mod=bus_clk_hz/(freq*64)) < 0xFFFFu)
    {
      ps = 6;   
      LPLD_FTM2_MOD = mod;  
      if((mod=bus_clk_hz/(freq*32)) < 0xFFFFu)
      {
        ps = 5; 
        LPLD_FTM2_MOD = mod;  
        if((mod=bus_clk_hz/(freq*16)) < 0xFFFFu)
        {
          ps = 4;  
          LPLD_FTM2_MOD = mod;    
          if((mod=bus_clk_hz/(freq*8)) < 0xFFFFu)
          {
            ps = 3;
            LPLD_FTM2_MOD = mod;
            if((mod=bus_clk_hz/(freq*4)) < 0xFFFFu)
            {
              ps = 2;
              LPLD_FTM2_MOD = mod;
              if((mod=bus_clk_hz/(freq*2)) < 0xFFFFu)
              {
                ps = 1;
                LPLD_FTM2_MOD = mod;
                if((mod=bus_clk_hz/(freq*1)) < 0xFFFFu)
                {
                  ps = 0;
                  LPLD_FTM2_MOD = mod;
                }
              }
            }
          }
        }  
      }
    }
  }
  else
  {
    return 0;
  }
  
  // 使能FTM时钟模块
  SIM_SCGC3 |= SIM_SCGC3_FTM2_MASK;
  
  // 配置FTM控制寄存器
  // 禁用中断, 加计数模式, 时钟源:System clock（Bus Clk）, 分频系数:8
  // 假设SysClk = 50MHz, SC_PS=3, FTM Clk = 50MHz/2^3 = 6.25MHz
  FTM2_SC = FTM_SC_CLKS(1)|FTM_SC_PS(ps);
  
  // 设置PWM周期及占空比
  //    PWM周期 = (MOD-CNTIN+1)*FTM时钟周期 :
  // 配置FTM计数初始值
  FTM2_CNT = 0;
  FTM2_CNTIN = 0;
  // 配置FTM计数MOD值
  FTM2_MOD = LPLD_FTM2_MOD;
  
  return 1;
}

/*
 * LPLD_FTM2_PWM_Open
 * FTM2模块PWM输出通道及占空比配置
 *  
 * 说明: 其他GPIO也可配置为FTM2输出,本函数只考虑PTA,如需改变请自行修改 
 * 
 * 参数:
 *    channel - PWM输出通道
 *      |__0--PTA10
 *      |__1--PTA11
 *    duty - PWM输出占空比
 *      |__0~10000--占空比0.00%~100.00%
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM2_PWM_Open(uint8 channel, uint32 duty)
{
  uint32 cv;
  volatile uint32 mod;
  
  if(duty>10000) return 0;
  //占空比 = (CnV-CNTIN)/(MOD-CNTIN+1)
  mod = LPLD_FTM2_MOD;
  cv = (duty*(mod-0+1)+0)/10000;
  
  //选择并开启通道
  switch(channel)
  {
    case 0:
    case 1:
      SIM_SCGC5 |= SIM_SCGC5_PORTA_MASK;
      PORT_PCR_REG(PORTA_BASE_PTR, channel+10) = PORT_PCR_MUX(3);
      break;
    default:
       return 0;
  }  
  
  // 配置FTM通道控制寄存器 
  // 通道模式 MSB:MSA-1X, 通道边缘选择 ELSB:ELSA-10
  FTM_CnSC_REG(FTM2_BASE_PTR, channel) = FTM_CnSC_MSB_MASK|FTM_CnSC_ELSB_MASK;
  // 配置FTM通道值
  FTM_CnV_REG(FTM2_BASE_PTR, channel) = cv;
  
  return 1;
}

/*
 * LPLD_FTM2_PWM_ChangeDuty
 * 改变FTM2模块PWM输出通道占空比
 *
 * 参数:
 *    channel - PWM输出通道
 *      |__0--PTA8
 *      |__1--PTA9
 *    duty - PWM输出占空比
 *      |__0~10000--占空比0.00%~100.00%
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM2_PWM_ChangeDuty(uint8 channel, uint32 duty)
{
  uint32 cv;
  volatile uint32 mod;
  
  if(duty>10000) return 0;
  //占空比 = (CnV-CNTIN)/(MOD-CNTIN+1)
  mod = LPLD_FTM2_MOD;
  cv = (duty*(mod-0+1)+0)/10000;
 
  // 配置FTM通道值
  FTM_CnV_REG(FTM2_BASE_PTR, channel) = cv;
  
  return 1;
}


/*
 * LPLD_FTM0_InputCapture_Init
 * FTM0模块输入捕获功能初始化
 *
 * 参数:
 *    channel - 输入捕获通道
 *      |__0--PTC1
 *      |__1--PTC2
 *      |__2--PTC3
 *      |__3--PTC4
 *      |__4--PTD4
 *      |__5--PTD5
 *      |__6--PTD6
 *      |__7--PTD7
 *    edge - 边缘选择
 *      |__1--上升沿
 *      |__2--下降沿
 *      |__3--上升和下降沿
 *    ps - 计数器时钟分频，值越小，计数器时钟频率越高
 *      |__0--1分频
 *      |__1--2分频
 *      |__2--4分频
 *      |__3--8分频
 *      |__4--16分频
 *      |__5--32分频
 *      |__6--64分频
 *      |__7--128分频
 *    isr_func--用户中断程序入口地址，输入中断或计数器溢出中断
 *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM0_InputCapture_Init(uint8 channel, uint8 edge, uint8 ps, FTM_ISR_CALLBACK isr_func)
{
 
  // 使能FTM时钟模块
  SIM_SCGC6 |= SIM_SCGC6_FTM0_MASK;
  
  FTM0_CONF=FTM_CONF_BDMMODE(0x3);

  if(ps==7)
  {
    LPLD_FTM0_Divider = 128;
  }
  else if(ps==6)
  {
    LPLD_FTM0_Divider = 64;
  }
  else if(ps==5)
  {
    LPLD_FTM0_Divider = 32;
  }
  else if(ps==4)
  {
    LPLD_FTM0_Divider = 16;
  }
  else if(ps==3)
  {
    LPLD_FTM0_Divider = 8;
  }
  else if(ps==2)
  {
    LPLD_FTM0_Divider = 4;
  }
  else if(ps==1)
  {
    LPLD_FTM0_Divider = 2;
  }
  else if(ps==0)
  {
    LPLD_FTM0_Divider = 1;
  }
  else
  {
    return 0;
  }
  
  //选择并开启通道
  switch(channel)
  {
    case 0:
    case 1:
    case 2:
    case 3:
      PORT_PCR_REG(PORTC_BASE_PTR, channel+1) = PORT_PCR_MUX(4);
      break;
    case 4:
    case 5:
    case 6:
    case 7:
      PORT_PCR_REG(PORTD_BASE_PTR, channel) = PORT_PCR_MUX(4);
      break;
    default:
       return 0;
  }   

  FTM0_MODE &=(~FTM_MODE_FTMEN_MASK);       //使能FTM全功能
  
  // 配置FTM控制寄存器
  // 将FTM Counter配置成Free Counter
  // 禁用中断, 加计数模式, 时钟源:System clock（Bus Clk）, 分频系数:PS
  // 假设SysClk = 50MHz, SC_PS=3, FTM Clk = 50MHz/2^3 = 6.25MHz
  FTM0_SC |= FTM_SC_CLKS(1)|FTM_SC_PS(ps);
  FTM0_SC |= FTM_SC_TOIE_MASK;             //使能计数溢出中断
  FTM0_SC &= (~FTM_SC_CPWMS_MASK);         //FTM加计数
  
  FTM0_CNT = 0;
  FTM0_CNTIN = 0;
  FTM0_MOD = 0;                           
  FTM0_QDCTRL = (~FTM_QDCTRL_QUADEN_MASK); //关闭正交解码
  FTM0_FILTER = 0x00;                      //关过虑器
 
  FTM_CnSC_REG(FTM0_BASE_PTR, channel) = 0x00;
  FTM_CnSC_REG(FTM0_BASE_PTR, channel) &= (~FTM_CnSC_CHF_MASK);
  FTM_CnSC_REG(FTM0_BASE_PTR, channel) |= FTM_CnSC_CHIE_MASK;         //使能通道捕获输入中断
  FTM_CnSC_REG(FTM0_BASE_PTR, channel) &= (~FTM_CnSC_MSB_MASK);
  FTM_CnSC_REG(FTM0_BASE_PTR, channel) &= (~FTM_CnSC_MSA_MASK);       //配置成Input capture模式
  if(edge==1)       //上升沿捕获
  {
    FTM_CnSC_REG(FTM0_BASE_PTR, channel) &= (~FTM_CnSC_ELSB_MASK);  
    FTM_CnSC_REG(FTM0_BASE_PTR, channel) |= FTM_CnSC_ELSA_MASK;         
  }
  else if(edge==2)  //下降沿捕获
  {
    FTM_CnSC_REG(FTM0_BASE_PTR, channel) |= FTM_CnSC_ELSB_MASK;  
    FTM_CnSC_REG(FTM0_BASE_PTR, channel) &= (~FTM_CnSC_ELSA_MASK);         
  }
  else if(edge==3)  //上升或下降沿捕获
  {
    FTM_CnSC_REG(FTM0_BASE_PTR, channel) |= FTM_CnSC_ELSB_MASK;
    FTM_CnSC_REG(FTM0_BASE_PTR, channel) |= FTM_CnSC_ELSA_MASK;         
  }
  else
  {
    return 0;
  }
  FTM_CnSC_REG(FTM0_BASE_PTR, channel) &= (~FTM_CnSC_DMA_MASK);       //关闭DMA
  
  //设置中断函数入口地址并开启中断
  if(isr_func!=NULL)
  {
    FTM_ISR[0] = isr_func;
    enable_irq(62);
  }

  return 1;
}


/*
 * LPLD_FTM1_InputCapture_Init
 * FTM1模块输入捕获功能初始化
 *
 * 参数:
 *    channel - 输入捕获通道
 *      |__0--PTA8
 *      |__1--PTA9
 *    edge - 边缘选择
 *      |__1--上升沿
 *      |__2--下降沿
 *      |__3--上升和下降沿
 *    ps - 计数器时钟分频，值越小，计数器时钟频率越高
 *      |__0--1分频
 *      |__1--2分频
 *      |__2--4分频
 *      |__3--8分频
 *      |__4--16分频
 *      |__5--32分频
 *      |__6--64分频
 *      |__7--128分频
 *    isr_func--用户中断程序入口地址，输入中断或计数器溢出中断
 *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM1_InputCapture_Init(uint8 channel, uint8 edge, uint8 ps, FTM_ISR_CALLBACK isr_func)
{
 
  // 使能FTM时钟模块
  SIM_SCGC6 |= SIM_SCGC6_FTM1_MASK;
  
  FTM1_CONF=FTM_CONF_BDMMODE(0x3);

  if(ps==7)
  {
    LPLD_FTM1_Divider = 128;
  }
  else if(ps==6)
  {
    LPLD_FTM1_Divider = 64;
  }
  else if(ps==5)
  {
    LPLD_FTM1_Divider = 32;
  }
  else if(ps==4)
  {
    LPLD_FTM1_Divider = 16;
  }
  else if(ps==3)
  {
    LPLD_FTM1_Divider = 8;
  }
  else if(ps==2)
  {
    LPLD_FTM1_Divider = 4;
  }
  else if(ps==1)
  {
    LPLD_FTM1_Divider = 2;
  }
  else if(ps==0)
  {
    LPLD_FTM1_Divider = 1;
  }
  else
  {
    return 0;
  }
  
  //选择并开启通道
  switch(channel)
  {
    case 0:
    case 1:
      PORT_PCR_REG(PORTA_BASE_PTR, channel+8) = PORT_PCR_MUX(3);
      break;
    default:
       return 0;
  }  

  FTM1_MODE &=(~FTM_MODE_FTMEN_MASK);       //使能FTM全功能
  
  // 配置FTM控制寄存器
  // 将FTM Counter配置成Free Counter
  // 禁用中断, 加计数模式, 时钟源:System clock（Bus Clk）, 分频系数:PS
  // 假设SysClk = 50MHz, SC_PS=3, FTM Clk = 50MHz/2^3 = 6.25MHz
  FTM1_SC |= FTM_SC_CLKS(1)|FTM_SC_PS(ps);
  FTM1_SC |= FTM_SC_TOIE_MASK;             //使能计数溢出中断
  FTM1_SC &= (~FTM_SC_CPWMS_MASK);         //FTM加计数
  
  FTM1_CNT = 0;
  FTM1_CNTIN = 0;
  FTM1_MOD = 0;                           
  FTM1_QDCTRL = (~FTM_QDCTRL_QUADEN_MASK); //关闭正交解码
  FTM1_FILTER = 0x00;                      //关过虑器
 
  FTM_CnSC_REG(FTM1_BASE_PTR, channel) = 0x00;
  FTM_CnSC_REG(FTM1_BASE_PTR, channel) &= (~FTM_CnSC_CHF_MASK);
  FTM_CnSC_REG(FTM1_BASE_PTR, channel) |= FTM_CnSC_CHIE_MASK;         //使能通道捕获输入中断
  FTM_CnSC_REG(FTM1_BASE_PTR, channel) &= (~FTM_CnSC_MSB_MASK);
  FTM_CnSC_REG(FTM1_BASE_PTR, channel) &= (~FTM_CnSC_MSA_MASK);       //配置成Input capture模式
  if(edge==1)       //上升沿捕获
  {
    FTM_CnSC_REG(FTM1_BASE_PTR, channel) &= (~FTM_CnSC_ELSB_MASK);  
    FTM_CnSC_REG(FTM1_BASE_PTR, channel) |= FTM_CnSC_ELSA_MASK;         
  }
  else if(edge==2)  //下降沿捕获
  {
    FTM_CnSC_REG(FTM1_BASE_PTR, channel) |= FTM_CnSC_ELSB_MASK;  
    FTM_CnSC_REG(FTM1_BASE_PTR, channel) &= (~FTM_CnSC_ELSA_MASK);         
  }
  else if(edge==3)  //上升或下降沿捕获
  {
    FTM_CnSC_REG(FTM1_BASE_PTR, channel) |= FTM_CnSC_ELSB_MASK;
    FTM_CnSC_REG(FTM1_BASE_PTR, channel) |= FTM_CnSC_ELSA_MASK;         
  }
  else
  {
    return 0;
  }
  FTM_CnSC_REG(FTM1_BASE_PTR, channel) &= (~FTM_CnSC_DMA_MASK);       //关闭DMA
  
  //设置中断函数入口地址并开启中断
  if(isr_func!=NULL)
  {
    FTM_ISR[1] = isr_func;
    enable_irq(63);
  }

  return 1;
}



/*
 * LPLD_FTM2_InputCapture_Init
 * FTM1模块输入捕获功能初始化
 *
 * 参数:
 *    channel - 输入捕获通道
 *      |__0--PTA10
 *      |__1--PTA11
 *    edge - 边缘选择
 *      |__1--上升沿
 *      |__2--下降沿
 *      |__3--上升和下降沿
 *    ps - 计数器时钟分频，值越小，计数器时钟频率越高
 *      |__0--1分频
 *      |__1--2分频
 *      |__2--4分频
 *      |__3--8分频
 *      |__4--16分频
 *      |__5--32分频
 *      |__6--64分频
 *      |__7--128分频
 *    isr_func--用户中断程序入口地址，输入中断或计数器溢出中断
 *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_FTM2_InputCapture_Init(uint8 channel, uint8 edge, uint8 ps, FTM_ISR_CALLBACK isr_func)
{
 
  // 使能FTM时钟模块
  SIM_SCGC3 |= SIM_SCGC3_FTM2_MASK;
  
  FTM2_CONF=FTM_CONF_BDMMODE(0x3);

  if(ps==7)
  {
    LPLD_FTM2_Divider = 128;
  }
  else if(ps==6)
  {
    LPLD_FTM2_Divider = 64;
  }
  else if(ps==5)
  {
    LPLD_FTM2_Divider = 32;
  }
  else if(ps==4)
  {
    LPLD_FTM2_Divider = 16;
  }
  else if(ps==3)
  {
    LPLD_FTM2_Divider = 8;
  }
  else if(ps==2)
  {
    LPLD_FTM2_Divider = 4;
  }
  else if(ps==1)
  {
    LPLD_FTM2_Divider = 2;
  }
  else if(ps==0)
  {
    LPLD_FTM2_Divider = 1;
  }
  else
  {
    return 0;
  }
  
  //选择并开启通道
  switch(channel)
  {
    case 0:
    case 1:
      PORT_PCR_REG(PORTA_BASE_PTR, channel+10) = PORT_PCR_MUX(3);
      break;
    default:
       return 0;
  }  

  FTM2_MODE &=(~FTM_MODE_FTMEN_MASK);       //使能FTM全功能
  
  // 配置FTM控制寄存器
  // 将FTM Counter配置成Free Counter
  // 禁用中断, 加计数模式, 时钟源:System clock（Bus Clk）, 分频系数:PS
  // 假设SysClk = 50MHz, SC_PS=3, FTM Clk = 50MHz/2^3 = 6.25MHz
  FTM2_SC |= FTM_SC_CLKS(1)|FTM_SC_PS(ps);
  FTM2_SC |= FTM_SC_TOIE_MASK;             //使能计数溢出中断
  FTM2_SC &= (~FTM_SC_CPWMS_MASK);         //FTM加计数
  
  FTM2_CNT = 0;
  FTM2_CNTIN = 0;
  FTM2_MOD = 0;                           
  FTM2_QDCTRL = (~FTM_QDCTRL_QUADEN_MASK); //关闭正交解码
  FTM2_FILTER = 0x00;                      //关过虑器
 
  FTM_CnSC_REG(FTM2_BASE_PTR, channel) = 0x00;
  FTM_CnSC_REG(FTM2_BASE_PTR, channel) &= (~FTM_CnSC_CHF_MASK);
  FTM_CnSC_REG(FTM2_BASE_PTR, channel) |= FTM_CnSC_CHIE_MASK;         //使能通道捕获输入中断
  FTM_CnSC_REG(FTM2_BASE_PTR, channel) &= (~FTM_CnSC_MSB_MASK);
  FTM_CnSC_REG(FTM2_BASE_PTR, channel) &= (~FTM_CnSC_MSA_MASK);       //配置成Input capture模式
  if(edge==1)       //上升沿捕获
  {
    FTM_CnSC_REG(FTM2_BASE_PTR, channel) &= (~FTM_CnSC_ELSB_MASK);  
    FTM_CnSC_REG(FTM2_BASE_PTR, channel) |= FTM_CnSC_ELSA_MASK;         
  }
  else if(edge==2)  //下降沿捕获
  {
    FTM_CnSC_REG(FTM2_BASE_PTR, channel) |= FTM_CnSC_ELSB_MASK;  
    FTM_CnSC_REG(FTM2_BASE_PTR, channel) &= (~FTM_CnSC_ELSA_MASK);         
  }
  else if(edge==3)  //上升或下降沿捕获
  {
    FTM_CnSC_REG(FTM2_BASE_PTR, channel) |= FTM_CnSC_ELSB_MASK;
    FTM_CnSC_REG(FTM2_BASE_PTR, channel) |= FTM_CnSC_ELSA_MASK;         
  }
  else
  {
    return 0;
  }
  FTM_CnSC_REG(FTM2_BASE_PTR, channel) &= (~FTM_CnSC_DMA_MASK);       //关闭DMA
  
  //设置中断函数入口地址并开启中断
  if(isr_func!=NULL)
  {
    FTM_ISR[2] = isr_func;
    enable_irq(64);
  }

  return 1;
}


/*
 * LPLD_FTM_Isr
 * FTM通用中断底层入口函数
 * 
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void LPLD_FTM_Isr(void)
{
  #define FTM_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
  uint8 ftm_ch = FTM_VECTORNUM - 78;
    
  //调用用户自定义中断服务
  FTM_ISR[ftm_ch]();  

}