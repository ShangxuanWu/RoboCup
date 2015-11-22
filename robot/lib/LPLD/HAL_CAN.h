/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_CAN.c
 * 用途: ADC底层模块相关函数
 * 最后修改日期: 20120711
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */

#ifndef __HAL_CAN_H__
#define __HAL_CAN_H__

#include "common.h"

//FlexCAN模块中断回调函数类型
typedef void (*CAN_ISR_CALLBACK)(void);

#define FILTER_SLAVEA_ID  0x01  //本机ID
#define FILTER_SLAVEB_ID  0x02  //本机ID
#define FILTER_SLAVEC_ID  0x03  //本机ID
#define FILTER_SLAVED_ID  0x04  //本机ID
#define FILTER_SLAVEE_ID  0x05  //本机ID
#define FILTER_SLAVEF_ID  0x06  //本机ID
#define FILTER_SLAVEG_ID  0x07  //本机ID
#define FILTER_SLAVEH_ID  0x08  //本机ID
#define FILTER_SLAVEI_ID  0x09  //本机ID
#define FILTER_SLAVEJ_ID  0x0A  //本机ID
#define FILTER_SLAVEK_ID  0x0B  //本机ID
#define FILTER_SLAVEL_ID  0x0C  //本机ID
#define FILTER_SLAVEM_ID  0x0D  //本机ID
#define FILTER_SLAVEN_ID  0x0E  //本机ID
#define FILTER_SLAVEO_ID  0x0F  //本机ID

#define CAN_BAUD_100KHZ         (100)

//定义初始化邮箱的数目，该数目由CAN_MCR_REG中设置邮箱多少的相关位决定
//系统默认为 16个邮箱
#define MB_MAX_NO    (16)
#define MB_MAX_DATA  (8)
//定义邮箱的值
#define MB_NUM_0                0  //定义邮箱0
#define MB_NUM_1                1  //定义邮箱1
#define MB_NUM_2                2  //定义邮箱2
#define MB_NUM_3                3  //定义邮箱3
#define MB_NUM_4                4  //定义邮箱4
#define MB_NUM_5                5  //定义邮箱5
#define MB_NUM_6                6  //定义邮箱6
#define MB_NUM_7                7  //定义邮箱7
#define MB_NUM_8                8  //定义邮箱8
#define MB_NUM_9                9  //定义邮箱9
#define MB_NUM_10               10 //定义邮箱10
#define MB_NUM_11               11 //定义邮箱11
#define MB_NUM_12               12 //定义邮箱12
#define MB_NUM_13               13 //定义邮箱13
#define MB_NUM_14               14 //定义邮箱14
#define MB_NUM_15               15 //定义邮箱15

//定义中断形式
#define FLEXCAN_MB_INT                0  
#define FLEXCAN_BUS_OFF_INT           1   
#define FLEXCAN_ERROR_INT             2   
#define FLEXCAN_TRANS_WARNING_INT     3   
#define FLEXCAN_RECV_WARNING_INT      4
#define FLEXCAN_WAKEUP_INT            5
#define FLEXCAN_IMEU_INT              6
#define FLEXCAN_LOST_RECV_INT         7

//自循环
#define CAN_NOSELFLOOP                    0
#define CAN_SELFLOOP                  1

#define swap_bytes(ptr)	{ uint8   byte; \
                                    byte = (ptr)[0]; (ptr)[0] = (ptr)[3]; (ptr)[3]=byte; \
                                    byte = (ptr)[1]; (ptr)[1] = (ptr)[2]; (ptr)[2]=byte; \
			}

#define FLEXCAN_CTRL2_RFFN              (0x0F000000L)
#define FLEXCAN_CTRL2_RFFN_BIT_NO       (24)

//Flex_CAN报文结构位定义
#define	CAN_MSG_IDE_MASK	        (0x80000000L) 
#define CAN_MSG_IDE_BIT_NO	        (31)
#define CAN_MSG_ID_EXTENDED	        (CAN_MSG_ID_MASK)
#define CAN_MSG_ID_STANDARD	        (0)
#define CAN_MSG_TYPE_MASK 	        (0x40000000L)
#define CAN_MSG_TYPE_BIT_NO	        (30)
#define CAN_MSG_TYPE_DATA_FRAME	        (CAN_MSG_TYPE_MASK)
#define CAN_MSG_TYPE_REMOTE_FRAME	(0)

//Flex_CAN_MB的位定义和宏
#define FLEXCAN_MB_CS_TIMESTAMP(x)      (((x)&0x0000FFFF)<<0)
#define FLEXCAN_MB_CS_TIMESTAMP_MASK    (0x0000FFFFL)
#define FLEXCAN_MB_CS_LENGTH(x)         (((x)&0x0000000F)<<16)
#define FLEXCAN_MB_CS_RTR               (0x00100000)
#define FLEXCAN_MB_CS_IDE               (0x00200000)
#define FLEXCAN_MB_CS_SRR               (0x00400000)
#define FLEXCAN_MB_CS_CODE(x)           (((x)&0x0000000F)<<24)
#define FLEXCAN_MB_CS_CODE_MASK	        (0x0F000000L)
#define FLEXCAN_MB_CS_DLC_MASK	        (0x000F0000L)

