
#define CYC_BUF_MAX	256
typedef struct
{
	unsigned char buf[CYC_BUF_MAX];
	unsigned char get;
	unsigned char put;
}CycleBuf;

/************************  �ṹ���ʼ��  ****************************/
void Cyc_Init(CycleBuf* inCB);

/************************  �����ݷŽ�������  ****************************/
void Cyc_PutIn(CycleBuf* inCB,unsigned char inData);

/************************  �����ݷŽ�������  ****************************/
unsigned char Cyc_Get(CycleBuf* inCB,unsigned char* inData);
