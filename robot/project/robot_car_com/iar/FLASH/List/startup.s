///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:14:07 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\common\startup.c               /
//    Command line =  "F:\robot _init\robot\lib\common\startup.c" -D IAR -D   /
//                    LPLD_K60 -lCN "F:\robot _init\robot\project\robot_car_c /
//                    om\iar\FLASH\List\" -lB "F:\robot                       /
//                    _init\robot\project\robot_car_com\iar\FLASH\List\" -o   /
//                    "F:\robot _init\robot\project\robot_car_com\iar\FLASH\O /
//                    bj\" --no_cse --no_unroll --no_inline --no_code_motion  /
//                    --no_tbaa --no_clustering --no_scheduling --debug       /
//                    --endian=little --cpu=Cortex-M4 -e --fpu=None           /
//                    --dlib_config "D:\IAR Systems\Embedded Workbench        /
//                    6.4\arm\INC\c\DLib_Config_Normal.h" -I "F:\robot        /
//                    _init\robot\project\robot_car_com\iar\..\app\" -I       /
//                    "F:\robot _init\robot\project\robot_car_com\iar\..\..\. /
//                    .\lib\common\" -I "F:\robot                             /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\cpu\ /
//                    " -I "F:\robot _init\robot\project\robot_car_com\iar\.. /
//                    \..\..\lib\cpu\headers\" -I "F:\robot                   /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\adc16\" -I "F:\robot _init\robot\project\robot_car_ /
//                    com\iar\..\..\..\lib\drivers\enet\" -I "F:\robot        /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\lptmr\" -I "F:\robot _init\robot\project\robot_car_ /
//                    com\iar\..\..\..\lib\drivers\mcg\" -I "F:\robot         /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\pmc\" -I "F:\robot _init\robot\project\robot_car_co /
//                    m\iar\..\..\..\lib\drivers\rtc\" -I "F:\robot           /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\driv /
//                    ers\uart\" -I "F:\robot _init\robot\project\robot_car_c /
//                    om\iar\..\..\..\lib\drivers\wdog\" -I "F:\robot         /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\plat /
//                    forms\" -I "F:\robot _init\robot\project\robot_car_com\ /
//                    iar\..\..\..\lib\LPLD\" -I "F:\robot                    /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\LPLD /
//                    \FatFs\" -I "F:\robot _init\robot\project\robot_car_com /
//                    \iar\..\..\..\lib\LPLD\USB\" -I "F:\robot               /
//                    _init\robot\project\robot_car_com\iar\..\..\..\lib\iar_ /
//                    config_files\" -Ol                                      /
//    List file    =  F:\robot _init\robot\project\robot_car_com\iar\FLASH\Li /
//                    st\startup.s                                            /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME startup

        #define SHT_PROGBITS 0x1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION `.data`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION `.data_init`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION CodeRelocate:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0
        SECTION CodeRelocateRam:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        EXTERN __VECTOR_RAM
        EXTERN __VECTOR_TABLE
        EXTERN write_vtor

        PUBLIC common_startup

// F:\robot _init\robot\lib\common\startup.c
//    1 /*
//    2  * File:    startup.c
//    3  * Purpose: Generic Kinetis startup code
//    4  *
//    5  * Notes:
//    6  */
//    7 
//    8 #include "common.h"
//    9 
//   10 #if (defined(IAR))
//   11 	#pragma section = ".data"
//   12 	#pragma section = ".data_init"
//   13 	#pragma section = ".bss"
//   14 	#pragma section = "CodeRelocate"
//   15 	#pragma section = "CodeRelocateRam"
//   16 #endif
//   17 
//   18 /********************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   19 void
//   20 common_startup(void)
//   21 {
common_startup:
        PUSH     {R7,LR}
//   22 
//   23 #if (defined(CW))	
//   24     extern char __START_BSS[];
//   25     extern char __END_BSS[];
//   26     extern uint32 __DATA_ROM[];
//   27     extern uint32 __DATA_RAM[];
//   28     extern char __DATA_END[];
//   29 #endif
//   30 
//   31     /* 声明一个计数器在拷贝循环中使用 */
//   32     uint32 n;
//   33 
//   34     /* 为不同的数据段定义指针。
//   35      * 这些变量将由链接文件中获取的值初始化
//   36      */
//   37     uint8 * data_ram, * data_rom, * data_rom_end;
//   38     uint8 * bss_start, * bss_end;
//   39 
//   40 
//   41     /* 引进链接文件中的VECTOR_TABLE和VECTOR_RAM的地址 */
//   42     extern uint32 __VECTOR_TABLE[];
//   43     extern uint32 __VECTOR_RAM[];
//   44 
//   45     /* 将中断向量表复制到RAM中 */
//   46     if (__VECTOR_RAM != __VECTOR_TABLE)
        LDR.N    R0,??common_startup_0
        LDR.N    R1,??common_startup_0+0x4
        CMP      R0,R1
        BEQ.N    ??common_startup_1
//   47     {
//   48         for (n = 0; n < 0x410; n++)
        MOVS     R0,#+0
        B.N      ??common_startup_2
