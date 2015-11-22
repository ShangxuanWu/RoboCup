/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 该函数代码部分参考苏大程序
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_CAN.h
 * 用途: CAN底层模块相关函数
 * 最后修改日期: 20120711
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */

/*
 *******需用到FTM中断，请在isr.h中粘贴一下代码:*********

//FTM模块中断服务定义

#undef  VECTOR_045
#define VECTOR_045 LPLD_CAN_Isr
#undef  VECTOR_046
#define VECTOR_046 LPLD_CAN_Isr
#undef  VECTOR_047
#define VECTOR_047 LPLD_CAN_Isr
#undef  VECTOR_048
#define VECTOR_048 LPLD_CAN_Isr
#undef  VECTOR_049
#define VECTOR_049 LPLD_CAN_Isr
#undef  VECTOR_050
#define VECTOR_050 LPLD_CAN_Isr
#undef  VECTOR_051
#define VECTOR_051 LPLD_CAN_Isr
#undef  VECTOR_052
#define VECTOR_052 LPLD_CAN_Isr
#undef  VECTOR_053
#define VECTOR_053 LPLD_CAN_Isr

//以下函数在LPLD_Kinetis底层包，不必修改
extern void LPLD_CAN_Isr(void);

 ***********************代码结束*************************
*/

#include "HAL_CAN.h"
//#include "common.h"
//#include "arm_cm4.h"


//用户自定义中断服务函数数组
CAN_ISR_CALLBACK CAN_ISR[16];

//GPIO映射地址数组
volatile CAN_MemMapPtr CANx_Ptr[5] = {CAN0_BASE_PTR, 
                                      CAN1_BASE_PTR};

//定义内部函数
static uint8 LPLD_CAN_SetBaud(CANx, uint32);



/*
 * LPLD_CAN_Init
 * 该函数用于Flex_CAN模块初始化
 * 参数:
 *    canx--设置CAN模块号
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 *    baud_khz--设置CAN总线波特率
 *      |__0
 *      |__....
 *    selfloop--设置CAN总线自循环模式
 *      |__CAN_NOSELFLOOP   --不循环
 *      |__CAN_SELFLOOP     --循环 
 * 输出:
 *    0:配置出现错误
 *    1:配置成功
 */
