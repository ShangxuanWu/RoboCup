/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_I2C.c
 * 用途: I2C底层模块相关函数
 * 最后修改日期: 20120402
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */

#include "common.h"
#include "HAL_I2C.h"



//I2C映射地址数组
volatile I2C_MemMapPtr I2Cx_Ptr[2] = {I2C0_BASE_PTR, 
                                      I2C1_BASE_PTR};

/*
 * LPLD_I2C_Init
 * I2C通用初始化函数
 * 
 * 参数:
 *    i2cx--选择I2C模块号
 *      |__I2C0           --I2C0号模块
 *      |__I2C1           --I2C1号模块
 *    port--通道端口位选择
 *      |__0              --I2C0(PTB2-I2C0_SCL PTB3-I2C0_SDA)
 *      |                 --I2C1(PTE0-I2C1_SDA PTE1-I2C1_SCL)
 *      |__1              --I2C0(PTD8-I2C0_SCL PTD9-I2C0_SDA)
 *      |                 --I2C1(PTC10-I2C1_SCL PTC11-I2C1_SDA)
 *    scl_frq--选择IIC SCL频率
 *      |__I2C_SCL_50KHZ  --50khz
 *      |__I2C_SCL_100KHZ --100khz
 *      |__I2C_SCL_150KHZ --150khz
 *      |__I2C_SCL_200KHZ --200khz
 *      |__I2C_SCL_250KHZ --250khz
 *      |__I2C_SCL_300KHZ --300khz
 * 输出:
 *    0--配置错误
 *    1--配置成功
 */
uint8 LPLD_I2C_Init(I2Cx i2cx, uint8 port, uint8 scl_frq)
{
  uint8 ps; 
  
  //参数检查
  ASSERT( i2cx <= I2C1);                            //判断I2Cx模块号
  ASSERT( scl_frq <= I2C_SCL_300KHZ);               //判断SCL频率
  ASSERT( port <= 1);                               //判断端口选择
  
  //总线频率50mhz
  //scl_frq=50mhz/(mul * scl div)
  if(scl_frq == I2C_SCL_50KHZ)
  {
    ps=0x33;
  }
  else if(scl_frq == I2C_SCL_100KHZ)
  {
    ps=0x2B;
  }
  else if(scl_frq == I2C_SCL_150KHZ)
  {
    ps=0x28;
  }
  else if(scl_frq == I2C_SCL_200KHZ)
  {
    ps=0x23;
  }
  else if(scl_frq == I2C_SCL_250KHZ)
  {
    ps=0x21;
  }
  else if(scl_frq == I2C_SCL_300KHZ)
  {
    ps=0x20;
  }
  else
    return 0;

  if(i2cx==I2C0)
  {
    if(!port)
    {
      /* configure GPIO for I2C0 function */
      PORTB_PCR2 = PORT_PCR_MUX(2);
      PORTB_PCR3 = PORT_PCR_MUX(2);   
    }
    else if(port==1)
    {
      /* configure GPIO for I2C0 function */
      PORTD_PCR8 = PORT_PCR_MUX(2);
      PORTD_PCR9 = PORT_PCR_MUX(2);   
    }
    else
      return 0;
    
    SIM_SCGC4 |= SIM_SCGC4_I2C0_MASK; //开启I2C0时钟
  }
  else if(i2cx==I2C1)
  {
    if(!port)
    {
      /* configure GPIO for I2C0 function */
      PORTE_PCR0 = PORT_PCR_MUX(6);
      PORTE_PCR1 = PORT_PCR_MUX(6);   
    }
    else if(port==1)
    {
      /* configure GPIO for I2C0 function */
      PORTC_PCR10 = PORT_PCR_MUX(2);
      PORTC_PCR11 = PORT_PCR_MUX(2);   
    }
    else
      return 0;
    
    SIM_SCGC4 |= SIM_SCGC4_I2C1_MASK; //开启IIC1时钟
  }
  else
    return 0;
  
  I2C_F_REG(I2Cx_Ptr[i2cx]) = ps;
  I2C_C1_REG(I2Cx_Ptr[i2cx]) = I2C_C1_IICEN_MASK;      //使能I2Cx
  
  return 1;
}


/*
 * LPLD_I2C_Start
 * I2C开始信号产生
 * 
 * 参数:
 *    i2cx--选择I2C模块号
 *      |__I2C0           --I2C0号模块
 *      |__I2C1           --I2C1号模块
 */
void LPLD_I2C_Start(I2Cx i2cx)
{
  I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
  I2C_C1_REG(i2cptr) |= I2C_C1_TX_MASK ;
  I2C_C1_REG(i2cptr) |= I2C_C1_MST_MASK ;
}


