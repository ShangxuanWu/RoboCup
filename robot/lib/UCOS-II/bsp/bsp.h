
/*
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: bsp.h
 * 用途: 包括UCOS系统的BSP（板级支持包）函数
 * 最后修改日期: 20120715
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#ifndef __BSP_H__
#define __BSP_H__
#include "common.h"

#include "bsp_int.h"

void LPLD_uCOS_bsp_Init(void);
void LPLD_uCOS_Register_K60Int(CPU_FNCT_VOID handler, uint32_t int_id);

#endif