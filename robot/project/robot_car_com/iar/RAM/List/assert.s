///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:13 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\�й������˴���\robot_project\lib\common\assert.c     /
//    Command line =  D:\�й������˴���\robot_project\lib\common\assert.c -D  /
//                    IAR -D LPLD_K60 -lCN D:\�й������˴���\robot_project\pr /
//                    oject\LPLD_Template\iar\RAM\List\ -lB                   /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\ -o D:\�й������˴���\robot_project\project /
//                    \LPLD_Template\iar\RAM\Obj\ --no_cse --no_unroll        /
//                    --no_inline --no_code_motion --no_tbaa --no_clustering  /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config             /
//                    "D:\Program Files\IAR Systems\Embedded Workbench        /
//                    6.0\arm\INC\c\DLib_Config_Normal.h" -I                  /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\app\ -I D:\�й������˴���\robot_project\project\L /
//                    PLD_Template\iar\..\..\..\lib\common\ -I                /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\cpu\ -I D:\�й������˴���\robot_project /
//                    \project\LPLD_Template\iar\..\..\..\lib\cpu\headers\    /
//                    -I D:\�й������˴���\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\drivers\adc16\ -I                    /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\enet\ -I                        /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\lptmr\ -I                       /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\mcg\ -I                         /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\pmc\ -I                         /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\rtc\ -I                         /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\uart\ -I                        /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\wdog\ -I                        /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\platforms\ -I                           /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\LPLD\ -I D:\�й������˴���\robot_projec /
//                    t\project\LPLD_Template\iar\..\..\..\lib\LPLD\FatFs\    /
//                    -I D:\�й������˴���\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\LPLD\USB\ -I                         /
//                    D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\iar_config_files\ -Ol                   /
//    List file    =  D:\�й������˴���\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\assert.s                                    /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME assert

        #define SHT_PROGBITS 0x1

        EXTERN printf

        PUBLIC ASSERT_FAILED_STR
        PUBLIC assert_failed

// D:\�й������˴���\robot_project\lib\common\assert.c
//    1 /*
//    2  * File:        assert.c
//    3  * Purpose:     Provide macro for software assertions
//    4  *
//    5  * Notes:       ASSERT macro defined in assert.h calls assert_failed()
//    6  */
//    7 
//    8 #include "common.h"
//    9 

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   10 const char ASSERT_FAILED_STR[] = "Assertion failed in %s at line %d\n";
ASSERT_FAILED_STR:
        DATA
        DC8 "Assertion failed in %s at line %d\012"
        DC8 0
//   11 
//   12 /********************************************************************/

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   13 void
//   14 assert_failed(char *file, int line)
//   15 {
assert_failed:
        PUSH     {R7,LR}
//   16     int i;
//   17     
//   18     printf(ASSERT_FAILED_STR, file, line);
        MOVS     R2,R1
        MOVS     R1,R0
        LDR.N    R0,??assert_failed_0
        BL       printf
//   19 
//   20     while (1)
//   21     {
//   22 //        platform_led_display(0xFF);
//   23         for (i = 100000; i; i--) ;
??assert_failed_1:
        LDR.N    R0,??assert_failed_0+0x4  ;; 0x186a0
        B.N      ??assert_failed_2
??assert_failed_3:
        SUBS     R0,R0,#+1
??assert_failed_2:
        CMP      R0,#+0
        BNE.N    ??assert_failed_3
//   24 //        platform_led_display(0x00);
//   25         for (i = 100000; i; i--) ;
        LDR.N    R0,??assert_failed_0+0x4  ;; 0x186a0
??assert_failed_4:
        CMP      R0,#+0
        BEQ.N    ??assert_failed_1
        SUBS     R0,R0,#+1
        B.N      ??assert_failed_4
        DATA
??assert_failed_0:
        DC32     ASSERT_FAILED_STR
        DC32     0x186a0
//   26     }
//   27 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//   28 /********************************************************************/
// 
// 36 bytes in section .rodata
// 40 bytes in section .text
// 
// 40 bytes of CODE  memory
// 36 bytes of CONST memory
//
//Errors: none
//Warnings: none