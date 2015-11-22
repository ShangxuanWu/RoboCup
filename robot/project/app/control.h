#ifndef __CONTROL_H
#define __CONTROL_H

extern long TIME_PASSED;

#define CONTROL_COMMAND_COUNT 9
enum COMMAND {
  C_STOP = 0, C_AHEAD, C_RIGHT, C_LEFT, C_AROUND, C_GETCORNER, C_BREAK, C_START, C_LETSWIN
};

enum EVENT {
  E_ERROR = -1, E_NONE = 0, E_FINISHED, E_CROSS, E_ONCROSS
};

#define CONTROL_CALLBACK_FUNC_VAR(func, cmd, event) void (*func)(enum COMMAND, enum EVENT event)
#define CONTROL_CALLBACK_FUNC(func, cmd, event) void func(enum COMMAND cmd, enum EVENT event)

void control_init(void);
void control_set_callback(enum COMMAND command, CONTROL_CALLBACK_FUNC_VAR(func, cmd, event));
void control_call_callback(enum COMMAND command, enum EVENT event);
void control_enable(void);
void control_disable(void);

int control_get_distance(void);
void control_clear_distance(void);

int control_get_r1error(void);
int control_get_r2error(void);

_Bool control_get_carinfront(void);

_Bool control_can_interrupt(void);

int control_goahead(int);
int control_turnaround(void);
int control_turnleft(void);
int control_turnright(void);
int control_stop(void);
int control_getcorner(void);
int control_break(void);
int control_start(void);

int control_letswin(void);

void pit_isr0(); // 时钟中断5ms，电机控制
void pit_isr1(); // 100ms板闪灯
void uart1_recv_isr(void);
void uart2_recv_isr(void);
void uart3_recv_isr(void);
//void uart4_recv_isr(void);
void uart5_recv_isr(void);
/********************************************************************/
//void analyse(void);
//void control(void);
//void do_stop(void);
void left_set_v(int v);
void right_set_v(int v);

///////////////////////////////hao///////////////////////
//void fisrthongwaierror(void);//边沿跳变获得误差
//void secondhongwaierror(void);//边沿跳变获得误差
//void bluetooth(void);
//void sendblue(int,int);
void do_control(void);

void do_goahead(void);
void do_stop(void);
void do_getcorner(void);
void do_turnleft(void);
void do_turnright(void);
void do_turnaround(void);
void do_break(void);
void do_start(void);
void do_letswin(void);

#endif