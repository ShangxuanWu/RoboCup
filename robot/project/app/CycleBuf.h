
#define CYC_BUF_MAX	256
typedef struct
{
	unsigned char buf[CYC_BUF_MAX];
	unsigned char get;
	unsigned char put;
}CycleBuf;

/************************  结构体初始化  ****************************/
void Cyc_Init(CycleBuf* inCB);

/************************  将数据放进缓冲区  ****************************/
void Cyc_PutIn(CycleBuf* inCB,unsigned char inData);

/************************  将数据放进缓冲区  ****************************/
unsigned char Cyc_Get(CycleBuf* inCB,unsigned char* inData);
