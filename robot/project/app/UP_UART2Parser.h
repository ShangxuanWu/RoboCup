#ifndef UP_UART2PARSER_H
#define UP_UART2PARSER_H
	
#include "common.h"
#include "HAL_UART.h"

#define  debug_node_addr   0x1000
#define u16 uint16
#define u8 uint8
#define u32 uint32
/****************************************************************************************************
 配置信息
 *****************************************************************************************************/
extern void CFG_MyAddr(u16 inMyAddr);

/****************************************************************************************************
 获取数值
*****************************************************************************************************/
extern u8 GetCmdAction(void);
extern void GetFieldSensors(u8* inArr);
extern u8 GetDestPos(void);
extern int GetCardUID(u8* inBuf);

/****************************************************************************************************
 发送数值
*****************************************************************************************************/
extern void UART2_SendADs(u16 inDestAddr,int inNum,u16* inADs);
extern void UART2_SendInfo(u16 inDestAddr,int inNum,u8* inInfo);
extern void UART2_SendRobotState(u16 inDestAddr,u8 inPos,u8 inNext,u8 inHeadFor );
extern void UART2_SendCardUID(u16 inDestAddr,u8* inUID);
extern void UART2_SendPathPoint(u16 inDestAddr,int* inPathx,int* inPathy,int inNum);
extern void UART2_SendMap(u16 inDestAddr,u8* indata,u8 inLen);

/****************************************************************************************************
 数据解析
*****************************************************************************************************/
void Uart2_ParseFrame(unsigned char* pData);
extern void UART2_ParseData(unsigned char data);
extern void Uart2_RecvBuf(u8 inData);
extern void UART2_ParseRawBuf(void);

void Parse_RFID(u8 inData);
extern void ParseRFIDData(void);
extern void BufRFID(u8 inData);

extern void LCD_DisplayFieldSensors(void);

extern unsigned char iCard[4];
#endif
