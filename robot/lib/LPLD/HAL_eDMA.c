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
/*
 *******需用到DMA中断，请在isr.h中粘贴一下代码:*********

//DMA模块中断服务定义
#undef  VECTOR_016
#define VECTOR_016 LPLD_DMA_Isr
#undef  VECTOR_017
#define VECTOR_017 LPLD_DMA_Isr
#undef  VECTOR_018
#define VECTOR_018 LPLD_DMA_Isr
#undef  VECTOR_019
#define VECTOR_019 LPLD_DMA_Isr
#undef  VECTOR_020
#define VECTOR_020 LPLD_DMA_Isr
#undef  VECTOR_021
#define VECTOR_021 LPLD_DMA_Isr
#undef  VECTOR_022
#define VECTOR_022 LPLD_DMA_Isr
#undef  VECTOR_023
#define VECTOR_023 LPLD_DMA_Isr
#undef  VECTOR_024
#define VECTOR_024 LPLD_DMA_Isr
#undef  VECTOR_025
#define VECTOR_025 LPLD_DMA_Isr
#undef  VECTOR_026
#define VECTOR_026 LPLD_DMA_Isr
#undef  VECTOR_027
#define VECTOR_027 LPLD_DMA_Isr
#undef  VECTOR_028
#define VECTOR_028 LPLD_DMA_Isr
#undef  VECTOR_029
#define VECTOR_029 LPLD_DMA_Isr
#undef  VECTOR_030
#define VECTOR_030 LPLD_DMA_Isr
#undef  VECTOR_031
#define VECTOR_031 LPLD_DMA_Isr
#undef  VECTOR_032
#define VECTOR_032 LPLD_DMA_Isr
//以下函数在LPLD_Kinetis底层包，不必修改
extern void LPLD_DMA_Isr(void);

 ***********************代码结束*************************
*/

#include "common.h"
#include "HAL_eDMA.h"

//内部函数
static uint8 LPLD_eDMA_Config(LPLD_eDMA_Cfg_t*);

DMA_ISR_CALLBACK DMA_ISR[16];

/*
 * LPLD_DMA_Init
 * DMA模块通用初始化函数--用于源地址到目的地址之间的数据直接传输（不用通过CPU）
 * 详细参数在LPLD_eDMA_Cfg_t 结构体中定义（在HAL_eDMA.h）头文件中定义
 */
uint8 LPLD_DMA_Init(LPLD_eDMA_Cfg_t *DMA_Config)
{ 
    //如果用户没有设置 每一次传输字节的个数 默认为每次传输一个字节
    if(DMA_Config->Trans_bytesNum  == NULL)
    {
       DMA_Config->Trans_bytesNum =1;
    }
    
    //如果用户没有设置 源地址增加 默认为执行一次DMA请求后源地址不增加
    if(DMA_Config->Source_Addr_inc == NULL)
    {
       DMA_Config->Source_Addr_inc  =ADDR_HOLD;       //源地址不增加
    }
    //如果用户没有设置 源数据长度 默认为8位数据长度
    if(DMA_Config->Source_Size ==NULL)
    {
       DMA_Config->Source_Size       =DMA_SRC_8BIT;    //源数据宽度8bit 一个字节
    } 
    //如果用户没有设置 主循环计数器完成以后 源地址是否调整 默认为设置为源地址不调整
    if(DMA_Config->Source_Adj_Addr ==NULL)
    {
        DMA_Config->Source_Adj_Addr  =0;    
    }
    
    //如果用户没有设置 目的地址增加 默认为执行一次DMA请求后目的地址加一
    if(DMA_Config->Dest_Addr_inc ==NULL)
    {
        DMA_Config->Dest_Addr_inc     =ADDR_INCREASE;    //针对目的地址的操作执行完毕后加1
    } 
    //如果用户没有设置 源数据长度 默认为8位数据长度
    if(DMA_Config->Dest_Size ==NULL)
    {
        DMA_Config->Dest_Size         =DMA_DST_8BIT;     //目的数据宽度8bit 一个字节
    } 
    //如果用户没有设置 主循环计数器完成以后 目的地址是否调整 默认为设置为目的地址不调整
    if(DMA_Config->Dest_Adj_Addr ==NULL)
    {
        DMA_Config->Dest_Adj_Addr     =0;    
    }
    //如果用户没有设置 中断模式 默认关闭中断
    if(DMA_Config->Dma_irqc ==NULL)
    {
       DMA_Config->Dma_irqc          =0;                //关闭中断
    }
    //如果用户没有设置 DMA自动关闭方式 默认开启主循环计数器减为0自动关闭DMA功能
    if(DMA_Config->Dma_AutoClose ==NULL)
    {
       DMA_Config->Dma_AutoClose     =0;                //开启主循环计数器减为0自动关闭DMA功能
    } 
    
    if(DMA_Config->isr_func!=NULL)
    {
        DMA_ISR[DMA_Config->Channelx] = DMA_Config->isr_func;
        //在NVIC中使能DMA中断
        enable_irq(DMA_Config->Channelx); 
    }
    //配置DMA寄存器
    return LPLD_eDMA_Config(DMA_Config);
}


