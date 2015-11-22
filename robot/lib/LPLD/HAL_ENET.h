/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_ENET.h
 * 用途: ENET底层模块相关函数
 * 最后修改日期: 20120920
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#ifndef __HAL_ENET_H__
#define __HAL_ENET_H__
/********************************************************************/

//是否打印PHY寄存器数值，用于调试查看
#define PHY_PRINT_REG

// PHY收发器宏定义
#define ENET_LINK_DELAY			5000

/* MII寄存器地址 */
#define PHY_BMCR                    (0x00)
#define PHY_BMSR                    (0x01)
#define PHY_PHYIDR1                 (0x02)
#define PHY_PHYIDR2                 (0x03)
#define PHY_ANAR                    (0x04)
#define PHY_ANLPAR                  (0x05)
#define PHY_ANLPARNP                (0x05)
#define PHY_ANER                    (0x06)
#define PHY_ANNPTR                  (0x07)
#define PHY_PHYSTS                  (0x10)
#define PHY_MICR                    (0x11)
#define PHY_MISR                    (0x12)
#define PHY_PAGESEL                 (0x13)


/* PHY_BMCR寄存器位定义 */
#define PHY_BMCR_RESET              (0x8000)
#define PHY_BMCR_LOOP               (0x4000)
#define PHY_BMCR_SPEED              (0x2000)
#define PHY_BMCR_AN_ENABLE          (0x1000)
#define PHY_BMCR_POWERDOWN          (0x0800)
#define PHY_BMCR_ISOLATE            (0x0400)
#define PHY_BMCR_AN_RESTART         (0x0200)
#define PHY_BMCR_FDX                (0x0100)
#define PHY_BMCR_COL_TEST           (0x0080)

/* PHY_BMSR寄存器位定义 */
#define PHY_BMSR_100BT4             (0x8000)
#define PHY_BMSR_100BTX_FDX         (0x4000)
#define PHY_BMSR_100BTX             (0x2000)
#define PHY_BMSR_10BT_FDX           (0x1000)
#define PHY_BMSR_10BT               (0x0800)
#define PHY_BMSR_NO_PREAMBLE        (0x0040)
#define PHY_BMSR_AN_COMPLETE        (0x0020)
#define PHY_BMSR_REMOTE_FAULT       (0x0010)
#define PHY_BMSR_AN_ABILITY         (0x0008)
#define PHY_BMSR_LINK               (0x0004)
#define PHY_BMSR_JABBER             (0x0002)
#define PHY_BMSR_EXTENDED           (0x0001)

/* PHY_ANAR寄存器位定义 */
#define PHY_ANAR_NEXT_PAGE          (0x8001)
#define PHY_ANAR_REM_FAULT          (0x2001)
#define PHY_ANAR_PAUSE              (0x0401)
#define PHY_ANAR_100BT4             (0x0201)
#define PHY_ANAR_100BTX_FDX         (0x0101)
#define PHY_ANAR_100BTX             (0x0081)
#define PHY_ANAR_10BT_FDX           (0x0041)
#define PHY_ANAR_10BT               (0x0021)
#define PHY_ANAR_802_3              (0x0001)

/* PHY_ANLPAR寄存器位定义 */
#define PHY_ANLPAR_NEXT_PAGE        (0x8000)
#define PHY_ANLPAR_ACK              (0x4000)
#define PHY_ANLPAR_REM_FAULT        (0x2000)
#define PHY_ANLPAR_PAUSE            (0x0400)
#define PHY_ANLPAR_100BT4           (0x0200)
#define PHY_ANLPAR_100BTX_FDX       (0x0100)
#define PHY_ANLPAR_100BTX           (0x0080)
#define PHY_ANLPAR_10BTX_FDX        (0x0040)
#define PHY_ANLPAR_10BT             (0x0020)


/* PHY_PHYSTS寄存器位定义 */
#define PHY_PHYSTS_MDIXMODE         (0x4000)
#define PHY_PHYSTS_RX_ERR_LATCH     (0x2000)
#define PHY_PHYSTS_POL_STATUS       (0x1000)
#define PHY_PHYSTS_FALSECARRSENSLAT (0x0800)
#define PHY_PHYSTS_SIGNALDETECT     (0x0400)
#define PHY_PHYSTS_PAGERECEIVED     (0x0100)
#define PHY_PHYSTS_MIIINTERRUPT     (0x0080)
#define PHY_PHYSTS_REMOTEFAULT      (0x0040)
#define PHY_PHYSTS_JABBERDETECT     (0x0020)
#define PHY_PHYSTS_AUTONEGCOMPLETE  (0x0010)
#define PHY_PHYSTS_LOOPBACKSTATUS   (0x0008)
#define PHY_PHYSTS_DUPLEXSTATUS     (0x0004)
#define PHY_PHYSTS_SPEEDSTATUS      (0x0002)
#define PHY_PHYSTS_LINKSTATUS       (0x0001)


