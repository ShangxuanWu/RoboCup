#include "UP_UART2Parser.h"
#include "CycleBuf.h"

static int i;

static u16 MyAddr = 0x0100;

//���ݻ���
#define RAWBUF_LEN	128
static u8 RawBuf[RAWBUF_LEN];
static u8* pHead = RawBuf;
static u8* pTail = &RawBuf[RAWBUF_LEN-1];
static u8* pPut = RawBuf;
static u8* pGet = RawBuf;
static u8 ParseBuf[64];

//��������ʹ�õĻ���
static u8 SendBuf[RAWBUF_LEN];

//��ͣ
static u8 RobotAction = 0;
static u8 DestPos = 0;
static u8 FieldSensors[10] = {0,0,0,0,0,0,0,0,0,0};//{1,2,3,4,5,6,7,8,9,10};

 /****************************************************************************************************
 ��ȡ��ֵ
 *****************************************************************************************************/
u8 GetCmdAction(void)
{
	return RobotAction;
}

void GetFieldSensors(u8* inArr)
{
	for(i=0;i<10;i++)
	{
		inArr[i] = FieldSensors[i];
	}
}

u8 GetDestPos(void)
{
	return DestPos;
}

 /****************************************************************************************************
 ������Ϣ
 *****************************************************************************************************/
void CFG_MyAddr(u16 inMyAddr)
{
	MyAddr = inMyAddr;
}

 /****************************************************************************************************
 ���յ����ݽ���
 *****************************************************************************************************/
void Uart2_RecvBuf(u8 inData)
{
	//printf("Uart2_RecvBuf\n");
	*pPut = inData;
	pPut ++;
	if(pPut == pTail)  //���ﻺ����β���ˣ��ص�ͷ������β�ν�
	{
		pPut = pHead;
	}

	FieldSensors[1] = 19;
}

void UART2_ParseRawBuf(void)
{
	while(pGet != pPut)
	{
		 UART2_ParseData(*pGet);
		 pGet ++;
		 if(pGet == pTail)	   //���ﻺ����β���ˣ��ص�ͷ������β�ν�
		 {
		 	pGet = pHead;
		 }
	}
}

//UART2����Э��֡
void Uart2_ParseFrame(unsigned char* pData)
{
unsigned int j=0,i;
unsigned int k=0;
	switch(pData[7])
	{
	case 0x00:	//���ش���������
            j=0;
    	    k = pData[2]-9;
	    for (i=0 ; i<8+k ; i++)
	    {   j+=pData[i];
	    }
	    j=j& 0x00FF;
		//	printf("%x",j);
	    if (pData[8+k]==j)
	    {                               //�����ȷ
		  for(i=0;i<10;i++)
		  {
			FieldSensors[i] = pData[8+i];
		  }
		//	return(1);
	    }


		break;

	case 0x01:	//Ŀ��λ�ã�����ʱ�ã�
		DestPos = pData[8];
		break;

	case 0xFF:	//��ͣ����
		RobotAction = pData[8];
		break;
	}
}

//UART2��������
void UART2_ParseData(unsigned char data)
{
	static int RecvIndex = 0;					//���ݽ�������
	static unsigned char lastRecv =0;			//���յ���һ���ַ�
	static unsigned char FrameStart = 0;					//֡������ʼ
	static int FrameLength = 3;					//֡����
	
	if ( FrameStart == 0 && lastRecv == 0x55 && data == 0xAA)		//���յ�����
	{
		FrameStart = 1;					//��ʾ���յ���55 aa ��ʼ���
		ParseBuf[0] = lastRecv;		//���ղŽ��յ������ݷŵ�����������
		ParseBuf[1] = data;
		RecvIndex = 2;					//�Ѿ������������ֽڵ�����
		lastRecv=0x00;
		return;
	}
	
	if (FrameStart == 1)
	{
		if (RecvIndex == 2)
		{
			FrameLength = data;

			if (FrameLength>=RAWBUF_LEN) 
			{
				FrameStart = 0;
				RecvIndex = 0;
				return;
			}
		}
		
		//�����յ����ݿ���������������
		ParseBuf[RecvIndex]=data;
		RecvIndex++;
		
		//ͨ���������ݳ������ж��Ƿ���һ֡
		if (RecvIndex == FrameLength)
		{ 
			//������һ֡������
			Uart2_ParseFrame(ParseBuf);
			FrameStart = 0;
		}
		
		//�������������ʱ�������������д���ᵼ�����ֺ����
		if (RecvIndex>=RAWBUF_LEN) 
		{
			FrameStart = 0;
			RecvIndex = 0;
			return;
		}
	}
//	else
		lastRecv=data;
}

void U16ToU8(u16 inSrc,u8* inTar)
{
	*inTar = (u8)0xff & (inSrc>>8);
	*(inTar+1) = (u8)0xff & inSrc;
}

 /****************************************************************************************************
 ������ֵ
 *****************************************************************************************************/