uint8 LPLD_CAN_Init(CANx canx, uint32 baud_khz, uint8 selfloop)
{
    int8 i;
    CAN_MemMapPtr canptr = CANx_Ptr[canx];
  
    //使能FlexCAN外部时钟
    OSC_CR |= OSC_CR_ERCLKEN_MASK | OSC_CR_EREFSTEN_MASK;
    
    //使能CAN模块时钟
    if(canx == CAN0)
        SIM_SCGC6 |= SIM_SCGC6_FLEXCAN0_MASK;//使能CAN0的时钟模块 
    else
        SIM_SCGC3 |= SIM_SCGC3_FLEXCAN1_MASK;//使能CAN1的时钟模块
    
    //配置CAN_RX/TX复用引脚功能
    if(canx == CAN0)
    {
	//CAN0_TX
        PORTA_PCR12 = PORT_PCR_MUX(2) | PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; //Tx上拉
        //CAN0_RX
	PORTA_PCR13 = PORT_PCR_MUX(2) | PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; //RX上拉
    }
    else
    {
    	PORTE_PCR24 = PORT_PCR_MUX(2) | PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; //Tx上拉
    	PORTE_PCR25 = PORT_PCR_MUX(2) | PORT_PCR_PE_MASK | PORT_PCR_PS_MASK; //Rx上拉
    } 
    //注：CTRL1不能在FRZ（冻结）模式下设置
    //选择时钟源，外设时钟48MHz，内部时钟：12MHz
    //选择内部时钟
    CAN_CTRL1_REG(canptr)|= CAN_CTRL1_CLKSRC_MASK;    
     
    //使能CAN模块
    CAN_MCR_REG(canptr) &= ~CAN_MCR_MDIS_MASK;
    
    //在时钟初始化完毕和CAN总线使能完毕后，
    //单片机自动进入冻结模式
    //只有在冻结模式下才能配置大多数CAN总线寄存器
    //使能冻结模式
    CAN_MCR_REG(canptr) |= CAN_MCR_FRZ_MASK; 
    //确认不在低功耗模式，如果在低功耗模式下软件复位无法完成
    while((CAN_MCR_REG(canptr) & CAN_MCR_LPMACK_MASK ));
    
    //软件复位
    //受影响的registers： MCR (except the MDIS bit), TIMER, ECR, ESR1, ESR2,
    //                    IMASK1, IMASK2, IFLAG1, IFLAG2 and CRCR.
    //不受影响的registers：CTRL1, CTRL2, RXIMR0–RXIMR63, RXMGMASK, RX14MASK,
    //                     RX15MASK, RXFGMASK, RXFIR, all Message Buffers
    //复位后MCR中RFEN=0，因而Rx FIFO并没有使能  --------重要
    //因而“使能冻结模式位”被复位
    
    //CAN 总线软件复位，复位后该自动清零
    CAN_MCR_REG(canptr) |= CAN_MCR_SOFTRST_MASK; 
    //等待复位完成
    while(CAN_MCR_SOFTRST_MASK & CAN_MCR_REG(canptr)); 
    
    //退出正常模式，再次使能冻结模式 ,因为软件复位使冻结模式退出 
    CAN_MCR_REG(canptr) |= CAN_MCR_FRZ_MASK;  
    //等待进入冻结模式 
    while(!(CAN_MCR_REG(canptr) & CAN_MCR_FRZACK_MASK));
    
    //=================Initialize the Module Configuration Register=============
    //1 Enable the individual filtering per MB and reception queue features by setting the IRMQ bit
    //1设置全匹配蔽位，并配置与之相关的寄存器
    CAN_CTRL2_REG(canptr) &= ~CAN_CTRL2_EACEN_MASK;//接收邮箱过滤IDE匹配，RTR不匹配
    CAN_CTRL2_REG(canptr) &= ~CAN_CTRL2_RRS_MASK;  //不自动产生远程请求帧产生
    CAN_MCR_REG(canptr)   &= ~CAN_MCR_IRMQ_MASK;   //使能全局匹配寄存器      
    CAN_CTRL2_REG(canptr) |= CAN_CTRL2_MRP_MASK;   //ID首先从邮箱中匹配
    CAN_CTRL1_REG(canptr) |= CAN_CTRL1_LBUF_MASK;  //发送的时候从低优先级发送
    CAN_RXMGMASK_REG(canptr) = 0x1FFFFFFF;         //28位ID全部匹配
    CAN_RX14MASK_REG(canptr) = 0x00000000;
    CAN_RX15MASK_REG(canptr) = 0x00000000;
    //2 WRN_EN bit
    //2设置是否产生警告中断
    CAN_MCR_REG(canptr)  &= ~CAN_MCR_WRNEN_MASK;    //不产生警告中断
    //3 SRX_DIS bit
    //3设置是否自我接受
    //CAN_MCR_REG(canptr)  |= CAN_MCR_SRXDIS_MASK;  //禁止CAN自我接收
    //4 Enable the Rx FIFO by setting the RFEN bit
    //4 设置是否使能RX FIFO
    CAN_MCR_REG(canptr)  &= ~CAN_MCR_RFEN_MASK ;    //禁止接收FIFO
    //5 Enable the abort mechanism by setting the AEN bit
    CAN_MCR_REG(canptr)  &= ~CAN_MCR_AEN_MASK;   
    //6 Enable the local priority feature by setting the LPRIO_EN bit
    CAN_MCR_REG(canptr)  &= ~CAN_MCR_LPRIOEN_MASK;
    

    //模式选择：回环模式或正常模式
    if(selfloop)
      CAN_CTRL1_REG(canptr) |= CAN_CTRL1_LPB_MASK;   //使用回环模式
    else
      CAN_CTRL1_REG(canptr) &= ~CAN_CTRL1_LPB_MASK;  //使用正常模式
    //->Initialize the Control Register
    //Determine the bit timing parameters: PROPSEG, PSEG1, PSEG2, RJW
    //Determine the bit rate by programming the PRESDIV field
    //Determine the internal arbitration mode (LBUF bit)
    //设置波特率
    if(LPLD_CAN_SetBaud(canx,baud_khz))//若设置错误
    {
        return 0;
    }
    //“SYNC” message 使能同步功能
    CAN_MCR_REG(canptr)  |= CAN_CTRL1_TSYN_MASK;
    CAN_TIMER_REG(canptr) = 0x0000;
    //->Initialize the Message Buffers
    //The Control and Status word of all Message Buffers must be initialized
    //If Rx FIFO was enabled, the ID filter table must be initialized
    //Other entries in each Message Buffer should be initialized as required
    //将16个邮箱缓冲区内容清0
    for(i=0;i<16;i++)
    {
      canptr->MB[i].CS    = 0x00000000;
      canptr->MB[i].ID    = 0x00000000;
      canptr->MB[i].WORD0 = 0x00000000;
      canptr->MB[i].WORD1 = 0x00000000;
    }
    //初始化所需要的接受邮箱，设置邮箱的ID，即filter的ID值
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_1,FILTER_SLAVEA_ID);//1
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_2,FILTER_SLAVEB_ID);//2
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_3,FILTER_SLAVEC_ID);//3
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_4,FILTER_SLAVED_ID);//4
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_5,FILTER_SLAVEE_ID);//5
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_6,FILTER_SLAVEF_ID);//6
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_7,FILTER_SLAVEG_ID);//7
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_8,FILTER_SLAVEH_ID);//8
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_9,FILTER_SLAVEI_ID);//9
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_10,FILTER_SLAVEJ_ID);//10
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_11,FILTER_SLAVEK_ID);//11
    LPLD_CAN_Enable_RX_Buf(canx,MB_NUM_12,FILTER_SLAVEL_ID);//12
    //->Initialize the Rx Individual Mask Registers
    //设置每个邮箱的匹配寄存器，用到那个邮箱设置哪给
    canptr->RXIMR[0]  = 0x00000000;
    canptr->RXIMR[1]  = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[2]  = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[3]  = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[4]  = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[5]  = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[6]  = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[7]  = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[8]  = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[9]  = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[10] = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[11] = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[12] = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[13] = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[14] = 0x1FFFFFFF; //设置28位屏蔽位
    canptr->RXIMR[15] = 0x1FFFFFFF; //设置28位屏蔽位
    //Set required interrupt mask bits in the IMASK Registers (for all MB interrupts), in
    //CTRL Register (for Bus Off and Error interrupts) and in MCR Register for Wake-Up interrupt
    //清除所有邮箱的标志位
    LPLD_CAN_ClearAllFlag(canx);
    //使能接受邮箱中断
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_1);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_2);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_3);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_4);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_5);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_6);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_7);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_8);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_9);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_10);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_11);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_12);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_13);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_14);
    LPLD_CAN_Enable_Interrupt(canx,MB_NUM_15);
    //Negate the HALT bit in MCR
    
    //只有在冻结模式下才能配置，配置完推出冻结模式
    CAN_MCR_REG(canptr) &= ~(CAN_MCR_HALT_MASK);
    //等待直到退出冻结模式
    while( CAN_MCR_REG(canptr) & CAN_MCR_FRZACK_MASK);    
    //等到不在冻结模式，休眠模式或者停止模式
    while((CAN_MCR_REG(canptr) & CAN_MCR_NOTRDY_MASK));
    //Starting with the last event, FlexCAN attempts to synchronize to the CAN bus.
    return 1;
}

