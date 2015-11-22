#include "CycleBuf.h"

static int i;
/************************  �ṹ���ʼ��  ****************************/
void Cyc_Init(CycleBuf* inCB)
{
	inCB->put = 0;
	inCB->get = 0;
        
        for(i=0;i<CYC_BUF_MAX;i++)
        {
          inCB->buf[i] = 0;
        }
}

/************************  �����ݷŽ�������  ****************************/
void Cyc_PutIn(CycleBuf* inCB,unsigned char inData)
{
	inCB->buf[inCB->put] = inData;
	inCB->put ++;

	if(inCB->put >= CYC_BUF_MAX)
	{
	  inCB->put = 0;
	}
}

/************************  �����ݷŽ�������  ****************************/
unsigned char Cyc_Get(CycleBuf* inCB,unsigned char* inData)
{
  unsigned char result = 0;
  if(inCB->put != inCB->get)
  {
    *inData = inCB->buf[inCB->get];
    inCB->get ++;
    if(inCB->get >=CYC_BUF_MAX)
    {
      inCB->get = 0;
    }
    result = 1;
  }
  else
  {
    result = 0;
  }

  return result;
}