//��ADֵ���ͻ���λ��
void UART2_SendADs(u16 inDestAddr,int inNum,u16* inADs)
{
	SendBuf[0] = 0x55;	
	SendBuf[1] = 0xaa;
	SendBuf[2] = 0x29; 		//����

	for(i=3;i<35;i++)
	{
		SendBuf[i] = 0;
	}

	//Ŀ���ַ
	U16ToU8(inDestAddr,&SendBuf[3]);

	//�Լ��ĵ�ַ
	U16ToU8(MyAddr,&SendBuf[5]);
	
	SendBuf[7] = 0x02;		//AD

 	for(i=0;i<inNum;i++)
	{
		U16ToU8(inADs[i],&SendBuf[8+i*2]);
	}

	//У���
	SendBuf[SendBuf[2]-1] = 0;
	for(i=0;i<SendBuf[2]-1;i++)
	{
		SendBuf[SendBuf[2]-1] += SendBuf[i];	
	}

	//����
	for(i=0;i<SendBuf[2];i++)
	{
		LPLD_UART_PutChar(UART2, SendBuf[i]);
	}
}

void UART2_SendInfo(u16 inDestAddr,int inNum,u8* inInfo)
{
	SendBuf[0] = 0x55;	
	SendBuf[1] = 0xaa;
	SendBuf[2] = inNum + 9; 		//����

	//Ŀ���ַ
	U16ToU8(inDestAddr,&SendBuf[3]);

	//�Լ��ĵ�ַ
	U16ToU8(MyAddr,&SendBuf[5]);

	SendBuf[7] = 0xff;		//info
	
 	for(i=0;i<inNum;i++)
	{
		SendBuf[8+i] = inInfo[i];
	}

	//У���
	SendBuf[SendBuf[2]-1] = 0;
	for(i=0;i<SendBuf[2]-1;i++)
	{
		SendBuf[SendBuf[2]-1] += SendBuf[i];	
	}

	//����
	for(i=0;i<SendBuf[2];i++)
	{
		LPLD_UART_PutChar(UART2, SendBuf[i]);
	}
}

void UART2_SendRobotState(u16 inDestAddr,u8 inPos,u8 inNext,u8 inHeadFor )
{
	SendBuf[0] = 0x55;	
	SendBuf[1] = 0xaa;
	SendBuf[2] = 0x0c; 		//����

	//Ŀ���ַ
	U16ToU8(inDestAddr,&SendBuf[3]);

	//�Լ��ĵ�ַ
	U16ToU8(MyAddr,&SendBuf[5]);

	SendBuf[7] = 0x01;		//state
	
	SendBuf[8] = inPos;
	SendBuf[9] =  inNext;
	SendBuf[10] =  inHeadFor;
 	

	//У���
	SendBuf[SendBuf[2]-1] = 0;
	for(i=0;i<SendBuf[2]-1;i++)
	{
		SendBuf[SendBuf[2]-1] += SendBuf[i];	
	}

	//����
	for(i=0;i<SendBuf[2];i++)
	{
		LPLD_UART_PutChar(UART2, SendBuf[i]);
	}
}

void UART2_SendCardUID(u16 inDestAddr,u8* inUID)
{
	SendBuf[0] = 0x55;	
	SendBuf[1] = 0xaa;
	SendBuf[2] = 0x0D; 		//����

	//Ŀ���ַ
	U16ToU8(inDestAddr,&SendBuf[3]);

	//�Լ��ĵ�ַ
	U16ToU8(MyAddr,&SendBuf[5]);

	SendBuf[7] = 0x11;		//Card UID
	
 	for(i=0;i<4;i++)
	{
		SendBuf[8+i] = inUID[i];
	}

	//У���
	SendBuf[SendBuf[2]-1] = 0;
	for(i=0;i<SendBuf[2]-1;i++)
	{
		SendBuf[SendBuf[2]-1] += SendBuf[i];	
	}

	//����
	for(i=0;i<SendBuf[2];i++)
	{
		LPLD_UART_PutChar(UART2, SendBuf[i]);
	}
}

void UART2_SendPathPoint(u16 inDestAddr,int* inPathx,int* inPathy,int inNum)
{
	SendBuf[0] = 0x55;	
	SendBuf[1] = 0xaa;
	SendBuf[2] = (u8)inNum*2 + 9; 		//����

	//Ŀ���ַ
	U16ToU8(inDestAddr,&SendBuf[3]);

	//�Լ��ĵ�ַ
	U16ToU8(MyAddr,&SendBuf[5]);

	SendBuf[7] = 0x04;		//·����
	
 	for(i=0;i<inNum;i++)
	{
		SendBuf[8+2*i] = (u8)inPathx[i];
		SendBuf[8+2*i+1] = (u8)inPathy[i];
	}

	//У���
	SendBuf[SendBuf[2]-1] = 0;
	for(i=0;i<SendBuf[2]-1;i++)
	{
		SendBuf[SendBuf[2]-1] += SendBuf[i];	
	}

	//����
	for(i=0;i<SendBuf[2];i++)
	{
		LPLD_UART_PutChar(UART2, SendBuf[i]);
	}
}