/*
 * LPLD_CAN_SetIsr
 * 该函数用于Flex_CAN模块的16个中断源配置
 * 参数:
 *    canx--设置CAN模块号
 *      |__CAN0             -CAN0号模块
 *      |__CAN1             -CAN1号模块
 *    can_int_type--配置中断方式
 *      |__FLEXCAN_MB_INT               -邮箱中断
 *      |__FLEXCAN_BUS_OFF_INT          -总线关闭
 *      |__FLEXCAN_ERROR_INT            -错误中断
 *      |__FLEXCAN_TRANS_WARNING_INT    -发送警告中断
 *      |__FLEXCAN_RECV_WARNING_INT     -接收警告中断
 *      |__FLEXCAN_WAKEUP_INT           -唤醒中断
 *      |__FLEXCAN_IMEU_INT             -独立匹配元素更新
 *      |__FLEXCAN_LOST_RECV_INT        -接收丢失中断 
 *    isr_func--用户中断程序入口地址
 *      |__用户在工程文件下定义的中断函数名，函数必须为:无返回值,无参数(eg. void isr(void);)
 * 输出:
 *    无
 */
void LPLD_CAN_SetIsr(CANx canx, uint8 can_int_type, CAN_ISR_CALLBACK isr_func)
{
  //参数检查
  ASSERT( canx <=  CAN0);                                 //模块号
  ASSERT( can_int_type <= FLEXCAN_LOST_RECV_INT);         //中断类型
  
  enable_irq(29 + canx*8 + can_int_type);
  CAN_ISR[canx*8 + can_int_type] = isr_func;
  
}