/*
 * LPLD_ReStart
 * I2C再次产生开始信号
 * 
 * 参数:
 *    i2cx--选择I2C模块号
 *      |__I2C0           --I2C0号模块
 *      |__I2C1           --I2C1号模块
*/
void LPLD_I2C_ReStart(I2Cx i2cx)
{
  I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
  I2C_C1_REG(i2cptr) |= I2C_C1_RSTA_MASK ;
}


/*
 * LPLD_I2C_Stop
 * I2C停止信号产生
 * 
 * 参数:
 *    i2cx--选择I2C模块号
 *      |__I2C0           --I2C0号模块
 *      |__I2C1           --I2C1号模块
 */
void LPLD_I2C_Stop(I2Cx i2cx)
{
  I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
  I2C_C1_REG(i2cptr) &=(~I2C_C1_MST_MASK);
  I2C_C1_REG(i2cptr) &=(~I2C_C1_TX_MASK); 
}


/*
 * LPLD_I2C_WaitAck
 * I2C设置等待应答信号，开启则等待，关闭则不等待
 * 
 * 参数:
 *    i2cx--选择I2C模块号
 *      |__I2C0           --I2C0号模块
 *      |__I2C1           --I2C1号模块
 *    is_wait--选择是否等待应答
 *      |__I2C_ACK_OFF    --关闭等待Ack
 *      |__I2C_ACK_ON     --开启等待Ack，并等待ACK信号
 */
void LPLD_I2C_WaitAck(I2Cx i2cx, uint8 is_wait)
{
  I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
  uint16 time_out;
  if(is_wait == I2C_ACK_ON)
  {
    while(!(I2C_S_REG(I2Cx_Ptr[i2cx]) & I2C_S_IICIF_MASK))
    {
      if(time_out>60000) //如果等待超时，强行退出
        break;
      else time_out++;
    }
    I2C_S_REG(i2cptr) |= I2C_S_IICIF_MASK;
  }
  else
  {
    //关闭I2C的ACK
    I2C_C1_REG(i2cptr) |= I2C_C1_TXAK_MASK; 
  }
}


/*
 * LPLD_I2C_Write
 * I2C发送一个字节数据给目的地址设备
 * 
 * 参数:
 *    i2cx--选择I2C模块号
 *      |__I2C0           --I2C0号模块
 *      |__I2C1           --I2C1号模块
 *    data8--要发送的字节数据
 *
 */
void LPLD_I2C_Write(I2Cx i2cx, uint8 data8)
{
  I2C_D_REG(I2Cx_Ptr[i2cx]) = data8; 
}


/*
 * LPLD_I2C_Read
 * I2C从外部设备读一个字节数据
 * 
 * 参数:
 *    i2cx--选择I2C模块号
 *      |__I2C0           --I2C0号模块
 *      |__I2C1           --I2C1号模块
 * 返回值:
 *    I2C读取的数据 
 */

uint8 LPLD_I2C_Read(I2Cx i2cx)
{
  uint8 temp;
  temp = I2C_D_REG(I2Cx_Ptr[i2cx]); 
  return temp;
}

/*
 * LPLD_I2C_SetMasterWR
 * I2C主机读写模式配置
 * 
 * 参数:
 *    IICx--选择I2C模块的通道
 *      |__0 I2C0
 *      |__1 I2C1
 *    mode--读写模式选择
 *      |__I2C_MWSR         --主机写
 *      |__I2C_MRSW         --主机读
 */

void LPLD_I2C_SetMasterWR(I2Cx i2cx, uint8 mode)
{
  I2C_MemMapPtr i2cptr = I2Cx_Ptr[i2cx];
  if(mode==I2C_MRSW) 
    I2C_C1_REG(i2cptr) &= (~I2C_C1_TX_MASK);
  else
    I2C_C1_REG(i2cptr) |= ( I2C_C1_TX_MASK);
}

/*
 * LPLD_IIC_StartTrans
 * I2C开始传输函数，需要设置外围设备地址和读写模式
 * 
 * 参数:
 *    IICx--选择I2C模块的通道
 *      |__0 I2C0
 *      |__1 I2C1
 *    addr--外围设备地址     
 *    mode--读写模式选择
 *      |__I2C_MWSR         --主机写
 *      |__I2C_MRSW         --主机读
 */
void LPLD_I2C_StartTrans(I2Cx i2cx, uint8 addr, uint8 mode)
{
  //I2C产生start信号
  LPLD_I2C_Start(i2cx);
  //将从机地址和主机读写位合成一个字节写入
  LPLD_I2C_Write(i2cx, (addr<<1)|mode );
}




