#include "zigbee.h"
#include "common.h"
#include "field_sensor.h"
#include "HAL_UART.h"

#define ZIGBEE_UART UART4
#define ZIGBEE_BAND 38400

#define BUFFER_SIZE 64

char zigbee_buffer[BUFFER_SIZE];
int zigbee_index=0;
int zigbee_read_index=0;
char rev_buff;

char rev_mode=0;
char rev_sensor_index=0;

void zigbee_isr()
{
	
  while(rev_buff=LPLD_UART_GetChar(ZIGBEE_UART))
  {
    zigbee_buffer[zigbee_index]=rev_buff;
    zigbee_index++;
    if(zigbee_index>=6)
      break;
  }
  for(int i=0;i<zigbee_index;i++)
  {
    if(rev_sensor_index!=0)
    {
      field_sensor_add(rev_sensor_index,zigbee_buffer[i]-'0');
      rev_mode=0;
      rev_sensor_index=0;
    }
     if(rev_mode=='$')
      rev_sensor_index=zigbee_buffer[i];
    if(zigbee_buffer[i]=='$')
    {
      rev_mode='$'; 
    }
  
    
  }
 
  zigbee_index=0;
}

void zigbee_init()
{
	LPLD_UART_Init(ZIGBEE_UART,ZIGBEE_BAND);  // zigbee使用38400波特率的串口
	LPLD_UART_RIE_Enable(ZIGBEE_UART, zigbee_isr);
}


void zigbee_send_char(char c)
{
	LPLD_UART_PutChar(ZIGBEE_UART,c);
}

void zigbee_send_str(char* c,int len)
{
	LPLD_UART_PutCharArr(ZIGBEE_UART,c,len);
}

char zigbee_read()
{
   if(zigbee_read_index>=64)zigbee_read_index=0;
   if(zigbee_read_index==zigbee_index) return -1;
   return zigbee_buffer[zigbee_read_index++];
}