/*
 * LPLD_CAN_SendData
 * 该函数用于Flex_CAN模块向总线发送数据
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             -CAN0号模块
 *      |__CAN1             -CAN1号模块
 *    mbx--对应的邮箱号
 *      |__MB_NUM_0         --邮箱0
 *      |__...              --...
 *      |__MB_NUM_15        --邮箱15
 *    id--目标位置的id号  
 *    len--发送数据的字节数，最大8个字节   
 *    *data--发送数据的缓冲区
 * 输出:
 *    0:配置出现错误
 *    1:配置成功
 */
uint8 LPLD_CAN_SendData(CANx canx, uint16 mbx, uint32 id, uint8 len, uint8 *data)
{
    int16  i,j,k;
    uint32 word[2] = {0};
    CAN_MemMapPtr canptr = CANx_Ptr[canx];
    
    //判断缓冲区和数据长度设置错误
    if(mbx >= MB_MAX_NO || len > MB_MAX_DATA)
        return 0; //超出范围
    
    //将8个字节转换成32位的word存储
    //首先判断当前数据包含字节数
    j = (len-1)/4; //是否超过4字节
    k = (len-1)%4; //
    if(j > 0)         //长度大于4(即发送数据超过4字节)
    {
      word[0] = ((data[0]<<24) | (data[1]<<16) | (data[2]<< 8) |  data[3] );
    }
    for(i = 0; i <= k ; i++)
    {
       word[j] |= data[(j<<2)+i] << (24-(i<<3)); 
    }
    
    //通过id判断帧类型——扩展帧
    j = (id &  CAN_MSG_IDE_MASK)>>CAN_MSG_IDE_BIT_NO;  //IDE
    //通过id判断帧类型——远程帧
    k = (id &  CAN_MSG_TYPE_MASK)>>CAN_MSG_TYPE_BIT_NO;//RTR
    
    //获得ID位数
    i =  j? 0: FLEXCAN_MB_ID_STD_BIT_NO;
    
    if(canptr->IFLAG1 & (1<<mbx))
      canptr->IFLAG1 = (1<<mbx);
    //以下四步骤为发送过程
    //先缓冲区写激活码
    canptr->MB[mbx].CS = FLEXCAN_MB_CS_CODE(FLEXCAN_MB_CODE_TX_INACTIVE);
    
    //向缓冲区写目标ID
    canptr->MB[mbx].ID = (1 << FLEXCAN_MB_ID_PRIO_BIT_NO) | ((id & ~(CAN_MSG_IDE_MASK|CAN_MSG_TYPE_MASK))<<i);  
    
    //向缓冲区写数据
    canptr->MB[mbx].WORD0 = word[0];
    canptr->MB[mbx].WORD1 = word[1];  
    
    //通过制定的发送代码开始发送
    canptr->MB[mbx].CS = FLEXCAN_MB_CS_CODE(FLEXCAN_MB_CODE_TX_ONCE)//写激活代码
                               | (j<<FLEXCAN_MB_CS_IDE_BIT_NO)          //缓冲区写IDE位
			       | (k<<FLEXCAN_MB_CS_RTR_BIT_NO)          //缓冲区写RTR位
                               | FLEXCAN_MB_CS_LENGTH(len);            //缓冲区写数据长度
    for(i = 0;i <1000;i++); //等待缓冲区装载完成
							
    //限时等待发送完成（如果使用中断则限时等待语句可删除）
    i=0;
    while(!(canptr->IFLAG1 & (1<<mbx)))
    {
    	if((i++)>0x1000)
          return 0;
    }
    //清报文缓冲区中断标志
    canptr->IFLAG1 = (1<<mbx);
    return 1;
}