#define FLEXCAN_MB_CODE_RX_INACTIVE	(0)   //
#define FLEXCAN_MB_CODE_RX_EMPTY	(4)
#define FLEXCAN_MB_CODE_RX_FULL		(2)
#define FLEXCAN_MB_CODE_RX_OVERRUN	(6)
#define FLEXCAN_MB_CODE_RX_BUSY		(1)

#define FLEXCAN_MB_CS_IDE_BIT_NO        (21)
#define FLEXCAN_MB_CS_RTR_BIT_NO        (20)
#define FLEXCAN_MB_CS_DLC_BIT_NO        (16)

#define FLEXCAN_MB_CODE_TX_INACTIVE	    (8)
#define FLEXCAN_MB_CODE_TX_ABORT	    (9)
#define FLEXCAN_MB_CODE_TX_ONCE		    (0x0C)
#define FLEXCAN_MB_CODE_TX_RESPONSE	    (0x0A)
#define FLEXCAN_MB_CODE_TX_RESPONSE_TEMP    (0x0E)
#define FLEXCAN_GET_CODE(cs)		    (((cs) & FLEXCAN_MB_CS_CODE_MASK)>>24)
#define FLEXCAN_GET_LENGTH(cs)              (((cs) & FLEXCAN_MB_CS_DLC_MASK)>>16)

//定义RX buffer code状态宏定义
#define RX_BUF_STATUS_INACTIVE          (0x00)
#define RX_BUF_STATUS_EMPTY             (0x04)
#define RX_BUF_STATUS_FULL              (0x02)
#define RX_BUF_STATUS_OVERRUN           (0x06)
#define RX_BUF_STATUS_RUNSWER           (0x0A)
#define RX_BUF_STATUS_BUSY              (0x01)

//FLEXCAN_MB_ID的位定义和宏
#define FLEXCAN_MB_ID_STD_MASK		  (0x1FFC0000L)
#define FLEXCAN_MB_ID_EXT_MASK		  (0x1FFFFFFFL)
#define FLEXCAN_MB_ID_IDEXT(x)            (((x)&0x0003FFFF)<<0)
#define FLEXCAN_MB_ID_IDSTD(x)            (((x)&0x000007FF)<<18)
#define FLEXCAN_MB_ID_PRIO(x)             (((x)&0x00000007)<<29)
#define FLEXCAN_MB_ID_PRIO_BIT_NO	  (29)
#define FLEXCAN_MB_ID_STD_BIT_NO	  (18)
#define FLEXCAN_MB_ID_EXT_BIT_NO	  (0)

//FLEXCAN_MB_WORD0的位定义和宏
#define FLEXCAN_MB_WORD0_DATA3(x)     (((x)&0x000000FF)<<0)
#define FLEXCAN_MB_WORD0_DATA2(x)     (((x)&0x000000FF)<<8)
#define FLEXCAN_MB_WORD0_DATA1(x)     (((x)&0x000000FF)<<16)
#define FLEXCAN_MB_WORD0_DATA0(x)     (((x)&0x000000FF)<<24)
//FLEXCAN_MB_WORD1的位定义和宏
#define FLEXCAN_MB_WORD1_DATA7(x)     (((x)&0x000000FF)<<0)
#define FLEXCAN_MB_WORD1_DATA6(x)     (((x)&0x000000FF)<<8)
#define FLEXCAN_MB_WORD1_DATA5(x)     (((x)&0x000000FF)<<16)
#define FLEXCAN_MB_WORD1_DATA4(x)     (((x)&0x000000FF)<<24)

//Flex_CAN模块初始化
uint8 LPLD_CAN_Init(CANx, uint32, uint8);
//设置中断服务函数
void LPLD_CAN_SetIsr(CANx, uint8, CAN_ISR_CALLBACK);
//Flex_CAN模块发送数据
uint8 LPLD_CAN_SendData(CANx, uint16, uint32, uint8, uint8*);
//Flex_CAN模块接收数据
uint8 LPLD_CAN_RecvData(CANx, uint16, uint32*, uint8*, uint8*);
//Flex_CAN使能接收缓冲
void LPLD_CAN_Enable_RX_Buf(CANx, uint16, uint32);
//Flex_CAN使能中断
void LPLD_CAN_Enable_Interrupt(CANx, uint16);
//Flex_CAN禁止中断
void LPLD_CAN_Disable_Interrupt(CANx, uint16);
//Flex_CAN获取标志位
uint32 LPLD_CAN_GetFlag(CANx, uint16);
//Flex_CAN清除标志位
void LPLD_CAN_ClearFlag(CANx, uint16);
//Flex_CAN清除所有标志
void LPLD_CAN_ClearAllFlag(CANx);
//Flex_CAN模块解锁
uint16 LPLD_CAN_Unlock_MBx(CANx);
//Flex_CAN模块中断处理函数
void LPLD_CAN_Isr(void);

#endif 
