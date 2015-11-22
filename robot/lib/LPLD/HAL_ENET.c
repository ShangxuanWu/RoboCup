/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_ENET.c
 * 用途: ENET底层模块相关函数
 * 最后修改日期: 20120920
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
/*
 *******需用到ENET中断，请在isr.h中粘贴一下代码:*********

//ENET模块中断服务定义
#undef  VECTOR_092
#define VECTOR_092 LPLD_ENET_TXF_Isr
#undef  VECTOR_093
#define VECTOR_093 LPLD_ENET_RXF_Isr
//以下函数在LPLD_Kinetis底层包，不必修改
extern void LPLD_ENET_TXF_Isr(void);
extern void LPLD_ENET_RXF_Isr(void);

 ***********************代码结束*************************
*/
#include "common.h"
#include "HAL_ENET.h"

//引用外部变量
extern int periph_clk_khz;;

//用户自定义中断服务函数数组
ENET_ISR_CALLBACK ENET_ISR[4]={NULL, NULL, NULL, NULL};

//内部函数声明
static void LPLD_ENET_BDInit( void );
static void LPLD_ENET_Delay(uint32 time);


/*******************************************************************
 *
 *                ENET模块函数
 *
*******************************************************************/

/*
 * LPLD_ENET_Init
 * ENET模块初始化，包括PHY收发器初始化，MAC初始化，BD初始化
 * 
 * 参数:
 *    *MACAddress--MAC地址指针
 *
 * 输出:
 *    无
 */
void LPLD_ENET_Init(const uint8* MACAddress)
{
 
  uint16 usData;
 
  //使能ENET时钟
  SIM_SCGC2 |= SIM_SCGC2_ENET_MASK;

  //允许并发访问MPU控制器
  MPU_CESR = 0;         
        
  //缓冲区描述符初始化
  LPLD_ENET_BDInit();
  
  //复位ENET
  ENET_ECR = ENET_ECR_RESET_MASK;

  //等待至少8个时钟周期
  for( usData = 0; usData < 10; usData++ )
  {
    asm( "NOP" );
  }
    
  //初始化MII接口
  LPLD_ENET_MiiInit(periph_clk_khz/1000/*MHz*/);       
        
  //使能中断并设置优先级
  set_irq_priority (76, 6);
  enable_irq(76);           //ENET发送中断
  set_irq_priority (77, 6);
  enable_irq(77);           //ENET接收中断
  //set_irq_priority (78, 6);
  //enable_irq(78);           //ENET错误及其他中断

  //使能GPIO引脚复用功能
  PORTB_PCR0  = PORT_PCR_MUX(4);  //GPIO;//RMII0_MDIO/MII0_MDIO
  PORTB_PCR1  = PORT_PCR_MUX(4);  //GPIO;//RMII0_MDC/MII0_MDC    
  PORTA_PCR14 = PORT_PCR_MUX(4);  //RMII0_CRS_DV/MII0_RXDV
  PORTA_PCR12 = PORT_PCR_MUX(4);  //RMII0_RXD1/MII0_RXD1
  PORTA_PCR13 = PORT_PCR_MUX(4);  //RMII0_RXD0/MII0_RXD0
  PORTA_PCR15 = PORT_PCR_MUX(4);  //RMII0_TXEN/MII0_TXEN
  PORTA_PCR16 = PORT_PCR_MUX(4);  //RMII0_TXD0/MII0_TXD0
  PORTA_PCR17 = PORT_PCR_MUX(4);  //RMII0_TXD1/MII0_TXD1
  
    
  //等待PHY收发器复位完成
  do
  {
    LPLD_ENET_Delay( ENET_LINK_DELAY );
    usData = 0xffff;
    LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_PHYIDR1, &usData );
        
  } while( usData == 0xffff );