/*
 * LPLD_CAN_Enable_RX_Buf
 * 该函数用于使能Flex_CAN模块的接收缓冲区
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 *    mbx--对应的邮箱号
 *      |__MB_NUM_0         --邮箱0
 *      |__...              --...
 *      |__MB_NUM_15        --邮箱15
 *    id--接收缓冲的ID，用于和接收到的ID进行匹配。
 * 输出:
 *    无
 *
 */
void LPLD_CAN_Enable_RX_Buf(CANx canx, uint16 mbx, uint32 id)
{
    uint32 idemp;
    //获得当前缓冲区的CODE值0X0100
    uint32 cs = FLEXCAN_MB_CS_CODE(FLEXCAN_MB_CODE_RX_EMPTY); 
    CAN_MemMapPtr canptr = CANx_Ptr[canx];

    //将MB配置为非激活状态
    canptr->MB[mbx].CS = FLEXCAN_MB_CS_CODE(FLEXCAN_MB_CODE_RX_INACTIVE); 	
    
    //取出29位单独的ID
    idemp = id & 0x1FFFFFFF;
    
    //设置ID用于接收的数据帧和邮箱的ID进行匹配
    if(id & CAN_MSG_IDE_MASK)//扩展帧
    {
        canptr->MB[mbx].ID = idemp;
        cs |= FLEXCAN_MB_CS_IDE;//置位IDE位，设置为扩展帧
    }
    else//标准帧
    {
        //将ID左移18位存储在标准帧的ID位置
        canptr->MB[mbx].ID = (idemp << FLEXCAN_MB_ID_STD_BIT_NO); //取标准帧的ID号          
    }
    
    //激活接收缓冲区，code写0100
    canptr->MB[mbx].CS = cs;  //设置为接受缓冲区，用于接受数据    
}

/*
 * LPLD_CAN_RecvData
 * 该函数用于接收Flex_CAN模块从总线获取的数据
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 *    mbx--对应的邮箱号
 *      |__MB_NUM_0         --邮箱0
 *      |__...              --...
 *      |__MB_NUM_15        --邮箱15
 *    *id--接收到的ID   
 *    *len--接收到的数据长度指针
 *    *data--接收到的数据缓冲区指针
 * 输出:
 *    0:配置时出现错误
 *    1:配置时成功
 */
