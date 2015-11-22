///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:14:07 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\FatFs\option\syscall.c    /
//    Command line =  "F:\robot _init\robot\lib\LPLD\FatFs\option\syscall.c"  /
//                    -D IAR -D LPLD_K60 -lCN "F:\robot                       /
//                    _init\robot\project\robot_car_com\iar\FLASH\List\" -lB  /
//                    "F:\robot _init\robot\project\robot_car_com\iar\FLASH\L /
//                    ist\" -o "F:\robot _init\robot\project\robot_car_com\ia /
//                    r\FLASH\Obj\" --no_cse --no_unroll --no_inline          /
//                    --no_code_motion --no_tbaa --no_clustering              /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config "D:\IAR     /
//                    Systems\Embedded Workbench                              /
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
//                    st\syscall.s                                            /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME syscall

        #define SHT_PROGBITS 0x1

        EXTERN free
        EXTERN malloc

        PUBLIC ff_memalloc
        PUBLIC ff_memfree

// F:\robot _init\robot\lib\LPLD\FatFs\option\syscall.c
//    1 /*------------------------------------------------------------------------*/
//    2 /* Sample code of OS dependent controls for FatFs R0.08b                  */
//    3 /* (C)ChaN, 2011                                                          */
//    4 /*------------------------------------------------------------------------*/
//    5 
//    6 #include <stdlib.h>		/* ANSI memory controls */
//    7 //#include <malloc.h>		/* ANSI memory controls */
//    8 
//    9 #include "../ff.h"
//   10 
//   11 
//   12 #if _FS_REENTRANT
//   13 /*------------------------------------------------------------------------*/
//   14 /* Create a Synchronization Object                                        */
//   15 /*------------------------------------------------------------------------*/
//   16 /* This function is called in f_mount function to create a new
//   17 /  synchronization object, such as semaphore and mutex. When a zero is
//   18 /  returned, the f_mount function fails with FR_INT_ERR.
//   19 */
//   20 
//   21 int ff_cre_syncobj (	/* TRUE:Function succeeded, FALSE:Could not create due to any error */
//   22 	BYTE vol,			/* Corresponding logical drive being processed */
//   23 	_SYNC_t *sobj		/* Pointer to return the created sync object */
//   24 )
//   25 {
//   26 	int ret;
//   27 
//   28 	*sobj = CreateMutex(NULL, FALSE, NULL);	/* Win32 */
//   29 	ret = (*sobj != INVALID_HANDLE_VALUE);
//   30 
//   31 //	*sobj = SyncObjects[vol];	/* uITRON (give a static sync object) */
//   32 //	ret = 1;					/* The initial value of the semaphore must be 1. */
//   33 
//   34 //	*sobj = OSMutexCreate(0, &err);			/* uC/OS-II */
//   35 //	ret = (err == OS_NO_ERR);
//   36 
//   37 //	*sobj = xSemaphoreCreateMutex();		/* FreeRTOS */
//   38 //	ret = (*sobj != NULL);
//   39 
//   40 	return ret;
//   41 }
//   42 
//   43 
//   44 
//   45 /*------------------------------------------------------------------------*/
//   46 /* Delete a Synchronization Object                                        */
//   47 /*------------------------------------------------------------------------*/
//   48 /* This function is called in f_mount function to delete a synchronization
//   49 /  object that created with ff_cre_syncobj function. When a zero is
//   50 /  returned, the f_mount function fails with FR_INT_ERR.
//   51 */
//   52 
//   53 int ff_del_syncobj (	/* TRUE:Function succeeded, FALSE:Could not delete due to any error */
//   54 	_SYNC_t sobj		/* Sync object tied to the logical drive to be deleted */
//   55 )
//   56 {
//   57 	BOOL ret;
//   58 
//   59 	ret = CloseHandle(sobj);	/* Win32 */
//   60 
//   61 //	ret = 1;					/* uITRON (nothing to do) */
//   62 
//   63 //	OSMutexDel(sobj, OS_DEL_ALWAYS, &err);	/* uC/OS-II */
//   64 //	ret = (err == OS_NO_ERR);
//   65 
//   66 //	ret = 1;					/* FreeRTOS (nothing to do) */
//   67 
//   68 	return ret;
//   69 }
//   70 
//   71 
//   72 
//   73 /*------------------------------------------------------------------------*/
//   74 /* Request Grant to Access the Volume                                     */
//   75 /*------------------------------------------------------------------------*/
//   76 /* This function is called on entering file functions to lock the volume.
//   77 /  When a zero is returned, the file function fails with FR_TIMEOUT.
//   78 */
//   79 
//   80 int ff_req_grant (	/* TRUE:Got a grant to access the volume, FALSE:Could not get a grant */
//   81 	_SYNC_t sobj	/* Sync object to wait */
//   82 )
//   83 {
//   84 	int ret;
//   85 
//   86 	ret = (WaitForSingleObject(sobj, _FS_TIMEOUT) == WAIT_OBJECT_0);	/* Win32 */
//   87 
//   88 //	ret = (wai_sem(sobj) == E_OK);	/* uITRON */
//   89 
//   90 //	OSMutexPend(sobj, _FS_TIMEOUT, &err));			/* uC/OS-II */
//   91 //	ret = (err == OS_NO_ERR);
//   92 
//   93 //	ret = (xSemaphoreTake(sobj, _FS_TIMEOUT) == pdTRUE);	/* FreeRTOS */
//   94 
//   95 	return ret;
//   96 }
//   97 
//   98 
//   99 
//  100 /*------------------------------------------------------------------------*/
//  101 /* Release Grant to Access the Volume                                     */
//  102 /*------------------------------------------------------------------------*/
//  103 /* This function is called on leaving file functions to unlock the volume.
//  104 */
//  105 
//  106 void ff_rel_grant (
//  107 	_SYNC_t sobj	/* Sync object to be signaled */
//  108 )
//  109 {
//  110 	ReleaseMutex(sobj);		/* Win32 */
//  111 
//  112 //	sig_sem(sobj);			/* uITRON */
//  113 
//  114 //	OSMutexPost(sobj);		/* uC/OS-II */
//  115 
//  116 //	xSemaphoreGive(sobj);	/* FreeRTOS */
//  117 
//  118 }
//  119 
//  120 #endif
//  121 
//  122 
//  123 
//  124 
//  125 #if _USE_LFN == 3	/* LFN with a working buffer on the heap */
//  126 /*------------------------------------------------------------------------*/
//  127 /* Allocate a memory block                                                */
//  128 /*------------------------------------------------------------------------*/
//  129 /* If a NULL is returned, the file function fails with FR_NOT_ENOUGH_CORE.
//  130 */
//  131 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  132 void* ff_memalloc (	/* Returns pointer to the allocated memory block */
//  133 	UINT size		/* Number of bytes to allocate */
//  134 )
//  135 {
ff_memalloc:
        PUSH     {R7,LR}
//  136 	return malloc(size);
        BL       malloc
        POP      {R1,PC}          ;; return
//  137 }
//  138 
//  139 
//  140 /*------------------------------------------------------------------------*/
//  141 /* Free a memory block                                                    */
//  142 /*------------------------------------------------------------------------*/
//  143 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  144 void ff_memfree(
//  145 	void* mblock	/* Pointer to the memory block to free */
//  146 )
//  147 {
ff_memfree:
        PUSH     {R7,LR}
//  148 	free(mblock);
        BL       free
//  149 }
        POP      {R0,PC}          ;; return

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
//  150 
//  151 #endif
// 
// 16 bytes in section .text
// 
// 16 bytes of CODE memory
//
//Errors: none
//Warnings: none