#ifdef PHY_PRINT_REG
  printf("PHY_PHYIDR1=0x%X\r\n",usData);
  LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_PHYIDR2, &usData );
  printf("PHY_PHYIDR2=0x%X\r\n",usData); 
  LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_ANLPAR, &usData );
  printf("PHY_ANLPAR=0x%X\r\n",usData);
  LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_ANLPARNP, &usData );
  printf("PHY_ANLPARNP=0x%X\r\n",usData);
  LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_PHYSTS, &usData );
  printf("PHY_PHYSTS=0x%X\r\n",usData);
  LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_MICR, &usData );
  printf("PHY_MICR=0x%X\r\n",usData);
  LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_MISR, &usData );
  printf("PHY_MISR=0x%X\r\n",usData);
#endif 
  
  //开始自动协商
  LPLD_ENET_MiiWrite(CFG_PHY_ADDRESS, PHY_BMCR, ( PHY_BMCR_AN_RESTART | PHY_BMCR_AN_ENABLE ) );

#ifdef PHY_PRINT_REG
  LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_BMCR, &usData );
  printf("PHY_BMCR=0x%X\r\n",usData);
#endif 
  
  //等待自动协商完成
  do
  {
    LPLD_ENET_Delay( ENET_LINK_DELAY );
    LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_BMSR, &usData );

  } while( !( usData & PHY_BMSR_AN_COMPLETE ) );

#ifdef PHY_PRINT_REG
    printf("PHY_BMSR=0x%X\r\n",usData);
#endif 
    
  //根据协商结果设置ENET模块
  LPLD_ENET_MiiRead(CFG_PHY_ADDRESS, PHY_STATUS, &usData );  

#ifdef PHY_PRINT_REG
  printf("PHY_STATUS=0x%X\r\n",usData);
#endif 
  
  //清除单独和组地址哈希寄存器
  ENET_IALR = 0;
  ENET_IAUR = 0;
  ENET_GALR = 0;
  ENET_GAUR = 0;
  
  //设置ENET模块MAC地址
  LPLD_ENET_SetAddress(MACAddress);
    
  //设置接收控制寄存器，最大长度、RMII模式、接收CRC校验等
  ENET_RCR = ENET_RCR_MAX_FL(CFG_ENET_MAX_PACKET_SIZE) | ENET_RCR_MII_MODE_MASK | ENET_RCR_CRCFWD_MASK | ENET_RCR_RMII_MODE_MASK;

  //清除发送接收控制
  ENET_TCR = 0;
        
  //通讯方式设置
  if( usData & PHY_DUPLEX_STATUS )
  {
    //全双工
    ENET_RCR &= (unsigned long)~ENET_RCR_DRT_MASK;
    ENET_TCR |= ENET_TCR_FDEN_MASK;
  }
  else
  {
    //半双工
    ENET_RCR |= ENET_RCR_DRT_MASK;
    ENET_TCR &= (unsigned long)~ENET_TCR_FDEN_MASK;
  }
  
  //通信速率设置
  if( usData & PHY_SPEED_STATUS )
  {
    //10Mbps
    ENET_RCR |= ENET_RCR_RMII_10T_MASK;
  }

  //使用非增强型缓冲区描述符
  ENET_ECR = 0;
  
  
  //设置接收缓冲区长度
  ENET_MRBR = (unsigned short) CFG_ENET_RX_BUFFER_SIZE;

  //指向环形接收缓冲区描述符序列的头地址
  ENET_RDSR = ( unsigned long ) &( xENETRxDescriptors[ 0 ] );

  //指向环形发送缓冲区描述符序列的头地址
  ENET_TDSR = ( unsigned long ) xENETTxDescriptors;

  //清除ENET中断事件
  ENET_EIR = ( unsigned long ) -1;

  //使能中断
  ENET_EIMR = 0 
            | ENET_EIMR_RXF_MASK  //接收中断
            | ENET_EIMR_TXF_MASK  //发送中断
            //ENET中断
            | ENET_EIMR_UN_MASK | ENET_EIMR_RL_MASK | ENET_EIMR_LC_MASK | ENET_EIMR_BABT_MASK | ENET_EIMR_BABR_MASK | ENET_EIMR_EBERR_MASK
            | ENET_EIMR_RXB_MASK
            ;

  //使能ENET模块
  ENET_ECR |= ENET_ECR_ETHEREN_MASK;

  //表明接收缓冲区为空
  ENET_RDAR = ENET_RDAR_RDAR_MASK;
}