/* PHY硬件特性 */
#define PHY_STATUS		    ( 0x10 )
#define PHY_DUPLEX_STATUS	    ( 0x04 )
#define PHY_SPEED_STATUS	    ( 0x02 )

/* PHY收发器硬件地址 */
#define CFG_PHY_ADDRESS	            0x01


//Freescale处理器相关定义

/* TX缓冲区描述符位定义 */
#define TX_BD_R			0x0080
#define TX_BD_TO1		0x0040
#define TX_BD_W			0x0020
#define TX_BD_TO2		0x0010
#define TX_BD_L			0x0008
#define TX_BD_TC		0x0004
#define TX_BD_ABC		0x0002

/* TX增强型缓冲区描述符位定义 */
#define TX_BD_INT       0x00000040 
#define TX_BD_TS        0x00000020 
#define TX_BD_PINS      0x00000010 
#define TX_BD_IINS      0x00000008 
#define TX_BD_TXE       0x00800000 
#define TX_BD_UE        0x00200000 
#define TX_BD_EE        0x00100000
#define TX_BD_FE        0x00080000 
#define TX_BD_LCE       0x00040000 
#define TX_BD_OE        0x00020000 
#define TX_BD_TSE       0x00010000 

#define TX_BD_BDU       0x00000080    

/* RX缓冲区描述符位定义 */
// 0偏移标志 - 状态:大端格式
#define RX_BD_E			0x0080
#define RX_BD_R01		0x0040
#define RX_BD_W			0x0020
#define RX_BD_R02		0x0010
#define RX_BD_L			0x0008
#define RX_BD_M			0x0001
#define RX_BD_BC		0x8000
#define RX_BD_MC		0x4000
#define RX_BD_LG		0x2000
#define RX_BD_NO		0x1000
#define RX_BD_CR		0x0400
#define RX_BD_OV		0x0200
#define RX_BD_TR		0x0100

/* RX增强型缓冲区描述符位定义 */
#define RX_BD_ME               0x00000080    
#define RX_BD_PE               0x00000004    
#define RX_BD_CE               0x00000002    
#define RX_BD_UC               0x00000001
    
#define RX_BD_INT              0x00008000    

#define RX_BD_ICE              0x20000000    
#define RX_BD_PCR              0x10000000    
#define RX_BD_VLAN             0x04000000    
#define RX_BD_IPV6             0x02000000    
#define RX_BD_FRAG             0x01000000    

#define RX_BD_BDU              0x00000080   

/* MII接口超时 */
#define MII_TIMEOUT		0x1FFFF

/* 中断服务子程序类型 */
#define ENET_RXF_ISR            0
#define ENET_TXF_ISR            1

typedef void (*ENET_ISR_CALLBACK)(void);

/* 以太帧相关定义 */
#define CFG_NUM_ENET_TX_BUFFERS       1     //发送缓冲区个数
#define CFG_NUM_ENET_RX_BUFFERS	      8     //接收缓冲区个数
#define CFG_ENET_TX_BUFFER_SIZE	      1520  //以太发送帧缓冲区长度
#define CFG_ENET_RX_BUFFER_SIZE	      256   //以太接收帧缓冲区长度
#define CFG_ENET_MAX_PACKET_SIZE      1520  //以太发最大数据包长度


/* 缓冲区描述符结构体 */
typedef struct
{
  uint16 status;	//控制和状态位
  uint16 length;	//传输长度
  uint8  *data;	//缓冲区地址
} NBUF;

/* 描述符数组空间 */
static unsigned char xENETTxDescriptors_unaligned[ ( CFG_NUM_ENET_TX_BUFFERS * sizeof( NBUF ) ) + 16 ];
static unsigned char xENETRxDescriptors_unaligned[ ( CFG_NUM_ENET_RX_BUFFERS * sizeof( NBUF ) ) + 16 ];
static unsigned char ucENETRxBuffers[ ( CFG_NUM_ENET_RX_BUFFERS * CFG_ENET_RX_BUFFER_SIZE ) + 16 ];

/* DMA缓冲区描述符指针，为结构体数组，必须设置为16字节对齐 */
static NBUF *xENETTxDescriptors;
static NBUF *xENETRxDescriptors;

/* DMA缓冲区描述符指针，必须设置为16字节对齐 */
static unsigned long uxNextRxBuffer = 0, uxNextTxBuffer = 0;


void LPLD_ENET_Init(const uint8*);
uint8 LPLD_ENET_SetIsr(uint8, ENET_ISR_CALLBACK);
void LPLD_ENET_MacSend(uint8*, uint16);
uint8 LPLD_ENET_MacRecv(uint8*, uint16*);
uint8 LPLD_ENET_HashAddress(const uint8*);
void LPLD_ENET_SetAddress(const uint8*);
void LPLD_ENET_MiiInit(int);
uint8 LPLD_ENET_MiiWrite(uint16 , uint16, uint16);
uint8 LPLD_ENET_MiiRead(uint16, uint16, uint16*);

/*******************************************************************/

#endif /* __HAL_ENET_H__ */