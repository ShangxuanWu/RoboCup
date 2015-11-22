/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_eDAM.c
 * 用途: eDMA底层模块相关函数
 * 最后修改日期: 20120321
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
*/

#ifndef __HAL_EDMA_H__
#define __HAL_EDMA_H__
//=====================================
//      DMA request sources Number
//      外设的DMA请求号
//=====================================
#define UART0_REV_DMAREQ  2
#define UART0_TRAN_DMAREQ 3
#define UART1_REV_DMAREQ  4
#define UART1_TRAN_DMAREQ 5
#define UART2_REV_DMAREQ  6
#define UART2_TRAN_DMAREQ 7
#define UART3_REV_DMAREQ  8
#define UART3_TRAN_DMAREQ 9
#define UART4_REV_DMAREQ  10
#define UART4_TRAN_DMAREQ 11
#define UART5_REV_DMAREQ  12
#define UART5_TRAN_DMAREQ 13
#define I2S0_REV_DMAREQ   14
#define I2S0_TRAN_DMAREQ  15
#define SPI0_REV_DMAREQ   16
#define SPI0_TRAN_DMAREQ  17
#define SPI1_REV_DMAREQ   18
#define SPI1_TRAN_DMAREQ  19
#define I2C0_DMAREQ       22
#define I2C1_DMAREQ       23
#define FTM0_CH0_DMAREQ   24
#define FTM0_CH1_DMAREQ   25
#define FTM0_CH2_DMAREQ   26
#define FTM0_CH3_DMAREQ   27
#define FTM0_CH4_DMAREQ   28
#define FTM0_CH5_DMAREQ   29
#define FTM0_CH6_DMAREQ   30
#define FTM0_CH7_DMAREQ   31
#define FTM1_CH0_DMAREQ   32
#define FTM1_CH1_DMAREQ   33
#define FTM2_CH0_DMAREQ   34
#define FTM2_CH1_DMAREQ   35
#define FTM3_CH0_DMAREQ   36
#define FTM3_CH1_DMAREQ   37
#define FTM3_CH2_DMAREQ   38
#define FTM1_CH3_DMAREQ   39  
#define ADC0_DMAREQ       40
#define ADC1_DMAREQ       41
#define CMP0_DMAREQ       42
#define CMP1_DMAREQ       43
#define CMP2_DMAREQ       44
#define DAC0_DMAREQ       45
#define DAC1_DMAREQ       46
#define CMT_DMAREQ        47
#define PDB_DMAREQ        48
#define PORTA_DMAREQ      49
#define PORTB_DMAREQ      50
#define PORTC_DMAREQ      51
#define PORTD_DMAREQ      52
#define PORTE_DMAREQ      53
#define FTM3_CH4_DMAREQ   54
#define FTM3_CH5_DMAREQ   55
#define FTM3_CH6_DMAREQ   56
#define FTM3_CH7_DMAREQ   57
  
//===========================================
//      DMA 传输的数据长度
//      源地址数据长度分为：  8bit、16bit、32bit
//      目的地址数据长度分为：8bit、16bit、32bit
//===========================================
#define DMA_SRC_8BIT   DMA_ATTR_SSIZE(0)
#define DMA_SRC_16BIT  DMA_ATTR_SSIZE(1)
#define DMA_SRC_32BIT  DMA_ATTR_SSIZE(2)

#define DMA_DST_8BIT   DMA_ATTR_DSIZE(0)
#define DMA_DST_16BIT  DMA_ATTR_DSIZE(1)
#define DMA_DST_32BIT  DMA_ATTR_DSIZE(2)
//==========================================
//      执行完一次DMA操作以后，地址是否偏移
//      =1 地址加一
//      =0 地址不累加
//==========================================
#define ADDR_INCREASE  1
#define ADDR_HOLD      0

//==========================================
//      定义DMA通道号
//==========================================
#define  DMA_CH0 0
#define  DMA_CH1 1
#define  DMA_CH2 2
#define  DMA_CH3 3
#define  DMA_CH4 4
#define  DMA_CH5 5
#define  DMA_CH6 6
#define  DMA_CH7 7
#define  DMA_CH8 8
#define  DMA_CH9 9
#define  DMA_CH10 10
#define  DMA_CH11 11
#define  DMA_CH12 12
#define  DMA_CH13 13
#define  DMA_CH14 14
#define  DMA_CH15 15


typedef void (*DMA_ISR_CALLBACK)(void);


typedef struct 
{
    uint8  Channelx;           //通道编号
    uint8  Peri_DmaReq;        //外设的DMA请求号
    uint16 Minor_loop_Length;  //设置数据长度 
    uint32 Trans_bytesNum;     //每一次DMA请求后，传输的字节个数
    
    uint32 Source_Addr ;    //源地址
    uint8  Source_Size ;    //源数据的宽度 即每一次传输数据的宽度 8bit、16bit、32bit三种数据宽度
    uint8  Source_Addr_inc; //在执行完一个地址之后，地址是否累加 1：累加 0:不累加
    uint32 Source_Adj_Addr; //当主的计数次数（major iteration count）达到后，是否重新更改源地址
    
    uint32 Dest_Addr ;      //目的地址
    uint8  Dest_Size ;      //目的地址的宽度 即每一次传输数据的宽度 8bit、16bit、32bit三种数据宽度
    uint8  Dest_Addr_inc;   //在执行完一个地址之后，地址是否累加 1：累加 0:不累加
    uint32 Dest_Adj_Addr;   //当主的计数次数（major iteration count）达到后，是否重新更改目的地址
    
    uint8  Dma_irqc;        //Dma中断选择  
                              //00 关闭中断  
                              //01 主循环计数器计数减到一半，产生中断
                              //02 主循环计数器计数减到零时，产生中断
       
    uint8  Dma_AutoClose;    //当主循环计数器减少到零的时候，是否关闭DMA
                               //00 开启自动关闭
                               //01 关闭自动关闭
    DMA_ISR_CALLBACK isr_func;  //定义回调函数
      
}LPLD_eDMA_Cfg_t;



uint8 LPLD_DMA_Init(LPLD_eDMA_Cfg_t*);
void LPLD_DMA_EnableReq(uint8, uint8);
void LPLD_DMA_Reload(uint8, uint32, uint32, uint16);
void LPLD_DMA_Isr(void);

#endif