//   49             __VECTOR_RAM[n] = __VECTOR_TABLE[n];
??common_startup_3:
        LDR.N    R1,??common_startup_0
        LDR.N    R2,??common_startup_0+0x4
        LDR      R2,[R2, R0, LSL #+2]
        STR      R2,[R1, R0, LSL #+2]
        ADDS     R0,R0,#+1
??common_startup_2:
        CMP      R0,#+1040
        BCC.N    ??common_startup_3
//   50     }
//   51     /* 将新的中断向量表指针赋给VTOR寄存器 */
//   52     write_vtor((uint32)__VECTOR_RAM);
??common_startup_1:
        LDR.N    R0,??common_startup_0
        BL       write_vtor
//   53 
//   54     /* 获得.data段的地址(已初始化的数据段) */
//   55 	#if (defined(CW))
//   56         data_ram = (uint8 *)__DATA_RAM;
//   57 	    data_rom = (uint8 *)__DATA_ROM;
//   58 	    data_rom_end  = (uint8 *)__DATA_END; /* 该段在CodeWarrior编译器中为RAM地址 */
//   59 	    n = data_rom_end - data_ram;
//   60     #elif (defined(IAR))
//   61 		data_ram = __section_begin(".data");
        LDR.N    R1,??common_startup_0+0x8
//   62 		data_rom = __section_begin(".data_init");
        LDR.N    R2,??common_startup_0+0xC
//   63 		data_rom_end = __section_end(".data_init");
        LDR.N    R0,??common_startup_0+0x10
//   64 		n = data_rom_end - data_rom;
        SUBS     R0,R0,R2
        B.N      ??common_startup_4
//   65 	#endif		
//   66 		
//   67 	/* 从ROM复制已初始化的数据到RAM */
//   68 	while (n--)
//   69 		*data_ram++ = *data_rom++;
??common_startup_5:
        LDRB     R3,[R2, #+0]
        STRB     R3,[R1, #+0]
        ADDS     R2,R2,#+1
        ADDS     R1,R1,#+1
??common_startup_4:
        MOVS     R3,R0
        SUBS     R0,R3,#+1
        CMP      R3,#+0
        BNE.N    ??common_startup_5
//   70 	
//   71 	
//   72     /* 获得.bss段的地址 (初始化为0的数据) */
//   73 	#if (defined(CW))
//   74 		bss_start = (uint8 *)__START_BSS;
//   75 		bss_end = (uint8 *)__END_BSS;
//   76 	#elif (defined(IAR))
//   77 		bss_start = __section_begin(".bss");
        LDR.N    R1,??common_startup_0+0x14
//   78 		bss_end = __section_end(".bss");
        LDR.N    R0,??common_startup_0+0x18
//   79 	#endif
//   80 		
//   81 		
//   82 	
//   83 
//   84     /* 清零初始化为0的数据段 */
//   85     n = bss_end - bss_start;
        SUBS     R0,R0,R1
        B.N      ??common_startup_6
//   86     while(n--)
//   87       *bss_start++ = 0;
??common_startup_7:
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
        ADDS     R1,R1,#+1
??common_startup_6:
        MOVS     R2,R0
        SUBS     R0,R2,#+1
        CMP      R2,#+0
        BNE.N    ??common_startup_7
//   88 
//   89 	/* 取得所有应该从ROM复制到RAM的代码段的地址。
//   90          * IAR有一个预定义的关键字可以标记独立的函数为从RAM执行。
//   91          * 在函数的返回类型前添加"__ramfunc"关键字可以将函数标记为从RAM中执行。
//   92          * 例如:__ramfunc void foo(void);
//   93 	 */
//   94 	#if (defined(IAR))
//   95 		uint8* code_relocate_ram = __section_begin("CodeRelocateRam");
        LDR.N    R1,??common_startup_0+0x1C
//   96 		uint8* code_relocate = __section_begin("CodeRelocate");
        LDR.N    R2,??common_startup_0+0x20
//   97 		uint8* code_relocate_end = __section_end("CodeRelocate");
        LDR.N    R0,??common_startup_0+0x24
//   98 
//   99 		/* 将函数从ROM复制到RAM */
//  100 		n = code_relocate_end - code_relocate;
        SUBS     R0,R0,R2
        B.N      ??common_startup_8
//  101 		while (n--)
//  102 			*code_relocate_ram++ = *code_relocate++;
??common_startup_9:
        LDRB     R3,[R2, #+0]
        STRB     R3,[R1, #+0]
        ADDS     R2,R2,#+1
        ADDS     R1,R1,#+1
??common_startup_8:
        MOVS     R3,R0
        SUBS     R0,R3,#+1
        CMP      R3,#+0
        BNE.N    ??common_startup_9
//  103 	#endif
//  104 }
        POP      {R0,PC}          ;; return
        DATA
??common_startup_0:
        DC32     __VECTOR_RAM
        DC32     __VECTOR_TABLE
        DC32     SFB(`.data`)
        DC32     SFB(`.data_init`)
        DC32     SFE(`.data_init`)
        DC32     SFB(`.bss`)
        DC32     SFE(`.bss`)
        DC32     SFB(CodeRelocateRam)
        DC32     SFB(CodeRelocate)
        DC32     SFE(CodeRelocate)

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.data`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.data_init`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocate:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocateRam:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  105 /********************************************************************/
// 
// 156 bytes in section .text
// 
// 156 bytes of CODE memory
//
//Errors: none
//Warnings: none