/*
 * LPLD_ENET_SetIsr
 * ENET模块中断函数设置
 * 
 * 参数:
 *    type--中断类型
 *      |__ENET_RXF_ISR   -接收中断
 *      |__ENET_TXF_ISR   -发送中断
 *    isr_func--用户中断程序入口地址
 *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 *
 */
uint8 LPLD_ENET_SetIsr(uint8 type, ENET_ISR_CALLBACK isr_func)
{
  if(type>4)
    return 0;
  
  ENET_ISR[type] = isr_func;
  return 1;
}


/*
 * LPLD_ENET_RXF_Isr
 * ENET接收中断底层入口函数
 * 
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void LPLD_ENET_RXF_Isr(void)
{   
  ENET_EIR |= ENET_EIMR_RXF_MASK; 
    
  //调用用户自定义中断服务
  if(ENET_ISR[ENET_RXF_ISR])
  {
    ENET_ISR[ENET_RXF_ISR]();  
  }
}


/*
 * LPLD_ENET_TXF_Isr
 * ENET发送中断底层入口函数
 * 
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void LPLD_ENET_TXF_Isr(void)
{  
  ENET_EIR |= ENET_EIMR_TXF_MASK; 
    
  //调用用户自定义中断服务
  if(ENET_ISR[ENET_TXF_ISR])
  {
    ENET_ISR[ENET_TXF_ISR]();  
  }
}

/*
 * LPLD_ENET_Delay
 * ENET模块内部延时函数
 * 
 * 参数:
 *    time--延迟大小
 *
 * 输出:
 *    无
 */
static void LPLD_ENET_Delay(uint32 time)
{
  uint32 i = 0,j = 0;
  
  for(i = 0;i < time;i++)
  {
    for(j = 0;j < 50000;j++);
  }
}


/*
 * LPLD_ENET_BDInit
 * 缓冲区描述符初始化
 * 
 * 参数:
 *    无
 *
 * 输出:
 *    无
 */
static void LPLD_ENET_BDInit( void )
{
  unsigned long ux;
  uint8 *pcBufPointer;
  
  //寻找<发送描述符数组空间>中的16字节对齐的地址，即低四位为0的起始地址
  pcBufPointer = &( xENETTxDescriptors_unaligned[ 0 ] );
  while( ( ( unsigned long ) pcBufPointer & 0x0fUL ) != 0 )
  {
    pcBufPointer++;
  }
  xENETTxDescriptors = ( NBUF * ) pcBufPointer;
  
  //寻找<接收描述符数组空间>中的16字节对齐的地址
  pcBufPointer = &( xENETRxDescriptors_unaligned[ 0 ] );
  while( ( ( unsigned long ) pcBufPointer & 0x0fUL ) != 0 )
  {
    pcBufPointer++;
  }
  xENETRxDescriptors = ( NBUF * ) pcBufPointer;
  
  //发送缓冲区描述符初始化
  for( ux = 0; ux < CFG_NUM_ENET_TX_BUFFERS; ux++ )
  {
    xENETTxDescriptors[ ux ].status = 0;
    xENETTxDescriptors[ ux ].data = 0;
    xENETTxDescriptors[ ux ].length = 0;
  }
  
  //寻找<接收缓冲区空间>中的16字节对齐的地址
  pcBufPointer = &( ucENETRxBuffers[ 0 ] );
  while( ( ( unsigned long ) pcBufPointer & 0x0fUL ) != 0 )
  {
    pcBufPointer++;
  }
  
  //接收缓冲区描述符初始化
  for( ux = 0; ux < CFG_NUM_ENET_RX_BUFFERS; ux++ )
  {
    xENETRxDescriptors[ ux ].status = RX_BD_E;
    xENETRxDescriptors[ ux ].length = 0;
    xENETRxDescriptors[ ux ].data = (uint8 *)__REV((uint32)pcBufPointer);
    pcBufPointer += CFG_ENET_RX_BUFFER_SIZE;
  
  }
  
  //设置缓冲区描述符环形序列中的最后一个状态位为Wrap
  xENETTxDescriptors[ CFG_NUM_ENET_TX_BUFFERS - 1 ].status |= TX_BD_W;
  xENETRxDescriptors[ CFG_NUM_ENET_RX_BUFFERS - 1 ].status |= RX_BD_W;
  
  uxNextRxBuffer = 0;
  uxNextTxBuffer = 0;
}

