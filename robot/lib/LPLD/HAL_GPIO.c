/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_GPIO.c
 * 用途: GPIO底层模块相关函数
 * 最后修改日期: 20120321
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
/*
 *******需用到GPIO中断，请在isr.h中粘贴一下代码:*********

//GPIO模块中断服务定义
#undef  VECTOR_103
#define VECTOR_103 LPLD_GPIO_Isr
#undef  VECTOR_104
#define VECTOR_104 LPLD_GPIO_Isr
#undef  VECTOR_105
#define VECTOR_105 LPLD_GPIO_Isr
#undef  VECTOR_106
#define VECTOR_106 LPLD_GPIO_Isr
#undef  VECTOR_107
#define VECTOR_107 LPLD_GPIO_Isr
//以下函数在LPLD_Kinetis底层包，不必修改
extern void LPLD_GPIO_Isr(void);

 ***********************代码结束*************************
*/

#include "common.h"
#include "HAL_GPIO.h"


//用户自定义中断服务函数数组
GPIO_ISR_CALLBACK GPIO_ISR[5];
//GPIO映射地址数组
volatile GPIO_MemMapPtr GPIOx_Ptr[5] = {PTA_BASE_PTR, 
                                        PTB_BASE_PTR, 
                                        PTC_BASE_PTR, 
                                        PTD_BASE_PTR, 
                                        PTE_BASE_PTR};
//PORT映射地址数组
volatile PORT_MemMapPtr PORTx_Ptr[5] = {PORTA_BASE_PTR, 
                                        PORTB_BASE_PTR, 
                                        PORTC_BASE_PTR, 
                                        PORTD_BASE_PTR, 
                                        PORTE_BASE_PTR};

/*
 * LPLD_GPIO_Init
 * GPIO通用初始化函数
 * 
 * 参数:
 *    ptx--端口号
 *      |__PTA        --Port A
 *      |__PTB        --Port B
 *      |__PTC        --Port C
 *      |__PTD        --Port D
 *      |__PTE        --Port E
 *    port_bit--端口位数
 *      |__0~31
 *    dir--端口数据方向
 *      |__DIR_INPUT  --输入
 *      |__DIR_OUTPUT --输出
 *    data1--输出初始电平/输入上拉或下拉
 *      |__INPUT_PDOWN--如果dir=DIR_INPUT,输入内部下拉
 *      |__INPUT_PUP  --如果dir=DIR_INPUT,输入内部上拉
 *      |__OUTPUT_L   --如果dir=DIR_OUTPUT,输出低电平
 *      |__OUTPUT_H   --如果dir=DIR_OUTPUT,输出高电平
 *    irqc--输入中断
 *      |__IRQC_DIS   --不使能中断
 *      |__IRQC_DMARI --上升沿触发DMA
 *      |__IRQC_DMAFA --下降沿触发DMA
 *      |__IRQC_DMAET --上升/下降沿触发DMA
 *      |__IRQC_L     --逻辑低触发中断
 *      |__IRQC_RI    --上升沿触发中断
 *      |__IRQC_FA    --下降沿触发中断
 *      |__IRQC_ET    --上升/下降沿触发中断
 *      |__IRQC_H     --逻辑高触发中断
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_GPIO_Init(PTx ptx, uint8 port_bit, uint8 dir, uint8 data1, uint8 irqc)
{
  GPIO_MemMapPtr gpio_ptr = GPIOx_Ptr[ptx];
  PORT_MemMapPtr port_ptr = PORTx_Ptr[ptx];
  
  //参数检查
  ASSERT( ptx <= PTE);                  //判断端口
  ASSERT( port_bit <= 31 );             //判断端口位数
  ASSERT( dir <= 1 );                   //判断方向
  ASSERT( data1 <= 1 );                 //判断输出初始电平/输入上拉或下拉
  ASSERT( irqc <= IRQC_H);              //判断端中断配置

  //配置为GPIO功能
  PORT_PCR_REG(port_ptr, port_bit) = PORT_PCR_MUX(1);
  
  //输入或输出设置
  if(dir==DIR_OUTPUT)
  {
    GPIO_PDDR_REG(gpio_ptr) |= 0x1u<<port_bit;
    //设置初始输出
    if(data1==OUTPUT_H)
    {
      GPIO_PSOR_REG(gpio_ptr) = 0x1u<<port_bit; 
    }
    else
    {
      GPIO_PCOR_REG(gpio_ptr) = 0x1u<<port_bit;  
    }
  }
  else
  { 
    GPIO_PDDR_REG(gpio_ptr) &= ~(0x1u<<port_bit);
    PORT_PCR_REG(port_ptr, port_bit) |= PORT_PCR_IRQC(irqc); 
    //配置内部上拉或下拉或不使能
    if(data1==INPUT_PUP)
    {
      //上拉
      PORT_PCR_REG(port_ptr, port_bit) |= PORT_PCR_PE_MASK | PORT_PCR_PS_MASK ; 
    }
    else if(data1==INPUT_PDOWN)
    {
      //下拉
      PORT_PCR_REG(port_ptr, port_bit) |= PORT_PCR_PE_MASK ; 
    }
    else
    {
      //不使能上下拉
      PORT_PCR_REG(port_ptr, port_bit) &= ~PORT_PCR_PE_MASK ; 
    }
 
  }
  
  return 1;
}

/*
 * LPLD_GPIO_SetIsr
 * 设置GPIO通道用户定义的中断服务函数，并使能中断
 * 
 * 参数:
 *    ptx--端口号
 *      |__PTA        --Port A
 *      |__PTB        --Port B
 *      |__PTC        --Port C
 *      |__PTD        --Port D
 *      |__PTE        --Port E
 *    isr_func--用户中断程序入口地址
 *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 *
 */
