#include <EEPROM.h>
#define ULTRASONIC_NUM 2
#define EEPROM_STATUS 0
#define EEPROM_READY 23
#define SENSOR_INDEX_ADDRESS 1
#define ALARM_DISTANCE_ADDRESS 2
int echo[ULTRASONIC_NUM]={5,7}; //
int trig[ULTRASONIC_NUM]={6,8}; //

int led = 2;
#define LED_ON digitalWrite(2, HIGH)
#define LED_OFF digitalWrite(2, LOW)


char sensor_index = 'A'; //传感器编号 'A'~'Z'

int alarm_distance[ULTRASONIC_NUM]={25,25}; //警报距离，当超声波检测到距离小于该值发出警报

void load_config()
{
	if(EEPROM.read(EEPROM_STATUS)==EEPROM_READY)
	{
		sensor_index=EEPROM.read(SENSOR_INDEX_ADDRESS);
		for(int i=0;i<ULTRASONIC_NUM;i++)
		{
			alarm_distance[i]=EEPROM.read(ALARM_DISTANCE_ADDRESS+i);
		}
	}
}


void ultrasonic_init() //初始化超声波
{
	for(int i = 0; i < ULTRASONIC_NUM; i++)
	{
		pinMode(echo[i],INPUT);
		pinMode(trig[i],OUTPUT);
	}
}

int ultrasonic_get_distance(int i)//获取编号为i的超声波测到的距离
{
	digitalWrite(trig[i],LOW);
	delayMicroseconds(2);
	digitalWrite(trig[i],HIGH);
	delayMicroseconds(10);
	digitalWrite(trig[i],LOW);
	int distance = pulseIn(echo[i],HIGH);
	distance = distance/58;
	return distance;
}



void send_alarm(int i) //发送警报格式为 '$'['A']['1']
{
	Serial.print('$');
	Serial.print(sensor_index);
	Serial.print(i);
	Serial.flush(); //保证全部都发送出去
}


void send_sensor_status()
{

	//Serial.print('sensor index is');
	Serial.println(sensor_index);
	//Serial.print('alarm_distance is ');
	for(int i=0;i<ULTRASONIC_NUM;i++)
	{
		Serial.print(alarm_distance[i]);
		Serial.print(' ');
	}
	Serial.print('\n');
	Serial.flush();
}

bool check_ultrasonic(int i)
{
    if(alarm_distance[i]==0)return false; //如果警报距离是0就不启动超声波直接返回false;
	int temp_distance = ultrasonic_get_distance(i);
	if (temp_distance<2) return false; //返回的距离小于超声波最小测量距离
	if(temp_distance>alarm_distance[i])
	{	
		return false;
	}
	else
	{
		send_alarm(i);
		LED_ON;
		delay(100);
		LED_OFF;
		return true;
	}
}

void setup()
{
	load_config();
	ultrasonic_init();
	pinMode(led, OUTPUT);
	LED_OFF;
	Serial.begin(38400);
}

void loop()
{
	if(Serial.available()>0) //串口缓冲区接受到字符数目大于0
	{
		char mode = Serial.read();
		int  target_sensor=0;
        switch(mode)
		{
			case '@':
				  target_sensor=Serial.read();
				 if(target_sensor<0) break; //没收到有效数据
				 if(target_sensor==sensor_index)
				 {
					int new_senor_index = Serial.read();
					if(new_senor_index<0)break;
					if(new_senor_index>'Z' || new_senor_index<'A') break;
					EEPROM.write(SENSOR_INDEX_ADDRESS,new_senor_index);
					sensor_index = new_senor_index;
					EEPROM.write(EEPROM_STATUS,EEPROM_READY);
					send_sensor_status();
				 }
				break;
			case '$':
				break;
			case '#':
				 target_sensor = Serial.read();
				if(target_sensor<0)break;
				if(target_sensor==sensor_index)
				{
					int target_ultrasonic = Serial.read()-'0';
					if(target_ultrasonic<0) break;
					if(target_ultrasonic>9 || target_ultrasonic<0)break;
					int new_alarm_distance = Serial.parseInt();
					alarm_distance[target_ultrasonic]=new_alarm_distance;
					EEPROM.write(ALARM_DISTANCE_ADDRESS+target_ultrasonic,new_alarm_distance);
					send_sensor_status();
				}
				break;
			default:
				break;
		}
	}
	else
	{
		if(check_ultrasonic(0))return; //如果该超声波前有敌人发送信号并退出循环
		if(check_ultrasonic(1))return;

	}
}