/*
 * LPLD_ENET_MacSend
 * 以太帧发送函数
 * 
 * 参数:
 *    *ch--数据帧头地址，该数据帧为以太帧，必须包含目的地址、源地址、类型等。
 *    len--数据帧长度。
 *
 * 输出:
 *    无
 */
void LPLD_ENET_MacSend(uint8 *ch, uint16 len)
{
  
  //检查当前发送缓冲区描述符是否可用
  while( xENETTxDescriptors[ uxNextTxBuffer ].status & TX_BD_R);
  
  //设置发送缓冲区描述符
  xENETTxDescriptors[ uxNextTxBuffer ].data = (uint8 *)__REV((uint32)ch);
  xENETTxDescriptors[ uxNextTxBuffer ].length = __REVSH(len);
  xENETTxDescriptors[ uxNextTxBuffer ].status = ( TX_BD_R | TX_BD_L | TX_BD_TC | TX_BD_W );
  
  uxNextTxBuffer++;
  if( uxNextTxBuffer >= CFG_NUM_ENET_TX_BUFFERS )
  {
    uxNextTxBuffer = 0;
  }
  
  //使能发送
  ENET_TDAR = ENET_TDAR_TDAR_MASK;
  
}


/*
 * LPLD_ENET_MacRecv
 * 以太帧接收函数
 * 
 * 参数:
 *    *ch--接收数据帧头地址。
 *    *len--数据帧长度地址。
 *
 * 输出:
 *    无
 */
uint8 LPLD_ENET_MacRecv(uint8 *ch, uint16 *len)
{
  uint8 *prvRxd;
  *len = 0;
  uxNextRxBuffer = 0; 
  
  //寻找为非空的接收缓冲区描述符 
  while( (xENETRxDescriptors[ uxNextRxBuffer ].status & RX_BD_E)!=0 )
  {
    uxNextRxBuffer++; 
    if( uxNextRxBuffer >= CFG_NUM_ENET_RX_BUFFERS )
    {
      uxNextRxBuffer = 0; 
      return 1;
    } 
    
  }
  
  //读取接收缓冲区描述符
  *len  =  __REVSH(xENETRxDescriptors[ uxNextRxBuffer ].length);
  prvRxd =  (uint8 *)__REV((uint32)xENETRxDescriptors[ uxNextRxBuffer ].data);      
  memcpy((void *)ch, (void *)prvRxd, *len);      
  
  //清除接收缓冲区描述符状态标志Empty
  xENETRxDescriptors[ uxNextRxBuffer ].status |= RX_BD_E;
  ENET_RDAR = ENET_RDAR_RDAR_MASK;	
  return 0;
}


/*
 * LPLD_ENET_HashAddress
 * 生成给定的MAC地址的哈希表
 * 
 * 参数:
 *    *addr--6字节地址指针。
 *
 * 输出:
 *    32位CRC校验的高6位
 */
uint8 LPLD_ENET_HashAddress(const uint8* addr)
{
  uint32 crc;
  uint8 byte;
  int i, j;
  
  crc = 0xFFFFFFFF;
  for(i=0; i<6; ++i)
  {
    byte = addr[i];
    for(j=0; j<8; ++j)
    {
      if((byte & 0x01)^(crc & 0x01))
      {
        crc >>= 1;
        crc = crc ^ 0xEDB88320;
      }
      else
        crc >>= 1;
      byte >>= 1;
    }
  }
  return (uint8)(crc >> 26);
}