uint8 LPLD_CAN_RecvData(CANx canx, uint16 mbx, uint32 *id, uint8 *len, uint8 *data)  
{
    int8   i,j,k;
    int8   format;
    uint16 code;
    int16  length;   
    uint8  *pMBData;
    uint8  *pBytes = data;
    CAN_MemMapPtr canptr = CANx_Ptr[canx];
    
    //读timer值解除邮箱自锁
    //在一般模式（相对于FIFO接收）下，必须首先解锁邮箱
    LPLD_CAN_Unlock_MBx(CAN0);
    
    code = FLEXCAN_GET_CODE(canptr->MB[mbx].CS);
    //如果是 FULL 或 OVERRUN状态 证明接受到数据
    if(code != RX_BUF_STATUS_FULL && code != RX_BUF_STATUS_OVERRUN)
    {
      *len = 0;
      return 0;
    }
    length = FLEXCAN_GET_LENGTH(canptr->MB[mbx].CS);  //取MB结构中CS的DLC值
    
    if(length <1)//接收到的数据长度小于1，返回错误
    {
      *len = 0;
      return 0;
    }
   
    //判断是标准帧还是扩展帧
    format = (canptr->MB[mbx].CS & FLEXCAN_MB_CS_IDE)? 1:0;//判断IDE位
    *id    = (canptr->MB[mbx].ID & FLEXCAN_MB_ID_EXT_MASK); //在接受回来的帧中，先按扩展帧提取ID，之后根据format判断后，进一步处理ID
 
    if(!format) //format=0,标准帧
    {
      *id >>= FLEXCAN_MB_ID_STD_BIT_NO; // 获得标准帧号
    }
    else   
    { 
      *id |= CAN_MSG_IDE_MASK; //标记扩展的ID        
    }
   //判断是远程帧or数据帧
    format = (canptr->MB[mbx].CS & FLEXCAN_MB_CS_RTR)? 1:0;  
    if(format)
    {
      *id |= CAN_MSG_TYPE_MASK; //标记为远程帧类型       
    }
    //读取报文数据
    j = (length-1)>>2; //1
    k = length-1;      //7
    if(j > 0)//如果接收的是8字节数据
    {  
      //将word0中的数据提取出来
      (*(uint32*)pBytes) = canptr->MB[mbx].WORD0;
      //调换顺序0 1 2 3-->3 2 1 0
      swap_bytes(pBytes);    
      k -= 4;
      //将WORD1的最高字节地址付给pMBData
      pMBData = (uint8*)&canptr->MB[mbx].WORD1+3;
    }
    else
    {
      pMBData = (uint8*)&canptr->MB[mbx].WORD0+3;
    }
 
    for(i = 0; i <= k; i++)
    {
      pBytes[i+(j<<2)] = *pMBData--;	
    }
    *len = length;
    return 1;
}

/*
 * LPLD_CAN_Enable_Interrupt
 * 该函数用于按位使能Flex_CAN模块的邮箱中断
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 *    mbx--对应的邮箱号
 *      |__MB_NUM_0         --邮箱0
 *      |__...              --...
 *      |__MB_NUM_15        --邮箱15
 * 输出:
 *    无
 *
 */
void LPLD_CAN_Enable_Interrupt(CANx canx, uint16 mbx)
{
    CAN_MemMapPtr canptr = CANx_Ptr[canx];

    //使能相应通道的中断
    CAN_IMASK1_REG(canptr) |= (1<<mbx); 
}

/*
 * LPLD_CAN_Disable_Interrupt
 * 该函数用于按位禁止Flex_CAN模块的邮箱中断
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 *    mbx--对应的邮箱号
 *      |__MB_NUM_0         --邮箱0
 *      |__...              --...
 *      |__MB_NUM_15        --邮箱15
 * 输出:
 *    无
 *
 */
