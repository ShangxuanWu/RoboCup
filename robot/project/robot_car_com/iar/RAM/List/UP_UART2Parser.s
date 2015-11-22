///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  22:39:30 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\project\LPLD_Template\a /
//                    pp\UP_UART2Parser.c                                     /
//    Command line =  D:\中国机器人大赛\robot_project\project\LPLD_Template\a /
//                    pp\UP_UART2Parser.c -D IAR -D LPLD_K60 -lCN             /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\ -lB D:\中国机器人大赛\robot_project\projec /
//                    t\LPLD_Template\iar\RAM\List\ -o                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\RAM\Obj\ --no_cse --no_unroll --no_inline            /
//                    --no_code_motion --no_tbaa --no_clustering              /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config             /
//                    "D:\Program Files\IAR Systems\Embedded Workbench        /
//                    6.0\arm\INC\c\DLib_Config_Normal.h" -I                  /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\app\ -I D:\中国机器人大赛\robot_project\project\L /
//                    PLD_Template\iar\..\..\..\lib\common\ -I                /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\cpu\ -I D:\中国机器人大赛\robot_project /
//                    \project\LPLD_Template\iar\..\..\..\lib\cpu\headers\    /
//                    -I D:\中国机器人大赛\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\drivers\adc16\ -I                    /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\enet\ -I                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\lptmr\ -I                       /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\mcg\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\pmc\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\rtc\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\uart\ -I                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\wdog\ -I                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\platforms\ -I                           /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\LPLD\ -I D:\中国机器人大赛\robot_projec /
//                    t\project\LPLD_Template\iar\..\..\..\lib\LPLD\FatFs\    /
//                    -I D:\中国机器人大赛\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\LPLD\USB\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\iar_config_files\ -Ol                   /
//    List file    =  D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\UP_UART2Parser.s                            /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME UP_UART2Parser

        #define SHT_PROGBITS 0x1

        EXTERN Cyc_Get
        EXTERN Cyc_PutIn
        EXTERN UP_UART2_Putc

        PUBLIC Buf
        PUBLIC BufRFID
        PUBLIC CFG_MyAddr
        PUBLIC Card
        PUBLIC FrameStart
        PUBLIC GetCardUID
        PUBLIC GetCmdAction
        PUBLIC GetDestPos
        PUBLIC GetFieldSensors
        PUBLIC LCD_DisplayFieldSensors
        PUBLIC ParseRFIDData
        PUBLIC Parse_RFID
        PUBLIC RecvIndex
        PUBLIC U16ToU8
        PUBLIC UART2_ParseData
        PUBLIC UART2_ParseRawBuf
        PUBLIC UART2_SendADs
        PUBLIC UART2_SendCardUID
        PUBLIC UART2_SendInfo
        PUBLIC UART2_SendMap
        PUBLIC UART2_SendPathPoint
        PUBLIC UART2_SendRobotState
        PUBLIC Uart2_ParseFrame
        PUBLIC Uart2_RecvBuf
        PUBLIC `Xor`

// D:\中国机器人大赛\robot_project\project\LPLD_Template\app\UP_UART2Parser.c
//    1 #include "UP_UART2Parser.h"
//    2 #include "CycleBuf.h"
//    3 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    4 static int i;
i:
        DS8 4
//    5 

        SECTION `.data`:DATA:REORDER:NOROOT(1)
//    6 static u16 MyAddr = 0x0100;
MyAddr:
        DATA
        DC16 256
//    7 
//    8 //数据缓冲
//    9 #define RAWBUF_LEN	128

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   10 static u8 RawBuf[RAWBUF_LEN];
RawBuf:
        DS8 128

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   11 static u8* pHead = RawBuf;
pHead:
        DATA
        DC32 RawBuf

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   12 static u8* pTail = &RawBuf[RAWBUF_LEN-1];
pTail:
        DATA
        DC32 RawBuf + 7FH

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   13 static u8* pPut = RawBuf;
pPut:
        DATA
        DC32 RawBuf

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   14 static u8* pGet = RawBuf;
pGet:
        DATA
        DC32 RawBuf

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   15 static u8 ParseBuf[64];
ParseBuf:
        DS8 64
//   16 
//   17 //返送数据使用的缓冲

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   18 static u8 SendBuf[RAWBUF_LEN];
SendBuf:
        DS8 128
//   19 
//   20 //启停

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   21 static u8 RobotAction = 0;
RobotAction:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   22 static u8 DestPos = 0;
DestPos:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   23 static u8 FieldSensors[10] = {0,0,0,0,0,0,0,0,0,0};//{1,2,3,4,5,6,7,8,9,10};
FieldSensors:
        DS8 12
