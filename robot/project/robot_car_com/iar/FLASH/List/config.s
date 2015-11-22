///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    23/Jul/2014  00:11:44 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\robot\project\robot_car_com\app\config.c             /
//    Command line =  D:\robot\project\robot_car_com\app\config.c -D IAR -D   /
//                    LPLD_K60 -lCN D:\robot\project\robot_car_com\iar\FLASH\ /
//                    List\ -lB D:\robot\project\robot_car_com\iar\FLASH\List /
//                    \ -o D:\robot\project\robot_car_com\iar\FLASH\Obj\      /
//                    --no_cse --no_unroll --no_inline --no_code_motion       /
//                    --no_tbaa --no_clustering --no_scheduling --debug       /
//                    --endian=little --cpu=Cortex-M4 -e --fpu=None           /
//                    --dlib_config D:\IAR\arm\INC\c\DLib_Config_Normal.h -I  /
//                    D:\robot\project\robot_car_com\iar\..\app\ -I           /
//                    D:\robot\project\robot_car_com\iar\..\..\..\lib\common\ /
//                     -I D:\robot\project\robot_car_com\iar\..\..\..\lib\cpu /
//                    \ -I D:\robot\project\robot_car_com\iar\..\..\..\lib\cp /
//                    u\headers\ -I D:\robot\project\robot_car_com\iar\..\..\ /
//                    ..\lib\drivers\adc16\ -I D:\robot\project\robot_car_com /
//                    \iar\..\..\..\lib\drivers\enet\ -I                      /
//                    D:\robot\project\robot_car_com\iar\..\..\..\lib\drivers /
//                    \lptmr\ -I D:\robot\project\robot_car_com\iar\..\..\..\ /
//                    lib\drivers\mcg\ -I D:\robot\project\robot_car_com\iar\ /
//                    ..\..\..\lib\drivers\pmc\ -I                            /
//                    D:\robot\project\robot_car_com\iar\..\..\..\lib\drivers /
//                    \rtc\ -I D:\robot\project\robot_car_com\iar\..\..\..\li /
//                    b\drivers\uart\ -I D:\robot\project\robot_car_com\iar\. /
//                    .\..\..\lib\drivers\wdog\ -I                            /
//                    D:\robot\project\robot_car_com\iar\..\..\..\lib\platfor /
//                    ms\ -I D:\robot\project\robot_car_com\iar\..\..\..\lib\ /
//                    LPLD\ -I D:\robot\project\robot_car_com\iar\..\..\..\li /
//                    b\LPLD\FatFs\ -I D:\robot\project\robot_car_com\iar\..\ /
//                    ..\..\lib\LPLD\USB\ -I D:\robot\project\robot_car_com\i /
//                    ar\..\..\..\lib\iar_config_files\ -Ol                   /
//    List file    =  D:\robot\project\robot_car_com\iar\FLASH\List\config.s  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME config

        #define SHT_PROGBITS 0x1

        PUBLIC BEGIN_POINT
        PUBLIC CAR_NUMBER

// D:\robot\project\robot_car_com\app\config.c
//    1 #include "config.h"
//    2 

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    3 int CAR_NUMBER = 0;
CAR_NUMBER:
        DS8 4

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//    4 int BEGIN_POINT = 0;
BEGIN_POINT:
        DS8 4

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
// 8 bytes in section .bss
// 
// 8 bytes of DATA memory
//
//Errors: none
//Warnings: none
