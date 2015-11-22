/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_I2C.h
 * 用途: I2C底层模块相关函数
 * 最后修改日期: 20120402
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */

#ifndef __HAL_I2C_H__
#define __HAL_I2C_H__
/********************************************************************/

#define I2C_SCL_50KHZ                   0
#define I2C_SCL_100KHZ                  1
#define I2C_SCL_150KHZ                  2
#define I2C_SCL_200KHZ                  3
#define I2C_SCL_250KHZ                  4
#define I2C_SCL_300KHZ                  5

#define I2C_ACK_OFF                     0
#define I2C_ACK_ON                      1

#define I2C_MWSR                        0x00  //主设备写
#define I2C_MRSW                        0x01  //主设备读

#define LPLD_I2C_MWSR                   I2C_MWSR  
#define LPLD_I2C_MRSW                   I2C_MRSW  

uint8 LPLD_I2C_Init(I2Cx, uint8, uint8);
void LPLD_I2C_Start(I2Cx);
void LPLD_I2C_Stop(I2Cx);
void LPLD_I2C_WaitAck(I2Cx, uint8);
void LPLD_I2C_ReStart(I2Cx);
void LPLD_I2C_Write(I2Cx, uint8);
uint8 LPLD_I2C_Read(I2Cx);
void LPLD_I2C_SetMasterWR(I2Cx, uint8);
void LPLD_I2C_StartTrans(I2Cx, uint8, uint8);

#endif /* __HAL_I2C_H__ */