void LPLD_CAN_Disable_Interrupt(CANx canx, uint16 mbx)
{
    CAN_MemMapPtr canptr = CANx_Ptr[canx];
    
    CAN_IMASK1_REG(canptr) &= ~CAN_IMASK1_BUFLM(mbx);
}

/*
 * LPLD_CAN_ClearFlag
 * 该函数用于按位清除Flex_CAN模块的邮箱中断标志位
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 *    mbx--对应的邮箱号
 *      |__MB_NUM_0         --邮箱0
 *      |__...              --...
 *      |__MB_NUM_15        --邮箱15
 * 输出:
 *    无
 *
 */
void LPLD_CAN_ClearFlag(CANx canx, uint16 mbx)
{
    CAN_MemMapPtr canptr = CANx_Ptr[canx];
    
    canptr->IFLAG1= (1<<mbx);
}


/*
 * LPLD_CAN_ClearAllFlag
 * 该函数用于清除所有Flex_CAN模块的邮箱中断标志位
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 * 输出:
 *    无
 *
 */
void LPLD_CAN_ClearAllFlag(CANx canx)
{
    CAN_MemMapPtr canptr = CANx_Ptr[canx];
    
    canptr->IFLAG1= 0xFFFF;
    canptr->IFLAG2= 0xFFFF;
}


/*
 * LPLD_CAN_Unlock_MBx
 * 该函数用于解锁Flex_CAN模块中的接收邮箱，通过读取自由计数器的值
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 *
 * 输出:
 *    返自由计数器的值
 *
 */
uint16 LPLD_CAN_Unlock_MBx(CANx canx)
{
  CAN_MemMapPtr canptr = CANx_Ptr[canx];
  uint16 timer;

  timer = CAN_TIMER_REG(canptr);
  return timer;
}

/*
 * LPLD_CAN_GetFlag
 * 该函数用于获得Flex_CAN模块的邮箱中断标志位
 * 
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 *    mbx--对应的邮箱号
 *      |__MB_NUM_0         --邮箱0
 *      |__...              --...
 *      |__MB_NUM_15        --邮箱15
 * 输出:
 *    邮箱所对应的中断标志位
 *
 */
uint32 LPLD_CAN_GetFlag(CANx canx, uint16 mbx)
{
  CAN_MemMapPtr canptr = CANx_Ptr[canx];
  
  return (canptr->IFLAG1 & (1<<mbx));
}

/*
 * LPLD_CAN_SetBaud
 * 设置指定CAN模块波特率
 * 参数:
 *    canx--设置CAN总线通道
 *      |__CAN0             --CAN0号模块
 *      |__CAN1             --CAN1号模块
 *    baud_khz--设置CAN总线波特率
 *      |__设置波特率的值，单位Khz
 *
 * 输出:
 *    0--配置错误
 *    1--配置成功
 *
 */
