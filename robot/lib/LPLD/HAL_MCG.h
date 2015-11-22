/*
 * --------------"拉普兰德K60底层库"-----------------
 *
 * 测试硬件平台:LPLD_K60 Card
 * 版权所有:北京拉普兰德电子技术有限公司
 * 网络销售:http://laplenden.taobao.com
 * 公司门户:http://www.lpld.cn
 *
 * 文件名: HAL_MCG.h
 * 用途: MCG底层模块相关函数
 * 最后修改日期: 20120216
 *
 * 开发者使用协议:
 *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
 *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
 *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
 */
#ifndef __HAL_MCG_H__
#define __HAL_MCG_H__
/********************************************************************/

unsigned char LPLD_PLL_Setup(unsigned char pll_option);
#if (defined(IAR))
	__ramfunc void LPLD_Set_SYS_DIV(uint32 outdiv1, uint32 outdiv2, uint32 outdiv3, uint32 outdiv4);
#elif (defined(CW))
	__relocate_code__ 
	void LPLD_Set_SYS_DIV(uint32 outdiv1, uint32 outdiv2, uint32 outdiv3, uint32 outdiv4);
#endif	
        
        
enum PLL_option
{
  PLL_60=60,
  PLL_70=70,
  PLL_80=80,
  PLL_90=90,
  PLL_96=96,
  PLL_100=100,
  PLL_110=110,
  PLL_120=120,
  PLL_130=130,
  PLL_150=150,
  PLL_170=170,
  PLL_180=180,
  PLL_200=200,
  PLL_209=209
};


#endif /* __HAL_MCG_H__ */