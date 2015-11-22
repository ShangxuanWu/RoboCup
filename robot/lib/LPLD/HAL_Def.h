/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_Def.h
 * 用途: LPLD Kinetis驱动库通用定义配置
 * 最后修改日期: 20121112
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#ifndef __HAL_DEF_H__
#define __HAL_DEF_H__

//底层库版本定义
#define OSKinetis_Version     2.2

/*
 * GPIO模块
 *
 */
typedef enum PTx
{
  PTA,
  PTB,
  PTC,
  PTD,
  PTE
}PTx;

typedef enum PTAn
{
  PTA0,
  PTA1,
  PTA2,
  PTA3,
  PTA4,
  PTA5,
  PTA6,
  PTA7,
  
  PTA8,
  PTA9,
  PTA10,
  PTA11,
  PTA12,
  PTA13,
  PTA14,
  PTA15,
  
  PTA16,
  PTA17,
  PTA18,
  PTA19,
  PTA20,
  PTA21,
  PTA22,
  PTA23,
  
  PTA24,
  PTA25,
  PTA26,
  PTA27,
  PTA28,
  PTA29,
  PTA30,
  PTA31
}PTAn;

typedef enum PTBn
{
  PTB0,
  PTB1,
  PTB2,
  PTB3,
  PTB4,
  PTB5,
  PTB6,
  PTB7,
  
  PTB8,
  PTB9,
  PTB10,
  PTB11,
  PTB12,
  PTB13,
  PTB14,
  PTB15,
  
  PTB16,
  PTB17,
  PTB18,
  PTB19,
  PTB20,
  PTB21,
  PTB22,
  PTB23,
  
  PTB24,
  PTB25,
  PTB26,
  PTB27,
  PTB28,
  PTB29,
  PTB30,
  PTB31
}PTBn;

typedef enum PTCn
{
  PTC0,
  PTC1,
  PTC2,
  PTC3,
  PTC4,
  PTC5,
  PTC6,
  PTC7,
  
  PTC8,
  PTC9,
  PTC10,
  PTC11,
  PTC12,
  PTC13,
  PTC14,
  PTC15,
  
  PTC16,
  PTC17,
  PTC18,
  PTC19,
  PTC20,
  PTC21,
  PTC22,
  PTC23,
  
  PTC24,
  PTC25,
  PTC26,
  PTC27,
  PTC28,
  PTC29,
  PTC30,
  PTC31
}PTCn;

typedef enum PTDn
{
  PTD0,
  PTD1,
  PTD2,
  PTD3,
  PTD4,
  PTD5,
  PTD6,
  PTD7,
  
  PTD8,
  PTD9,
  PTD10,
  PTD11,
  PTD12,
  PTD13,
  PTD14,
  PTD15,
  
  PTD16,
  PTD17,
  PTD18,
  PTD19,
  PTD20,
  PTD21,
  PTD22,
  PTD23,
  
  PTD24,
  PTD25,
  PTD26,
  PTD27,
  PTD28,
  PTD29,
  PTD30,
  PTD31
}PTDn;

typedef enum PTEn
{
  PTE0,
  PTE1,
  PTE2,
  PTE3,
  PTE4,
  PTE5,
  PTE6,
  PTE7,
  
  PTE8,
  PTE9,
  PTE10,
  PTE11,
  PTE12,
  PTE13,
  PTE14,
  PTE15,
  
  PTE16,
  PTE17,
  PTE18,
  PTE19,
  PTE20,
  PTE21,
  PTE22,
  PTE23,
  
  PTE24,
  PTE25,
  PTE26,
  PTE27,
  PTE28,
  PTE29,
  PTE30,
  PTE31
}PTEn;



/*
 * ADC模块
 *
 */
typedef enum ADCx
{
  ADC0,
  ADC1
}ADCx;



/*
 * DAC模块
 *
 */
typedef enum DACx
{
  DAC0,
  DAC1
}DACx;


/*
 * PIT模块
 *
 */
typedef enum PITx
{
  PIT0,
  PIT1,
  PIT2,
  PIT3
}PITx;


/*
 * FTM模块
 *
 */
typedef enum FTMx
{
  FTM0,
  FTM1,
  FTM2
}FTMx;


/*
 * UART模块
 *
 */
typedef enum UARTx
{
  UART0,
  UART1,
  UART2,
  UART3,
  UART4,
  UART5
}UARTx;


/*
 * CAN模块
 *
 */
typedef enum CANx
{
  CAN0,
  CAN1
}CANx;


/*
 * I2C模块
 *
 */
typedef enum I2Cx
{
  I2C0,
  I2C1
}I2Cx;


/*
 * SPI模块
 *
 */
typedef enum SPIx
{
  SPI0,
  SPI1,
  SPI2
}SPIx;


#endif /* __HAL_DEF_H__ */