static uint8 LPLD_CAN_SetBaud(CANx canx, uint32 baud_khz)
{    
  CAN_MemMapPtr canptr = CANx_Ptr[canx];
  
  switch (baud_khz)
  {
    case (33):	// 33.33K
      if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
      { 
         // 48M/120= 400k sclock, 12Tq
         // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
         // RJW = 3, PSEG1 = 4, PSEG2 = 4,PRESDIV = 120
        CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                          | CAN_CTRL1_RJW(2)
                                          | CAN_CTRL1_PSEG1(3) 
                                          | CAN_CTRL1_PSEG2(3)
                                          | CAN_CTRL1_PRESDIV(119));
      }
      else
      { 
         // 12M/20= 600k sclock, 18Tq
         // PROPSEG = 1, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
         // RJW = 4, PSEG1 = 8, PSEG2 = 8,PRESDIV = 20
        CAN_CTRL1_REG(canptr) = (0  | CAN_CTRL1_PROPSEG(0) 
                                          | CAN_CTRL1_PROPSEG(3)
                                          | CAN_CTRL1_PSEG1(7) 
                                          | CAN_CTRL1_PSEG2(7)
                                          | CAN_CTRL1_PRESDIV(19));
      }
    break;
  case (83):	// 83.33K
    if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
    {
     // 48M/48= 1M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 3, PSEG1 = 4, PSEG2 = 4,PRESDIV = 48
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(2)
                                      | CAN_CTRL1_PSEG1(3)
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(47));
    }
    else
    { 
     // 12M/12= 1M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 3, PSEG1 = 4, PSEG2 = 4,PRESDIV = 12
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(2)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(11));
    }
    break;
  case (50):
    if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
    {                
     // 48M/80= 0.6M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 40
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(1)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(79));
    }
    else
    {
     // 12M/20= 0.6M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 20                 
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2)
                                      | CAN_CTRL1_RJW(2)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(19));                   
    }
    break;
  case (100):
    if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
    { 
     // 48M/40= 1.2M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 40
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2)
                                      | CAN_CTRL1_RJW(2)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(39));
    }
    else
    {
     // 12M/10= 1.2M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 10
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(2)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(9));                   
    }
    break;
  case (125):
    if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
    {                 
     // 48M/32= 1.5M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 32
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(2)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(31));
    }
    else
    {
     // 12M/8= 1.5M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 3, PSEG1 = 4, PSEG2 = 4, PRESDIV = 8
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(2)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(7));                  
    }
    break;
  case (250):
    if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
    {                
     // 48M/16= 3M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 2, PSEG1 = 4, PSEG2 = 4, PRESDIV = 16
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2)
                                      | CAN_CTRL1_RJW(1)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(15));
    }
    else
    {
     // 12M/4= 3M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 2, PSEG1 = 4, PSEG2 = 4, PRESDIV = 4
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(1)
                                      | CAN_CTRL1_PSEG1(3)
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(3));                   
    }
    break;
  case (500):
    if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
    {                
     // 48M/8=6M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 2, PSEG1 = 4, PSEG2 = 4, PRESDIV = 6
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(1)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(7));
    }
    else
    {
     // 12M/2=6M sclock, 12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 2, PSEG1 = 4, PSEG2 = 4, PRESDIV = 2
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(1)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(1));                   
    }
    break;
  case (1000): 
    if(CAN_CTRL1_REG(canptr) & CAN_CTRL1_CLKSRC_MASK)
    {                  
     // 48M/6=8M sclock
     // PROPSEG = 4, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 1, PSEG1 = 1, PSEG2 = 2, PRESCALER = 6
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(3) 
                                      | CAN_CTRL1_RJW(0)
                                      | CAN_CTRL1_PSEG1(0)
                                      | CAN_CTRL1_PSEG2(1)
                                      | CAN_CTRL1_PRESDIV(5));
    }
    else
    {  
     // 12M/1=12M sclock,12Tq
     // PROPSEG = 3, LOM = 0x0, LBUF = 0x0, TSYNC = 0x0, SAMP = 1
     // RJW = 4, PSEG1 = 4, PSEG2 = 4, PRESCALER = 1
      CAN_CTRL1_REG(canptr) = (0 | CAN_CTRL1_PROPSEG(2) 
                                      | CAN_CTRL1_RJW(3)
                                      | CAN_CTRL1_PSEG1(3) 
                                      | CAN_CTRL1_PSEG2(3)
                                      | CAN_CTRL1_PRESDIV(0));
    }
    break;
  default: 
    return 0;
  }
  return 1;
}

/*
 * LPLD_CAN_Isr
 * CAN通用中断底层入口函数
 * 
 * 用户无需修改，程序自动进入对应通道中断函数
 */

void LPLD_CAN_Isr(void)
{
  #define CAN_VECTORNUM   (*(volatile uint8*)(0xE000ED04))
  uint8 can_active_int = CAN_VECTORNUM - 45;
  CAN_ISR[can_active_int]();
}
