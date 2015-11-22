/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_MCG.h
 * 用途: MCG底层模块相关函数
 * 最后修改日期: 20120216
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 *
 * 说明:本页代码基于Freescale官方示例代码修改，源代码文件为 mcg.c
 */
#include "common.h"
#include "HAL_MCG.h"

/*
 * LPLD_PLL_Setup
 * PLL初始化内核及其他系统时钟
 * 
 * 参数:
 *    clk_option--期望内核时钟频率
 *      |__PLLx--参见HAL_MCG.h中的PLL_option定义
 *
 * 输出:
 *    内核频率，单位MHz
 */
unsigned char LPLD_PLL_Setup(unsigned char pll_option)
{
  unsigned char pll_freq;
  unsigned char prdiv;
  
  if(pll_option<111)
  {
    prdiv = 24;  
  }
  else if(pll_option<201)
  {
    prdiv = 12; 
  }
  else if(pll_option<221)
  {
    prdiv = 11; 
  }
  else
  {
    return 0;
  }
  
  // 这里假设复位后 MCG 模块默认为 FEI 模式
  
  // 首先移动到 FBE 模式
  MCG_C2 = 0;
  
  // 振荡器初始化完成后,释放锁存状态下的 oscillator 和 GPIO 
  SIM_SCGC4 |= SIM_SCGC4_LLWU_MASK;
  LLWU_CS |= LLWU_CS_ACKISO_MASK;
  
  // 选择外部 oscilator 、参考分频器 and 清零 IREFS 启动外部osc
  // CLKS=2, FRDIV=3, IREFS=0, IRCLKEN=0, IREFSTEN=0
  MCG_C1 = MCG_C1_CLKS(2) | MCG_C1_FRDIV(3);  
  
  //while (!(MCG_S & MCG_S_OSCINIT_MASK)){};  // 等待 oscillator 初始化
  
  while (MCG_S & MCG_S_IREFST_MASK){}; // 等待参考时钟清零
  
  while (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) != 0x2){}; // 等待时钟状态显示为外部参考时钟(ext ref clk)
  
  // 进入FBE模式
  // 配置 PLL 参考分频器, PLLCLKEN=0, PLLSTEN=0, PRDIV=5
  // 用晶振频率来选择 PRDIV 值. 仅在有频率晶振的时候支持
  // 产生 2MHz 的参考时钟给 PLL.
  MCG_C5 = MCG_C5_PRDIV(prdiv); // 设置 PLL 匹配晶振的参考分频数 
  
  // 确保MCG_C6处于复位状态,禁止LOLIE、PLL、和时钟控制器,清PLL VCO分频器
  MCG_C6 = 0x0;
  // 选择PLL VCO分频器,系统时钟分频器取决于时钟选项
  
  switch (pll_option) {
    case 60:
      // 设置系统选项分频
      // MCG=PLL, core = MCG, bus = MCG/2, FlexBus = MCG/2, Flash clock= MCG/3
      LPLD_Set_SYS_DIV(0,1,1,2);  //core=60M, bus=30M, FlexBus=30M, Flash Clk=20M
      // 设置 VCO 分频并使能 50MHz PLL, LOLIE=0, PLLS=1, CME=0, VDIV=1
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(6); //VDIV = 6 (2x30) 60MHz
      pll_freq = 60;
      break;
    case 70:
      LPLD_Set_SYS_DIV(0,1,1,2);  //core=70M, bus=35M, FlexBus=35M, Flash Clk=23.3M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(11); //VDIV = 11 (2x35) 70MHz
      pll_freq = 70;
      break;
    case 80:
      LPLD_Set_SYS_DIV(0,1,1,3);  //core=80M, bus=40M, FlexBus=40M, Flash Clk=20M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(16); //VDIV = 16 (2x40) 80MHz
      pll_freq = 80;
      break;
    case 90:
      LPLD_Set_SYS_DIV(0,1,1,3);  //core=90M, bus=45M, FlexBus=45M, Flash Clk=22.5M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(21); //VDIV = 21 (2x45) 90MHz
      pll_freq = 90;
      break;
    case 96:
      LPLD_Set_SYS_DIV(0,1,1,3);  //core=96M, bus=48M, FlexBus=48M, Flash Clk=22.5M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(24); //VDIV = 24 (2x48) 96MHz
      pll_freq = 96;
      break;
    case 100:
      LPLD_Set_SYS_DIV(0,1,1,3);  //core=100M, bus=50M, FlexBus=50M, Flash Clk=25M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(26); //VDIV = 26 (2x50) 100MHz
      pll_freq = 100;
      break;
    case 110:
      LPLD_Set_SYS_DIV(0,2,2,4);  //core=110M, bus=36.7M, FlexBus=36.7M, Flash Clk=22M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(31); //VDIV = 31 (2x55) 110MHz
      pll_freq = 110;
      break;
    case 120:
      LPLD_Set_SYS_DIV(0,2,2,4);  //core=120M, bus=40M, FlexBus=40M, Flash Clk=24M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(7); //VDIV = 7 (3.846x31) 119.2MHz
      pll_freq = 120;
      break;
    case 130:
      LPLD_Set_SYS_DIV(0,2,2,5);  //core=130M, bus=43M, FlexBus=43M, Flash Clk=21.6M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(10); //VDIV = 10 (3.846x34) 130.8MHz
      pll_freq = 130;
      break;
    case 150:
      LPLD_Set_SYS_DIV(0,2,2,5);  //core=150M, bus=50M, FlexBus=50M, Flash Clk=25M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(15); //VDIV = 15 (3.846x39) 150MHz
      pll_freq = 150;
      break;
    case 170:
      LPLD_Set_SYS_DIV(0,3,3,6);  //core=170M, bus=42.5M, FlexBus=42.5M, Flash Clk=24.3M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(20); //VDIV = 20 (3.846x44) 169.2MHz
      pll_freq = 170;
      break;
    case 180:
      LPLD_Set_SYS_DIV(0,3,3,7);  //core=180M, bus=45M, FlexBus=45M, Flash Clk=22.5M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(23); //VDIV = 23 (3.846x47) 180.8MHz
      pll_freq = 180;
      break;
    case 200:
      LPLD_Set_SYS_DIV(0,3,3,7);  //core=200M, bus=50M, FlexBus=50M, Flash Clk=25M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(28); //VDIV = 28 (3.846x52) 200MHz
      pll_freq = 200;
      break;
    case 209:
      LPLD_Set_SYS_DIV(0,4,4,8);  //core=209M, bus=42M, FlexBus=42M, Flash Clk=23.2M
      MCG_C6 = MCG_C6_PLLS_MASK | MCG_C6_VDIV(26); //VDIV = 26 (4.17x50) 208.5MHz
      pll_freq = 209;
    break;
  }
  
  while (!(MCG_S & MCG_S_PLLST_MASK)){}; // wait for PLL status bit to set
  
  while (!(MCG_S & MCG_S_LOCK_MASK)){}; // Wait for LOCK bit to set
  
  // 已经进入PBE模式
  
  // Transition into PEE by setting CLKS to 0
  // CLKS=0, FRDIV=3, IREFS=0, IRCLKEN=0, IREFSTEN=0
  MCG_C1 &= ~MCG_C1_CLKS_MASK;
  
  // Wait for clock status bits to update
  while (((MCG_S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) != 0x3){};
  
  // 已经进入PEE模式
  
  return pll_freq;
} 


