#ifndef __ZIGBEE_H
#define __ZIGBEE_H

void zigbee_init();

void zigbee_send_char(char c);

void zigbee_send_str(char* c,int len);

void zigbee_isr();

#endif