/*
 * 内部函数，用户无需调用
 * LPLD_eDMA_Config
 * 配置eDMA寄存器函数
 *
 * 参数 LPLD_eDMA_Cfg_t *eDMA_Config
 * 详细参数在LPLD_eDMA_Cfg 结构体中定义
 * LPLD_eDMA_Cfg_t 结构体在（在HAL_eDMA.h）头文件中定义
 *
 * 输出：
 *   0 配置失败
 *   1 配置成功
*/
static uint8 LPLD_eDMA_Config(LPLD_eDMA_Cfg_t *DMA_Config)
{
    //=====配置eDMA模块时钟===========
    SIM_SCGC6|=SIM_SCGC6_DMAMUX_MASK; //打开DMA通道多路复用器时钟
        
    SIM_SCGC7|=SIM_SCGC7_DMA_MASK;    //打开DMA模块时钟
    //================================
    if(DMA_Config->Channelx>15) 
    {
        return 0;
    }
    else
    {
        //选择 通道x 配置外设的DMA source requestNumber
        DMAMUX_BASE_PTR->CHCFG[DMA_Config->Channelx]=DMAMUX_CHCFG_SOURCE(DMA_Config->Peri_DmaReq);
    }
    /*设置源地址信息*/
    //设置源地址   
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].SADDR=DMA_Config->Source_Addr;
    //在执行完针对源地址的操作之后，是否在原地址的基础上累加
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].SOFF =DMA_Config->Source_Addr_inc;
    //先清零数据长度寄存器
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].ATTR=0;
    //设置源地址的传输宽度
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].ATTR |=DMA_Config->Source_Size;
    //主的计数次数（major iteration count）达到后，是否重新更改源地址
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].SLAST =DMA_Config->Source_Adj_Addr;
    
    /*设置目的地址信息*/ 
    //设置目的地址 
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].DADDR=DMA_Config->Dest_Addr;
    //在执行完针对目的地址的操作之后，是否在原地址的基础上累加
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].DOFF =DMA_Config->Dest_Addr_inc;
    //设置源地址的传输宽度
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].ATTR |=DMA_Config->Dest_Size;
    //主的计数次数（major iteration count）达到后，是否重新更改目的地址
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].DLAST_SGA =DMA_Config->Dest_Adj_Addr;
    
    if(DMA_Config->Minor_loop_Length>32767) //主循环计数器的次数在0---32767之间
    {
        return 0;
    }
    else
    {
        //===============设置主计数器长度，循环次数====================================
        //设置数据长度，长度每次递减。也可以称为 当前主循环计数器 current major loop count
        DMA_BASE_PTR->TCD[DMA_Config->Channelx].CITER_ELINKNO=DMA_CITER_ELINKNO_CITER(DMA_Config->Minor_loop_Length);
        //起始循环计数器，当主循环计数器为零的时候，将装载起始循环计数器的值
        DMA_BASE_PTR->TCD[DMA_Config->Channelx].BITER_ELINKNO=DMA_CITER_ELINKNO_CITER(DMA_Config->Minor_loop_Length);
        //设置每一次传输字节的个数，个数达到上限时，DMA便将数据存入memory
        DMA_BASE_PTR->TCD[DMA_Config->Channelx].NBYTES_MLNO=DMA_NBYTES_MLNO_NBYTES(DMA_Config->Trans_bytesNum);
    }
    
    //============设置DMA TCD控制寄存器==========================//  
    DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR =0;     //清空CSR的设置                   
    //===========设置DMA中断===================================//
    if(!DMA_Config->Dma_irqc)
    {
       DMA_INT &=~(1<<DMA_Config->Channelx); //关闭相应通道的中断请求  
    }
    else if(DMA_Config->Dma_irqc==1)
    {
       DMA_INT |=(1<<DMA_Config->Channelx); //开启相应通道的中断请求
       DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR  |=DMA_CSR_INTHALF_MASK;//使能DMA 主循环计数器减到一半 中断
    }
    else if(DMA_Config->Dma_irqc==2)
    {
       DMA_INT |=(1<<DMA_Config->Channelx); //开启相应通道的中断请求
       DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR  |=DMA_CSR_INTMAJOR_MASK;//使能DMA 主循环计数器减到零 中断
    }
    
    if(!DMA_Config->Dma_AutoClose)
    {
       DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR  |=DMA_CSR_DREQ_MASK; //主循环计数器等于零后，自动关闭DMA 
    }
    else
    {
       DMA_BASE_PTR->TCD[DMA_Config->Channelx].CSR  &=(~DMA_CSR_DREQ_MASK); //主循环计数器等于零后，不关闭DMA
    }
    //注：使能此寄存器DMA开始工作
    //关闭通道x硬件DMA请求 
    DMA_ERQ&=~(1<<DMA_Config->Channelx);
    //DMA通道使能
    DMAMUX_BASE_PTR->CHCFG[DMA_Config->Channelx]|=DMAMUX_CHCFG_ENBL_MASK;
    
    return 1;
}