uint8 LPLD_GPIO_SetIsr(PTx ptx, GPIO_ISR_CALLBACK isr_func)
{
  GPIO_ISR[ptx] = isr_func;
  enable_irq(ptx + 87);
  
  return 1;
}

/*
 * LPLD_GPIO_ClearIsr
 * 清除GPIO通道用户定义的中断服务函数，并禁用中断
 * 
 * 参数:
 *    ptx--端口号
 *      |__PTA        --Port A
 *      |__PTB        --Port B
 *      |__PTC        --Port C
 *      |__PTD        --Port D
 *      |__PTE        --Port E
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 *
 */
uint8 LPLD_GPIO_ClearIsr(PTx ptx)
{
  disable_irq(ptx + 87);
  GPIO_ISR[ptx] = NULL;
  
  return 1;
}

/*
 * LPLD_GPIO_Set
 * 设置GPIO端口0~31位输出
 * 
 * 参数:
 *    ptx--端口号
 *      |__PTA        --Port A
 *      |__PTB        --Port B
 *      |__PTC        --Port C
 *      |__PTD        --Port D
 *      |__PTE        --Port E
 *    data32--输出数据
 *      |__0x00000000~0xFFFFFFFF--低到高代表GPIO口的第0~31位数据
 *
 * 输出:
 *
 */
void LPLD_GPIO_Set(PTx ptx, uint32 data32)
{ 
  GPIO_PDOR_REG(GPIOx_Ptr[ptx]) = data32;
}

/*
 * LPLD_GPIO_Set_b
 * 设置GPIO端口一位的输出
 * 
 * 参数:
 *    ptx--端口号
 *      |__PTA        --Port A
 *      |__PTB        --Port B
 *      |__PTC        --Port C
 *      |__PTD        --Port D
 *      |__PTE        --Port E
 *    port_bit--位数
 *      |__0~31       --GPIO口的第0~31位
 *    data1--输出数据
 *      |__OUTPUT_L   --输出低电平
 *      |__OUTPUT_H   --输出高电平
 *
 * 输出:
 *
 */
void LPLD_GPIO_Set_b(PTx ptx, uint8 port_bit, uint8 data1)
{
  if(data1==OUTPUT_L)
    GPIO_PCOR_REG(GPIOx_Ptr[ptx]) = 0x1u<<port_bit;
  else
    GPIO_PSOR_REG(GPIOx_Ptr[ptx]) = 0x1u<<port_bit;
}

/*
 * LPLD_GPIO_Toggle
 * 设置GPIO端口0~31的电平翻转
 * 
 * 参数:
 *    ptx--端口号
 *      |__PTA        --Port A
 *      |__PTB        --Port B
 *      |__PTC        --Port C
 *      |__PTD        --Port D
 *      |__PTE        --Port E
 *    data32--翻转数据
 *      |__0x00000000~0xFFFFFFFF--低到高代表GPIO口的第0~31位的翻转，1为反转，0为保持不变。
 *
 * 输出:
 *
 */
void LPLD_GPIO_Toggle(PTx ptx, uint32 data32)
{
  GPIO_PTOR_REG(GPIOx_Ptr[ptx]) = data32;
}

/*
 * LPLD_GPIO_Toggle_b
 * 设置GPIO端口一位的翻转
 * 
 * 参数:
 *    ptx--端口号
 *      |__PTA        --Port A
 *      |__PTB        --Port B
 *      |__PTC        --Port C
 *      |__PTD        --Port D
 *      |__PTE        --Port E
 *    port_bit--位数
 *      |__0~31       --设置GPIO口的一位翻转
 *
 * 输出:
 *
 */
void LPLD_GPIO_Toggle_b(PTx ptx, uint8 port_bit)
{
  GPIO_PTOR_REG(GPIOx_Ptr[ptx]) = 0x1u<<port_bit;
}

/*
 * LPLD_GPIO_Get
 * 取得GPIO口的数据
 * 
 * 参数:
 *    ptx--端口号
 *      |__PTA        --Port A
 *      |__PTB        --Port B
 *      |__PTC        --Port C
 *      |__PTD        --Port D
 *      |__PTE        --Port E
 *
 * 输出:
 *    指定GPIO口的32位输入
 *
 */
uint32 LPLD_GPIO_Get(PTx ptx)
{
  return GPIO_PDIR_REG(GPIOx_Ptr[ptx]);
}

/*
 * LPLD_GPIO_Get_b
 * 取得GPIO口某一位的数据
 * 
 * 参数:
 *    ptx--端口号
 *      |__PTA        --Port A
 *      |__PTB        --Port B
 *      |__PTC        --Port C
 *      |__PTD        --Port D
 *      |__PTE        --Port E
 *    port_bit--位数
 *      |__0~31--GPIO口的第0~31位
 *
 * 输出:
 *    指定GPIO口的指定位数的电平
 *
 */
uint8 LPLD_GPIO_Get_b(PTx ptx, uint8 port_bit)
{
  return (GPIO_PDIR_REG(GPIOx_Ptr[ptx])>>port_bit)&0x1u;
}

/*
 * LPLD_GPIO_Isr
 * GPIO通用中断底层入口函数
 * 
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void LPLD_GPIO_Isr(void)
{
  #define GPIO_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
  uint8 gpio_port = GPIO_VECTORNUM - 103;
    
  //调用用户自定义中断服务
  GPIO_ISR[gpio_port]();  
  
  //清除中断标志位
  PORT_ISFR_REG((PORT_MemMapPtr)((0x40049+gpio_port)<<12))=0xFFFFFFFF;
}