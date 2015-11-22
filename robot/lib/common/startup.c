/*
 * File:    startup.c
 * Purpose: Generic Kinetis startup code
 *
 * Notes:
 */

#include "common.h"

#if (defined(IAR))
	#pragma section = ".data"
	#pragma section = ".data_init"
	#pragma section = ".bss"
	#pragma section = "CodeRelocate"
	#pragma section = "CodeRelocateRam"
#endif

/********************************************************************/
void
common_startup(void)
{

#if (defined(CW))	
    extern char __START_BSS[];
    extern char __END_BSS[];
    extern uint32 __DATA_ROM[];
    extern uint32 __DATA_RAM[];
    extern char __DATA_END[];
#endif

    /* 声明一个计数器在拷贝循环中使用 */
    uint32 n;

    /* 为不同的数据段定义指针。
     * 这些变量将由链接文件中获取的值初始化
     */
    uint8 * data_ram, * data_rom, * data_rom_end;
    uint8 * bss_start, * bss_end;


    /* 引进链接文件中的VECTOR_TABLE和VECTOR_RAM的地址 */
    extern uint32 __VECTOR_TABLE[];
    extern uint32 __VECTOR_RAM[];

    /* 将中断向量表复制到RAM中 */
    if (__VECTOR_RAM != __VECTOR_TABLE)
    {
        for (n = 0; n < 0x410; n++)
            __VECTOR_RAM[n] = __VECTOR_TABLE[n];
    }
    /* 将新的中断向量表指针赋给VTOR寄存器 */
    write_vtor((uint32)__VECTOR_RAM);

    /* 获得.data段的地址(已初始化的数据段) */
	#if (defined(CW))
        data_ram = (uint8 *)__DATA_RAM;
	    data_rom = (uint8 *)__DATA_ROM;
	    data_rom_end  = (uint8 *)__DATA_END; /* 该段在CodeWarrior编译器中为RAM地址 */
	    n = data_rom_end - data_ram;
    #elif (defined(IAR))
		data_ram = __section_begin(".data");
		data_rom = __section_begin(".data_init");
		data_rom_end = __section_end(".data_init");
		n = data_rom_end - data_rom;
	#endif		
		
	/* 从ROM复制已初始化的数据到RAM */
	while (n--)
		*data_ram++ = *data_rom++;
	
	
    /* 获得.bss段的地址 (初始化为0的数据) */
	#if (defined(CW))
		bss_start = (uint8 *)__START_BSS;
		bss_end = (uint8 *)__END_BSS;
	#elif (defined(IAR))
		bss_start = __section_begin(".bss");
		bss_end = __section_end(".bss");
	#endif
		
		
	

    /* 清零初始化为0的数据段 */
    n = bss_end - bss_start;
    while(n--)
      *bss_start++ = 0;

	/* 取得所有应该从ROM复制到RAM的代码段的地址。
         * IAR有一个预定义的关键字可以标记独立的函数为从RAM执行。
         * 在函数的返回类型前添加"__ramfunc"关键字可以将函数标记为从RAM中执行。
         * 例如:__ramfunc void foo(void);
	 */
	#if (defined(IAR))
		uint8* code_relocate_ram = __section_begin("CodeRelocateRam");
		uint8* code_relocate = __section_begin("CodeRelocate");
		uint8* code_relocate_end = __section_end("CodeRelocate");

		/* 将函数从ROM复制到RAM */
		n = code_relocate_end - code_relocate;
		while (n--)
			*code_relocate_ram++ = *code_relocate++;
	#endif
}
/********************************************************************/