/*
 * LPLD_DMA_EnableReq
 * 此函数根据enable的值，开启或关闭通道x的DMA请求，
 * 一旦开启通道x的DMA请求，DMA模块就开始工作
 * 
 * 参数:
 *    chx--DMA通道值  一共16个DMA通道
 *      |__0  DMA_Channel_0
 *      |__1  DMA_Channel_1
 *      .....
 *      |__15 DMA_Channel_15
 *
 *    enable--开启或关闭DMA请求
 *      |__0  关闭通道x的外设DMA请求
 *      |__1  开启通道x的外设DMA请求     
 */
void LPLD_DMA_EnableReq(uint8 chx,uint8 enable)
{
    if(enable)
    {
        //开启通道x的外设DMA请求 
        DMA_ERQ|=(1<<chx);
    }
    else
    {
        //关闭通道x的外设DMA请求 
        DMA_ERQ&=~(1<<chx);
    }
}

/*
 * LPLD_DMA_Reload
 * 当完成一次DMA主循环之后，调用此函数可以调整目的地址，并重新设置主循环计数器的次数
 * 调整之后 新的目的地址=原来目的地址+下一次主循环的次数
 * 
 * 参数:
 *    chx--DMA通道值  一共16个DMA通道 
 *      |__0  DMA_Channel_0
 *      |__1  DMA_Channel_1
 *      .....
 *      |__15 DMA_Channel_15
 *
 *    dest_base_addr--  目的存储区的首地址，可以是数组的首地址，也可以是数据寄存器的地址
 *      
 *    dest_offset_addr--目的地址的偏移量，一般情况下目的地址的偏移量等于主循环计数器的次数
 *    
 *    loop_length--主循环计数器的次数
 *     
 */
void LPLD_DMA_Reload(uint8 chx, uint32 dest_base_addr, uint32 dest_offset_addr, uint16 loop_length)
{
    //重新设置目的地址
    DMA_BASE_PTR->TCD[chx].DADDR =(uint32)(dest_base_addr+dest_offset_addr);
    //设置数据长度，长度每次递减。也可以称为 当前主循环计数器 current major loop count
    DMA_BASE_PTR->TCD[chx].CITER_ELINKNO=DMA_CITER_ELINKNO_CITER(loop_length);
    //起始循环计数器，当主循环计数器为零的时候，将装载起始循环计数器的值
    DMA_BASE_PTR->TCD[chx].BITER_ELINKNO=DMA_CITER_ELINKNO_CITER(loop_length);
}


/*
 * LPLD_DMA_Isr
 * DMA中断底层入口函数
 * 
 * 用户无需修改，程序自动进入对应通道中断函数
 */
void LPLD_DMA_Isr(void)
{
  #define DMA_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
  uint8 dma_ch = DMA_VECTORNUM - 16;
  
  //调用用户自定义中断服务
  DMA_ISR[dma_ch]();
  //清除中断标志位
  DMA_INT |= 0x1u<<dma_ch; 
}