/*
 * LPLD_ENET_SetAddress
 * 设置MAC物理地址
 * 
 * 参数:
 *    *pa--6字节的物理地址指针。
 *
 * 输出:
 *    无
 */
void LPLD_ENET_SetAddress(const uint8 *pa)
{
  uint8 crc;
  
  //设置物理地址
  ENET_PALR = (uint32)((pa[0]<<24) | (pa[1]<<16) | (pa[2]<<8) | pa[3]);
  ENET_PAUR = (uint32)((pa[4]<<24) | (pa[5]<<16));
  
  //根据物理地址计算并设置独立地址哈希寄存器的值
  crc = LPLD_ENET_HashAddress(pa);
  if(crc >= 32)
    ENET_IAUR |= (uint32)(1 << (crc - 32));
  else
    ENET_IALR |= (uint32)(1 << crc);
}



/*******************************************************************
 *
 *                PHY设备MII接口函数
 *
*******************************************************************/

/*
 * LPLD_ENET_MiiInit
 * 设置ENET模块的MII接口时钟，期望频率为2.5MHz
 * MII_SPEED = 系统时钟 / (2.5MHz * 2)
 * 
 * 参数:
 *    sys_clk_mhz--系统主频
 *
 * 输出:
 *    无
 */
void LPLD_ENET_MiiInit(int sys_clk_mhz)
{
  ENET_MSCR = 0 | ENET_MSCR_MII_SPEED((2*sys_clk_mhz/5)+1);
}


/*
 * LPLD_ENET_MiiWrite
 * MII接口写
 * 
 * 参数:
 *    phy_addr--物理收发器地址
 *    reg_addr--寄存器地址
 *    data--写入的数据
 *
 * 输出:
 *    1--写超时
 *    0--写入成功
 */
uint8 LPLD_ENET_MiiWrite(uint16 phy_addr, uint16 reg_addr, uint16 data)
{
  uint32 timeout;
  
  //清除MII中断事件
  ENET_EIR = ENET_EIR_MII_MASK;
  
  //初始化MII管理帧寄存器
  ENET_MMFR = 0
            | ENET_MMFR_ST(0x01)
            | ENET_MMFR_OP(0x01)
            | ENET_MMFR_PA(phy_addr)
            | ENET_MMFR_RA(reg_addr)
            | ENET_MMFR_TA(0x02)
            | ENET_MMFR_DATA(data);
  
  //等待MII传输完成中断事件
  for (timeout = 0; timeout < MII_TIMEOUT; timeout++)
  {
    if (ENET_EIR & ENET_EIR_MII_MASK)
      break;
  }
  
  if(timeout == MII_TIMEOUT) 
    return 1;
  
  //清除MII中断事件
  ENET_EIR = ENET_EIR_MII_MASK;
  
  return 0;
}


/*
 * LPLD_ENET_MiiRead
 * MII接口读
 * 
 * 参数:
 *    phy_addr--物理收发器地址
 *    reg_addr--寄存器地址
 *    *data--读出的数据地址指针
 *
 * 输出:
 *    1--读超时
 *    0--读取成功
 */
uint8 LPLD_ENET_MiiRead(uint16 phy_addr, uint16 reg_addr, uint16 *data)
{
  uint32 timeout;
  
  //清除MII中断事件
  ENET_EIR = ENET_EIR_MII_MASK;
  
  //初始化MII管理帧寄存器
  ENET_MMFR = 0
            | ENET_MMFR_ST(0x01)
            | ENET_MMFR_OP(0x2)
            | ENET_MMFR_PA(phy_addr)
            | ENET_MMFR_RA(reg_addr)
            | ENET_MMFR_TA(0x02);
  
  //等待MII传输完成中断事件
  for (timeout = 0; timeout < MII_TIMEOUT; timeout++)
  {
    if (ENET_EIR & ENET_EIR_MII_MASK)
      break;
  }
  
  if(timeout == MII_TIMEOUT) 
    return 1;
  
  //清除MII中断事件
  ENET_EIR = ENET_EIR_MII_MASK;
  
  *data = ENET_MMFR & 0x0000FFFF;
  
  return 0;
}