//   24 
//   25  /****************************************************************************************************
//   26  获取数值
//   27  *****************************************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   28 u8 GetCmdAction(void)
//   29 {
//   30 	return RobotAction;
GetCmdAction:
        LDR.W    R0,??DataTable17
        LDRB     R0,[R0, #+0]
        BX       LR               ;; return
//   31 }
//   32 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   33 u8 GetFieldSensors(u8* inArr)
//   34 {
//   35 	for(i=0;i<10;i++)
GetFieldSensors:
        LDR.W    R1,??DataTable17_1
        MOVS     R2,#+0
        STR      R2,[R1, #+0]
        B.N      ??GetFieldSensors_0
//   36 	{
//   37 		inArr[i] = FieldSensors[i];
??GetFieldSensors_1:
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable17_1
        LDR      R2,[R2, #+0]
        LDR.W    R3,??DataTable17_2
        LDRB     R2,[R2, R3]
        STRB     R2,[R1, R0]
//   38 	}
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        ADDS     R1,R1,#+1
        LDR.W    R2,??DataTable17_1
        STR      R1,[R2, #+0]
??GetFieldSensors_0:
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        CMP      R1,#+10
        BLT.N    ??GetFieldSensors_1
//   39 }
        BX       LR               ;; return
//   40 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   41 u8 GetDestPos(void)
//   42 {
//   43 	return DestPos;
GetDestPos:
        LDR.W    R0,??DataTable17_3
        LDRB     R0,[R0, #+0]
        BX       LR               ;; return
//   44 }
//   45 
//   46  /****************************************************************************************************
//   47  配置信息
//   48  *****************************************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   49 void CFG_MyAddr(u16 inMyAddr)
//   50 {
//   51 	MyAddr = inMyAddr;
CFG_MyAddr:
        LDR.W    R1,??DataTable17_4
        STRH     R0,[R1, #+0]
//   52 }
        BX       LR               ;; return
//   53 
//   54  /****************************************************************************************************
//   55  接收的数据解析
//   56  *****************************************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   57 void Uart2_RecvBuf(u8 inData)
//   58 {
//   59 	//printf("Uart2_RecvBuf\n");
//   60 	*pPut = inData;
Uart2_RecvBuf:
        LDR.W    R1,??DataTable17_5
        LDR      R1,[R1, #+0]
        STRB     R0,[R1, #+0]
//   61 	pPut ++;
        LDR.W    R0,??DataTable17_5
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_5
        STR      R0,[R1, #+0]
//   62 	if(pPut == pTail)  //到达缓冲区尾部了，回到头部，首尾衔接
        LDR.W    R0,??DataTable17_5
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_6
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??Uart2_RecvBuf_0
//   63 	{
//   64 		pPut = pHead;
        LDR.W    R0,??DataTable17_5
        LDR.W    R1,??DataTable17_7
        LDR      R1,[R1, #+0]
        STR      R1,[R0, #+0]
//   65 	}
//   66 
//   67 	FieldSensors[1] = 19;
??Uart2_RecvBuf_0:
        LDR.W    R0,??DataTable17_2
        MOVS     R1,#+19
        STRB     R1,[R0, #+1]
//   68 }
        BX       LR               ;; return
//   69 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   70 void UART2_ParseRawBuf(void)
//   71 {
UART2_ParseRawBuf:
        PUSH     {R7,LR}
        B.N      ??UART2_ParseRawBuf_0
//   72 	while(pGet != pPut)
//   73 	{
//   74 		 UART2_ParseData(*pGet);
??UART2_ParseRawBuf_1:
        LDR.W    R0,??DataTable17_8
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+0]
        BL       UART2_ParseData
//   75 		 pGet ++;
        LDR.W    R0,??DataTable17_8
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_8
        STR      R0,[R1, #+0]
//   76 		 if(pGet == pTail)	   //到达缓冲区尾部了，回到头部，首尾衔接
        LDR.W    R0,??DataTable17_8
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_6
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??UART2_ParseRawBuf_0
//   77 		 {
//   78 		 	pGet = pHead;
        LDR.W    R0,??DataTable17_8
        LDR.W    R1,??DataTable17_7
        LDR      R1,[R1, #+0]
        STR      R1,[R0, #+0]
//   79 		 }
//   80 	}
??UART2_ParseRawBuf_0:
        LDR.W    R0,??DataTable17_8
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_5
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??UART2_ParseRawBuf_1
//   81 }
        POP      {R0,PC}          ;; return
//   82 
//   83 //UART2解析协议帧

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   84 void Uart2_ParseFrame(unsigned char* pData)
//   85 {
Uart2_ParseFrame:
        PUSH     {R4}
//   86 unsigned int j=0,i;
        MOVS     R1,#+0
//   87 unsigned int k=0;
        MOVS     R3,#+0
//   88 	switch(pData[7])
        LDRB     R2,[R0, #+7]
        CMP      R2,#+0
        BEQ.N    ??Uart2_ParseFrame_0
        CMP      R2,#+1
        BEQ.N    ??Uart2_ParseFrame_1
        CMP      R2,#+255
        BEQ.N    ??Uart2_ParseFrame_2
        B.N      ??Uart2_ParseFrame_3
//   89 	{
//   90 	case 0x00:	//场地传感器数据
//   91             j=0;
??Uart2_ParseFrame_0:
        MOVS     R1,#+0
//   92     	    k = pData[2]-9;
        LDRB     R2,[R0, #+2]
        SUBS     R3,R2,#+9
//   93 	    for (i=0 ; i<8+k ; i++)
        MOVS     R2,#+0
        B.N      ??Uart2_ParseFrame_4
//   94 	    {   j+=pData[i];
??Uart2_ParseFrame_5:
        LDRB     R4,[R2, R0]
        ADDS     R1,R1,R4
//   95 	    }
        ADDS     R2,R2,#+1
??Uart2_ParseFrame_4:
        ADDS     R4,R3,#+8
        CMP      R2,R4
        BCC.N    ??Uart2_ParseFrame_5
//   96 	    j=j& 0x00FF;
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
//   97 		//	printf("%x",j);
//   98 	    if (pData[8+k]==j)
        ADDS     R2,R3,R0
        LDRB     R2,[R2, #+8]
        CMP      R2,R1
        BNE.N    ??Uart2_ParseFrame_6
//   99 	    {                               //解包正确
//  100 		  for(i=0;i<10;i++)
        MOVS     R2,#+0
        B.N      ??Uart2_ParseFrame_7
//  101 		  {
//  102 			FieldSensors[i] = pData[8+i];
??Uart2_ParseFrame_8:
        ADDS     R1,R2,R0
        LDRB     R1,[R1, #+8]
        LDR.W    R3,??DataTable17_2
        STRB     R1,[R2, R3]
//  103 		  }
        ADDS     R2,R2,#+1
??Uart2_ParseFrame_7:
        CMP      R2,#+10
        BCC.N    ??Uart2_ParseFrame_8
//  104 		//	return(1);
//  105 	    }
//  106 
//  107 
//  108 		break;
??Uart2_ParseFrame_6:
        B.N      ??Uart2_ParseFrame_3
//  109 
//  110 	case 0x01:	//目标位置（调试时用）
//  111 		DestPos = pData[8];
??Uart2_ParseFrame_1:
        LDRB     R0,[R0, #+8]
        LDR.W    R1,??DataTable17_3
        STRB     R0,[R1, #+0]
//  112 		break;
        B.N      ??Uart2_ParseFrame_3
//  113 
//  114 	case 0xFF:	//启停控制
//  115 		RobotAction = pData[8];
??Uart2_ParseFrame_2:
        LDRB     R0,[R0, #+8]
        LDR.W    R1,??DataTable17
        STRB     R0,[R1, #+0]
//  116 		break;
//  117 	}
//  118 }
??Uart2_ParseFrame_3:
        POP      {R4}
        BX       LR               ;; return
//  119 
//  120 //UART2解析数据

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  121 void UART2_ParseData(unsigned char data)
//  122 {
UART2_ParseData:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  123 	static int RecvIndex = 0;					//数据接收索引
//  124 	static unsigned char lastRecv =0;			//接收的上一个字符
//  125 	static unsigned char FrameStart = 0;					//帧解析开始
//  126 	static int FrameLength = 3;					//帧长度
//  127 	
//  128 	if ( FrameStart == 0 && lastRecv == 0x55 && data == 0xAA)		//接收的数据
        LDR.W    R0,??DataTable17_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??UART2_ParseData_0
        LDR.W    R0,??DataTable17_10
        LDRB     R0,[R0, #+0]
        CMP      R0,#+85
        BNE.N    ??UART2_ParseData_0
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+170
        BNE.N    ??UART2_ParseData_0
//  129 	{
//  130 		FrameStart = 1;					//表示接收到了55 aa 开始标记
        LDR.W    R0,??DataTable17_9
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  131 		ParseBuf[0] = lastRecv;		//将刚才接收到的数据放到缓冲数组里
        LDR.W    R0,??DataTable17_11
        LDR.W    R1,??DataTable17_10
        LDRB     R1,[R1, #+0]
        STRB     R1,[R0, #+0]
//  132 		ParseBuf[1] = data;
        LDR.W    R0,??DataTable17_11
        STRB     R4,[R0, #+1]
//  133 		RecvIndex = 2;					//已经缓冲了两个字节的数据
        LDR.W    R0,??DataTable17_12
        MOVS     R1,#+2
        STR      R1,[R0, #+0]
//  134 		lastRecv=0x00;
        LDR.W    R0,??DataTable17_10
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  135 		return;
        B.N      ??UART2_ParseData_1
//  136 	}
//  137 	
//  138 	if (FrameStart == 1)
??UART2_ParseData_0:
        LDR.W    R0,??DataTable17_9
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??UART2_ParseData_2
//  139 	{
//  140 		if (RecvIndex == 2)
        LDR.W    R0,??DataTable17_12
        LDR      R0,[R0, #+0]
        CMP      R0,#+2
        BNE.N    ??UART2_ParseData_3
//  141 		{
//  142 			FrameLength = data;
        LDR.W    R0,??DataTable17_13
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        STR      R4,[R0, #+0]
//  143 
//  144 			if (FrameLength>=RAWBUF_LEN) 
        LDR.W    R0,??DataTable17_13
        LDR      R0,[R0, #+0]
        CMP      R0,#+128
        BLT.N    ??UART2_ParseData_3
//  145 			{
//  146 				FrameStart = 0;
        LDR.W    R0,??DataTable17_9
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  147 				RecvIndex = 0;
        LDR.W    R0,??DataTable17_12
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  148 				return;
        B.N      ??UART2_ParseData_1
//  149 			}
//  150 		}
//  151 		
//  152 		//将接收的数据拷贝到缓冲数组里
//  153 		ParseBuf[RecvIndex]=data;
??UART2_ParseData_3:
        LDR.W    R0,??DataTable17_12
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_11
        STRB     R4,[R0, R1]
//  154 		RecvIndex++;
        LDR.W    R0,??DataTable17_12
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_12
        STR      R0,[R1, #+0]
//  155 		
//  156 		//通过接收数据长度来判断是否满一帧
//  157 		if (RecvIndex == FrameLength)
        LDR.W    R0,??DataTable17_12
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_13
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BNE.N    ??UART2_ParseData_4
//  158 		{ 
//  159 			//数据满一帧，解析
//  160 			Uart2_ParseFrame(ParseBuf);
        LDR.W    R0,??DataTable17_11
        BL       Uart2_ParseFrame
//  161 			FrameStart = 0;
        LDR.W    R0,??DataTable17_9
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  162 		}
//  163 		
//  164 		//当缓冲数据溢出时（接收数据里有错误会导致这种后果）
//  165 		if (RecvIndex>=RAWBUF_LEN) 
??UART2_ParseData_4:
        LDR.W    R0,??DataTable17_12
        LDR      R0,[R0, #+0]
        CMP      R0,#+128
        BLT.N    ??UART2_ParseData_2
//  166 		{
//  167 			FrameStart = 0;
        LDR.W    R0,??DataTable17_9
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  168 			RecvIndex = 0;
        LDR.W    R0,??DataTable17_12
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  169 			return;
        B.N      ??UART2_ParseData_1
//  170 		}
//  171 	}
//  172 //	else
//  173 		lastRecv=data;
??UART2_ParseData_2:
        LDR.W    R0,??DataTable17_10
        STRB     R4,[R0, #+0]
//  174 }
??UART2_ParseData_1:
        POP      {R4,PC}          ;; return

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
??RecvIndex:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
??lastRecv:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
??FrameStart:
        DS8 1

        SECTION `.data`:DATA:REORDER:NOROOT(2)
??FrameLength:
        DATA
        DC32 3
//  175 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  176 void U16ToU8(u16 inSrc,u8* inTar)
//  177 {
//  178 	*inTar = (u8)0xff & (inSrc>>8);
U16ToU8:
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R2,R0,#+8
        STRB     R2,[R1, #+0]
//  179 	*(inTar+1) = (u8)0xff & inSrc;
        STRB     R0,[R1, #+1]
//  180 }
        BX       LR               ;; return
//  181 
//  182  /****************************************************************************************************
//  183  发送数值
//  184  *****************************************************************************************************/
//  185 //将AD值返送回上位机

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  186 void UART2_SendADs(u16 inDestAddr,int inNum,u16* inADs)
//  187 {
UART2_SendADs:
        PUSH     {R3-R5,LR}
        MOVS     R4,R1
        MOVS     R5,R2
//  188 	SendBuf[0] = 0x55;	
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+85
        STRB     R2,[R1, #+0]
//  189 	SendBuf[1] = 0xaa;
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+170
        STRB     R2,[R1, #+1]
//  190 	SendBuf[2] = 0x29; 		//包长
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+41
        STRB     R2,[R1, #+2]
//  191 
//  192 	for(i=3;i<35;i++)
        LDR.W    R1,??DataTable17_1
        MOVS     R2,#+3
        STR      R2,[R1, #+0]
        B.N      ??UART2_SendADs_0
//  193 	{
//  194 		SendBuf[i] = 0;
??UART2_SendADs_1:
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable17_14
        MOVS     R3,#+0
        STRB     R3,[R1, R2]
//  195 	}
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        ADDS     R1,R1,#+1
        LDR.W    R2,??DataTable17_1
        STR      R1,[R2, #+0]
??UART2_SendADs_0:
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        CMP      R1,#+35
        BLT.N    ??UART2_SendADs_1
//  196 
//  197 	//目标地址
//  198 	U16ToU8(inDestAddr,&SendBuf[3]);
        LDR.W    R1,??DataTable17_15
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       U16ToU8
//  199 
//  200 	//自己的地址
//  201 	U16ToU8(MyAddr,&SendBuf[5]);
        LDR.W    R1,??DataTable17_16
        LDR.W    R0,??DataTable17_4
        LDRH     R0,[R0, #+0]
        BL       U16ToU8
//  202 	
//  203 	SendBuf[7] = 0x02;		//AD
        LDR.W    R0,??DataTable17_14
        MOVS     R1,#+2
        STRB     R1,[R0, #+7]
//  204 
//  205  	for(i=0;i<inNum;i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendADs_2
//  206 	{
//  207 		U16ToU8(inADs[i],&SendBuf[8+i*2]);
??UART2_SendADs_3:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R1,R0, LSL #+1
        ADDS     R1,R0,#+8
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDRH     R0,[R5, R0, LSL #+1]
        BL       U16ToU8
//  208 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendADs_2:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        CMP      R0,R4
        BLT.N    ??UART2_SendADs_3
//  209 
//  210 	//校验和
//  211 	SendBuf[SendBuf[2]-1] = 0;
        LDR.W    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        MOVS     R1,#+0
        STRB     R1,[R0, #-1]
//  212 	for(i=0;i<SendBuf[2]-1;i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendADs_4
//  213 	{
//  214 		SendBuf[SendBuf[2]-1] += SendBuf[i];	
??UART2_SendADs_5:
        LDR.W    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        LDRB     R0,[R0, #-1]
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable17_14
        LDRB     R1,[R1, R2]
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        LDR.W    R2,??DataTable17_14
        ADDS     R1,R1,R2
        STRB     R0,[R1, #-1]
//  215 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendADs_4:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        CMP      R0,R1
        BLT.N    ??UART2_SendADs_5
//  216 
//  217 	//发送
//  218 	for(i=0;i<SendBuf[2];i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendADs_6
//  219 	{
//  220 		UP_UART2_Putc(SendBuf[i]);
??UART2_SendADs_7:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R0,[R0, R1]
        BL       UP_UART2_Putc
//  221 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendADs_6:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        CMP      R0,R1
        BLT.N    ??UART2_SendADs_7
//  222 }
        POP      {R0,R4,R5,PC}    ;; return
//  223 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  224 void UART2_SendInfo(u16 inDestAddr,int inNum,u8* inInfo)
//  225 {
UART2_SendInfo:
        PUSH     {R3-R5,LR}
        MOVS     R4,R1
        MOVS     R5,R2
//  226 	SendBuf[0] = 0x55;	
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+85
        STRB     R2,[R1, #+0]
//  227 	SendBuf[1] = 0xaa;
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+170
        STRB     R2,[R1, #+1]
//  228 	SendBuf[2] = inNum + 9; 		//包长
        ADDS     R1,R4,#+9
        LDR.W    R2,??DataTable17_14
        STRB     R1,[R2, #+2]
//  229 
//  230 	//目标地址
//  231 	U16ToU8(inDestAddr,&SendBuf[3]);
        LDR.W    R1,??DataTable17_15
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       U16ToU8
//  232 
//  233 	//自己的地址
//  234 	U16ToU8(MyAddr,&SendBuf[5]);
        LDR.W    R1,??DataTable17_16
        LDR.W    R0,??DataTable17_4
        LDRH     R0,[R0, #+0]
        BL       U16ToU8
//  235 
//  236 	SendBuf[7] = 0xff;		//info
        LDR.W    R0,??DataTable17_14
        MOVS     R1,#+255
        STRB     R1,[R0, #+7]
//  237 	
//  238  	for(i=0;i<inNum;i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendInfo_0
//  239 	{
//  240 		SendBuf[8+i] = inInfo[i];
??UART2_SendInfo_1:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, R5]
        STRB     R1,[R0, #+8]
//  241 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendInfo_0:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        CMP      R0,R4
        BLT.N    ??UART2_SendInfo_1
//  242 
//  243 	//校验和
//  244 	SendBuf[SendBuf[2]-1] = 0;
        LDR.W    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        MOVS     R1,#+0
        STRB     R1,[R0, #-1]
//  245 	for(i=0;i<SendBuf[2]-1;i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendInfo_2
//  246 	{
//  247 		SendBuf[SendBuf[2]-1] += SendBuf[i];	
??UART2_SendInfo_3:
        LDR.W    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        LDRB     R0,[R0, #-1]
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable17_14
        LDRB     R1,[R1, R2]
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        LDR.W    R2,??DataTable17_14
        ADDS     R1,R1,R2
        STRB     R0,[R1, #-1]
//  248 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendInfo_2:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        CMP      R0,R1
        BLT.N    ??UART2_SendInfo_3
//  249 
//  250 	//发送
//  251 	for(i=0;i<SendBuf[2];i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendInfo_4
//  252 	{
//  253 		UP_UART2_Putc(SendBuf[i]);
??UART2_SendInfo_5:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R0,[R0, R1]
        BL       UP_UART2_Putc
//  254 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendInfo_4:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        CMP      R0,R1
        BLT.N    ??UART2_SendInfo_5
//  255 }
        POP      {R0,R4,R5,PC}    ;; return
//  256 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  257 void UART2_SendRobotState(u16 inDestAddr,u8 inPos,u8 inNext,u8 inHeadFor )
//  258 {
UART2_SendRobotState:
        PUSH     {R4-R6,LR}
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
//  259 	SendBuf[0] = 0x55;	
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+85
        STRB     R2,[R1, #+0]
//  260 	SendBuf[1] = 0xaa;
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+170
        STRB     R2,[R1, #+1]
//  261 	SendBuf[2] = 0x0c; 		//包长
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+12
        STRB     R2,[R1, #+2]
//  262 
//  263 	//目标地址
//  264 	U16ToU8(inDestAddr,&SendBuf[3]);
        LDR.W    R1,??DataTable17_15
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       U16ToU8
//  265 
//  266 	//自己的地址
//  267 	U16ToU8(MyAddr,&SendBuf[5]);
        LDR.W    R1,??DataTable17_16
        LDR.W    R0,??DataTable17_4
        LDRH     R0,[R0, #+0]
        BL       U16ToU8
//  268 
//  269 	SendBuf[7] = 0x01;		//state
        LDR.W    R0,??DataTable17_14
        MOVS     R1,#+1
        STRB     R1,[R0, #+7]
//  270 	
//  271 	SendBuf[8] = inPos;
        LDR.W    R0,??DataTable17_14
        STRB     R4,[R0, #+8]
//  272 	SendBuf[9] =  inNext;
        LDR.W    R0,??DataTable17_14
        STRB     R5,[R0, #+9]
//  273 	SendBuf[10] =  inHeadFor;
        LDR.W    R0,??DataTable17_14
        STRB     R6,[R0, #+10]
//  274  	
//  275 
//  276 	//校验和
//  277 	SendBuf[SendBuf[2]-1] = 0;
        LDR.W    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        MOVS     R1,#+0
        STRB     R1,[R0, #-1]
//  278 	for(i=0;i<SendBuf[2]-1;i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendRobotState_0
//  279 	{
//  280 		SendBuf[SendBuf[2]-1] += SendBuf[i];	
??UART2_SendRobotState_1:
        LDR.W    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        LDRB     R0,[R0, #-1]
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable17_14
        LDRB     R1,[R1, R2]
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        LDR.W    R2,??DataTable17_14
        ADDS     R1,R1,R2
        STRB     R0,[R1, #-1]
//  281 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendRobotState_0:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        CMP      R0,R1
        BLT.N    ??UART2_SendRobotState_1
//  282 
//  283 	//发送
//  284 	for(i=0;i<SendBuf[2];i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendRobotState_2
//  285 	{
//  286 		UP_UART2_Putc(SendBuf[i]);
??UART2_SendRobotState_3:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R0,[R0, R1]
        BL       UP_UART2_Putc
//  287 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendRobotState_2:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        CMP      R0,R1
        BLT.N    ??UART2_SendRobotState_3
//  288 }
        POP      {R4-R6,PC}       ;; return
//  289 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  290 void UART2_SendCardUID(u16 inDestAddr,u8* inUID)
//  291 {
UART2_SendCardUID:
        PUSH     {R4,LR}
        MOVS     R4,R1
//  292 	SendBuf[0] = 0x55;	
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+85
        STRB     R2,[R1, #+0]
//  293 	SendBuf[1] = 0xaa;
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+170
        STRB     R2,[R1, #+1]
//  294 	SendBuf[2] = 0x0D; 		//包长
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+13
        STRB     R2,[R1, #+2]
//  295 
//  296 	//目标地址
//  297 	U16ToU8(inDestAddr,&SendBuf[3]);
        LDR.W    R1,??DataTable17_15
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       U16ToU8
//  298 
//  299 	//自己的地址
//  300 	U16ToU8(MyAddr,&SendBuf[5]);
        LDR.W    R1,??DataTable17_16
        LDR.W    R0,??DataTable17_4
        LDRH     R0,[R0, #+0]
        BL       U16ToU8
//  301 
//  302 	SendBuf[7] = 0x03;		//Card UID
        LDR.W    R0,??DataTable17_14
        MOVS     R1,#+3
        STRB     R1,[R0, #+7]
//  303 	
//  304  	for(i=0;i<4;i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendCardUID_0
//  305 	{
//  306 		SendBuf[8+i] = inUID[i];
??UART2_SendCardUID_1:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, R4]
        STRB     R1,[R0, #+8]
//  307 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendCardUID_0:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        CMP      R0,#+4
        BLT.N    ??UART2_SendCardUID_1
//  308 
//  309 	//校验和
//  310 	SendBuf[SendBuf[2]-1] = 0;
        LDR.W    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        MOVS     R1,#+0
        STRB     R1,[R0, #-1]
//  311 	for(i=0;i<SendBuf[2]-1;i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendCardUID_2
//  312 	{
//  313 		SendBuf[SendBuf[2]-1] += SendBuf[i];	
??UART2_SendCardUID_3:
        LDR.W    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R0,R1
        LDRB     R0,[R0, #-1]
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR.W    R2,??DataTable17_14
        LDRB     R1,[R1, R2]
        ADDS     R0,R1,R0
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        LDR.W    R2,??DataTable17_14
        ADDS     R1,R1,R2
        STRB     R0,[R1, #-1]
//  314 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendCardUID_2:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        CMP      R0,R1
        BLT.N    ??UART2_SendCardUID_3
//  315 
//  316 	//发送
//  317 	for(i=0;i<SendBuf[2];i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendCardUID_4
//  318 	{
//  319 		UP_UART2_Putc(SendBuf[i]);
??UART2_SendCardUID_5:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R0,[R0, R1]
        BL       UP_UART2_Putc
//  320 	}
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendCardUID_4:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        CMP      R0,R1
        BLT.N    ??UART2_SendCardUID_5
//  321 }
        POP      {R4,PC}          ;; return
//  322 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  323 void UART2_SendPathPoint(u16 inDestAddr,int* inPathx,int* inPathy,int inNum)
//  324 {
UART2_SendPathPoint:
        PUSH     {R4-R6,LR}
        MOVS     R4,R1
        MOVS     R5,R2
        MOVS     R6,R3
//  325 	SendBuf[0] = 0x55;	
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+85
        STRB     R2,[R1, #+0]
//  326 	SendBuf[1] = 0xaa;
        LDR.W    R1,??DataTable17_14
        MOVS     R2,#+170
        STRB     R2,[R1, #+1]
//  327 	SendBuf[2] = (u8)inNum*2 + 9; 		//包长
        MOVS     R1,R6
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R1,R1,#+1
        ADDS     R1,R1,#+9
        LDR.W    R2,??DataTable17_14
        STRB     R1,[R2, #+2]
//  328 
//  329 	//目标地址
//  330 	U16ToU8(inDestAddr,&SendBuf[3]);
        LDR.W    R1,??DataTable17_15
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       U16ToU8
//  331 
//  332 	//自己的地址
//  333 	U16ToU8(MyAddr,&SendBuf[5]);
        LDR.W    R1,??DataTable17_16
        LDR.W    R0,??DataTable17_4
        LDRH     R0,[R0, #+0]
        BL       U16ToU8
//  334 
//  335 	SendBuf[7] = 0x04;		//路径点
        LDR.W    R0,??DataTable17_14
        MOVS     R1,#+4
        STRB     R1,[R0, #+7]
//  336 	
//  337  	for(i=0;i<inNum;i++)
        LDR.W    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendPathPoint_0
//  338 	{
//  339 		SendBuf[8+2*i] = (u8)inPathx[i];
??UART2_SendPathPoint_1:
        LDR.W    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R1,R0, LSL #+1
        LDR.W    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR      R1,[R4, R1, LSL #+2]
        STRB     R1,[R0, #+8]
//  340 		SendBuf[8+2*i+1] = (u8)inPathy[i];
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.W    R1,??DataTable17_14
        ADDS     R0,R1,R0, LSL #+1
        LDR.N    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR      R1,[R5, R1, LSL #+2]
        STRB     R1,[R0, #+9]
//  341 	}
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendPathPoint_0:
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        CMP      R0,R6
        BLT.N    ??UART2_SendPathPoint_1
//  342 
//  343 	//校验和
//  344 	SendBuf[SendBuf[2]-1] = 0;
        LDR.N    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.N    R1,??DataTable17_14
        ADDS     R0,R0,R1
        MOVS     R1,#+0
        STRB     R1,[R0, #-1]
//  345 	for(i=0;i<SendBuf[2]-1;i++)
        LDR.N    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendPathPoint_2
//  346 	{
//  347 		SendBuf[SendBuf[2]-1] += SendBuf[i];	
??UART2_SendPathPoint_3:
        LDR.N    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.N    R1,??DataTable17_14
        ADDS     R0,R0,R1
        LDRB     R0,[R0, #-1]
        LDR.N    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR.N    R2,??DataTable17_14
        LDRB     R1,[R1, R2]
        ADDS     R0,R1,R0
        LDR.N    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        LDR.N    R2,??DataTable17_14
        ADDS     R1,R1,R2
        STRB     R0,[R1, #-1]
//  348 	}
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendPathPoint_2:
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        CMP      R0,R1
        BLT.N    ??UART2_SendPathPoint_3
//  349 
//  350 	//发送
//  351 	for(i=0;i<SendBuf[2];i++)
        LDR.N    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendPathPoint_4
//  352 	{
//  353 		UP_UART2_Putc(SendBuf[i]);
??UART2_SendPathPoint_5:
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable17_14
        LDRB     R0,[R0, R1]
        BL       UP_UART2_Putc
//  354 	}
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendPathPoint_4:
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        CMP      R0,R1
        BLT.N    ??UART2_SendPathPoint_5
//  355 }
        POP      {R4-R6,PC}       ;; return
//  356 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  357 void UART2_SendMap(u16 inDestAddr,u8* indata,u8 inLen)
//  358 {
UART2_SendMap:
        PUSH     {R3-R5,LR}
        MOVS     R4,R1
        MOVS     R5,R2
//  359 	SendBuf[0] = 0x55;	
        LDR.N    R1,??DataTable17_14
        MOVS     R2,#+85
        STRB     R2,[R1, #+0]
//  360 	SendBuf[1] = 0xaa;
        LDR.N    R1,??DataTable17_14
        MOVS     R2,#+170
        STRB     R2,[R1, #+1]
//  361 	SendBuf[2] = inLen + 9; 		//包长
        LDR.N    R1,??DataTable17_14
        ADDS     R2,R5,#+9
        STRB     R2,[R1, #+2]
//  362 
//  363 	//目标地址
//  364 	U16ToU8(inDestAddr,&SendBuf[3]);
        LDR.N    R1,??DataTable17_15
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       U16ToU8
//  365 
//  366 	//自己的地址
//  367 	U16ToU8(MyAddr,&SendBuf[5]);
        LDR.N    R1,??DataTable17_16
        LDR.N    R0,??DataTable17_4
        LDRH     R0,[R0, #+0]
        BL       U16ToU8
//  368 
//  369 	SendBuf[7] = 0x05;		//路径点
        LDR.N    R0,??DataTable17_14
        MOVS     R1,#+5
        STRB     R1,[R0, #+7]
//  370 	
//  371  	for(i=0;i<inLen;i++)
        LDR.N    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendMap_0
//  372 	{
//  373 		SendBuf[8+i] = indata[i];
??UART2_SendMap_1:
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable17_14
        ADDS     R0,R0,R1
        LDR.N    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDRB     R1,[R1, R4]
        STRB     R1,[R0, #+8]
//  374 	}
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendMap_0:
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R0,R5
        BLT.N    ??UART2_SendMap_1
//  375 
//  376 	//校验和
//  377 	SendBuf[SendBuf[2]-1] = 0;
        LDR.N    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.N    R1,??DataTable17_14
        ADDS     R0,R0,R1
        MOVS     R1,#+0
        STRB     R1,[R0, #-1]
//  378 	for(i=0;i<SendBuf[2]-1;i++)
        LDR.N    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendMap_2
//  379 	{
//  380 		SendBuf[SendBuf[2]-1] += SendBuf[i];	
??UART2_SendMap_3:
        LDR.N    R0,??DataTable17_14
        LDRB     R0,[R0, #+2]
        LDR.N    R1,??DataTable17_14
        ADDS     R0,R0,R1
        LDRB     R0,[R0, #-1]
        LDR.N    R1,??DataTable17_1
        LDR      R1,[R1, #+0]
        LDR.N    R2,??DataTable17_14
        LDRB     R1,[R1, R2]
        ADDS     R0,R1,R0
        LDR.N    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        LDR.N    R2,??DataTable17_14
        ADDS     R1,R1,R2
        STRB     R0,[R1, #-1]
//  381 	}
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendMap_2:
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        CMP      R0,R1
        BLT.N    ??UART2_SendMap_3
//  382 
//  383 	//发送
//  384 	for(i=0;i<SendBuf[2];i++)
        LDR.N    R0,??DataTable17_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
        B.N      ??UART2_SendMap_4
//  385 	{
//  386 		UP_UART2_Putc(SendBuf[i]);
??UART2_SendMap_5:
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable17_14
        LDRB     R0,[R0, R1]
        BL       UP_UART2_Putc
//  387 	}
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable17_1
        STR      R0,[R1, #+0]
??UART2_SendMap_4:
        LDR.N    R0,??DataTable17_1
        LDR      R0,[R0, #+0]
        LDR.N    R1,??DataTable17_14
        LDRB     R1,[R1, #+2]
        CMP      R0,R1
        BLT.N    ??UART2_SendMap_5
//  388 }
        POP      {R0,R4,R5,PC}    ;; return
//  389  /****************************************************************************************************
//  390  RFID解析
//  391  *****************************************************************************************************/
//  392 static u8 rfParseBuf[32];
//  393 static u8 rfRecvIndex = 0;

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  394 static CycleBuf rfidBuf;
rfidBuf:
        DS8 260

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  395 unsigned char Card[4]={0,0,0,0};
Card:
        DS8 4
//  396 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  397 void BufRFID(u8 inData)
//  398 {
BufRFID:
        PUSH     {R7,LR}
//  399 	  Cyc_PutIn(&rfidBuf,inData);
        MOVS     R1,R0
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.N    R0,??DataTable17_17
        BL       Cyc_PutIn
//  400 }
        POP      {R0,PC}          ;; return
//  401 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  402 unsigned char Xor(unsigned char *data,int len)
//  403 {
`Xor`:
        PUSH     {R4}
//  404    unsigned char result=0;
        MOVS     R2,#+0
//  405    int i;
//  406    for(i=0;i<len;i++)
        MOVS     R3,#+0
        B.N      ??Xor_0
//  407    {
//  408      result^=data[i];
??Xor_1:
        LDRB     R4,[R3, R0]
        EORS     R2,R4,R2
//  409    }
        ADDS     R3,R3,#+1
??Xor_0:
        CMP      R3,R1
        BLT.N    ??Xor_1
//  410    return result;
        MOVS     R0,R2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4}
        BX       LR               ;; return
//  411 }

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  412 unsigned char FrameStart=0;
FrameStart:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  413 unsigned char Buf[48];
Buf:
        DS8 48

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  414 unsigned char  RecvIndex=0;
RecvIndex:
        DS8 1
//  415 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  416 void Parse_RFID(unsigned char in)
//  417 {
Parse_RFID:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  418 int i;
//  419 	 if ( FrameStart == 0)		//接收的数据
        LDR.N    R0,??DataTable17_18
        LDRB     R0,[R0, #+0]
        CMP      R0,#+0
        BNE.N    ??Parse_RFID_0
//  420     {
//  421       FrameStart = 1;			//表示接收到了 BD 开始标记
        LDR.N    R0,??DataTable17_18
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  422       Buf[0] = in;
        LDR.N    R0,??DataTable17_19
        STRB     R4,[R0, #+0]
//  423       RecvIndex = 1;			//已经缓冲了1个字节的数据
        LDR.N    R0,??DataTable17_20
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  424       return;
        B.N      ??Parse_RFID_1
//  425     }
//  426     
//  427     if(RecvIndex==5)                //错误纠正
??Parse_RFID_0:
        LDR.N    R0,??DataTable17_20
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??Parse_RFID_2
//  428     {
//  429       for(i=0;i<4;i++)
        MOVS     R0,#+0
        B.N      ??Parse_RFID_3
//  430       {
//  431         Buf[i]=Buf[i+1];
??Parse_RFID_4:
        LDR.N    R1,??DataTable17_19
        ADDS     R1,R0,R1
        LDRB     R1,[R1, #+1]
        LDR.N    R2,??DataTable17_19
        STRB     R1,[R0, R2]
//  432       }
        ADDS     R0,R0,#+1
??Parse_RFID_3:
        CMP      R0,#+4
        BLT.N    ??Parse_RFID_4
//  433       if(in==Xor(Buf,4))
        MOVS     R1,#+4
        LDR.N    R0,??DataTable17_19
        BL       `Xor`
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,R0
        BNE.N    ??Parse_RFID_5
//  434       {
//  435         for(i=0;i<4;i++)
        MOVS     R0,#+0
        B.N      ??Parse_RFID_6
//  436         {
//  437           Card[i]=Buf[i];
??Parse_RFID_7:
        LDR.N    R1,??DataTable17_21
        LDR.N    R2,??DataTable17_19
        LDRB     R2,[R0, R2]
        STRB     R2,[R0, R1]
//  438         }       
        ADDS     R0,R0,#+1
??Parse_RFID_6:
        CMP      R0,#+4
        BLT.N    ??Parse_RFID_7
//  439       }
//  440       RecvIndex=0;
??Parse_RFID_5:
        LDR.N    R0,??DataTable17_20
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  441       FrameStart=0;
        LDR.N    R0,??DataTable17_18
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  442       return;
        B.N      ??Parse_RFID_1
//  443       
//  444     }
//  445     if (FrameStart == 1)
??Parse_RFID_2:
        LDR.N    R0,??DataTable17_18
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE.N    ??Parse_RFID_8
//  446     {      
//  447       //将接收的数据拷贝到缓冲数组里
//  448       Buf[RecvIndex]=in;
        LDR.N    R0,??DataTable17_20
        LDRB     R0,[R0, #+0]
        LDR.N    R1,??DataTable17_19
        STRB     R4,[R0, R1]
//  449       RecvIndex++;
        LDR.N    R0,??DataTable17_20
        LDRB     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.N    R1,??DataTable17_20
        STRB     R0,[R1, #+0]
//  450       
//  451       //通过接收数据长度来判断是否满一帧
//  452       if ((RecvIndex == 5)&&(Buf[4]==Xor(Buf,4)))
        LDR.N    R0,??DataTable17_20
        LDRB     R0,[R0, #+0]
        CMP      R0,#+5
        BNE.N    ??Parse_RFID_9
        MOVS     R1,#+4
        LDR.N    R0,??DataTable17_19
        BL       `Xor`
        LDR.N    R1,??DataTable17_19
        LDRB     R1,[R1, #+4]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R1,R0
        BNE.N    ??Parse_RFID_9
//  453       { 
//  454         for(i=0;i<4;i++)
        MOVS     R0,#+0
        B.N      ??Parse_RFID_10
//  455         {
//  456           Card[i]=Buf[i];
??Parse_RFID_11:
        LDR.N    R1,??DataTable17_21
        LDR.N    R2,??DataTable17_19
        LDRB     R2,[R0, R2]
        STRB     R2,[R0, R1]
//  457         }
        ADDS     R0,R0,#+1
??Parse_RFID_10:
        CMP      R0,#+4
        BLT.N    ??Parse_RFID_11
//  458 //        UART0SendCharArray(packet_data,4);
//  459         RecvIndex=0;
        LDR.N    R0,??DataTable17_20
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  460       }
//  461       
//  462       //当缓冲数据溢出时（接收数据里有错误会导致这种后果）
//  463       if (RecvIndex>=48) 
??Parse_RFID_9:
        LDR.N    R0,??DataTable17_20
        LDRB     R0,[R0, #+0]
        CMP      R0,#+48
        BCC.N    ??Parse_RFID_8
//  464       {
//  465         FrameStart = 0;
        LDR.N    R0,??DataTable17_18
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  466       }
//  467     }
//  468 }
??Parse_RFID_8:
??Parse_RFID_1:
        POP      {R4,PC}          ;; return
//  469 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  470 void ParseRFIDData()
//  471 {
ParseRFIDData:
        PUSH     {R7,LR}
//  472 	u8 temp = 0;
        MOVS     R0,#+0
        STRB     R0,[SP, #+0]
//  473 	u8 result = 0;
        MOVS     R0,#+0
        B.N      ??ParseRFIDData_0
//  474 	while(1)
//  475 	{
//  476 		result =  Cyc_Get(&rfidBuf,&temp);
//  477 		if(result > 0)
//  478 		{
//  479 			Parse_RFID(temp);
??ParseRFIDData_1:
        LDRB     R0,[SP, #+0]
        BL       Parse_RFID
//  480 		}
??ParseRFIDData_0:
        ADD      R1,SP,#+0
        LDR.N    R0,??DataTable17_17
        BL       Cyc_Get
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BCS.N    ??ParseRFIDData_1
//  481 		else
//  482 		{
//  483 			break;
//  484 		}
//  485 	}
//  486 }
        POP      {R0,PC}          ;; return
//  487 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  488 int GetCardUID(u8* inBuf)
//  489 {
GetCardUID:
        PUSH     {R4}
//  490 	int res = 0	;
        MOVS     R1,#+0
//  491 	for(i=0;i<4;i++)
        LDR.N    R2,??DataTable17_1
        MOVS     R3,#+0
        STR      R3,[R2, #+0]
        B.N      ??GetCardUID_0
//  492 	{
//  493 		inBuf[i] = Card[i];
??GetCardUID_1:
        LDR.N    R2,??DataTable17_1
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable17_1
        LDR      R3,[R3, #+0]
        LDR.N    R4,??DataTable17_21
        LDRB     R3,[R3, R4]
        STRB     R3,[R2, R0]
//  494 		if(Card[i] != 0)
        LDR.N    R2,??DataTable17_1
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable17_21
        LDRB     R2,[R2, R3]
        CMP      R2,#+0
        BEQ.N    ??GetCardUID_2
//  495 		{
//  496 			res = 1;
        MOVS     R1,#+1
//  497 			Card[i] = 0;
        LDR.N    R2,??DataTable17_1
        LDR      R2,[R2, #+0]
        LDR.N    R3,??DataTable17_21
        MOVS     R4,#+0
        STRB     R4,[R2, R3]
//  498 		}
//  499 	}
??GetCardUID_2:
        LDR.N    R2,??DataTable17_1
        LDR      R2,[R2, #+0]
        ADDS     R2,R2,#+1
        LDR.N    R3,??DataTable17_1
        STR      R2,[R3, #+0]
??GetCardUID_0:
        LDR.N    R2,??DataTable17_1
        LDR      R2,[R2, #+0]
        CMP      R2,#+4
        BLT.N    ??GetCardUID_1
//  500 	return res;
        MOVS     R0,R1
        POP      {R4}
        BX       LR               ;; return
//  501 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17:
        DC32     RobotAction

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_1:
        DC32     i

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_2:
        DC32     FieldSensors

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_3:
        DC32     DestPos

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_4:
        DC32     MyAddr

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_5:
        DC32     pPut

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_6:
        DC32     pTail

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_7:
        DC32     pHead

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_8:
        DC32     pGet

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_9:
        DC32     ??FrameStart

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_10:
        DC32     ??lastRecv

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_11:
        DC32     ParseBuf

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_12:
        DC32     ??RecvIndex

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_13:
        DC32     ??FrameLength

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_14:
        DC32     SendBuf

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_15:
        DC32     SendBuf+0x3

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_16:
        DC32     SendBuf+0x5

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_17:
        DC32     rfidBuf

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_18:
        DC32     FrameStart

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_19:
        DC32     Buf

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_20:
        DC32     RecvIndex

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable17_21:
        DC32     Card
//  502 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  503 void LCD_DisplayFieldSensors(void)
//  504 {
//  505 	/*UP_LCD_ShowInt(0,1,FieldSensors[0]);
//  506 	UP_LCD_ShowInt(0,2,FieldSensors[1]);
//  507 	UP_LCD_ShowInt(0,3,FieldSensors[2]);
//  508 
//  509 	UP_LCD_ShowInt(7,1,FieldSensors[3]);
//  510 	UP_LCD_ShowInt(4,2,FieldSensors[4]);
//  511 	UP_LCD_ShowInt(10,2,FieldSensors[5]);
//  512 	UP_LCD_ShowInt(7,3,FieldSensors[6]);
//  513 
//  514 	UP_LCD_ShowInt(14,1,FieldSensors[7]);
//  515 	UP_LCD_ShowInt(14,2,FieldSensors[8]);
//  516 	UP_LCD_ShowInt(14,3,FieldSensors[9]);
//  517 	
//  518 	if(RobotAction == 1)
//  519 	{
//  520 		UP_LCD_ShowLetter(7,2,'A');
//  521 	}
//  522 	else
//  523 	{
//  524 		UP_LCD_ShowLetter(7,2,'S');
//  525 	}*/
//  526 }
LCD_DisplayFieldSensors:
        BX       LR               ;; return

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  527 
// 
//   658 bytes in section .bss
//    22 bytes in section .data
// 2 626 bytes in section .text
// 
// 2 626 bytes of CODE memory
//   680 bytes of DATA memory
//
//Errors: none
//Warnings: 9