void UART2_SendMap(u16 inDestAddr,u8* indata,u8 inLen)
{
	SendBuf[0] = 0x55;	
	SendBuf[1] = 0xaa;
	SendBuf[2] = inLen + 9; 		//����

	//Ŀ���ַ
	U16ToU8(inDestAddr,&SendBuf[3]);

	//�Լ��ĵ�ַ
	U16ToU8(MyAddr,&SendBuf[5]);

	SendBuf[7] = 0x05;		//·����
	
 	for(i=0;i<inLen;i++)
	{
		SendBuf[8+i] = indata[i];
	}

	//У���
	SendBuf[SendBuf[2]-1] = 0;
	for(i=0;i<SendBuf[2]-1;i++)
	{
		SendBuf[SendBuf[2]-1] += SendBuf[i];	
	}

	//����
	for(i=0;i<SendBuf[2];i++)
	{
		LPLD_UART_PutChar(UART2, SendBuf[i]);
	}
}
 /****************************************************************************************************
 RFID����
 *****************************************************************************************************/
static u8 rfParseBuf[32];
static u8 rfRecvIndex = 0;
static CycleBuf rfidBuf;
unsigned char iCard[4]={0,0,0,0};

void BufRFID(u8 inData)
{
  Cyc_PutIn(&rfidBuf,inData);
}

unsigned char Xor(unsigned char *data,int len)
{
   unsigned char result=0;
   int i;
   for(i=0;i<len;i++)
   {
     result^=data[i];
   }
   return result;
}
unsigned char FrameStart=0;
unsigned char Buf[48];
unsigned char  RecvIndex=0;

void Parse_RFID(unsigned char in)
{
int i;
	 if ( FrameStart == 0)		//���յ�����
    {
      FrameStart = 1;			//��ʾ���յ��� BD ��ʼ���
      Buf[0] = in;
      RecvIndex = 1;			//�Ѿ�������1���ֽڵ�����
      return;
    }
    
    if(RecvIndex==5)                //�������
    {
      for(i=0;i<4;i++)
      {
        Buf[i]=Buf[i+1];
      }
      if(in==Xor(Buf,4))
      {
        for(i=0;i<4;i++)
        {
          iCard[i]=Buf[i];
        }       
      }
      RecvIndex=0;
      FrameStart=0;
      return;
      
    }
    if (FrameStart == 1)
    {      
      //�����յ����ݿ���������������
      Buf[RecvIndex]=in;
      RecvIndex++;
      
      //ͨ���������ݳ������ж��Ƿ���һ֡
      if ((RecvIndex == 5)&&(Buf[4]==Xor(Buf,4)))
      { 
        for(i=0;i<4;i++)
        {
          iCard[i]=Buf[i];
        }
//        UART0SendCharArray(packet_data,4);
        RecvIndex=0;
      }
      
      //�������������ʱ�������������д���ᵼ�����ֺ����
      if (RecvIndex>=48) 
      {
        FrameStart = 0;
      }
    }
}

void ParseRFIDData()
{
	u8 temp = 0;
	u8 result = 0;
	while(1)
	{
		result =  Cyc_Get(&rfidBuf,&temp);
		if(result > 0)
		{
			Parse_RFID(temp);
		}
		else
		{
			break;
		}
	}
}

int GetCardUID(u8* inBuf)
{
	int res = 0	;
	for(i=0;i<4;i++)
	{
		inBuf[i] = iCard[i];
		if(iCard[i] != 0)
		{
			res = 1;
			iCard[i] = 0;
		}
	}
	return res;
}

void LCD_DisplayFieldSensors(void)
{
	/*UP_LCD_ShowInt(0,1,FieldSensors[0]);
	UP_LCD_ShowInt(0,2,FieldSensors[1]);
	UP_LCD_ShowInt(0,3,FieldSensors[2]);

	UP_LCD_ShowInt(7,1,FieldSensors[3]);
	UP_LCD_ShowInt(4,2,FieldSensors[4]);
	UP_LCD_ShowInt(10,2,FieldSensors[5]);
	UP_LCD_ShowInt(7,3,FieldSensors[6]);

	UP_LCD_ShowInt(14,1,FieldSensors[7]);
	UP_LCD_ShowInt(14,2,FieldSensors[8]);
	UP_LCD_ShowInt(14,3,FieldSensors[9]);
	
	if(RobotAction == 1)
	{
		UP_LCD_ShowLetter(7,2,'A');
	}
	else
	{
		UP_LCD_ShowLetter(7,2,'S');
	}*/
}