/*
 * LPLD_Set_SYS_DIV
 * 设置系统始终分频(FSCL官方代码)
 *
 * 说明:
 * 这段代码必须放置在RAM中. It is a workaround for errata e2448.
 * 当Flash时钟分频改变的时候，Flash预读取必须禁用.
 * 当正在从Flash执行的时候这里不能执行.
 * 在预读取被重新使能之前必须在时钟分频改变后有一段小的延时.
 *
 * 参数:
 *    outdiv1~outdiv4--分别为core, bus, FlexBus, Flash时钟分频系数
 */
#if (defined(IAR))
	__ramfunc void LPLD_Set_SYS_DIV(uint32 outdiv1, uint32 outdiv2, uint32 outdiv3, uint32 outdiv4)
#elif (defined(CW))
__relocate_code__ 
void LPLD_Set_SYS_DIV(uint32 outdiv1, uint32 outdiv2, uint32 outdiv3, uint32 outdiv4)
#endif
{
  uint32 temp_reg;
  uint8 i;
  
  temp_reg = FMC_PFAPR; // 备份 FMC_PFAPR 寄存器
  
  // 设置 M0PFD 到 M7PFD 为 1 禁用预先读取
  FMC_PFAPR |= FMC_PFAPR_M7PFD_MASK | FMC_PFAPR_M6PFD_MASK | FMC_PFAPR_M5PFD_MASK
             | FMC_PFAPR_M4PFD_MASK | FMC_PFAPR_M3PFD_MASK | FMC_PFAPR_M2PFD_MASK
             | FMC_PFAPR_M1PFD_MASK | FMC_PFAPR_M0PFD_MASK;
  
  // 设置时钟分频为期望值  
  SIM_CLKDIV1 = SIM_CLKDIV1_OUTDIV1(outdiv1) | SIM_CLKDIV1_OUTDIV2(outdiv2) 
              | SIM_CLKDIV1_OUTDIV3(outdiv3) | SIM_CLKDIV1_OUTDIV4(outdiv4);

  // 延时一小段时间等待改变
  for (i = 0 ; i < outdiv4 ; i++)
  {}
  
  FMC_PFAPR = temp_reg; // 回复原先的 FMC_PFAPR 寄存器值
  
  return;
} // set_sys_dividers
