///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:08 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\LPLD\FatFs\ff.c     /
//    Command line =  D:\中国机器人大赛\robot_project\lib\LPLD\FatFs\ff.c -D  /
//                    IAR -D LPLD_K60 -lCN D:\中国机器人大赛\robot_project\pr /
//                    oject\LPLD_Template\iar\RAM\List\ -lB                   /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\ -o D:\中国机器人大赛\robot_project\project /
//                    \LPLD_Template\iar\RAM\Obj\ --no_cse --no_unroll        /
//                    --no_inline --no_code_motion --no_tbaa --no_clustering  /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config             /
//                    "D:\Program Files\IAR Systems\Embedded Workbench        /
//                    6.0\arm\INC\c\DLib_Config_Normal.h" -I                  /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\app\ -I D:\中国机器人大赛\robot_project\project\L /
//                    PLD_Template\iar\..\..\..\lib\common\ -I                /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\cpu\ -I D:\中国机器人大赛\robot_project /
//                    \project\LPLD_Template\iar\..\..\..\lib\cpu\headers\    /
//                    -I D:\中国机器人大赛\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\drivers\adc16\ -I                    /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\enet\ -I                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\lptmr\ -I                       /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\mcg\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\pmc\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\rtc\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\uart\ -I                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\drivers\wdog\ -I                        /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\platforms\ -I                           /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\LPLD\ -I D:\中国机器人大赛\robot_projec /
//                    t\project\LPLD_Template\iar\..\..\..\lib\LPLD\FatFs\    /
//                    -I D:\中国机器人大赛\robot_project\project\LPLD_Templat /
//                    e\iar\..\..\..\lib\LPLD\USB\ -I                         /
//                    D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\..\..\..\lib\iar_config_files\ -Ol                   /
//    List file    =  D:\中国机器人大赛\robot_project\project\LPLD_Template\i /
//                    ar\RAM\List\ff.s                                        /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME ff

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_Disk_IOC
        EXTERN LPLD_Disk_Initialize
        EXTERN LPLD_Disk_Read
        EXTERN LPLD_Disk_Status
        EXTERN LPLD_Disk_Write
        EXTERN ff_convert
        EXTERN ff_memalloc
        EXTERN ff_memfree
        EXTERN ff_wtoupper
        EXTERN get_fattime

        PUBLIC clust2sect
        PUBLIC f_chdir
        PUBLIC f_chdrive
        PUBLIC f_chmod
        PUBLIC f_close
        PUBLIC f_getcwd
        PUBLIC f_getfree
        PUBLIC f_gets
        PUBLIC f_lseek
        PUBLIC f_mkdir
        PUBLIC f_mkfs
        PUBLIC f_mount
        PUBLIC f_open
        PUBLIC f_opendir
        PUBLIC f_printf
        PUBLIC f_putc
        PUBLIC f_puts
        PUBLIC f_read
        PUBLIC f_readdir
        PUBLIC f_rename
        PUBLIC f_stat
        PUBLIC f_sync
        PUBLIC f_truncate
        PUBLIC f_unlink
        PUBLIC f_utime
        PUBLIC f_write
        PUBLIC gen_numname
        PUBLIC get_fat
        PUBLIC put_fat

// D:\中国机器人大赛\robot_project\lib\LPLD\FatFs\ff.c
//    1 /*
//    2 
//    3   LPLD K60底层驱动文件系统采用FatFs开源工程，仅对磁盘系统底层函数调用进行了修改。
//    4 
//    5 */
//    6 /*----------------------------------------------------------------------------/
//    7 /  FatFs - FAT file system module  R0.09                  (C)ChaN, 2011
//    8 /-----------------------------------------------------------------------------/
//    9 / FatFs module is a generic FAT file system module for small embedded systems.
//   10 / This is a free software that opened for education, research and commercial
//   11 / developments under license policy of following terms.
//   12 /
//   13 /  Copyright (C) 2011, ChaN, all right reserved.
//   14 /
//   15 / * The FatFs module is a free software and there is NO WARRANTY.
//   16 / * No restriction on use. You can use, modify and redistribute it for
//   17 /   personal, non-profit or commercial products UNDER YOUR RESPONSIBILITY.
//   18 / * Redistributions of source code must retain the above copyright notice.
//   19 /
//   20 /-----------------------------------------------------------------------------/
//   21 / Feb 26,'06 R0.00  Prototype.
//   22 /
//   23 / Apr 29,'06 R0.01  First stable version.
//   24 /
//   25 / Jun 01,'06 R0.02  Added FAT12 support.
//   26 /                   Removed unbuffered mode.
//   27 /                   Fixed a problem on small (<32M) partition.
//   28 / Jun 10,'06 R0.02a Added a configuration option (_FS_MINIMUM).
//   29 /
//   30 / Sep 22,'06 R0.03  Added f_rename().
//   31 /                   Changed option _FS_MINIMUM to _FS_MINIMIZE.
//   32 / Dec 11,'06 R0.03a Improved cluster scan algorithm to write files fast.
//   33 /                   Fixed f_mkdir() creates incorrect directory on FAT32.
//   34 /
//   35 / Feb 04,'07 R0.04  Supported multiple drive system.
//   36 /                   Changed some interfaces for multiple drive system.
//   37 /                   Changed f_mountdrv() to f_mount().
//   38 /                   Added f_mkfs().
//   39 / Apr 01,'07 R0.04a Supported multiple partitions on a physical drive.
//   40 /                   Added a capability of extending file size to f_lseek().
//   41 /                   Added minimization level 3.
//   42 /                   Fixed an endian sensitive code in f_mkfs().
//   43 / May 05,'07 R0.04b Added a configuration option _USE_NTFLAG.
//   44 /                   Added FSInfo support.
//   45 /                   Fixed DBCS name can result FR_INVALID_NAME.
//   46 /                   Fixed short seek (<= csize) collapses the file object.
//   47 /
//   48 / Aug 25,'07 R0.05  Changed arguments of f_read(), f_write() and f_mkfs().
//   49 /                   Fixed f_mkfs() on FAT32 creates incorrect FSInfo.
//   50 /                   Fixed f_mkdir() on FAT32 creates incorrect directory.
//   51 / Feb 03,'08 R0.05a Added f_truncate() and f_utime().
//   52 /                   Fixed off by one error at FAT sub-type determination.
//   53 /                   Fixed btr in f_read() can be mistruncated.
//   54 /                   Fixed cached sector is not flushed when create and close without write.
//   55 /
//   56 / Apr 01,'08 R0.06  Added fputc(), fputs(), fprintf() and fgets().
//   57 /                   Improved performance of f_lseek() on moving to the same or following cluster.
//   58 /
//   59 / Apr 01,'09 R0.07  Merged Tiny-FatFs as a configuration option. (_FS_TINY)
//   60 /                   Added long file name feature.
//   61 /                   Added multiple code page feature.
//   62 /                   Added re-entrancy for multitask operation.
//   63 /                   Added auto cluster size selection to f_mkfs().
//   64 /                   Added rewind option to f_readdir().
//   65 /                   Changed result code of critical errors.
//   66 /                   Renamed string functions to avoid name collision.
//   67 / Apr 14,'09 R0.07a Separated out OS dependent code on reentrant cfg.
//   68 /                   Added multiple sector size feature.
//   69 / Jun 21,'09 R0.07c Fixed f_unlink() can return FR_OK on error.
//   70 /                   Fixed wrong cache control in f_lseek().
//   71 /                   Added relative path feature.
//   72 /                   Added f_chdir() and f_chdrive().
//   73 /                   Added proper case conversion to extended char.
//   74 / Nov 03,'09 R0.07e Separated out configuration options from ff.h to ffconf.h.
//   75 /                   Fixed f_unlink() fails to remove a sub-dir on _FS_RPATH.
//   76 /                   Fixed name matching error on the 13 char boundary.
//   77 /                   Added a configuration option, _LFN_UNICODE.
//   78 /                   Changed f_readdir() to return the SFN with always upper case on non-LFN cfg.
//   79 /
//   80 / May 15,'10 R0.08  Added a memory configuration option. (_USE_LFN = 3)
//   81 /                   Added file lock feature. (_FS_SHARE)
//   82 /                   Added fast seek feature. (_USE_FASTSEEK)
//   83 /                   Changed some types on the API, XCHAR->TCHAR.
//   84 /                   Changed fname member in the FILINFO structure on Unicode cfg.
//   85 /                   String functions support UTF-8 encoding files on Unicode cfg.
//   86 / Aug 16,'10 R0.08a Added f_getcwd(). (_FS_RPATH = 2)
//   87 /                   Added sector erase feature. (_USE_ERASE)
//   88 /                   Moved file lock semaphore table from fs object to the bss.
//   89 /                   Fixed a wrong directory entry is created on non-LFN cfg when the given name contains ';'.
//   90 /                   Fixed f_mkfs() creates wrong FAT32 volume.
//   91 / Jan 15,'11 R0.08b Fast seek feature is also applied to f_read() and f_write().
//   92 /                   f_lseek() reports required table size on creating CLMP.
//   93 /                   Extended format syntax of f_printf function.
//   94 /                   Ignores duplicated directory separators in given path names.
//   95 /
//   96 / Sep 06,'11 R0.09  f_mkfs() supports multiple partition to finish the multiple partition feature.
//   97 /                   Added f_fdisk(). (_MULTI_PARTITION = 2)
//   98 /---------------------------------------------------------------------------*/
//   99 
//  100 #include "ff.h"			/* FatFs configurations and declarations */
//  101 #include "../FML_DiskIO.h"		/* Declarations of low level disk I/O functions */
//  102 
//  103 
//  104 /*--------------------------------------------------------------------------
//  105 
//  106    Module Private Definitions
//  107 
//  108 ---------------------------------------------------------------------------*/
//  109 
//  110 #if _FATFS != 6502	/* Revision ID */
//  111 #error Wrong include file (ff.h).
//  112 #endif
//  113 
//  114 
//  115 /* Definitions on sector size */
//  116 #if _MAX_SS != 512 && _MAX_SS != 1024 && _MAX_SS != 2048 && _MAX_SS != 4096
//  117 #error Wrong sector size.
//  118 #endif
//  119 #if _MAX_SS != 512
//  120 #define	SS(fs)	((fs)->ssize)	/* Variable sector size */
//  121 #else
//  122 #define	SS(fs)	512U			/* Fixed sector size */
//  123 #endif
//  124 
//  125 
//  126 /* Reentrancy related */
//  127 #if _FS_REENTRANT
//  128 #if _USE_LFN == 1
//  129 #error Static LFN work area must not be used in re-entrant configuration.
//  130 #endif
//  131 #define	ENTER_FF(fs)		{ if (!lock_fs(fs)) return FR_TIMEOUT; }
//  132 #define	LEAVE_FF(fs, res)	{ unlock_fs(fs, res); return res; }
//  133 #else
//  134 #define	ENTER_FF(fs)
//  135 #define LEAVE_FF(fs, res)	return res
//  136 #endif
//  137 
//  138 #define	ABORT(fs, res)		{ fp->flag |= FA__ERROR; LEAVE_FF(fs, res); }
//  139 
//  140 
//  141 /* File shareing feature */
//  142 #if _FS_SHARE
//  143 #if _FS_READONLY
//  144 #error _FS_SHARE must be 0 on read-only cfg.
//  145 #endif
//  146 typedef struct {
//  147 	FATFS *fs;				/* File ID 1, volume (NULL:blank entry) */
//  148 	DWORD clu;				/* File ID 2, directory */
//  149 	WORD idx;				/* File ID 3, directory index */
//  150 	WORD ctr;				/* File open counter, 0:none, 0x01..0xFF:read open count, 0x100:write mode */
//  151 } FILESEM;
//  152 #endif
//  153 
//  154 
//  155 /* Misc definitions */
//  156 #define LD_CLUST(dir)	(((DWORD)LD_WORD(dir+DIR_FstClusHI)<<16) | LD_WORD(dir+DIR_FstClusLO))
//  157 #define ST_CLUST(dir,cl) {ST_WORD(dir+DIR_FstClusLO, cl); ST_WORD(dir+DIR_FstClusHI, (DWORD)cl>>16);}
//  158 
//  159 
//  160 /* DBCS code ranges and SBCS extend char conversion table */
//  161 
//  162 #if _CODE_PAGE == 932	/* Japanese Shift-JIS */
//  163 #define _DF1S	0x81	/* DBC 1st byte range 1 start */
//  164 #define _DF1E	0x9F	/* DBC 1st byte range 1 end */
//  165 #define _DF2S	0xE0	/* DBC 1st byte range 2 start */
//  166 #define _DF2E	0xFC	/* DBC 1st byte range 2 end */
//  167 #define _DS1S	0x40	/* DBC 2nd byte range 1 start */
//  168 #define _DS1E	0x7E	/* DBC 2nd byte range 1 end */
//  169 #define _DS2S	0x80	/* DBC 2nd byte range 2 start */
//  170 #define _DS2E	0xFC	/* DBC 2nd byte range 2 end */
//  171 
//  172 #elif _CODE_PAGE == 936	/* Simplified Chinese GBK */
//  173 #define _DF1S	0x81
//  174 #define _DF1E	0xFE
//  175 #define _DS1S	0x40
//  176 #define _DS1E	0x7E
//  177 #define _DS2S	0x80
//  178 #define _DS2E	0xFE
//  179 
//  180 #elif _CODE_PAGE == 949	/* Korean */
//  181 #define _DF1S	0x81
//  182 #define _DF1E	0xFE
//  183 #define _DS1S	0x41
//  184 #define _DS1E	0x5A
//  185 #define _DS2S	0x61
//  186 #define _DS2E	0x7A
//  187 #define _DS3S	0x81
//  188 #define _DS3E	0xFE
//  189 
//  190 #elif _CODE_PAGE == 950	/* Traditional Chinese Big5 */
//  191 #define _DF1S	0x81
//  192 #define _DF1E	0xFE
//  193 #define _DS1S	0x40
//  194 #define _DS1E	0x7E
//  195 #define _DS2S	0xA1
//  196 #define _DS2E	0xFE
//  197 
//  198 #elif _CODE_PAGE == 437	/* U.S. (OEM) */
//  199 #define _DF1S	0
//  200 #define _EXCVT {0x80,0x9A,0x90,0x41,0x8E,0x41,0x8F,0x80,0x45,0x45,0x45,0x49,0x49,0x49,0x8E,0x8F,0x90,0x92,0x92,0x4F,0x99,0x4F,0x55,0x55,0x59,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  201 				0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  202 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  203 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  204 
//  205 #elif _CODE_PAGE == 720	/* Arabic (OEM) */
//  206 #define _DF1S	0
//  207 #define _EXCVT {0x80,0x81,0x45,0x41,0x84,0x41,0x86,0x43,0x45,0x45,0x45,0x49,0x49,0x8D,0x8E,0x8F,0x90,0x92,0x92,0x93,0x94,0x95,0x49,0x49,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  208 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  209 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  210 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  211 
//  212 #elif _CODE_PAGE == 737	/* Greek (OEM) */
//  213 #define _DF1S	0
//  214 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x92,0x92,0x93,0x94,0x95,0x96,0x97,0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87, \ 
//  215 				0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0xAA,0x92,0x93,0x94,0x95,0x96,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  216 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  217 				0x97,0xEA,0xEB,0xEC,0xE4,0xED,0xEE,0xE7,0xE8,0xF1,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  218 
//  219 #elif _CODE_PAGE == 775	/* Baltic (OEM) */
//  220 #define _DF1S	0
//  221 #define _EXCVT {0x80,0x9A,0x91,0xA0,0x8E,0x95,0x8F,0x80,0xAD,0xED,0x8A,0x8A,0xA1,0x8D,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0x95,0x96,0x97,0x97,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \ 
//  222 				0xA0,0xA1,0xE0,0xA3,0xA3,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  223 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xB5,0xB6,0xB7,0xB8,0xBD,0xBE,0xC6,0xC7,0xA5,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  224 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE3,0xE8,0xE8,0xEA,0xEA,0xEE,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  225 
//  226 #elif _CODE_PAGE == 850	/* Multilingual Latin 1 (OEM) */
//  227 #define _DF1S	0
//  228 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0xDE,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x59,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \ 
//  229 				0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  230 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  231 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE7,0xE9,0xEA,0xEB,0xED,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  232 
//  233 #elif _CODE_PAGE == 852	/* Latin 2 (OEM) */
//  234 #define _DF1S	0
//  235 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xDE,0x8F,0x80,0x9D,0xD3,0x8A,0x8A,0xD7,0x8D,0x8E,0x8F,0x90,0x91,0x91,0xE2,0x99,0x95,0x95,0x97,0x97,0x99,0x9A,0x9B,0x9B,0x9D,0x9E,0x9F, \ 
//  236 				0xB5,0xD6,0xE0,0xE9,0xA4,0xA4,0xA6,0xA6,0xA8,0xA8,0xAA,0x8D,0xAC,0xB8,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBD,0xBF, \ 
//  237 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC6,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD1,0xD1,0xD2,0xD3,0xD2,0xD5,0xD6,0xD7,0xB7,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  238 				0xE0,0xE1,0xE2,0xE3,0xE3,0xD5,0xE6,0xE6,0xE8,0xE9,0xE8,0xEB,0xED,0xED,0xDD,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xEB,0xFC,0xFC,0xFE,0xFF}
//  239 
//  240 #elif _CODE_PAGE == 855	/* Cyrillic (OEM) */
//  241 #define _DF1S	0
//  242 #define _EXCVT {0x81,0x81,0x83,0x83,0x85,0x85,0x87,0x87,0x89,0x89,0x8B,0x8B,0x8D,0x8D,0x8F,0x8F,0x91,0x91,0x93,0x93,0x95,0x95,0x97,0x97,0x99,0x99,0x9B,0x9B,0x9D,0x9D,0x9F,0x9F, \ 
//  243 				0xA1,0xA1,0xA3,0xA3,0xA5,0xA5,0xA7,0xA7,0xA9,0xA9,0xAB,0xAB,0xAD,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB6,0xB6,0xB8,0xB8,0xB9,0xBA,0xBB,0xBC,0xBE,0xBE,0xBF, \ 
//  244 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD1,0xD1,0xD3,0xD3,0xD5,0xD5,0xD7,0xD7,0xDD,0xD9,0xDA,0xDB,0xDC,0xDD,0xE0,0xDF, \ 
//  245 				0xE0,0xE2,0xE2,0xE4,0xE4,0xE6,0xE6,0xE8,0xE8,0xEA,0xEA,0xEC,0xEC,0xEE,0xEE,0xEF,0xF0,0xF2,0xF2,0xF4,0xF4,0xF6,0xF6,0xF8,0xF8,0xFA,0xFA,0xFC,0xFC,0xFD,0xFE,0xFF}
//  246 
//  247 #elif _CODE_PAGE == 857	/* Turkish (OEM) */
//  248 #define _DF1S	0
//  249 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0x98,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x98,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9E, \ 
//  250 				0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA6,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  251 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  252 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xDE,0x59,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  253 
//  254 #elif _CODE_PAGE == 858	/* Multilingual Latin 1 + Euro (OEM) */
//  255 #define _DF1S	0
//  256 #define _EXCVT {0x80,0x9A,0x90,0xB6,0x8E,0xB7,0x8F,0x80,0xD2,0xD3,0xD4,0xD8,0xD7,0xDE,0x8E,0x8F,0x90,0x92,0x92,0xE2,0x99,0xE3,0xEA,0xEB,0x59,0x99,0x9A,0x9D,0x9C,0x9D,0x9E,0x9F, \ 
//  257 				0xB5,0xD6,0xE0,0xE9,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  258 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC7,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD1,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  259 				0xE0,0xE1,0xE2,0xE3,0xE5,0xE5,0xE6,0xE7,0xE7,0xE9,0xEA,0xEB,0xED,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  260 
//  261 #elif _CODE_PAGE == 862	/* Hebrew (OEM) */
//  262 #define _DF1S	0
//  263 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  264 				0x41,0x49,0x4F,0x55,0xA5,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0x21,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  265 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  266 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  267 
//  268 #elif _CODE_PAGE == 866	/* Russian (OEM) */
//  269 #define _DF1S	0
//  270 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  271 				0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  272 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  273 				0x90,0x91,0x92,0x93,0x9d,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F,0xF0,0xF0,0xF2,0xF2,0xF4,0xF4,0xF6,0xF6,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  274 
//  275 #elif _CODE_PAGE == 874	/* Thai (OEM, Windows) */
//  276 #define _DF1S	0
//  277 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  278 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  279 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  280 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  281 
//  282 #elif _CODE_PAGE == 1250 /* Central Europe (Windows) */
//  283 #define _DF1S	0
//  284 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x8A,0x9B,0x8C,0x8D,0x8E,0x8F, \ 
//  285 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xA3,0xB4,0xB5,0xB6,0xB7,0xB8,0xA5,0xAA,0xBB,0xBC,0xBD,0xBC,0xAF, \ 
//  286 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  287 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xFF}
//  288 
//  289 #elif _CODE_PAGE == 1251 /* Cyrillic (Windows) */
//  290 #define _DF1S	0
//  291 #define _EXCVT {0x80,0x81,0x82,0x82,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x80,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x8A,0x9B,0x8C,0x8D,0x8E,0x8F, \ 
//  292 				0xA0,0xA2,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB2,0xA5,0xB5,0xB6,0xB7,0xA8,0xB9,0xAA,0xBB,0xA3,0xBD,0xBD,0xAF, \ 
//  293 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  294 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF}
//  295 
//  296 #elif _CODE_PAGE == 1252 /* Latin 1 (Windows) */
//  297 #define _DF1S	0
//  298 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0xAd,0x9B,0x8C,0x9D,0xAE,0x9F, \ 
//  299 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  300 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  301 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0x9F}
//  302 
//  303 #elif _CODE_PAGE == 1253 /* Greek (Windows) */
//  304 #define _DF1S	0
//  305 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  306 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  307 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xA2,0xB8,0xB9,0xBA, \ 
//  308 				0xE0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xF2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xFB,0xBC,0xFD,0xBF,0xFF}
//  309 
//  310 #elif _CODE_PAGE == 1254 /* Turkish (Windows) */
//  311 #define _DF1S	0
//  312 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x8A,0x9B,0x8C,0x9D,0x9E,0x9F, \ 
//  313 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  314 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  315 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0x9F}
//  316 
//  317 #elif _CODE_PAGE == 1255 /* Hebrew (Windows) */
//  318 #define _DF1S	0
//  319 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  320 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  321 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  322 				0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF}
//  323 
//  324 #elif _CODE_PAGE == 1256 /* Arabic (Windows) */
//  325 #define _DF1S	0
//  326 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x8C,0x9D,0x9E,0x9F, \ 
//  327 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  328 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  329 				0x41,0xE1,0x41,0xE3,0xE4,0xE5,0xE6,0x43,0x45,0x45,0x45,0x45,0xEC,0xED,0x49,0x49,0xF0,0xF1,0xF2,0xF3,0x4F,0xF5,0xF6,0xF7,0xF8,0x55,0xFA,0x55,0x55,0xFD,0xFE,0xFF}
//  330 
//  331 #elif _CODE_PAGE == 1257 /* Baltic (Windows) */
//  332 #define _DF1S	0
//  333 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F, \ 
//  334 				0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xA8,0xB9,0xAA,0xBB,0xBC,0xBD,0xBE,0xAF, \ 
//  335 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  336 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xFF}
//  337 
//  338 #elif _CODE_PAGE == 1258 /* Vietnam (OEM, Windows) */
//  339 #define _DF1S	0
//  340 #define _EXCVT {0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0xAC,0x9D,0x9E,0x9F, \ 
//  341 				0xA0,0x21,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF, \ 
//  342 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF, \ 
//  343 				0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xEC,0xCD,0xCE,0xCF,0xD0,0xD1,0xF2,0xD3,0xD4,0xD5,0xD6,0xF7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xFE,0x9F}
//  344 
//  345 #elif _CODE_PAGE == 1	/* ASCII (for only non-LFN cfg) */
//  346 #if _USE_LFN
//  347 #error Cannot use LFN feature without valid code page.
//  348 #endif
//  349 #define _DF1S	0
//  350 
//  351 #else
//  352 #error Unknown code page
//  353 
//  354 #endif
//  355 
//  356 
//  357 /* Character code support macros */
//  358 #define IsUpper(c)	(((c)>='A')&&((c)<='Z'))
//  359 #define IsLower(c)	(((c)>='a')&&((c)<='z'))
//  360 #define IsDigit(c)	(((c)>='0')&&((c)<='9'))
//  361 
//  362 #if _DF1S		/* Code page is DBCS */
//  363 
//  364 #ifdef _DF2S	/* Two 1st byte areas */
//  365 #define IsDBCS1(c)	(((BYTE)(c) >= _DF1S && (BYTE)(c) <= _DF1E) || ((BYTE)(c) >= _DF2S && (BYTE)(c) <= _DF2E))
//  366 #else			/* One 1st byte area */
//  367 #define IsDBCS1(c)	((BYTE)(c) >= _DF1S && (BYTE)(c) <= _DF1E)
//  368 #endif
//  369 
//  370 #ifdef _DS3S	/* Three 2nd byte areas */
//  371 #define IsDBCS2(c)	(((BYTE)(c) >= _DS1S && (BYTE)(c) <= _DS1E) || ((BYTE)(c) >= _DS2S && (BYTE)(c) <= _DS2E) || ((BYTE)(c) >= _DS3S && (BYTE)(c) <= _DS3E))
//  372 #else			/* Two 2nd byte areas */
//  373 #define IsDBCS2(c)	(((BYTE)(c) >= _DS1S && (BYTE)(c) <= _DS1E) || ((BYTE)(c) >= _DS2S && (BYTE)(c) <= _DS2E))
//  374 #endif
//  375 
//  376 #else			/* Code page is SBCS */
//  377 
//  378 #define IsDBCS1(c)	0
//  379 #define IsDBCS2(c)	0
//  380 
//  381 #endif /* _DF1S */
//  382 
//  383 
//  384 /* Name status flags */
//  385 #define NS			11		/* Index of name status byte in fn[] */
//  386 #define NS_LOSS		0x01	/* Out of 8.3 format */
//  387 #define NS_LFN		0x02	/* Force to create LFN entry */
//  388 #define NS_LAST		0x04	/* Last segment */
//  389 #define NS_BODY		0x08	/* Lower case flag (body) */
//  390 #define NS_EXT		0x10	/* Lower case flag (ext) */
//  391 #define NS_DOT		0x20	/* Dot entry */
//  392 
//  393 
//  394 /* FAT sub-type boundaries */
//  395 /* Note that the FAT spec by Microsoft says 4085 but Windows works with 4087! */
//  396 #define MIN_FAT16	4086	/* Minimum number of clusters for FAT16 */
//  397 #define	MIN_FAT32	65526	/* Minimum number of clusters for FAT32 */
//  398 
//  399 
//  400 /* FatFs refers the members in the FAT structures as byte array instead of
//  401 / structure member because the structure is not binary compatible between
//  402 / different platforms */
//  403 
//  404 #define BS_jmpBoot			0	/* Jump instruction (3) */
//  405 #define BS_OEMName			3	/* OEM name (8) */
//  406 #define BPB_BytsPerSec		11	/* Sector size [byte] (2) */
//  407 #define BPB_SecPerClus		13	/* Cluster size [sector] (1) */
//  408 #define BPB_RsvdSecCnt		14	/* Size of reserved area [sector] (2) */
//  409 #define BPB_NumFATs			16	/* Number of FAT copies (1) */
//  410 #define BPB_RootEntCnt		17	/* Number of root dir entries for FAT12/16 (2) */
//  411 #define BPB_TotSec16		19	/* Volume size [sector] (2) */
//  412 #define BPB_Media			21	/* Media descriptor (1) */
//  413 #define BPB_FATSz16			22	/* FAT size [sector] (2) */
//  414 #define BPB_SecPerTrk		24	/* Track size [sector] (2) */
//  415 #define BPB_NumHeads		26	/* Number of heads (2) */
//  416 #define BPB_HiddSec			28	/* Number of special hidden sectors (4) */
//  417 #define BPB_TotSec32		32	/* Volume size [sector] (4) */
//  418 #define BS_DrvNum			36	/* Physical drive number (2) */
//  419 #define BS_BootSig			38	/* Extended boot signature (1) */
//  420 #define BS_VolID			39	/* Volume serial number (4) */
//  421 #define BS_VolLab			43	/* Volume label (8) */
//  422 #define BS_FilSysType		54	/* File system type (1) */
//  423 #define BPB_FATSz32			36	/* FAT size [sector] (4) */
//  424 #define BPB_ExtFlags		40	/* Extended flags (2) */
//  425 #define BPB_FSVer			42	/* File system version (2) */
//  426 #define BPB_RootClus		44	/* Root dir first cluster (4) */
//  427 #define BPB_FSInfo			48	/* Offset of FSInfo sector (2) */
//  428 #define BPB_BkBootSec		50	/* Offset of backup boot sectot (2) */
//  429 #define BS_DrvNum32			64	/* Physical drive number (2) */
//  430 #define BS_BootSig32		66	/* Extended boot signature (1) */
//  431 #define BS_VolID32			67	/* Volume serial number (4) */
//  432 #define BS_VolLab32			71	/* Volume label (8) */
//  433 #define BS_FilSysType32		82	/* File system type (1) */
//  434 #define	FSI_LeadSig			0	/* FSI: Leading signature (4) */
//  435 #define	FSI_StrucSig		484	/* FSI: Structure signature (4) */
//  436 #define	FSI_Free_Count		488	/* FSI: Number of free clusters (4) */
//  437 #define	FSI_Nxt_Free		492	/* FSI: Last allocated cluster (4) */
//  438 #define MBR_Table			446	/* MBR: Partition table offset (2) */
//  439 #define	SZ_PTE				16	/* MBR: Size of a partition table entry */
//  440 #define BS_55AA				510	/* Boot sector signature (2) */
//  441 
//  442 #define	DIR_Name			0	/* Short file name (11) */
//  443 #define	DIR_Attr			11	/* Attribute (1) */
//  444 #define	DIR_NTres			12	/* NT flag (1) */
//  445 #define	DIR_CrtTime			14	/* Created time (2) */
//  446 #define	DIR_CrtDate			16	/* Created date (2) */
//  447 #define	DIR_FstClusHI		20	/* Higher 16-bit of first cluster (2) */
//  448 #define	DIR_WrtTime			22	/* Modified time (2) */
//  449 #define	DIR_WrtDate			24	/* Modified date (2) */
//  450 #define	DIR_FstClusLO		26	/* Lower 16-bit of first cluster (2) */
//  451 #define	DIR_FileSize		28	/* File size (4) */
//  452 #define	LDIR_Ord			0	/* LFN entry order and LLE flag (1) */
//  453 #define	LDIR_Attr			11	/* LFN attribute (1) */
//  454 #define	LDIR_Type			12	/* LFN type (1) */
//  455 #define	LDIR_Chksum			13	/* Sum of corresponding SFN entry */
//  456 #define	LDIR_FstClusLO		26	/* Filled by zero (0) */
//  457 #define	SZ_DIR				32		/* Size of a directory entry */
//  458 #define	LLE					0x40	/* Last long entry flag in LDIR_Ord */
//  459 #define	DDE					0xE5	/* Deleted directory enrty mark in DIR_Name[0] */
//  460 #define	NDDE				0x05	/* Replacement of a character collides with DDE */
//  461 
//  462 
//  463 /*------------------------------------------------------------*/
//  464 /* Module private work area                                   */
//  465 /*------------------------------------------------------------*/
//  466 /* Note that uninitialized variables with static duration are
//  467 /  zeroed/nulled at start-up. If not, the compiler or start-up
//  468 /  routine is out of ANSI-C standard.
//  469 */
//  470 
//  471 #if _VOLUMES
//  472 static

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  473 FATFS *FatFs[_VOLUMES];	/* Pointer to the file system objects (logical drives) */
FatFs:
        DS8 4
//  474 #else
//  475 #error Number of volumes must not be 0.
//  476 #endif
//  477 
//  478 static

        SECTION `.bss`:DATA:REORDER:NOROOT(1)
//  479 WORD Fsid;				/* File system mount ID */
Fsid:
        DS8 2
//  480 
//  481 #if _FS_RPATH
//  482 static

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//  483 BYTE CurrVol;			/* Current drive */
CurrVol:
        DS8 1
//  484 #endif
//  485 
//  486 #if _FS_SHARE
//  487 static

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//  488 FILESEM	Files[_FS_SHARE];	/* File lock semaphores */
Files:
        DS8 96
//  489 #endif
//  490 
//  491 #if _USE_LFN == 0			/* No LFN feature */
//  492 #define	DEF_NAMEBUF			BYTE sfn[12]
//  493 #define INIT_BUF(dobj)		(dobj).fn = sfn
//  494 #define	FREE_BUF()
//  495 
//  496 #elif _USE_LFN == 1			/* LFN feature with static working buffer */
//  497 static WCHAR LfnBuf[_MAX_LFN+1];
//  498 #define	DEF_NAMEBUF			BYTE sfn[12]
//  499 #define INIT_BUF(dobj)		{ (dobj).fn = sfn; (dobj).lfn = LfnBuf; }
//  500 #define	FREE_BUF()
//  501 
//  502 #elif _USE_LFN == 2 		/* LFN feature with dynamic working buffer on the stack */
//  503 #define	DEF_NAMEBUF			BYTE sfn[12]; WCHAR lbuf[_MAX_LFN+1]
//  504 #define INIT_BUF(dobj)		{ (dobj).fn = sfn; (dobj).lfn = lbuf; }
//  505 #define	FREE_BUF()
//  506 
//  507 #elif _USE_LFN == 3 		/* LFN feature with dynamic working buffer on the heap */
//  508 #define	DEF_NAMEBUF			BYTE sfn[12]; WCHAR *lfn
//  509 #define INIT_BUF(dobj)		{ lfn = ff_memalloc((_MAX_LFN + 1) * 2); \ 
//  510 							  if (!lfn) LEAVE_FF((dobj).fs, FR_NOT_ENOUGH_CORE); \ 
//  511 							  (dobj).lfn = lfn;	(dobj).fn = sfn; }
//  512 #define	FREE_BUF()			ff_memfree(lfn)
//  513 
//  514 #else
//  515 #error Wrong LFN configuration.
//  516 #endif
//  517 
//  518 
//  519 
//  520 
//  521 /*--------------------------------------------------------------------------
//  522 
//  523    Module Private Functions
//  524 
//  525 ---------------------------------------------------------------------------*/
//  526 
//  527 
//  528 /*-----------------------------------------------------------------------*/
//  529 /* String functions                                                      */
//  530 /*-----------------------------------------------------------------------*/
//  531 
//  532 /* Copy memory to memory */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  533 static
//  534 void mem_cpy (void* dst, const void* src, UINT cnt) {
//  535 	BYTE *d = (BYTE*)dst;
//  536 	const BYTE *s = (const BYTE*)src;
mem_cpy:
        B.N      ??mem_cpy_0
//  537 
//  538 #if _WORD_ACCESS == 1
//  539 	while (cnt >= sizeof(int)) {
//  540 		*(int*)d = *(int*)s;
//  541 		d += sizeof(int); s += sizeof(int);
//  542 		cnt -= sizeof(int);
//  543 	}
//  544 #endif
//  545 	while (cnt--)
//  546 		*d++ = *s++;
??mem_cpy_1:
        LDRB     R3,[R1, #+0]
        STRB     R3,[R0, #+0]
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
??mem_cpy_0:
        MOVS     R3,R2
        SUBS     R2,R3,#+1
        CMP      R3,#+0
        BNE.N    ??mem_cpy_1
//  547 }
        BX       LR               ;; return
//  548 
//  549 /* Fill memory */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  550 static
//  551 void mem_set (void* dst, int val, UINT cnt) {
//  552 	BYTE *d = (BYTE*)dst;
mem_set:
        B.N      ??mem_set_0
//  553 
//  554 	while (cnt--)
//  555 		*d++ = (BYTE)val;
??mem_set_1:
        STRB     R1,[R0, #+0]
        ADDS     R0,R0,#+1
??mem_set_0:
        MOVS     R3,R2
        SUBS     R2,R3,#+1
        CMP      R3,#+0
        BNE.N    ??mem_set_1
//  556 }
        BX       LR               ;; return
//  557 
//  558 /* Compare memory to memory */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  559 static
//  560 int mem_cmp (const void* dst, const void* src, UINT cnt) {
mem_cmp:
        PUSH     {R4}
//  561 	const BYTE *d = (const BYTE *)dst, *s = (const BYTE *)src;
//  562 	int r = 0;
        MOVS     R3,#+0
//  563 
//  564 	while (cnt-- && (r = *d++ - *s++) == 0) ;
??mem_cmp_0:
        MOVS     R4,R2
        SUBS     R2,R4,#+1
        CMP      R4,#+0
        BEQ.N    ??mem_cmp_1
        LDRB     R3,[R0, #+0]
        LDRB     R4,[R1, #+0]
        SUBS     R3,R3,R4
        ADDS     R1,R1,#+1
        ADDS     R0,R0,#+1
        CMP      R3,#+0
        BEQ.N    ??mem_cmp_0
//  565 	return r;
??mem_cmp_1:
        MOVS     R0,R3
        POP      {R4}
        BX       LR               ;; return
//  566 }
//  567 
//  568 /* Check if chr is contained in the string */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  569 static
//  570 int chk_chr (const char* str, int chr) {
chk_chr:
        B.N      ??chk_chr_0
//  571 	while (*str && *str != chr) str++;
??chk_chr_1:
        ADDS     R0,R0,#+1
??chk_chr_0:
        LDRB     R2,[R0, #+0]
        CMP      R2,#+0
        BEQ.N    ??chk_chr_2
        LDRB     R2,[R0, #+0]
        CMP      R2,R1
        BNE.N    ??chk_chr_1
//  572 	return *str;
??chk_chr_2:
        LDRB     R0,[R0, #+0]
        BX       LR               ;; return
//  573 }
//  574 
//  575 
//  576 
//  577 /*-----------------------------------------------------------------------*/
//  578 /* Request/Release grant to access the volume                            */
//  579 /*-----------------------------------------------------------------------*/
//  580 #if _FS_REENTRANT
//  581 
//  582 static
//  583 int lock_fs (
//  584 	FATFS *fs		/* File system object */
//  585 )
//  586 {
//  587 	return ff_req_grant(fs->sobj);
//  588 }
//  589 
//  590 
//  591 static
//  592 void unlock_fs (
//  593 	FATFS *fs,		/* File system object */
//  594 	FRESULT res		/* Result code to be returned */
//  595 )
//  596 {
//  597 	if (res != FR_NOT_ENABLED &&
//  598 		res != FR_INVALID_DRIVE &&
//  599 		res != FR_INVALID_OBJECT &&
//  600 		res != FR_TIMEOUT) {
//  601 		ff_rel_grant(fs->sobj);
//  602 	}
//  603 }
//  604 #endif
//  605 
//  606 
//  607 
//  608 /*-----------------------------------------------------------------------*/
//  609 /* File shareing control functions                                       */
//  610 /*-----------------------------------------------------------------------*/
//  611 #if _FS_SHARE
//  612 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  613 static
//  614 FRESULT chk_lock (	/* Check if the file can be accessed */
//  615 	DIR* dj,		/* Directory object pointing the file to be checked */
//  616 	int acc			/* Desired access (0:Read, 1:Write, 2:Delete/Rename) */
//  617 )
//  618 {
chk_lock:
        PUSH     {R4,R5}
//  619 	UINT i, be;
//  620 
//  621 	/* Search file semaphore table */
//  622 	for (i = be = 0; i < _FS_SHARE; i++) {
        MOVS     R3,#+0
        MOVS     R2,R3
        B.N      ??chk_lock_0
//  623 		if (Files[i].fs) {	/* Existing entry */
//  624 			if (Files[i].fs == dj->fs &&	 	/* Check if the file matched with an open file */
//  625 				Files[i].clu == dj->sclust &&
//  626 				Files[i].idx == dj->index) break;
//  627 		} else {			/* Blank entry */
//  628 			be++;
??chk_lock_1:
        ADDS     R2,R2,#+1
//  629 		}
??chk_lock_2:
        ADDS     R3,R3,#+1
??chk_lock_0:
        CMP      R3,#+8
        BCS.N    ??chk_lock_3
        MOVS     R4,#+12
        LDR.W    R5,??DataTable7
        MLA      R4,R4,R3,R5
        LDR      R4,[R4, #+0]
        CMP      R4,#+0
        BEQ.N    ??chk_lock_1
        MOVS     R4,#+12
        LDR.W    R5,??DataTable7
        MLA      R4,R4,R3,R5
        LDR      R4,[R4, #+0]
        LDR      R5,[R0, #+0]
        CMP      R4,R5
        BNE.N    ??chk_lock_2
        MOVS     R4,#+12
        LDR.W    R5,??DataTable7
        MLA      R4,R4,R3,R5
        LDR      R4,[R4, #+4]
        LDR      R5,[R0, #+8]
        CMP      R4,R5
        BNE.N    ??chk_lock_2
        MOVS     R4,#+12
        LDR.W    R5,??DataTable7
        MLA      R4,R4,R3,R5
        LDRH     R4,[R4, #+8]
        LDRH     R5,[R0, #+6]
        CMP      R4,R5
        BNE.N    ??chk_lock_2
//  630 	}
//  631 	if (i == _FS_SHARE)	/* The file is not opened */
??chk_lock_3:
        CMP      R3,#+8
        BNE.N    ??chk_lock_4
//  632 		return (be || acc == 2) ? FR_OK : FR_TOO_MANY_OPEN_FILES;	/* Is there a blank entry for new file? */
        CMP      R2,#+0
        BNE.N    ??chk_lock_5
        CMP      R1,#+2
        BNE.N    ??chk_lock_6
??chk_lock_5:
        MOVS     R0,#+0
        B.N      ??chk_lock_7
??chk_lock_6:
        MOVS     R0,#+18
??chk_lock_7:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??chk_lock_8
//  633 
//  634 	/* The file has been opened. Reject any open against writing file and all write mode open */
//  635 	return (acc || Files[i].ctr == 0x100) ? FR_LOCKED : FR_OK;
??chk_lock_4:
        CMP      R1,#+0
        BNE.N    ??chk_lock_9
        MOVS     R0,#+12
        LDR.W    R1,??DataTable7
        MLA      R0,R0,R3,R1
        LDRH     R0,[R0, #+10]
        MOV      R1,#+256
        CMP      R0,R1
        BNE.N    ??chk_lock_10
??chk_lock_9:
        MOVS     R0,#+16
        B.N      ??chk_lock_11
??chk_lock_10:
        MOVS     R0,#+0
??chk_lock_11:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??chk_lock_8:
        POP      {R4,R5}
        BX       LR               ;; return
//  636 }
//  637 
//  638 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  639 static
//  640 int enq_lock (void)	/* Check if an entry is available for a new file */
//  641 {
//  642 	UINT i;
//  643 
//  644 	for (i = 0; i < _FS_SHARE && Files[i].fs; i++) ;
enq_lock:
        MOVS     R0,#+0
        B.N      ??enq_lock_0
??enq_lock_1:
        ADDS     R0,R0,#+1
??enq_lock_0:
        CMP      R0,#+8
        BCS.N    ??enq_lock_2
        MOVS     R1,#+12
        LDR.W    R2,??DataTable7
        MLA      R1,R1,R0,R2
        LDR      R1,[R1, #+0]
        CMP      R1,#+0
        BNE.N    ??enq_lock_1
//  645 	return (i == _FS_SHARE) ? 0 : 1;
??enq_lock_2:
        CMP      R0,#+8
        BNE.N    ??enq_lock_3
        MOVS     R0,#+0
        B.N      ??enq_lock_4
??enq_lock_3:
        MOVS     R0,#+1
??enq_lock_4:
        BX       LR               ;; return
//  646 }
//  647 
//  648 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  649 static
//  650 UINT inc_lock (	/* Increment file open counter and returns its index (0:int error) */
//  651 	DIR* dj,	/* Directory object pointing the file to register or increment */
//  652 	int acc		/* Desired access mode (0:Read, !0:Write) */
//  653 )
//  654 {
inc_lock:
        PUSH     {R4}
//  655 	UINT i;
//  656 
//  657 
//  658 	for (i = 0; i < _FS_SHARE; i++) {	/* Find the file */
        MOVS     R2,#+0
        B.N      ??inc_lock_0
??inc_lock_1:
        ADDS     R2,R2,#+1
??inc_lock_0:
        CMP      R2,#+8
        BCS.N    ??inc_lock_2
//  659 		if (Files[i].fs == dj->fs &&
//  660 			Files[i].clu == dj->sclust &&
//  661 			Files[i].idx == dj->index) break;
        MOVS     R3,#+12
        LDR.W    R4,??DataTable7
        MLA      R3,R3,R2,R4
        LDR      R3,[R3, #+0]
        LDR      R4,[R0, #+0]
        CMP      R3,R4
        BNE.N    ??inc_lock_1
        MOVS     R3,#+12
        LDR.W    R4,??DataTable7
        MLA      R3,R3,R2,R4
        LDR      R3,[R3, #+4]
        LDR      R4,[R0, #+8]
        CMP      R3,R4
        BNE.N    ??inc_lock_1
        MOVS     R3,#+12
        LDR.W    R4,??DataTable7
        MLA      R3,R3,R2,R4
        LDRH     R3,[R3, #+8]
        LDRH     R4,[R0, #+6]
        CMP      R3,R4
        BNE.N    ??inc_lock_1
//  662 	}
//  663 
//  664 	if (i == _FS_SHARE) {				/* Not opened. Register it as new. */
??inc_lock_2:
        CMP      R2,#+8
        BNE.N    ??inc_lock_3
//  665 		for (i = 0; i < _FS_SHARE && Files[i].fs; i++) ;
        MOVS     R2,#+0
        B.N      ??inc_lock_4
??inc_lock_5:
        ADDS     R2,R2,#+1
??inc_lock_4:
        CMP      R2,#+8
        BCS.N    ??inc_lock_6
        MOVS     R3,#+12
        LDR.W    R4,??DataTable7
        MLA      R3,R3,R2,R4
        LDR      R3,[R3, #+0]
        CMP      R3,#+0
        BNE.N    ??inc_lock_5
//  666 		if (i == _FS_SHARE) return 0;	/* No space to register (int err) */
??inc_lock_6:
        CMP      R2,#+8
        BNE.N    ??inc_lock_7
        MOVS     R0,#+0
        B.N      ??inc_lock_8
//  667 		Files[i].fs = dj->fs;
??inc_lock_7:
        MOVS     R3,#+12
        LDR.W    R4,??DataTable7
        MLA      R3,R3,R2,R4
        LDR      R4,[R0, #+0]
        STR      R4,[R3, #+0]
//  668 		Files[i].clu = dj->sclust;
        MOVS     R3,#+12
        LDR.W    R4,??DataTable7
        MLA      R3,R3,R2,R4
        LDR      R4,[R0, #+8]
        STR      R4,[R3, #+4]
//  669 		Files[i].idx = dj->index;
        MOVS     R3,#+12
        LDR.W    R4,??DataTable7
        MLA      R3,R3,R2,R4
        LDRH     R0,[R0, #+6]
        STRH     R0,[R3, #+8]
//  670 		Files[i].ctr = 0;
        MOVS     R0,#+12
        LDR.W    R3,??DataTable7
        MLA      R0,R0,R2,R3
        MOVS     R3,#+0
        STRH     R3,[R0, #+10]
//  671 	}
//  672 
//  673 	if (acc && Files[i].ctr) return 0;	/* Access violation (int err) */
??inc_lock_3:
        CMP      R1,#+0
        BEQ.N    ??inc_lock_9
        MOVS     R0,#+12
        LDR.W    R3,??DataTable7
        MLA      R0,R0,R2,R3
        LDRH     R0,[R0, #+10]
        CMP      R0,#+0
        BEQ.N    ??inc_lock_9
        MOVS     R0,#+0
        B.N      ??inc_lock_8
//  674 
//  675 	Files[i].ctr = acc ? 0x100 : Files[i].ctr + 1;	/* Set semaphore value */
??inc_lock_9:
        CMP      R1,#+0
        BEQ.N    ??inc_lock_10
        MOV      R0,#+256
        B.N      ??inc_lock_11
??inc_lock_10:
        MOVS     R0,#+12
        LDR.W    R1,??DataTable7
        MLA      R0,R0,R2,R1
        LDRH     R0,[R0, #+10]
        ADDS     R0,R0,#+1
??inc_lock_11:
        MOVS     R1,#+12
        LDR.W    R3,??DataTable7
        MLA      R1,R1,R2,R3
        STRH     R0,[R1, #+10]
//  676 
//  677 	return i + 1;
        ADDS     R0,R2,#+1
??inc_lock_8:
        POP      {R4}
        BX       LR               ;; return
//  678 }
//  679 
//  680 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  681 static
//  682 FRESULT dec_lock (	/* Decrement file open counter */
//  683 	UINT i			/* Semaphore index */
//  684 )
//  685 {
//  686 	WORD n;
//  687 	FRESULT res;
//  688 
//  689 
//  690 	if (--i < _FS_SHARE) {
dec_lock:
        SUBS     R0,R0,#+1
        CMP      R0,#+8
        BCS.N    ??dec_lock_0
//  691 		n = Files[i].ctr;
        MOVS     R1,#+12
        LDR.W    R2,??DataTable7
        MLA      R1,R1,R0,R2
        LDRH     R1,[R1, #+10]
//  692 		if (n == 0x100) n = 0;
        MOV      R2,#+256
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,R2
        BNE.N    ??dec_lock_1
        MOVS     R1,#+0
//  693 		if (n) n--;
??dec_lock_1:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BEQ.N    ??dec_lock_2
        SUBS     R1,R1,#+1
//  694 		Files[i].ctr = n;
??dec_lock_2:
        MOVS     R2,#+12
        LDR.W    R3,??DataTable7
        MLA      R2,R2,R0,R3
        STRH     R1,[R2, #+10]
//  695 		if (!n) Files[i].fs = 0;
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BNE.N    ??dec_lock_3
        MOVS     R1,#+12
        LDR.W    R2,??DataTable7
        MLA      R0,R1,R0,R2
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  696 		res = FR_OK;
??dec_lock_3:
        MOVS     R0,#+0
        B.N      ??dec_lock_4
//  697 	} else {
//  698 		res = FR_INT_ERR;
??dec_lock_0:
        MOVS     R0,#+2
//  699 	}
//  700 	return res;
??dec_lock_4:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
//  701 }
//  702 
//  703 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  704 static
//  705 void clear_lock (	/* Clear lock entries of the volume */
//  706 	FATFS *fs
//  707 )
//  708 {
//  709 	UINT i;
//  710 
//  711 	for (i = 0; i < _FS_SHARE; i++) {
clear_lock:
        MOVS     R1,#+0
        B.N      ??clear_lock_0
//  712 		if (Files[i].fs == fs) Files[i].fs = 0;
??clear_lock_1:
        MOVS     R2,#+12
        LDR.W    R3,??DataTable7
        MLA      R2,R2,R1,R3
        LDR      R2,[R2, #+0]
        CMP      R2,R0
        BNE.N    ??clear_lock_2
        MOVS     R2,#+12
        LDR.W    R3,??DataTable7
        MLA      R2,R2,R1,R3
        MOVS     R3,#+0
        STR      R3,[R2, #+0]
//  713 	}
??clear_lock_2:
        ADDS     R1,R1,#+1
??clear_lock_0:
        CMP      R1,#+8
        BCC.N    ??clear_lock_1
//  714 }
        BX       LR               ;; return
//  715 #endif
//  716 
//  717 
//  718 
//  719 /*-----------------------------------------------------------------------*/
//  720 /* Change window offset                                                  */
//  721 /*-----------------------------------------------------------------------*/
//  722 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  723 static
//  724 FRESULT move_window (
//  725 	FATFS *fs,		/* File system object */
//  726 	DWORD sector	/* Sector number to make appearance in the fs->win[] */
//  727 )					/* Move to zero only writes back dirty window */
//  728 {
move_window:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  729 	DWORD wsect;
//  730 
//  731 
//  732 	wsect = fs->winsect;
        LDR      R6,[R4, #+48]
//  733 	if (wsect != sector) {	/* Changed current window */
        CMP      R6,R5
        BEQ.N    ??move_window_0
//  734 #if !_FS_READONLY
//  735 		if (fs->wflag) {	/* Write back dirty window if needed */
        LDRB     R0,[R4, #+4]
        CMP      R0,#+0
        BEQ.N    ??move_window_1
//  736 			if (LPLD_Disk_Write(fs->drv, fs->win, wsect, 1) != RES_OK)
        MOVS     R3,#+1
        MOVS     R2,R6
        ADDS     R1,R4,#+52
        LDRB     R0,[R4, #+1]
        BL       LPLD_Disk_Write
        CMP      R0,#+0
        BEQ.N    ??move_window_2
//  737 				return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??move_window_3
//  738 			fs->wflag = 0;
??move_window_2:
        MOVS     R0,#+0
        STRB     R0,[R4, #+4]
//  739 			if (wsect < (fs->fatbase + fs->fsize)) {	/* In FAT area */
        LDR      R0,[R4, #+36]
        LDR      R1,[R4, #+32]
        ADDS     R0,R1,R0
        CMP      R6,R0
        BCS.N    ??move_window_1
//  740 				BYTE nf;
//  741 				for (nf = fs->n_fats; nf > 1; nf--) {	/* Reflect the change to all FAT copies */
        LDRB     R7,[R4, #+3]
        B.N      ??move_window_4
//  742 					wsect += fs->fsize;
??move_window_5:
        LDR      R0,[R4, #+32]
        ADDS     R6,R0,R6
//  743 					LPLD_Disk_Write(fs->drv, fs->win, wsect, 1);
        MOVS     R3,#+1
        MOVS     R2,R6
        ADDS     R1,R4,#+52
        LDRB     R0,[R4, #+1]
        BL       LPLD_Disk_Write
//  744 				}
        SUBS     R7,R7,#+1
??move_window_4:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+2
        BCS.N    ??move_window_5
//  745 			}
//  746 		}
//  747 #endif
//  748 		if (sector) {
??move_window_1:
        CMP      R5,#+0
        BEQ.N    ??move_window_0
//  749 			if (LPLD_Disk_Read(fs->drv, fs->win, sector, 1) != RES_OK)
        MOVS     R3,#+1
        MOVS     R2,R5
        ADDS     R1,R4,#+52
        LDRB     R0,[R4, #+1]
        BL       LPLD_Disk_Read
        CMP      R0,#+0
        BEQ.N    ??move_window_6
//  750 				return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??move_window_3
//  751 			fs->winsect = sector;
??move_window_6:
        STR      R5,[R4, #+48]
//  752 		}
//  753 	}
//  754 
//  755 	return FR_OK;
??move_window_0:
        MOVS     R0,#+0
??move_window_3:
        POP      {R1,R4-R7,PC}    ;; return
//  756 }
//  757 
//  758 
//  759 
//  760 
//  761 /*-----------------------------------------------------------------------*/
//  762 /* Clean-up cached data                                                  */
//  763 /*-----------------------------------------------------------------------*/
//  764 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  765 static
//  766 FRESULT sync (	/* FR_OK: successful, FR_DISK_ERR: failed */
//  767 	FATFS *fs	/* File system object */
//  768 )
//  769 {
sync:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  770 	FRESULT res;
//  771 
//  772 
//  773 	res = move_window(fs, 0);
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       move_window
        MOVS     R5,R0
//  774 	if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??sync_0
//  775 		/* Update FSInfo sector if needed */
//  776 		if (fs->fs_type == FS_FAT32 && fs->fsi_flag) {
        LDRB     R0,[R4, #+0]
        CMP      R0,#+3
        BNE.N    ??sync_1
        LDRB     R0,[R4, #+5]
        CMP      R0,#+0
        BEQ.N    ??sync_1
//  777 			fs->winsect = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+48]
//  778 			/* Create FSInfo structure */
//  779 			mem_set(fs->win, 0, 512);
        MOV      R2,#+512
        MOVS     R1,#+0
        ADDS     R0,R4,#+52
        BL       mem_set
//  780 			ST_WORD(fs->win+BS_55AA, 0xAA55);
        MOVS     R0,#+85
        STRB     R0,[R4, #+562]
        MOVS     R0,#+170
        STRB     R0,[R4, #+563]
//  781 			ST_DWORD(fs->win+FSI_LeadSig, 0x41615252);
        MOVS     R0,#+82
        STRB     R0,[R4, #+52]
        MOVS     R0,#+82
        STRB     R0,[R4, #+53]
        MOVS     R0,#+97
        STRB     R0,[R4, #+54]
        MOVS     R0,#+65
        STRB     R0,[R4, #+55]
//  782 			ST_DWORD(fs->win+FSI_StrucSig, 0x61417272);
        MOVS     R0,#+114
        STRB     R0,[R4, #+536]
        MOVS     R0,#+114
        STRB     R0,[R4, #+537]
        MOVS     R0,#+65
        STRB     R0,[R4, #+538]
        MOVS     R0,#+97
        STRB     R0,[R4, #+539]
//  783 			ST_DWORD(fs->win+FSI_Free_Count, fs->free_clust);
        LDR      R0,[R4, #+16]
        STRB     R0,[R4, #+540]
        LDR      R0,[R4, #+16]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R4, #+541]
        LDR      R0,[R4, #+16]
        LSRS     R0,R0,#+16
        STRB     R0,[R4, #+542]
        LDR      R0,[R4, #+16]
        LSRS     R0,R0,#+24
        STRB     R0,[R4, #+543]
//  784 			ST_DWORD(fs->win+FSI_Nxt_Free, fs->last_clust);
        LDR      R0,[R4, #+12]
        STRB     R0,[R4, #+544]
        LDR      R0,[R4, #+12]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R4, #+545]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+16
        STRB     R0,[R4, #+546]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+24
        STRB     R0,[R4, #+547]
//  785 			/* Write it into the FSInfo sector */
//  786 			LPLD_Disk_Write(fs->drv, fs->win, fs->fsi_sector, 1);
        MOVS     R3,#+1
        LDR      R2,[R4, #+20]
        ADDS     R1,R4,#+52
        LDRB     R0,[R4, #+1]
        BL       LPLD_Disk_Write
//  787 			fs->fsi_flag = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+5]
//  788 		}
//  789 		/* Make sure that no pending write process in the physical drive */
//  790 		if (LPLD_Disk_IOC(fs->drv, CTRL_SYNC, 0) != RES_OK)
??sync_1:
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDRB     R0,[R4, #+1]
        BL       LPLD_Disk_IOC
        CMP      R0,#+0
        BEQ.N    ??sync_0
//  791 			res = FR_DISK_ERR;
        MOVS     R5,#+1
//  792 	}
//  793 
//  794 	return res;
??sync_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
//  795 }
//  796 #endif
//  797 
//  798 
//  799 
//  800 
//  801 /*-----------------------------------------------------------------------*/
//  802 /* Get sector# from cluster#                                             */
//  803 /*-----------------------------------------------------------------------*/
//  804 
//  805 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  806 DWORD clust2sect (	/* !=0: Sector number, 0: Failed - invalid cluster# */
//  807 	FATFS *fs,		/* File system object */
//  808 	DWORD clst		/* Cluster# to be converted */
//  809 )
//  810 {
//  811 	clst -= 2;
clust2sect:
        SUBS     R1,R1,#+2
//  812 	if (clst >= (fs->n_fatent - 2)) return 0;		/* Invalid cluster# */
        LDR      R2,[R0, #+28]
        SUBS     R2,R2,#+2
        CMP      R1,R2
        BCC.N    ??clust2sect_0
        MOVS     R0,#+0
        B.N      ??clust2sect_1
//  813 	return clst * fs->csize + fs->database;
??clust2sect_0:
        LDRB     R2,[R0, #+2]
        LDR      R0,[R0, #+44]
        MLA      R0,R2,R1,R0
??clust2sect_1:
        BX       LR               ;; return
//  814 }
//  815 
//  816 
//  817 
//  818 
//  819 /*-----------------------------------------------------------------------*/
//  820 /* FAT access - Read value of a FAT entry                                */
//  821 /*-----------------------------------------------------------------------*/
//  822 
//  823 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  824 DWORD get_fat (	/* 0xFFFFFFFF:Disk error, 1:Internal error, Else:Cluster status */
//  825 	FATFS *fs,	/* File system object */
//  826 	DWORD clst	/* Cluster# to get the link information */
//  827 )
//  828 {
get_fat:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  829 	UINT wc, bc;
//  830 	BYTE *p;
//  831 
//  832 
//  833 	if (clst < 2 || clst >= fs->n_fatent)	/* Chack range */
        CMP      R5,#+2
        BCC.N    ??get_fat_0
        LDR      R0,[R4, #+28]
        CMP      R5,R0
        BCC.N    ??get_fat_1
//  834 		return 1;
??get_fat_0:
        MOVS     R0,#+1
        B.N      ??get_fat_2
//  835 
//  836 	switch (fs->fs_type) {
??get_fat_1:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??get_fat_3
        BCC.N    ??get_fat_4
        CMP      R0,#+3
        BEQ.N    ??get_fat_5
        BCC.N    ??get_fat_6
        B.N      ??get_fat_4
//  837 	case FS_FAT12 :
//  838 		bc = (UINT)clst; bc += bc / 2;
??get_fat_3:
        MOVS     R6,R5
        ADDS     R6,R6,R6, LSR #+1
//  839 		if (move_window(fs, fs->fatbase + (bc / SS(fs)))) break;
        LDR      R0,[R4, #+36]
        ADDS     R1,R0,R6, LSR #+9
        MOVS     R0,R4
        BL       move_window
        CMP      R0,#+0
        BEQ.N    ??get_fat_7
//  840 		wc = fs->win[bc % SS(fs)]; bc++;
//  841 		if (move_window(fs, fs->fatbase + (bc / SS(fs)))) break;
//  842 		wc |= fs->win[bc % SS(fs)] << 8;
//  843 		return (clst & 1) ? (wc >> 4) : (wc & 0xFFF);
//  844 
//  845 	case FS_FAT16 :
//  846 		if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 2)))) break;
//  847 		p = &fs->win[clst * 2 % SS(fs)];
//  848 		return LD_WORD(p);
//  849 
//  850 	case FS_FAT32 :
//  851 		if (move_window(fs, fs->fatbase + (clst / (SS(fs) / 4)))) break;
//  852 		p = &fs->win[clst * 4 % SS(fs)];
//  853 		return LD_DWORD(p) & 0x0FFFFFFF;
//  854 	}
//  855 
//  856 	return 0xFFFFFFFF;	/* An error occurred at the disk I/O layer */
??get_fat_4:
        MOVS     R0,#-1
??get_fat_2:
        POP      {R1,R4-R7,PC}    ;; return
??get_fat_7:
        MOV      R0,#+512
        UDIV     R1,R6,R0
        MLS      R1,R1,R0,R6
        ADDS     R0,R1,R4
        LDRB     R7,[R0, #+52]
        ADDS     R6,R6,#+1
        LDR      R0,[R4, #+36]
        ADDS     R1,R0,R6, LSR #+9
        MOVS     R0,R4
        BL       move_window
        CMP      R0,#+0
        BNE.N    ??get_fat_4
??get_fat_8:
        MOV      R0,#+512
        UDIV     R1,R6,R0
        MLS      R1,R1,R0,R6
        ADDS     R0,R1,R4
        LDRB     R0,[R0, #+52]
        ORRS     R7,R7,R0, LSL #+8
        LSLS     R0,R5,#+31
        BPL.N    ??get_fat_9
        LSRS     R0,R7,#+4
        B.N      ??get_fat_10
??get_fat_9:
        LSLS     R0,R7,#+20       ;; ZeroExtS R0,R7,#+20,#+20
        LSRS     R0,R0,#+20
??get_fat_10:
        B.N      ??get_fat_2
??get_fat_6:
        LDR      R0,[R4, #+36]
        ADDS     R1,R0,R5, LSR #+8
        MOVS     R0,R4
        BL       move_window
        CMP      R0,#+0
        BNE.N    ??get_fat_4
??get_fat_11:
        LSLS     R0,R5,#+1
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        ADDS     R0,R2,R4
        ADDW     R0,R0,#+52
        LDRB     R1,[R0, #+1]
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,R1, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        B.N      ??get_fat_2
??get_fat_5:
        LDR      R0,[R4, #+36]
        ADDS     R1,R0,R5, LSR #+7
        MOVS     R0,R4
        BL       move_window
        CMP      R0,#+0
        BNE.N    ??get_fat_4
??get_fat_12:
        LSLS     R0,R5,#+2
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        ADDS     R0,R2,R4
        ADDW     R0,R0,#+52
        LDRB     R1,[R0, #+3]
        LDRB     R2,[R0, #+2]
        LSLS     R2,R2,#+16
        ORRS     R1,R2,R1, LSL #+24
        LDRB     R2,[R0, #+1]
        ORRS     R1,R1,R2, LSL #+8
        LDRB     R0,[R0, #+0]
        ORRS     R0,R0,R1
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        B.N      ??get_fat_2
//  857 }
//  858 
//  859 
//  860 
//  861 
//  862 /*-----------------------------------------------------------------------*/
//  863 /* FAT access - Change value of a FAT entry                              */
//  864 /*-----------------------------------------------------------------------*/
//  865 #if !_FS_READONLY
//  866 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  867 FRESULT put_fat (
//  868 	FATFS *fs,	/* File system object */
//  869 	DWORD clst,	/* Cluster# to be changed in range of 2 to fs->n_fatent - 1 */
//  870 	DWORD val	/* New value to mark the cluster */
//  871 )
//  872 {
put_fat:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  873 	UINT bc;
//  874 	BYTE *p;
//  875 	FRESULT res;
//  876 
//  877 
//  878 	if (clst < 2 || clst >= fs->n_fatent) {	/* Check range */
        CMP      R5,#+2
        BCC.N    ??put_fat_0
        LDR      R0,[R4, #+28]
        CMP      R5,R0
        BCC.N    ??put_fat_1
//  879 		res = FR_INT_ERR;
??put_fat_0:
        MOVS     R0,#+2
        B.N      ??put_fat_2
//  880 
//  881 	} else {
//  882 		switch (fs->fs_type) {
??put_fat_1:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+1
        BEQ.N    ??put_fat_3
        BCC.W    ??put_fat_4
        CMP      R0,#+3
        BEQ.N    ??put_fat_5
        BCC.N    ??put_fat_6
        B.N      ??put_fat_4
//  883 		case FS_FAT12 :
//  884 			bc = clst; bc += bc / 2;
??put_fat_3:
        MOVS     R7,R5
        ADDS     R7,R7,R7, LSR #+1
//  885 			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
        LDR      R0,[R4, #+36]
        ADDS     R1,R0,R7, LSR #+9
        MOVS     R0,R4
        BL       move_window
//  886 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  887 			p = &fs->win[bc % SS(fs)];
??put_fat_8:
        MOV      R0,#+512
        UDIV     R1,R7,R0
        MLS      R1,R1,R0,R7
        ADDS     R0,R1,R4
        ADDW     R1,R0,#+52
//  888 			*p = (clst & 1) ? ((*p & 0x0F) | ((BYTE)val << 4)) : (BYTE)val;
        MOVS     R0,R5
        LSLS     R0,R0,#+31
        BPL.N    ??put_fat_9
        LDRB     R0,[R1, #+0]
        ANDS     R0,R0,#0xF
        ORRS     R0,R0,R6, LSL #+4
        B.N      ??put_fat_10
??put_fat_9:
        MOVS     R0,R6
??put_fat_10:
        STRB     R0,[R1, #+0]
//  889 			bc++;
        ADDS     R7,R7,#+1
//  890 			fs->wflag = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+4]
//  891 			res = move_window(fs, fs->fatbase + (bc / SS(fs)));
        LDR      R0,[R4, #+36]
        ADDS     R1,R0,R7, LSR #+9
        MOVS     R0,R4
        BL       move_window
//  892 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  893 			p = &fs->win[bc % SS(fs)];
??put_fat_11:
        MOV      R1,#+512
        UDIV     R2,R7,R1
        MLS      R2,R2,R1,R7
        ADDS     R1,R2,R4
        ADDW     R1,R1,#+52
//  894 			*p = (clst & 1) ? (BYTE)(val >> 4) : ((*p & 0xF0) | ((BYTE)(val >> 8) & 0x0F));
        LSLS     R2,R5,#+31
        BPL.N    ??put_fat_12
        LSRS     R2,R6,#+4
        B.N      ??put_fat_13
??put_fat_12:
        LDRB     R2,[R1, #+0]
        ANDS     R2,R2,#0xF0
        LSRS     R3,R6,#+8
        ANDS     R3,R3,#0xF
        ORRS     R2,R3,R2
??put_fat_13:
        STRB     R2,[R1, #+0]
//  895 			break;
        B.N      ??put_fat_7
//  896 
//  897 		case FS_FAT16 :
//  898 			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 2)));
??put_fat_6:
        LDR      R0,[R4, #+36]
        ADDS     R1,R0,R5, LSR #+8
        MOVS     R0,R4
        BL       move_window
//  899 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  900 			p = &fs->win[clst * 2 % SS(fs)];
??put_fat_14:
        LSLS     R1,R5,#+1
        MOV      R2,#+512
        UDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        ADDS     R1,R3,R4
        ADDW     R1,R1,#+52
//  901 			ST_WORD(p, (WORD)val);
        STRB     R6,[R1, #+0]
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        LSRS     R2,R6,#+8
        STRB     R2,[R1, #+1]
//  902 			break;
        B.N      ??put_fat_7
//  903 
//  904 		case FS_FAT32 :
//  905 			res = move_window(fs, fs->fatbase + (clst / (SS(fs) / 4)));
??put_fat_5:
        LDR      R0,[R4, #+36]
        ADDS     R1,R0,R5, LSR #+7
        MOVS     R0,R4
        BL       move_window
//  906 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??put_fat_7
//  907 			p = &fs->win[clst * 4 % SS(fs)];
??put_fat_15:
        LSLS     R1,R5,#+2
        MOV      R2,#+512
        UDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        ADDS     R1,R3,R4
        ADDW     R1,R1,#+52
//  908 			val |= LD_DWORD(p) & 0xF0000000;
        LDRB     R2,[R1, #+3]
        LSLS     R2,R2,#+24
        ANDS     R2,R2,#0xF0000000
        ORRS     R6,R2,R6
//  909 			ST_DWORD(p, val);
        STRB     R6,[R1, #+0]
        MOVS     R2,R6
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        LSRS     R2,R2,#+8
        STRB     R2,[R1, #+1]
        LSRS     R2,R6,#+16
        STRB     R2,[R1, #+2]
        LSRS     R2,R6,#+24
        STRB     R2,[R1, #+3]
//  910 			break;
        B.N      ??put_fat_7
//  911 
//  912 		default :
//  913 			res = FR_INT_ERR;
??put_fat_4:
        MOVS     R0,#+2
//  914 		}
//  915 		fs->wflag = 1;
??put_fat_7:
        MOVS     R1,#+1
        STRB     R1,[R4, #+4]
//  916 	}
//  917 
//  918 	return res;
??put_fat_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4-R7,PC}    ;; return
//  919 }
//  920 #endif /* !_FS_READONLY */
//  921 
//  922 
//  923 
//  924 
//  925 /*-----------------------------------------------------------------------*/
//  926 /* FAT handling - Remove a cluster chain                                 */
//  927 /*-----------------------------------------------------------------------*/
//  928 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  929 static
//  930 FRESULT remove_chain (
//  931 	FATFS *fs,			/* File system object */
//  932 	DWORD clst			/* Cluster# to remove a chain from */
//  933 )
//  934 {
remove_chain:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R6,R1
//  935 	FRESULT res;
//  936 	DWORD nxt;
//  937 #if _USE_ERASE
//  938 	DWORD scl = clst, ecl = clst, resion[2];
//  939 #endif
//  940 
//  941 	if (clst < 2 || clst >= fs->n_fatent) {	/* Check range */
        CMP      R6,#+2
        BCC.N    ??remove_chain_0
        LDR      R0,[R4, #+28]
        CMP      R6,R0
        BCC.N    ??remove_chain_1
//  942 		res = FR_INT_ERR;
??remove_chain_0:
        MOVS     R5,#+2
        B.N      ??remove_chain_2
//  943 
//  944 	} else {
//  945 		res = FR_OK;
??remove_chain_1:
        MOVS     R5,#+0
        B.N      ??remove_chain_3
//  946 		while (clst < fs->n_fatent) {			/* Not a last link? */
//  947 			nxt = get_fat(fs, clst);			/* Get cluster status */
//  948 			if (nxt == 0) break;				/* Empty cluster? */
//  949 			if (nxt == 1) { res = FR_INT_ERR; break; }	/* Internal error? */
//  950 			if (nxt == 0xFFFFFFFF) { res = FR_DISK_ERR; break; }	/* Disk error? */
//  951 			res = put_fat(fs, clst, 0);			/* Mark the cluster "empty" */
//  952 			if (res != FR_OK) break;
//  953 			if (fs->free_clust != 0xFFFFFFFF) {	/* Update FSInfo */
??remove_chain_4:
        LDR      R0,[R4, #+16]
        CMN      R0,#+1
        BEQ.N    ??remove_chain_5
//  954 				fs->free_clust++;
        LDR      R0,[R4, #+16]
        ADDS     R0,R0,#+1
        STR      R0,[R4, #+16]
//  955 				fs->fsi_flag = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+5]
//  956 			}
//  957 #if _USE_ERASE
//  958 			if (ecl + 1 == nxt) {	/* Next cluster is contiguous */
//  959 				ecl = nxt;
//  960 			} else {				/* End of contiguous clusters */ 
//  961 				resion[0] = clust2sect(fs, scl);					/* Start sector */
//  962 				resion[1] = clust2sect(fs, ecl) + fs->csize - 1;	/* End sector */
//  963 				LPLD_Disk_IOC(fs->drv, CTRL_ERASE_SECTOR, resion);		/* Erase the block */
//  964 				scl = ecl = nxt;
//  965 			}
//  966 #endif
//  967 			clst = nxt;	/* Next cluster */
??remove_chain_5:
        MOVS     R6,R7
??remove_chain_3:
        LDR      R0,[R4, #+28]
        CMP      R6,R0
        BCS.N    ??remove_chain_2
        MOVS     R1,R6
        MOVS     R0,R4
        BL       get_fat
        MOVS     R7,R0
        CMP      R7,#+0
        BEQ.N    ??remove_chain_2
??remove_chain_6:
        CMP      R7,#+1
        BNE.N    ??remove_chain_7
        MOVS     R5,#+2
        B.N      ??remove_chain_2
??remove_chain_7:
        CMN      R7,#+1
        BNE.N    ??remove_chain_8
        MOVS     R5,#+1
        B.N      ??remove_chain_2
??remove_chain_8:
        MOVS     R2,#+0
        MOVS     R1,R6
        MOVS     R0,R4
        BL       put_fat
        MOVS     R5,R0
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??remove_chain_4
//  968 		}
//  969 	}
//  970 
//  971 	return res;
??remove_chain_2:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4-R7,PC}    ;; return
//  972 }
//  973 #endif
//  974 
//  975 
//  976 
//  977 
//  978 /*-----------------------------------------------------------------------*/
//  979 /* FAT handling - Stretch or Create a cluster chain                      */
//  980 /*-----------------------------------------------------------------------*/
//  981 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  982 static
//  983 DWORD create_chain (	/* 0:No free cluster, 1:Internal error, 0xFFFFFFFF:Disk error, >=2:New cluster# */
//  984 	FATFS *fs,			/* File system object */
//  985 	DWORD clst			/* Cluster# to stretch. 0 means create a new chain. */
//  986 )
//  987 {
create_chain:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R6,R1
//  988 	DWORD cs, ncl, scl;
//  989 	FRESULT res;
//  990 
//  991 
//  992 	if (clst == 0) {		/* Create a new chain */
        CMP      R6,#+0
        BNE.N    ??create_chain_0
//  993 		scl = fs->last_clust;			/* Get suggested start point */
        LDR      R7,[R4, #+12]
//  994 		if (!scl || scl >= fs->n_fatent) scl = 1;
        CMP      R7,#+0
        BEQ.N    ??create_chain_1
        LDR      R0,[R4, #+28]
        CMP      R7,R0
        BCC.N    ??create_chain_2
??create_chain_1:
        MOVS     R7,#+1
        B.N      ??create_chain_2
//  995 	}
//  996 	else {					/* Stretch the current chain */
//  997 		cs = get_fat(fs, clst);			/* Check the cluster status */
??create_chain_0:
        MOVS     R1,R6
        MOVS     R0,R4
        BL       get_fat
//  998 		if (cs < 2) return 1;			/* It is an invalid cluster */
        CMP      R0,#+2
        BCS.N    ??create_chain_3
        MOVS     R0,#+1
        B.N      ??create_chain_4
//  999 		if (cs < fs->n_fatent) return cs;	/* It is already followed by next cluster */
??create_chain_3:
        LDR      R1,[R4, #+28]
        CMP      R0,R1
        BCC.N    ??create_chain_4
// 1000 		scl = clst;
??create_chain_5:
        MOVS     R7,R6
// 1001 	}
// 1002 
// 1003 	ncl = scl;				/* Start cluster */
??create_chain_2:
        MOVS     R5,R7
// 1004 	for (;;) {
// 1005 		ncl++;							/* Next cluster */
??create_chain_6:
        ADDS     R5,R5,#+1
// 1006 		if (ncl >= fs->n_fatent) {		/* Wrap around */
        LDR      R0,[R4, #+28]
        CMP      R5,R0
        BCC.N    ??create_chain_7
// 1007 			ncl = 2;
        MOVS     R5,#+2
// 1008 			if (ncl > scl) return 0;	/* No free cluster */
        CMP      R7,R5
        BCS.N    ??create_chain_7
        MOVS     R0,#+0
        B.N      ??create_chain_4
// 1009 		}
// 1010 		cs = get_fat(fs, ncl);			/* Get the cluster status */
??create_chain_7:
        MOVS     R1,R5
        MOVS     R0,R4
        BL       get_fat
// 1011 		if (cs == 0) break;				/* Found a free cluster */
        CMP      R0,#+0
        BNE.N    ??create_chain_8
// 1012 		if (cs == 0xFFFFFFFF || cs == 1)/* An error occurred */
// 1013 			return cs;
// 1014 		if (ncl == scl) return 0;		/* No free cluster */
// 1015 	}
// 1016 
// 1017 	res = put_fat(fs, ncl, 0x0FFFFFFF);	/* Mark the new cluster "last link" */
        MVNS     R2,#-268435456
        MOVS     R1,R5
        MOVS     R0,R4
        BL       put_fat
// 1018 	if (res == FR_OK && clst != 0) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??create_chain_9
        CMP      R6,#+0
        BEQ.N    ??create_chain_9
// 1019 		res = put_fat(fs, clst, ncl);	/* Link it to the previous one if needed */
        MOVS     R2,R5
        MOVS     R1,R6
        MOVS     R0,R4
        BL       put_fat
// 1020 	}
// 1021 	if (res == FR_OK) {
??create_chain_9:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??create_chain_10
// 1022 		fs->last_clust = ncl;			/* Update FSINFO */
        STR      R5,[R4, #+12]
// 1023 		if (fs->free_clust != 0xFFFFFFFF) {
        LDR      R0,[R4, #+16]
        CMN      R0,#+1
        BEQ.N    ??create_chain_11
// 1024 			fs->free_clust--;
        LDR      R0,[R4, #+16]
        SUBS     R0,R0,#+1
        STR      R0,[R4, #+16]
// 1025 			fs->fsi_flag = 1;
        MOVS     R0,#+1
        STRB     R0,[R4, #+5]
        B.N      ??create_chain_11
// 1026 		}
// 1027 	} else {
??create_chain_8:
        CMN      R0,#+1
        BEQ.N    ??create_chain_12
        CMP      R0,#+1
        BNE.N    ??create_chain_13
??create_chain_12:
        B.N      ??create_chain_4
??create_chain_13:
        CMP      R5,R7
        BNE.N    ??create_chain_6
        MOVS     R0,#+0
        B.N      ??create_chain_4
// 1028 		ncl = (res == FR_DISK_ERR) ? 0xFFFFFFFF : 1;
??create_chain_10:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BNE.N    ??create_chain_14
        MOVS     R5,#-1
        B.N      ??create_chain_11
??create_chain_14:
        MOVS     R5,#+1
// 1029 	}
// 1030 
// 1031 	return ncl;		/* Return new cluster number or error code */
??create_chain_11:
        MOVS     R0,R5
??create_chain_4:
        POP      {R1,R4-R7,PC}    ;; return
// 1032 }
// 1033 #endif /* !_FS_READONLY */
// 1034 
// 1035 
// 1036 
// 1037 /*-----------------------------------------------------------------------*/
// 1038 /* FAT handling - Convert offset into cluster with link map table        */
// 1039 /*-----------------------------------------------------------------------*/
// 1040 
// 1041 #if _USE_FASTSEEK

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1042 static
// 1043 DWORD clmt_clust (	/* <2:Error, >=2:Cluster number */
// 1044 	FIL* fp,		/* Pointer to the file object */
// 1045 	DWORD ofs		/* File offset to be converted to cluster# */
// 1046 )
// 1047 {
// 1048 	DWORD cl, ncl, *tbl;
// 1049 
// 1050 
// 1051 	tbl = fp->cltbl + 1;	/* Top of CLMT */
clmt_clust:
        LDR      R2,[R0, #+36]
        ADDS     R2,R2,#+4
// 1052 	cl = ofs / SS(fp->fs) / fp->fs->csize;	/* Cluster order from top of the file */
        LSRS     R1,R1,#+9
        LDR      R0,[R0, #+0]
        LDRB     R0,[R0, #+2]
        UDIV     R0,R1,R0
        B.N      ??clmt_clust_0
// 1053 	for (;;) {
// 1054 		ncl = *tbl++;			/* Number of cluters in the fragment */
// 1055 		if (!ncl) return 0;		/* End of table? (error) */
// 1056 		if (cl < ncl) break;	/* In this fragment? */
// 1057 		cl -= ncl; tbl++;		/* Next fragment */
??clmt_clust_1:
        SUBS     R0,R0,R1
        ADDS     R2,R2,#+4
??clmt_clust_0:
        LDR      R1,[R2, #+0]
        ADDS     R2,R2,#+4
        CMP      R1,#+0
        BNE.N    ??clmt_clust_2
        MOVS     R0,#+0
        B.N      ??clmt_clust_3
??clmt_clust_2:
        CMP      R0,R1
        BCS.N    ??clmt_clust_1
// 1058 	}
// 1059 	return cl + *tbl;	/* Return the cluster number */
        LDR      R1,[R2, #+0]
        ADDS     R0,R1,R0
??clmt_clust_3:
        BX       LR               ;; return
// 1060 }
// 1061 #endif	/* _USE_FASTSEEK */
// 1062 
// 1063 
// 1064 
// 1065 /*-----------------------------------------------------------------------*/
// 1066 /* Directory handling - Set directory index                              */
// 1067 /*-----------------------------------------------------------------------*/
// 1068 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1069 static
// 1070 FRESULT dir_sdi (
// 1071 	DIR *dj,		/* Pointer to directory object */
// 1072 	WORD idx		/* Directory index number */
// 1073 )
// 1074 {
dir_sdi:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 1075 	DWORD clst;
// 1076 	WORD ic;
// 1077 
// 1078 
// 1079 	dj->index = idx;
        STRH     R5,[R4, #+6]
// 1080 	clst = dj->sclust;
        LDR      R0,[R4, #+8]
// 1081 	if (clst == 1 || clst >= dj->fs->n_fatent)	/* Check start cluster range */
        CMP      R0,#+1
        BEQ.N    ??dir_sdi_0
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+28]
        CMP      R0,R1
        BCC.N    ??dir_sdi_1
// 1082 		return FR_INT_ERR;
??dir_sdi_0:
        MOVS     R0,#+2
        B.N      ??dir_sdi_2
// 1083 	if (!clst && dj->fs->fs_type == FS_FAT32)	/* Replace cluster# 0 with root cluster# if in FAT32 */
??dir_sdi_1:
        CMP      R0,#+0
        BNE.N    ??dir_sdi_3
        LDR      R1,[R4, #+0]
        LDRB     R1,[R1, #+0]
        CMP      R1,#+3
        BNE.N    ??dir_sdi_3
// 1084 		clst = dj->fs->dirbase;
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+40]
// 1085 
// 1086 	if (clst == 0) {	/* Static table (root-dir in FAT12/16) */
??dir_sdi_3:
        CMP      R0,#+0
        BNE.N    ??dir_sdi_4
// 1087 		dj->clust = clst;
        STR      R0,[R4, #+12]
// 1088 		if (idx >= dj->fs->n_rootdir)		/* Index is out of range */
        LDR      R0,[R4, #+0]
        LDRH     R0,[R0, #+8]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,R0
        BCC.N    ??dir_sdi_5
// 1089 			return FR_INT_ERR;
        MOVS     R0,#+2
        B.N      ??dir_sdi_2
// 1090 		dj->sect = dj->fs->dirbase + idx / (SS(dj->fs) / SZ_DIR);	/* Sector# */
??dir_sdi_5:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+40]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R0,R5, LSR #+4
        STR      R0,[R4, #+16]
        B.N      ??dir_sdi_6
// 1091 	}
// 1092 	else {				/* Dynamic table (sub-dirs or root-dir in FAT32) */
// 1093 		ic = SS(dj->fs) / SZ_DIR * dj->fs->csize;	/* Entries per cluster */
??dir_sdi_4:
        LDR      R1,[R4, #+0]
        LDRB     R1,[R1, #+2]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSLS     R6,R1,#+4
        B.N      ??dir_sdi_7
// 1094 		while (idx >= ic) {	/* Follow cluster chain */
// 1095 			clst = get_fat(dj->fs, clst);				/* Get next cluster */
// 1096 			if (clst == 0xFFFFFFFF) return FR_DISK_ERR;	/* Disk error */
// 1097 			if (clst < 2 || clst >= dj->fs->n_fatent)	/* Reached to end of table or int error */
// 1098 				return FR_INT_ERR;
// 1099 			idx -= ic;
??dir_sdi_8:
        SUBS     R5,R5,R6
??dir_sdi_7:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R5,R6
        BCC.N    ??dir_sdi_9
        MOVS     R1,R0
        LDR      R0,[R4, #+0]
        BL       get_fat
        CMN      R0,#+1
        BNE.N    ??dir_sdi_10
        MOVS     R0,#+1
        B.N      ??dir_sdi_2
??dir_sdi_10:
        CMP      R0,#+2
        BCC.N    ??dir_sdi_11
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+28]
        CMP      R0,R1
        BCC.N    ??dir_sdi_8
??dir_sdi_11:
        MOVS     R0,#+2
        B.N      ??dir_sdi_2
// 1100 		}
// 1101 		dj->clust = clst;
??dir_sdi_9:
        STR      R0,[R4, #+12]
// 1102 		dj->sect = clust2sect(dj->fs, clst) + idx / (SS(dj->fs) / SZ_DIR);	/* Sector# */
        MOVS     R1,R0
        LDR      R0,[R4, #+0]
        BL       clust2sect
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        ADDS     R0,R0,R5, LSR #+4
        STR      R0,[R4, #+16]
// 1103 	}
// 1104 
// 1105 	dj->dir = dj->fs->win + (idx % (SS(dj->fs) / SZ_DIR)) * SZ_DIR;	/* Ptr to the entry in the sector */
??dir_sdi_6:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R0,#+16
        UDIV     R1,R5,R0
        MLS      R1,R1,R0,R5
        LDR      R0,[R4, #+0]
        ADDS     R0,R0,R1, LSL #+5
        ADDW     R0,R0,#+52
        STR      R0,[R4, #+20]
// 1106 
// 1107 	return FR_OK;	/* Seek succeeded */
        MOVS     R0,#+0
??dir_sdi_2:
        POP      {R4-R6,PC}       ;; return
// 1108 }
// 1109 
// 1110 
// 1111 
// 1112 
// 1113 /*-----------------------------------------------------------------------*/
// 1114 /* Directory handling - Move directory index next                        */
// 1115 /*-----------------------------------------------------------------------*/
// 1116 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1117 static
// 1118 FRESULT dir_next (	/* FR_OK:Succeeded, FR_NO_FILE:End of table, FR_DENIED:EOT and could not stretch */
// 1119 	DIR *dj,		/* Pointer to directory object */
// 1120 	int stretch		/* 0: Do not stretch table, 1: Stretch table if needed */
// 1121 )
// 1122 {
dir_next:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 1123 	DWORD clst;
// 1124 	WORD i;
// 1125 
// 1126 
// 1127 	stretch = stretch;		/* To suppress warning on read-only cfg. */
// 1128 	i = dj->index + 1;
        LDRH     R0,[R4, #+6]
        ADDS     R6,R0,#+1
// 1129 	if (!i || !dj->sect)	/* Report EOT when index has reached 65535 */
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,#+0
        BEQ.N    ??dir_next_0
        LDR      R0,[R4, #+16]
        CMP      R0,#+0
        BNE.N    ??dir_next_1
// 1130 		return FR_NO_FILE;
??dir_next_0:
        MOVS     R0,#+4
        B.N      ??dir_next_2
// 1131 
// 1132 	if (!(i % (SS(dj->fs) / SZ_DIR))) {	/* Sector changed? */
??dir_next_1:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R0,#+16
        UDIV     R1,R6,R0
        MLS      R1,R1,R0,R6
        CMP      R1,#+0
        BNE.N    ??dir_next_3
// 1133 		dj->sect++;					/* Next sector */
        LDR      R0,[R4, #+16]
        ADDS     R0,R0,#+1
        STR      R0,[R4, #+16]
// 1134 
// 1135 		if (dj->clust == 0) {	/* Static table */
        LDR      R0,[R4, #+12]
        CMP      R0,#+0
        BNE.N    ??dir_next_4
// 1136 			if (i >= dj->fs->n_rootdir)	/* Report EOT when end of table */
        LDR      R0,[R4, #+0]
        LDRH     R0,[R0, #+8]
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        CMP      R6,R0
        BCC.N    ??dir_next_3
// 1137 				return FR_NO_FILE;
        MOVS     R0,#+4
        B.N      ??dir_next_2
// 1138 		}
// 1139 		else {					/* Dynamic table */
// 1140 			if (((i / (SS(dj->fs) / SZ_DIR)) & (dj->fs->csize - 1)) == 0) {	/* Cluster changed? */
??dir_next_4:
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        LSRS     R0,R6,#+4
        LDR      R1,[R4, #+0]
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        TST      R0,R1
        BNE.N    ??dir_next_3
// 1141 				clst = get_fat(dj->fs, dj->clust);				/* Get next cluster */
        LDR      R1,[R4, #+12]
        LDR      R0,[R4, #+0]
        BL       get_fat
        MOVS     R7,R0
// 1142 				if (clst <= 1) return FR_INT_ERR;
        CMP      R7,#+2
        BCS.N    ??dir_next_5
        MOVS     R0,#+2
        B.N      ??dir_next_2
// 1143 				if (clst == 0xFFFFFFFF) return FR_DISK_ERR;
??dir_next_5:
        CMN      R7,#+1
        BNE.N    ??dir_next_6
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1144 				if (clst >= dj->fs->n_fatent) {					/* When it reached end of dynamic table */
??dir_next_6:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+28]
        CMP      R7,R0
        BCC.N    ??dir_next_7
// 1145 #if !_FS_READONLY
// 1146 					BYTE c;
// 1147 					if (!stretch) return FR_NO_FILE;			/* When do not stretch, report EOT */
        CMP      R5,#+0
        BNE.N    ??dir_next_8
        MOVS     R0,#+4
        B.N      ??dir_next_2
// 1148 					clst = create_chain(dj->fs, dj->clust);		/* Stretch cluster chain */
??dir_next_8:
        LDR      R1,[R4, #+12]
        LDR      R0,[R4, #+0]
        BL       create_chain
        MOVS     R7,R0
// 1149 					if (clst == 0) return FR_DENIED;			/* No free cluster */
        CMP      R7,#+0
        BNE.N    ??dir_next_9
        MOVS     R0,#+7
        B.N      ??dir_next_2
// 1150 					if (clst == 1) return FR_INT_ERR;
??dir_next_9:
        CMP      R7,#+1
        BNE.N    ??dir_next_10
        MOVS     R0,#+2
        B.N      ??dir_next_2
// 1151 					if (clst == 0xFFFFFFFF) return FR_DISK_ERR;
??dir_next_10:
        CMN      R7,#+1
        BNE.N    ??dir_next_11
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1152 					/* Clean-up stretched table */
// 1153 					if (move_window(dj->fs, 0)) return FR_DISK_ERR;	/* Flush active window */
??dir_next_11:
        MOVS     R1,#+0
        LDR      R0,[R4, #+0]
        BL       move_window
        CMP      R0,#+0
        BEQ.N    ??dir_next_12
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1154 					mem_set(dj->fs->win, 0, SS(dj->fs));			/* Clear window buffer */
??dir_next_12:
        MOV      R2,#+512
        MOVS     R1,#+0
        LDR      R0,[R4, #+0]
        ADDS     R0,R0,#+52
        BL       mem_set
// 1155 					dj->fs->winsect = clust2sect(dj->fs, clst);	/* Cluster start sector */
        MOVS     R1,R7
        LDR      R0,[R4, #+0]
        BL       clust2sect
        LDR      R1,[R4, #+0]
        STR      R0,[R1, #+48]
// 1156 					for (c = 0; c < dj->fs->csize; c++) {		/* Fill the new cluster with 0 */
        MOVS     R5,#+0
        B.N      ??dir_next_13
// 1157 						dj->fs->wflag = 1;
// 1158 						if (move_window(dj->fs, 0)) return FR_DISK_ERR;
// 1159 						dj->fs->winsect++;
??dir_next_14:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+48]
        ADDS     R0,R0,#+1
        LDR      R1,[R4, #+0]
        STR      R0,[R1, #+48]
        ADDS     R5,R5,#+1
??dir_next_13:
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+2]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,R0
        BCS.N    ??dir_next_15
        LDR      R0,[R4, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
        MOVS     R1,#+0
        LDR      R0,[R4, #+0]
        BL       move_window
        CMP      R0,#+0
        BEQ.N    ??dir_next_14
        MOVS     R0,#+1
        B.N      ??dir_next_2
// 1160 					}
// 1161 					dj->fs->winsect -= c;						/* Rewind window address */
??dir_next_15:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+48]
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        SUBS     R0,R0,R5
        LDR      R1,[R4, #+0]
        STR      R0,[R1, #+48]
// 1162 #else
// 1163 					return FR_NO_FILE;			/* Report EOT */
// 1164 #endif
// 1165 				}
// 1166 				dj->clust = clst;				/* Initialize data for new cluster */
??dir_next_7:
        STR      R7,[R4, #+12]
// 1167 				dj->sect = clust2sect(dj->fs, clst);
        MOVS     R1,R7
        LDR      R0,[R4, #+0]
        BL       clust2sect
        STR      R0,[R4, #+16]
// 1168 			}
// 1169 		}
// 1170 	}
// 1171 
// 1172 	dj->index = i;
??dir_next_3:
        STRH     R6,[R4, #+6]
// 1173 	dj->dir = dj->fs->win + (i % (SS(dj->fs) / SZ_DIR)) * SZ_DIR;
        UXTH     R6,R6            ;; ZeroExt  R6,R6,#+16,#+16
        MOVS     R0,#+16
        UDIV     R1,R6,R0
        MLS      R1,R1,R0,R6
        LDR      R0,[R4, #+0]
        ADDS     R0,R0,R1, LSL #+5
        ADDW     R0,R0,#+52
        STR      R0,[R4, #+20]
// 1174 
// 1175 	return FR_OK;
        MOVS     R0,#+0
??dir_next_2:
        POP      {R1,R4-R7,PC}    ;; return
// 1176 }

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\"*:<>?|\\177">`:
        DATA
        DC8 "\"*:<>?|\177"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "+,;=[]">`:
        DATA
        DC8 "+,;=[]"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\353\\376\\220MSDOS5.0">`:
        DATA
        DC8 "\353\376\220MSDOS5.0"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "NO NAME    FAT32   ">`:
        DATA
        DC8 "NO NAME    FAT32   "

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "NO NAME    FAT     ">`:
        DATA
        DC8 "NO NAME    FAT     "
// 1177 
// 1178 
// 1179 
// 1180 
// 1181 /*-----------------------------------------------------------------------*/
// 1182 /* LFN handling - Test/Pick/Fit an LFN segment from/to directory entry   */
// 1183 /*-----------------------------------------------------------------------*/
// 1184 #if _USE_LFN
// 1185 static

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
// 1186 const BYTE LfnOfs[] = {1,3,5,7,9,14,16,18,20,22,24,28,30};	/* Offset of LFN chars in the directory entry */
LfnOfs:
        DATA
        DC8 1, 3, 5, 7, 9, 14, 16, 18, 20, 22, 24, 28, 30, 0, 0, 0
// 1187 
// 1188 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1189 static
// 1190 int cmp_lfn (			/* 1:Matched, 0:Not matched */
// 1191 	WCHAR *lfnbuf,		/* Pointer to the LFN to be compared */
// 1192 	BYTE *dir			/* Pointer to the directory entry containing a part of LFN */
// 1193 )
// 1194 {
cmp_lfn:
        PUSH     {R4-R8,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 1195 	UINT i, s;
// 1196 	WCHAR wc, uc;
// 1197 
// 1198 
// 1199 	i = ((dir[LDIR_Ord] & ~LLE) - 1) * 13;	/* Get offset in the LFN buffer */
        LDRB     R0,[R5, #+0]
        BICS     R0,R0,#0x40
        SUBS     R0,R0,#+1
        MOVS     R1,#+13
        MUL      R6,R1,R0
// 1200 	s = 0; wc = 1;
        MOVS     R7,#+0
        MOVS     R8,#+1
// 1201 	do {
// 1202 		uc = LD_WORD(dir+LfnOfs[s]);	/* Pick an LFN character from the entry */
??cmp_lfn_0:
        LDR.W    R0,??DataTable9
        LDRB     R0,[R7, R0]
        ADDS     R0,R0,R5
        LDRB     R0,[R0, #+1]
        LDR.W    R1,??DataTable9
        LDRB     R1,[R7, R1]
        LDRB     R1,[R1, R5]
        ORRS     R0,R1,R0, LSL #+8
// 1203 		if (wc) {	/* Last char has not been processed */
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,#+0
        BEQ.N    ??cmp_lfn_1
// 1204 			wc = ff_wtoupper(uc);		/* Convert it to upper case */
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       ff_wtoupper
        MOV      R8,R0
// 1205 			if (i >= _MAX_LFN || wc != ff_wtoupper(lfnbuf[i++]))	/* Compare it */
        CMP      R6,#+64
        BCS.N    ??cmp_lfn_2
        LDRH     R0,[R4, R6, LSL #+1]
        BL       ff_wtoupper
        ADDS     R6,R6,#+1
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R8,R0
        BEQ.N    ??cmp_lfn_3
// 1206 				return 0;				/* Not matched */
??cmp_lfn_2:
        MOVS     R0,#+0
        B.N      ??cmp_lfn_4
// 1207 		} else {
// 1208 			if (uc != 0xFFFF) return 0;	/* Check filler */
??cmp_lfn_1:
        MOVW     R1,#+65535
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,R1
        BEQ.N    ??cmp_lfn_3
        MOVS     R0,#+0
        B.N      ??cmp_lfn_4
// 1209 		}
// 1210 	} while (++s < 13);				/* Repeat until all chars in the entry are checked */
??cmp_lfn_3:
        ADDS     R7,R7,#+1
        CMP      R7,#+13
        BCC.N    ??cmp_lfn_0
// 1211 
// 1212 	if ((dir[LDIR_Ord] & LLE) && wc && lfnbuf[i])	/* Last segment matched but different length */
        LDRB     R0,[R5, #+0]
        LSLS     R0,R0,#+25
        BPL.N    ??cmp_lfn_5
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,#+0
        BEQ.N    ??cmp_lfn_5
        LDRH     R0,[R4, R6, LSL #+1]
        CMP      R0,#+0
        BEQ.N    ??cmp_lfn_5
// 1213 		return 0;
        MOVS     R0,#+0
        B.N      ??cmp_lfn_4
// 1214 
// 1215 	return 1;						/* The part of LFN matched */
??cmp_lfn_5:
        MOVS     R0,#+1
??cmp_lfn_4:
        POP      {R4-R8,PC}       ;; return
// 1216 }
// 1217 
// 1218 
// 1219 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1220 static
// 1221 int pick_lfn (			/* 1:Succeeded, 0:Buffer overflow */
// 1222 	WCHAR *lfnbuf,		/* Pointer to the Unicode-LFN buffer */
// 1223 	BYTE *dir			/* Pointer to the directory entry */
// 1224 )
// 1225 {
pick_lfn:
        PUSH     {R4-R6}
// 1226 	UINT i, s;
// 1227 	WCHAR wc, uc;
// 1228 
// 1229 
// 1230 	i = ((dir[LDIR_Ord] & 0x3F) - 1) * 13;	/* Offset in the LFN buffer */
        LDRB     R2,[R1, #+0]
        ANDS     R2,R2,#0x3F
        SUBS     R2,R2,#+1
        MOVS     R3,#+13
        MULS     R2,R3,R2
// 1231 
// 1232 	s = 0; wc = 1;
        MOVS     R3,#+0
        MOVS     R4,#+1
// 1233 	do {
// 1234 		uc = LD_WORD(dir+LfnOfs[s]);		/* Pick an LFN character from the entry */
??pick_lfn_0:
        LDR.W    R5,??DataTable9
        LDRB     R5,[R3, R5]
        ADDS     R5,R5,R1
        LDRB     R5,[R5, #+1]
        LDR.W    R6,??DataTable9
        LDRB     R6,[R3, R6]
        LDRB     R6,[R6, R1]
        ORRS     R5,R6,R5, LSL #+8
// 1235 		if (wc) {	/* Last char has not been processed */
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
        CMP      R4,#+0
        BEQ.N    ??pick_lfn_1
// 1236 			if (i >= _MAX_LFN) return 0;	/* Buffer overflow? */
        CMP      R2,#+64
        BCC.N    ??pick_lfn_2
        MOVS     R0,#+0
        B.N      ??pick_lfn_3
// 1237 			lfnbuf[i++] = wc = uc;			/* Store it */
??pick_lfn_2:
        MOVS     R4,R5
        STRH     R4,[R0, R2, LSL #+1]
        ADDS     R2,R2,#+1
// 1238 		} else {
// 1239 			if (uc != 0xFFFF) return 0;		/* Check filler */
// 1240 		}
// 1241 	} while (++s < 13);						/* Read all character in the entry */
??pick_lfn_4:
        ADDS     R3,R3,#+1
        CMP      R3,#+13
        BCC.N    ??pick_lfn_0
// 1242 
// 1243 	if (dir[LDIR_Ord] & LLE) {				/* Put terminator if it is the last LFN part */
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+25
        BPL.N    ??pick_lfn_5
// 1244 		if (i >= _MAX_LFN) return 0;		/* Buffer overflow? */
        CMP      R2,#+64
        BCC.N    ??pick_lfn_6
        MOVS     R0,#+0
        B.N      ??pick_lfn_3
??pick_lfn_1:
        MOVW     R6,#+65535
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,R6
        BEQ.N    ??pick_lfn_4
        MOVS     R0,#+0
        B.N      ??pick_lfn_3
// 1245 		lfnbuf[i] = 0;
??pick_lfn_6:
        MOVS     R1,#+0
        STRH     R1,[R0, R2, LSL #+1]
// 1246 	}
// 1247 
// 1248 	return 1;
??pick_lfn_5:
        MOVS     R0,#+1
??pick_lfn_3:
        POP      {R4-R6}
        BX       LR               ;; return
// 1249 }
// 1250 
// 1251 
// 1252 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1253 static
// 1254 void fit_lfn (
// 1255 	const WCHAR *lfnbuf,	/* Pointer to the LFN buffer */
// 1256 	BYTE *dir,				/* Pointer to the directory entry */
// 1257 	BYTE ord,				/* LFN order (1-20) */
// 1258 	BYTE sum				/* SFN sum */
// 1259 )
// 1260 {
fit_lfn:
        PUSH     {R4-R7}
// 1261 	UINT i, s;
// 1262 	WCHAR wc;
// 1263 
// 1264 
// 1265 	dir[LDIR_Chksum] = sum;			/* Set check sum */
        STRB     R3,[R1, #+13]
// 1266 	dir[LDIR_Attr] = AM_LFN;		/* Set attribute. LFN entry */
        MOVS     R3,#+15
        STRB     R3,[R1, #+11]
// 1267 	dir[LDIR_Type] = 0;
        MOVS     R3,#+0
        STRB     R3,[R1, #+12]
// 1268 	ST_WORD(dir+LDIR_FstClusLO, 0);
        MOVS     R3,#+0
        STRB     R3,[R1, #+26]
        MOVS     R3,#+0
        STRB     R3,[R1, #+27]
// 1269 
// 1270 	i = (ord - 1) * 13;				/* Get offset in the LFN buffer */
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        SUBS     R3,R2,#+1
        MOVS     R4,#+13
        MULS     R3,R4,R3
// 1271 	s = wc = 0;
        MOVS     R4,#+0
        MOVS     R5,R4
        UXTH     R4,R4            ;; ZeroExt  R4,R4,#+16,#+16
// 1272 	do {
// 1273 		if (wc != 0xFFFF) wc = lfnbuf[i++];	/* Get an effective char */
??fit_lfn_0:
        MOVW     R6,#+65535
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,R6
        BEQ.N    ??fit_lfn_1
        LDRH     R5,[R0, R3, LSL #+1]
        ADDS     R3,R3,#+1
// 1274 		ST_WORD(dir+LfnOfs[s], wc);	/* Put it */
??fit_lfn_1:
        LDR.W    R6,??DataTable9
        LDRB     R6,[R4, R6]
        STRB     R5,[R6, R1]
        LDR.W    R6,??DataTable9
        LDRB     R6,[R4, R6]
        ADDS     R6,R6,R1
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LSRS     R7,R5,#+8
        STRB     R7,[R6, #+1]
// 1275 		if (!wc) wc = 0xFFFF;		/* Padding chars following last char */
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+0
        BNE.N    ??fit_lfn_2
        MOVW     R5,#+65535
// 1276 	} while (++s < 13);
??fit_lfn_2:
        ADDS     R4,R4,#+1
        CMP      R4,#+13
        BCC.N    ??fit_lfn_0
// 1277 	if (wc == 0xFFFF || !lfnbuf[i]) ord |= LLE;	/* Bottom LFN part is the start of LFN sequence */
        MOVW     R4,#+65535
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,R4
        BEQ.N    ??fit_lfn_3
        LDRH     R0,[R0, R3, LSL #+1]
        CMP      R0,#+0
        BNE.N    ??fit_lfn_4
??fit_lfn_3:
        ORRS     R2,R2,#0x40
// 1278 	dir[LDIR_Ord] = ord;			/* Set the LFN order */
??fit_lfn_4:
        STRB     R2,[R1, #+0]
// 1279 }
        POP      {R4-R7}
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC32     Files
// 1280 
// 1281 #endif
// 1282 #endif
// 1283 
// 1284 
// 1285 
// 1286 /*-----------------------------------------------------------------------*/
// 1287 /* Create numbered name                                                  */
// 1288 /*-----------------------------------------------------------------------*/
// 1289 #if _USE_LFN

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1290 void gen_numname (
// 1291 	BYTE *dst,			/* Pointer to generated SFN */
// 1292 	const BYTE *src,	/* Pointer to source SFN to be modified */
// 1293 	const WCHAR *lfn,	/* Pointer to LFN */
// 1294 	WORD seq			/* Sequence number */
// 1295 )
// 1296 {
gen_numname:
        PUSH     {R2-R6,LR}
        MOVS     R4,R0
        MOVS     R6,R2
        MOVS     R5,R3
// 1297 	BYTE ns[8], c;
// 1298 	UINT i, j;
// 1299 
// 1300 
// 1301 	mem_cpy(dst, src, 11);
        MOVS     R2,#+11
        MOVS     R0,R4
        BL       mem_cpy
// 1302 
// 1303 	if (seq > 5) {	/* On many collisions, generate a hash number instead of sequential number */
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+6
        BCC.N    ??gen_numname_0
// 1304 		do seq = (seq >> 1) + (seq << 15) + (WORD)*lfn++; while (*lfn);
??gen_numname_1:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        LSLS     R0,R5,#+15
        ADDS     R0,R0,R5, LSR #+1
        LDRH     R1,[R6, #+0]
        ADDS     R5,R1,R0
        ADDS     R6,R6,#+2
        LDRH     R0,[R6, #+0]
        CMP      R0,#+0
        BNE.N    ??gen_numname_1
// 1305 	}
// 1306 
// 1307 	/* itoa (hexdecimal) */
// 1308 	i = 7;
??gen_numname_0:
        MOVS     R0,#+7
// 1309 	do {
// 1310 		c = (seq % 16) + '0';
??gen_numname_2:
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R1,#+16
        SDIV     R2,R5,R1
        MLS      R2,R2,R1,R5
        ADDS     R1,R2,#+48
// 1311 		if (c > '9') c += 7;
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+58
        BCC.N    ??gen_numname_3
        ADDS     R1,R1,#+7
// 1312 		ns[i--] = c;
??gen_numname_3:
        ADD      R2,SP,#+0
        STRB     R1,[R0, R2]
        SUBS     R0,R0,#+1
// 1313 		seq /= 16;
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        MOVS     R1,#+16
        SDIV     R5,R5,R1
// 1314 	} while (seq);
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R5,#+0
        BNE.N    ??gen_numname_2
// 1315 	ns[i] = '~';
        ADD      R1,SP,#+0
        MOVS     R2,#+126
        STRB     R2,[R0, R1]
// 1316 
// 1317 	/* Append the number */
// 1318 	for (j = 0; j < i && dst[j] != ' '; j++) {
        MOVS     R1,#+0
        B.N      ??gen_numname_4
// 1319 		if (IsDBCS1(dst[j])) {
??gen_numname_5:
        ADDS     R1,R1,#+1
??gen_numname_4:
        CMP      R1,R0
        BCS.N    ??gen_numname_6
        LDRB     R2,[R1, R4]
        CMP      R2,#+32
        BNE.N    ??gen_numname_5
// 1320 			if (j == i - 1) break;
// 1321 			j++;
// 1322 		}
// 1323 	}
// 1324 	do {
// 1325 		dst[j++] = (i < 8) ? ns[i++] : ' ';
??gen_numname_6:
        MOVS     R2,R1
        ADDS     R1,R2,#+1
        CMP      R0,#+8
        BCS.N    ??gen_numname_7
        ADD      R3,SP,#+0
        LDRB     R3,[R0, R3]
        ADDS     R0,R0,#+1
        B.N      ??gen_numname_8
??gen_numname_7:
        MOVS     R3,#+32
??gen_numname_8:
        STRB     R3,[R2, R4]
// 1326 	} while (j < 8);
        CMP      R1,#+8
        BCC.N    ??gen_numname_6
// 1327 }
        POP      {R0,R1,R4-R6,PC}  ;; return
// 1328 #endif
// 1329 
// 1330 
// 1331 
// 1332 
// 1333 /*-----------------------------------------------------------------------*/
// 1334 /* Calculate sum of an SFN                                               */
// 1335 /*-----------------------------------------------------------------------*/
// 1336 #if _USE_LFN

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1337 static
// 1338 BYTE sum_sfn (
// 1339 	const BYTE *dir		/* Ptr to directory entry */
// 1340 )
// 1341 {
// 1342 	BYTE sum = 0;
sum_sfn:
        MOVS     R1,#+0
// 1343 	UINT n = 11;
        MOVS     R2,#+11
// 1344 
// 1345 	do sum = (sum >> 1) + (sum << 7) + *dir++; while (--n);
??sum_sfn_0:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LSLS     R3,R1,#+7
        ADDS     R1,R3,R1, LSR #+1
        LDRB     R3,[R0, #+0]
        ADDS     R1,R3,R1
        ADDS     R0,R0,#+1
        SUBS     R2,R2,#+1
        CMP      R2,#+0
        BNE.N    ??sum_sfn_0
// 1346 	return sum;
        MOVS     R0,R1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BX       LR               ;; return
// 1347 }
// 1348 #endif
// 1349 
// 1350 
// 1351 
// 1352 
// 1353 /*-----------------------------------------------------------------------*/
// 1354 /* Directory handling - Find an object in the directory                  */
// 1355 /*-----------------------------------------------------------------------*/
// 1356 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1357 static
// 1358 FRESULT dir_find (
// 1359 	DIR *dj			/* Pointer to the directory object linked to the file name */
// 1360 )
// 1361 {
dir_find:
        PUSH     {R4-R8,LR}
        MOVS     R5,R0
// 1362 	FRESULT res;
// 1363 	BYTE c, *dir;
// 1364 #if _USE_LFN
// 1365 	BYTE a, ord, sum;
// 1366 #endif
// 1367 
// 1368 	res = dir_sdi(dj, 0);			/* Rewind directory object */
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       dir_sdi
        MOVS     R4,R0
// 1369 	if (res != FR_OK) return res;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??dir_find_0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??dir_find_1
// 1370 
// 1371 #if _USE_LFN
// 1372 	ord = sum = 0xFF;
??dir_find_0:
        MOVS     R7,#+255
        MOV      R8,R7
// 1373 #endif
// 1374 	do {
// 1375 		res = move_window(dj->fs, dj->sect);
??dir_find_2:
        LDR      R1,[R5, #+16]
        LDR      R0,[R5, #+0]
        BL       move_window
        MOVS     R4,R0
// 1376 		if (res != FR_OK) break;
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??dir_find_3
// 1377 		dir = dj->dir;					/* Ptr to the directory entry of current index */
??dir_find_4:
        LDR      R6,[R5, #+20]
// 1378 		c = dir[DIR_Name];
        LDRB     R0,[R6, #+0]
// 1379 		if (c == 0) { res = FR_NO_FILE; break; }	/* Reached to end of table */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_find_5
        MOVS     R4,#+4
        B.N      ??dir_find_3
// 1380 #if _USE_LFN	/* LFN configuration */
// 1381 		a = dir[DIR_Attr] & AM_MASK;
??dir_find_5:
        LDRB     R1,[R6, #+11]
        ANDS     R1,R1,#0x3F
// 1382 		if (c == DDE || ((a & AM_VOL) && a != AM_LFN)) {	/* An entry without valid data */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+229
        BEQ.N    ??dir_find_6
        LSLS     R2,R1,#+28
        BPL.N    ??dir_find_7
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+15
        BEQ.N    ??dir_find_7
// 1383 			ord = 0xFF;
??dir_find_6:
        MOVS     R7,#+255
// 1384 		} else {
// 1385 			if (a == AM_LFN) {			/* An LFN entry is found */
// 1386 				if (dj->lfn) {
// 1387 					if (c & LLE) {		/* Is it start of LFN sequence? */
// 1388 						sum = dir[LDIR_Chksum];
// 1389 						c &= ~LLE; ord = c;	/* LFN start order */
// 1390 						dj->lfn_idx = dj->index;
// 1391 					}
// 1392 					/* Check validity of the LFN entry and compare it with given name */
// 1393 					ord = (c == ord && sum == dir[LDIR_Chksum] && cmp_lfn(dj->lfn, dir)) ? ord - 1 : 0xFF;
// 1394 				}
// 1395 			} else {					/* An SFN entry is found */
// 1396 				if (!ord && sum == sum_sfn(dir)) break;	/* LFN matched? */
// 1397 				ord = 0xFF; dj->lfn_idx = 0xFFFF;	/* Reset LFN sequence */
// 1398 				if (!(dj->fn[NS] & NS_LOSS) && !mem_cmp(dir, dj->fn, 11)) break;	/* SFN matched? */
// 1399 			}
// 1400 		}
// 1401 #else		/* Non LFN configuration */
// 1402 		if (!(dir[DIR_Attr] & AM_VOL) && !mem_cmp(dir, dj->fn, 11)) /* Is it a valid entry? */
// 1403 			break;
// 1404 #endif
// 1405 		res = dir_next(dj, 0);		/* Next entry */
??dir_find_8:
        MOVS     R1,#+0
        MOVS     R0,R5
        BL       dir_next
        MOVS     R4,R0
// 1406 	} while (res == FR_OK);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??dir_find_2
// 1407 
// 1408 	return res;
??dir_find_3:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??dir_find_1:
        POP      {R4-R8,PC}       ;; return
??dir_find_7:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+15
        BNE.N    ??dir_find_9
        LDR      R1,[R5, #+28]
        CMP      R1,#+0
        BEQ.N    ??dir_find_8
        LSLS     R1,R0,#+25
        BPL.N    ??dir_find_10
        LDRB     R8,[R6, #+13]
        ANDS     R0,R0,#0xBF
        MOVS     R7,R0
        LDRH     R1,[R5, #+6]
        STRH     R1,[R5, #+32]
??dir_find_10:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R0,R7
        BNE.N    ??dir_find_11
        LDRB     R0,[R6, #+13]
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,R0
        BNE.N    ??dir_find_11
        MOVS     R1,R6
        LDR      R0,[R5, #+28]
        BL       cmp_lfn
        CMP      R0,#+0
        BEQ.N    ??dir_find_11
        SUBS     R7,R7,#+1
        B.N      ??dir_find_12
??dir_find_11:
        MOVS     R7,#+255
??dir_find_12:
        B.N      ??dir_find_8
??dir_find_9:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??dir_find_13
        MOVS     R0,R6
        BL       sum_sfn
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,R0
        BEQ.N    ??dir_find_3
??dir_find_13:
        MOVS     R7,#+255
        MOVW     R0,#+65535
        STRH     R0,[R5, #+32]
        LDR      R0,[R5, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+31
        BMI.N    ??dir_find_8
        MOVS     R2,#+11
        LDR      R1,[R5, #+24]
        MOVS     R0,R6
        BL       mem_cmp
        CMP      R0,#+0
        BNE.N    ??dir_find_8
        B.N      ??dir_find_3
// 1409 }
// 1410 
// 1411 
// 1412 
// 1413 
// 1414 /*-----------------------------------------------------------------------*/
// 1415 /* Read an object from the directory                                     */
// 1416 /*-----------------------------------------------------------------------*/
// 1417 #if _FS_MINIMIZE <= 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1418 static
// 1419 FRESULT dir_read (
// 1420 	DIR *dj			/* Pointer to the directory object that pointing the entry to be read */
// 1421 )
// 1422 {
dir_read:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
// 1423 	FRESULT res;
// 1424 	BYTE c, *dir;
// 1425 #if _USE_LFN
// 1426 	BYTE a, ord = 0xFF, sum = 0xFF;
        MOVS     R6,#+255
        MOVS     R7,#+255
// 1427 #endif
// 1428 
// 1429 	res = FR_NO_FILE;
        MOVS     R5,#+4
// 1430 	while (dj->sect) {
??dir_read_0:
        LDR      R0,[R4, #+16]
        CMP      R0,#+0
        BEQ.N    ??dir_read_1
// 1431 		res = move_window(dj->fs, dj->sect);
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
        MOVS     R5,R0
// 1432 		if (res != FR_OK) break;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_read_1
// 1433 		dir = dj->dir;					/* Ptr to the directory entry of current index */
??dir_read_2:
        LDR      R0,[R4, #+20]
// 1434 		c = dir[DIR_Name];
        LDRB     R1,[R0, #+0]
// 1435 		if (c == 0) { res = FR_NO_FILE; break; }	/* Reached to end of table */
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BNE.N    ??dir_read_3
        MOVS     R5,#+4
        B.N      ??dir_read_1
// 1436 #if _USE_LFN	/* LFN configuration */
// 1437 		a = dir[DIR_Attr] & AM_MASK;
??dir_read_3:
        LDRB     R2,[R0, #+11]
        ANDS     R2,R2,#0x3F
// 1438 		if (c == DDE || (!_FS_RPATH && c == '.') || ((a & AM_VOL) && a != AM_LFN)) {	/* An entry without valid data */
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+229
        BEQ.N    ??dir_read_4
        LSLS     R3,R2,#+28
        BPL.N    ??dir_read_5
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+15
        BEQ.N    ??dir_read_5
// 1439 			ord = 0xFF;
??dir_read_4:
        MOVS     R6,#+255
// 1440 		} else {
// 1441 			if (a == AM_LFN) {			/* An LFN entry is found */
// 1442 				if (c & LLE) {			/* Is it start of LFN sequence? */
// 1443 					sum = dir[LDIR_Chksum];
// 1444 					c &= ~LLE; ord = c;
// 1445 					dj->lfn_idx = dj->index;
// 1446 				}
// 1447 				/* Check LFN validity and capture it */
// 1448 				ord = (c == ord && sum == dir[LDIR_Chksum] && pick_lfn(dj->lfn, dir)) ? ord - 1 : 0xFF;
// 1449 			} else {					/* An SFN entry is found */
// 1450 				if (ord || sum != sum_sfn(dir))	/* Is there a valid LFN? */
// 1451 					dj->lfn_idx = 0xFFFF;		/* It has no LFN. */
// 1452 				break;
// 1453 			}
// 1454 		}
// 1455 #else		/* Non LFN configuration */
// 1456 		if (c != DDE && (_FS_RPATH || c != '.') && !(dir[DIR_Attr] & AM_VOL))	/* Is it a valid entry? */
// 1457 			break;
// 1458 #endif
// 1459 		res = dir_next(dj, 0);				/* Next entry */
??dir_read_6:
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_next
        MOVS     R5,R0
// 1460 		if (res != FR_OK) break;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??dir_read_0
// 1461 	}
// 1462 
// 1463 	if (res != FR_OK) dj->sect = 0;
??dir_read_1:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??dir_read_7
        MOVS     R0,#+0
        STR      R0,[R4, #+16]
// 1464 
// 1465 	return res;
??dir_read_7:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4-R7,PC}    ;; return
??dir_read_5:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+15
        BNE.N    ??dir_read_8
        LSLS     R2,R1,#+25
        BPL.N    ??dir_read_9
        LDRB     R7,[R0, #+13]
        ANDS     R1,R1,#0xBF
        MOVS     R6,R1
        LDRH     R2,[R4, #+6]
        STRH     R2,[R4, #+32]
??dir_read_9:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R1,R6
        BNE.N    ??dir_read_10
        LDRB     R1,[R0, #+13]
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,R1
        BNE.N    ??dir_read_10
        MOVS     R1,R0
        LDR      R0,[R4, #+28]
        BL       pick_lfn
        CMP      R0,#+0
        BEQ.N    ??dir_read_10
        SUBS     R6,R6,#+1
        B.N      ??dir_read_11
??dir_read_10:
        MOVS     R6,#+255
??dir_read_11:
        B.N      ??dir_read_6
??dir_read_8:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??dir_read_12
        BL       sum_sfn
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,R0
        BEQ.N    ??dir_read_13
??dir_read_12:
        MOVW     R0,#+65535
        STRH     R0,[R4, #+32]
??dir_read_13:
        B.N      ??dir_read_1
// 1466 }
// 1467 #endif
// 1468 
// 1469 
// 1470 
// 1471 /*-----------------------------------------------------------------------*/
// 1472 /* Register an object to the directory                                   */
// 1473 /*-----------------------------------------------------------------------*/
// 1474 #if !_FS_READONLY

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1475 static
// 1476 FRESULT dir_register (	/* FR_OK:Successful, FR_DENIED:No free entry or too many SFN collision, FR_DISK_ERR:Disk error */
// 1477 	DIR *dj				/* Target directory with object name to be created */
// 1478 )
// 1479 {
dir_register:
        PUSH     {R4-R8,LR}
        SUB      SP,SP,#+16
        MOVS     R4,R0
// 1480 	FRESULT res;
// 1481 	BYTE c, *dir;
// 1482 #if _USE_LFN	/* LFN configuration */
// 1483 	WORD n, ne, is;
// 1484 	BYTE sn[12], *fn, sum;
// 1485 	WCHAR *lfn;
// 1486 
// 1487 
// 1488 	fn = dj->fn; lfn = dj->lfn;
        LDR      R7,[R4, #+24]
        LDR      R6,[R4, #+28]
// 1489 	mem_cpy(sn, fn, 12);
        MOVS     R2,#+12
        MOVS     R1,R7
        ADD      R0,SP,#+0
        BL       mem_cpy
// 1490 
// 1491 	if (_FS_RPATH && (sn[NS] & NS_DOT))		/* Cannot create dot entry */
        LDRB     R0,[SP, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??dir_register_0
// 1492 		return FR_INVALID_NAME;
        MOVS     R0,#+6
        B.N      ??dir_register_1
// 1493 
// 1494 	if (sn[NS] & NS_LOSS) {			/* When LFN is out of 8.3 format, generate a numbered name */
??dir_register_0:
        LDRB     R0,[SP, #+11]
        LSLS     R0,R0,#+31
        BPL.N    ??dir_register_2
// 1495 		fn[NS] = 0; dj->lfn = 0;			/* Find only SFN */
        MOVS     R0,#+0
        STRB     R0,[R7, #+11]
        MOVS     R0,#+0
        STR      R0,[R4, #+28]
// 1496 		for (n = 1; n < 100; n++) {
        MOVS     R8,#+1
        B.N      ??dir_register_3
??dir_register_4:
        ADDS     R8,R8,#+1
??dir_register_3:
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,#+100
        BCS.N    ??dir_register_5
// 1497 			gen_numname(fn, sn, lfn, n);	/* Generate a numbered name */
        MOV      R3,R8
        UXTH     R3,R3            ;; ZeroExt  R3,R3,#+16,#+16
        MOVS     R2,R6
        ADD      R1,SP,#+0
        MOVS     R0,R7
        BL       gen_numname
// 1498 			res = dir_find(dj);				/* Check if the name collides with existing SFN */
        MOVS     R0,R4
        BL       dir_find
        MOVS     R5,R0
// 1499 			if (res != FR_OK) break;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??dir_register_4
// 1500 		}
// 1501 		if (n == 100) return FR_DENIED;		/* Abort if too many collisions */
??dir_register_5:
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,#+100
        BNE.N    ??dir_register_6
        MOVS     R0,#+7
        B.N      ??dir_register_1
// 1502 		if (res != FR_NO_FILE) return res;	/* Abort if the result is other than 'not collided' */
??dir_register_6:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+4
        BEQ.N    ??dir_register_7
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??dir_register_1
// 1503 		fn[NS] = sn[NS]; dj->lfn = lfn;
??dir_register_7:
        LDRB     R0,[SP, #+11]
        STRB     R0,[R7, #+11]
        STR      R6,[R4, #+28]
// 1504 	}
// 1505 
// 1506 	if (sn[NS] & NS_LFN) {			/* When LFN is to be created, reserve an SFN + LFN entries. */
??dir_register_2:
        LDRB     R0,[SP, #+11]
        LSLS     R0,R0,#+30
        BPL.N    ??dir_register_8
// 1507 		for (ne = 0; lfn[ne]; ne++) ;
        MOVS     R7,#+0
        B.N      ??dir_register_9
??dir_register_10:
        ADDS     R7,R7,#+1
??dir_register_9:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        LDRH     R0,[R6, R7, LSL #+1]
        CMP      R0,#+0
        BNE.N    ??dir_register_10
// 1508 		ne = (ne + 25) / 13;
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        ADDS     R0,R7,#+25
        MOVS     R1,#+13
        SDIV     R7,R0,R1
        B.N      ??dir_register_11
// 1509 	} else {						/* Otherwise reserve only an SFN entry. */
// 1510 		ne = 1;
??dir_register_8:
        MOVS     R7,#+1
// 1511 	}
// 1512 
// 1513 	/* Reserve contiguous entries */
// 1514 	res = dir_sdi(dj, 0);
??dir_register_11:
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
        MOVS     R5,R0
// 1515 	if (res != FR_OK) return res;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??dir_register_12
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??dir_register_1
// 1516 	n = is = 0;
??dir_register_12:
        MOVS     R8,#+0
        MOV      R6,R8
// 1517 	do {
// 1518 		res = move_window(dj->fs, dj->sect);
??dir_register_13:
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
        MOVS     R5,R0
// 1519 		if (res != FR_OK) break;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_14
// 1520 		c = *dj->dir;				/* Check the entry status */
??dir_register_15:
        LDR      R0,[R4, #+20]
        LDRB     R0,[R0, #+0]
// 1521 		if (c == DDE || c == 0) {	/* Is it a blank entry? */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+229
        BEQ.N    ??dir_register_16
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_register_17
// 1522 			if (n == 0) is = dj->index;	/* First index of the contiguous entry */
??dir_register_16:
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        CMP      R8,#+0
        BNE.N    ??dir_register_18
        LDRH     R6,[R4, #+6]
// 1523 			if (++n == ne) break;	/* A contiguous entry that required count is found */
??dir_register_18:
        ADDS     R8,R8,#+1
        MOV      R0,R8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R0,R7
        BNE.N    ??dir_register_19
        B.N      ??dir_register_14
// 1524 		} else {
// 1525 			n = 0;					/* Not a blank entry. Restart to search */
??dir_register_17:
        MOVS     R8,#+0
// 1526 		}
// 1527 		res = dir_next(dj, 1);		/* Next entry with table stretch */
??dir_register_19:
        MOVS     R1,#+1
        MOVS     R0,R4
        BL       dir_next
        MOVS     R5,R0
// 1528 	} while (res == FR_OK);
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??dir_register_13
// 1529 
// 1530 	if (res == FR_OK && ne > 1) {	/* Initialize LFN entry if needed */
??dir_register_14:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_20
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+2
        BCC.N    ??dir_register_20
// 1531 		res = dir_sdi(dj, is);
        MOVS     R1,R6
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,R4
        BL       dir_sdi
        MOVS     R5,R0
// 1532 		if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_20
// 1533 			sum = sum_sfn(dj->fn);	/* Sum of the SFN tied to the LFN */
        LDR      R0,[R4, #+24]
        BL       sum_sfn
        MOVS     R6,R0
// 1534 			ne--;
        SUBS     R7,R7,#+1
// 1535 			do {					/* Store LFN entries in bottom first */
// 1536 				res = move_window(dj->fs, dj->sect);
??dir_register_21:
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
        MOVS     R5,R0
// 1537 				if (res != FR_OK) break;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_20
// 1538 				fit_lfn(dj->lfn, dj->dir, (BYTE)ne, sum);
??dir_register_22:
        MOVS     R3,R6
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOVS     R2,R7
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        LDR      R1,[R4, #+20]
        LDR      R0,[R4, #+28]
        BL       fit_lfn
// 1539 				dj->fs->wflag = 1;
        LDR      R0,[R4, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
// 1540 				res = dir_next(dj, 0);	/* Next entry */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_next
        MOVS     R5,R0
// 1541 			} while (res == FR_OK && --ne);
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_20
        SUBS     R7,R7,#+1
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BNE.N    ??dir_register_21
// 1542 		}
// 1543 	}
// 1544 
// 1545 #else	/* Non LFN configuration */
// 1546 	res = dir_sdi(dj, 0);
// 1547 	if (res == FR_OK) {
// 1548 		do {	/* Find a blank entry for the SFN */
// 1549 			res = move_window(dj->fs, dj->sect);
// 1550 			if (res != FR_OK) break;
// 1551 			c = *dj->dir;
// 1552 			if (c == DDE || c == 0) break;	/* Is it a blank entry? */
// 1553 			res = dir_next(dj, 1);			/* Next entry with table stretch */
// 1554 		} while (res == FR_OK);
// 1555 	}
// 1556 #endif
// 1557 
// 1558 	if (res == FR_OK) {		/* Initialize the SFN entry */
??dir_register_20:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_23
// 1559 		res = move_window(dj->fs, dj->sect);
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
        MOVS     R5,R0
// 1560 		if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??dir_register_23
// 1561 			dir = dj->dir;
        LDR      R6,[R4, #+20]
// 1562 			mem_set(dir, 0, SZ_DIR);	/* Clean the entry */
        MOVS     R2,#+32
        MOVS     R1,#+0
        MOVS     R0,R6
        BL       mem_set
// 1563 			mem_cpy(dir, dj->fn, 11);	/* Put SFN */
        MOVS     R2,#+11
        LDR      R1,[R4, #+24]
        MOVS     R0,R6
        BL       mem_cpy
// 1564 #if _USE_LFN
// 1565 			dir[DIR_NTres] = *(dj->fn+NS) & (NS_BODY | NS_EXT);	/* Put NT flag */
        LDR      R0,[R4, #+24]
        LDRB     R0,[R0, #+11]
        ANDS     R0,R0,#0x18
        STRB     R0,[R6, #+12]
// 1566 #endif
// 1567 			dj->fs->wflag = 1;
        LDR      R0,[R4, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
// 1568 		}
// 1569 	}
// 1570 
// 1571 	return res;
??dir_register_23:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??dir_register_1:
        ADD      SP,SP,#+16
        POP      {R4-R8,PC}       ;; return
// 1572 }
// 1573 #endif /* !_FS_READONLY */
// 1574 
// 1575 
// 1576 
// 1577 
// 1578 /*-----------------------------------------------------------------------*/
// 1579 /* Remove an object from the directory                                   */
// 1580 /*-----------------------------------------------------------------------*/
// 1581 #if !_FS_READONLY && !_FS_MINIMIZE

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1582 static
// 1583 FRESULT dir_remove (	/* FR_OK: Successful, FR_DISK_ERR: A disk error */
// 1584 	DIR *dj				/* Directory object pointing the entry to be removed */
// 1585 )
// 1586 {
dir_remove:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
// 1587 	FRESULT res;
// 1588 #if _USE_LFN	/* LFN configuration */
// 1589 	WORD i;
// 1590 
// 1591 	i = dj->index;	/* SFN index */
        LDRH     R5,[R4, #+6]
// 1592 	res = dir_sdi(dj, (WORD)((dj->lfn_idx == 0xFFFF) ? i : dj->lfn_idx));	/* Goto the SFN or top of the LFN entries */
        LDRH     R0,[R4, #+32]
        MOVW     R1,#+65535
        CMP      R0,R1
        BNE.N    ??dir_remove_0
        MOVS     R1,R5
        B.N      ??dir_remove_1
??dir_remove_0:
        LDRH     R1,[R4, #+32]
??dir_remove_1:
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        MOVS     R0,R4
        BL       dir_sdi
// 1593 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_remove_2
// 1594 		do {
// 1595 			res = move_window(dj->fs, dj->sect);
??dir_remove_3:
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       move_window
// 1596 			if (res != FR_OK) break;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??dir_remove_4
// 1597 			*dj->dir = DDE;			/* Mark the entry "deleted" */
??dir_remove_5:
        LDR      R1,[R4, #+20]
        MOVS     R2,#+229
        STRB     R2,[R1, #+0]
// 1598 			dj->fs->wflag = 1;
        LDR      R1,[R4, #+0]
        MOVS     R2,#+1
        STRB     R2,[R1, #+4]
// 1599 			if (dj->index >= i) break;	/* When reached SFN, all entries of the object has been deleted. */
        LDRH     R1,[R4, #+6]
        UXTH     R5,R5            ;; ZeroExt  R5,R5,#+16,#+16
        CMP      R1,R5
        BCS.N    ??dir_remove_4
// 1600 			res = dir_next(dj, 0);		/* Next entry */
??dir_remove_6:
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_next
// 1601 		} while (res == FR_OK);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??dir_remove_3
// 1602 		if (res == FR_NO_FILE) res = FR_INT_ERR;
??dir_remove_4:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BNE.N    ??dir_remove_2
        MOVS     R0,#+2
// 1603 	}
// 1604 
// 1605 #else			/* Non LFN configuration */
// 1606 	res = dir_sdi(dj, dj->index);
// 1607 	if (res == FR_OK) {
// 1608 		res = move_window(dj->fs, dj->sect);
// 1609 		if (res == FR_OK) {
// 1610 			*dj->dir = DDE;			/* Mark the entry "deleted" */
// 1611 			dj->fs->wflag = 1;
// 1612 		}
// 1613 	}
// 1614 #endif
// 1615 
// 1616 	return res;
??dir_remove_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
// 1617 }
// 1618 #endif /* !_FS_READONLY */
// 1619 
// 1620 
// 1621 
// 1622 
// 1623 /*-----------------------------------------------------------------------*/
// 1624 /* Pick a segment and create the object name in directory form           */
// 1625 /*-----------------------------------------------------------------------*/
// 1626 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1627 static
// 1628 FRESULT create_name (
// 1629 	DIR *dj,			/* Pointer to the directory object */
// 1630 	const TCHAR **path	/* Pointer to pointer to the segment in the path string */
// 1631 )
// 1632 {
create_name:
        PUSH     {R0,R4-R11,LR}
        MOV      R8,R1
// 1633 #ifdef _EXCVT
// 1634 	static const BYTE excvt[] = _EXCVT;	/* Upper conversion table for extended chars */
// 1635 #endif
// 1636 
// 1637 #if _USE_LFN	/* LFN configuration */
// 1638 	BYTE b, cf;
// 1639 	WCHAR w, *lfn;
// 1640 	UINT i, ni, si, di;
// 1641 	const TCHAR *p;
// 1642 
// 1643 	/* Create LFN in Unicode */
// 1644 	for (p = *path; *p == '/' || *p == '\\'; p++) ;	/* Strip duplicated separator */
        LDR      R9,[R8, #+0]
        B.N      ??create_name_0
??create_name_1:
        ADDS     R9,R9,#+1
??create_name_0:
        LDRB     R0,[R9, #+0]
        CMP      R0,#+47
        BEQ.N    ??create_name_1
        LDRB     R0,[R9, #+0]
        CMP      R0,#+92
        BEQ.N    ??create_name_1
// 1645 	lfn = dj->lfn;
        LDR      R0,[SP, #+0]
        LDR      R6,[R0, #+28]
// 1646 	si = di = 0;
        MOVS     R4,#+0
        MOVS     R5,R4
        B.N      ??create_name_2
// 1647 	for (;;) {
// 1648 		w = p[si++];					/* Get a character */
// 1649 		if (w < ' ' || w == '/' || w == '\\') break;	/* Break on end of segment */
// 1650 		if (di >= _MAX_LFN)				/* Reject too long name */
// 1651 			return FR_INVALID_NAME;
// 1652 #if !_LFN_UNICODE
// 1653 		w &= 0xFF;
// 1654 		if (IsDBCS1(w)) {				/* Check if it is a DBC 1st byte (always false on SBCS cfg) */
// 1655 			b = (BYTE)p[si++];			/* Get 2nd byte */
// 1656 			if (!IsDBCS2(b))
// 1657 				return FR_INVALID_NAME;	/* Reject invalid sequence */
// 1658 			w = (w << 8) + b;			/* Create a DBC */
// 1659 		}
// 1660 		w = ff_convert(w, 1);			/* Convert ANSI/OEM to Unicode */
// 1661 		if (!w) return FR_INVALID_NAME;	/* Reject invalid code */
// 1662 #endif
// 1663 		if (w < 0x80 && chk_chr("\"*:<>\?|\x7F", w)) /* Reject illegal chars for LFN */
// 1664 			return FR_INVALID_NAME;
// 1665 		lfn[di++] = w;					/* Store the Unicode char */
??create_name_3:
        STRH     R7,[R6, R5, LSL #+1]
        ADDS     R5,R5,#+1
??create_name_2:
        LDRB     R7,[R4, R9]
        ADDS     R4,R4,#+1
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+32
        BCC.N    ??create_name_4
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+47
        BEQ.N    ??create_name_4
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+92
        BNE.N    ??create_name_5
// 1666 	}
// 1667 	*path = &p[si];						/* Return pointer to the next segment */
??create_name_4:
        ADDS     R0,R4,R9
        STR      R0,[R8, #+0]
// 1668 	cf = (w < ' ') ? NS_LAST : 0;		/* Set last segment flag if end of path */
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+32
        BCS.N    ??create_name_6
        MOVS     R8,#+4
        B.N      ??create_name_7
??create_name_5:
        CMP      R5,#+64
        BCC.N    ??create_name_8
        MOVS     R0,#+6
        B.N      ??create_name_9
??create_name_8:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        MOVS     R1,#+1
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       ff_convert
        MOVS     R7,R0
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+0
        BNE.N    ??create_name_10
        MOVS     R0,#+6
        B.N      ??create_name_9
??create_name_10:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+128
        BCS.N    ??create_name_3
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        MOVS     R1,R7
        LDR.W    R0,??DataTable11
        BL       chk_chr
        CMP      R0,#+0
        BEQ.N    ??create_name_3
        MOVS     R0,#+6
        B.N      ??create_name_9
??create_name_6:
        MOVS     R8,#+0
// 1669 #if _FS_RPATH
// 1670 	if ((di == 1 && lfn[di-1] == '.') || /* Is this a dot entry? */
// 1671 		(di == 2 && lfn[di-1] == '.' && lfn[di-2] == '.')) {
??create_name_7:
        CMP      R5,#+1
        BNE.N    ??create_name_11
        ADDS     R0,R6,R5, LSL #+1
        LDRH     R0,[R0, #-2]
        CMP      R0,#+46
        BEQ.N    ??create_name_12
??create_name_11:
        CMP      R5,#+2
        BNE.N    ??create_name_13
        ADDS     R0,R6,R5, LSL #+1
        LDRH     R0,[R0, #-2]
        CMP      R0,#+46
        BNE.N    ??create_name_13
        ADDS     R0,R6,R5, LSL #+1
        LDRH     R0,[R0, #-4]
        CMP      R0,#+46
        BNE.N    ??create_name_13
// 1672 		lfn[di] = 0;
??create_name_12:
        MOVS     R0,#+0
        STRH     R0,[R6, R5, LSL #+1]
// 1673 		for (i = 0; i < 11; i++)
        MOVS     R9,#+0
        B.N      ??create_name_14
// 1674 			dj->fn[i] = (i < di) ? '.' : ' ';
??create_name_15:
        MOVS     R0,#+32
??create_name_16:
        LDR      R1,[SP, #+0]
        LDR      R1,[R1, #+24]
        STRB     R0,[R9, R1]
        ADDS     R9,R9,#+1
??create_name_14:
        CMP      R9,#+11
        BCS.N    ??create_name_17
        CMP      R9,R5
        BCS.N    ??create_name_15
        MOVS     R0,#+46
        B.N      ??create_name_16
// 1675 		dj->fn[i] = cf | NS_DOT;		/* This is a dot entry */
??create_name_17:
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+24]
        ORRS     R1,R8,#0x20
        STRB     R1,[R9, R0]
// 1676 		return FR_OK;
        MOVS     R0,#+0
        B.N      ??create_name_9
// 1677 	}
// 1678 #endif
// 1679 	while (di) {						/* Strip trailing spaces and dots */
// 1680 		w = lfn[di-1];
// 1681 		if (w != ' ' && w != '.') break;
// 1682 		di--;
??create_name_18:
        SUBS     R5,R5,#+1
??create_name_13:
        CMP      R5,#+0
        BEQ.N    ??create_name_19
        ADDS     R0,R6,R5, LSL #+1
        LDRH     R7,[R0, #-2]
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+32
        BEQ.N    ??create_name_18
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+46
        BEQ.N    ??create_name_18
// 1683 	}
// 1684 	if (!di) return FR_INVALID_NAME;	/* Reject nul string */
??create_name_19:
        CMP      R5,#+0
        BNE.N    ??create_name_20
        MOVS     R0,#+6
        B.N      ??create_name_9
// 1685 
// 1686 	lfn[di] = 0;						/* LFN is created */
??create_name_20:
        MOVS     R0,#+0
        STRH     R0,[R6, R5, LSL #+1]
// 1687 
// 1688 	/* Create SFN in directory form */
// 1689 	mem_set(dj->fn, ' ', 11);
        MOVS     R2,#+11
        MOVS     R1,#+32
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+24]
        BL       mem_set
// 1690 	for (si = 0; lfn[si] == ' ' || lfn[si] == '.'; si++) ;	/* Strip leading spaces and dots */
        MOVS     R4,#+0
        B.N      ??create_name_21
??create_name_22:
        ADDS     R4,R4,#+1
??create_name_21:
        LDRH     R0,[R6, R4, LSL #+1]
        CMP      R0,#+32
        BEQ.N    ??create_name_22
        LDRH     R0,[R6, R4, LSL #+1]
        CMP      R0,#+46
        BEQ.N    ??create_name_22
// 1691 	if (si) cf |= NS_LOSS | NS_LFN;
        CMP      R4,#+0
        BEQ.N    ??create_name_23
        ORRS     R8,R8,#0x3
        B.N      ??create_name_23
// 1692 	while (di && lfn[di - 1] != '.') di--;	/* Find extension (di<=si: no extension) */
??create_name_24:
        SUBS     R5,R5,#+1
??create_name_23:
        CMP      R5,#+0
        BEQ.N    ??create_name_25
        ADDS     R0,R6,R5, LSL #+1
        LDRH     R0,[R0, #-2]
        CMP      R0,#+46
        BNE.N    ??create_name_24
// 1693 
// 1694 	b = i = 0; ni = 8;
??create_name_25:
        MOVS     R10,#+0
        MOV      R9,R10
        MOVS     R11,#+8
        B.N      ??create_name_26
// 1695 	for (;;) {
// 1696 		w = lfn[si++];					/* Get an LFN char */
// 1697 		if (!w) break;					/* Break on end of the LFN */
// 1698 		if (w == ' ' || (w == '.' && si != di)) {	/* Remove spaces and dots */
// 1699 			cf |= NS_LOSS | NS_LFN; continue;
??create_name_27:
        ORRS     R8,R8,#0x3
// 1700 		}
??create_name_26:
        LDRH     R7,[R6, R4, LSL #+1]
        ADDS     R4,R4,#+1
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+0
        BNE.N    ??create_name_28
// 1701 
// 1702 		if (i >= ni || si == di) {		/* Extension or end of SFN */
// 1703 			if (ni == 11) {				/* Long extension */
// 1704 				cf |= NS_LOSS | NS_LFN; break;
// 1705 			}
// 1706 			if (si != di) cf |= NS_LOSS | NS_LFN;	/* Out of 8.3 format */
// 1707 			if (si > di) break;			/* No extension */
// 1708 			si = di; i = 8; ni = 11;	/* Enter extension section */
// 1709 			b <<= 2; continue;
// 1710 		}
// 1711 
// 1712 		if (w >= 0x80) {				/* Non ASCII char */
// 1713 #ifdef _EXCVT
// 1714 			w = ff_convert(w, 0);		/* Unicode -> OEM code */
// 1715 			if (w) w = excvt[w - 0x80];	/* Convert extended char to upper (SBCS) */
// 1716 #else
// 1717 			w = ff_convert(ff_wtoupper(w), 0);	/* Upper converted Unicode -> OEM code */
// 1718 #endif
// 1719 			cf |= NS_LFN;				/* Force create LFN entry */
// 1720 		}
// 1721 
// 1722 		if (_DF1S && w >= 0x100) {		/* Double byte char (always false on SBCS cfg) */
// 1723 			if (i >= ni - 1) {
// 1724 				cf |= NS_LOSS | NS_LFN; i = ni; continue;
// 1725 			}
// 1726 			dj->fn[i++] = (BYTE)(w >> 8);
// 1727 		} else {						/* Single byte char */
// 1728 			if (!w || chk_chr("+,;=[]", w)) {	/* Replace illegal chars for SFN */
// 1729 				w = '_'; cf |= NS_LOSS | NS_LFN;/* Lossy conversion */
// 1730 			} else {
// 1731 				if (IsUpper(w)) {		/* ASCII large capital */
// 1732 					b |= 2;
// 1733 				} else {
// 1734 					if (IsLower(w)) {	/* ASCII small capital */
// 1735 						b |= 1; w -= 0x20;
// 1736 					}
// 1737 				}
// 1738 			}
// 1739 		}
// 1740 		dj->fn[i++] = (BYTE)w;
// 1741 	}
// 1742 
// 1743 	if (dj->fn[0] == DDE) dj->fn[0] = NDDE;	/* If the first char collides with deleted mark, replace it with 0x05 */
??create_name_29:
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+24]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+229
        BNE.N    ??create_name_30
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+24]
        MOVS     R1,#+5
        STRB     R1,[R0, #+0]
// 1744 
// 1745 	if (ni == 8) b <<= 2;
??create_name_30:
        CMP      R11,#+8
        BNE.N    ??create_name_31
        LSLS     R10,R10,#+2
// 1746 	if ((b & 0x0C) == 0x0C || (b & 0x03) == 0x03)	/* Create LFN entry when there are composite capitals */
??create_name_31:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        ANDS     R0,R10,#0xC
        CMP      R0,#+12
        BEQ.N    ??create_name_32
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        ANDS     R0,R10,#0x3
        CMP      R0,#+3
        BNE.N    ??create_name_33
// 1747 		cf |= NS_LFN;
??create_name_32:
        ORRS     R8,R8,#0x2
// 1748 	if (!(cf & NS_LFN)) {						/* When LFN is in 8.3 format without extended char, NT flags are created */
??create_name_33:
        LSLS     R0,R8,#+30
        BMI.N    ??create_name_34
// 1749 		if ((b & 0x03) == 0x01) cf |= NS_EXT;	/* NT flag (Extension has only small capital) */
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        ANDS     R0,R10,#0x3
        CMP      R0,#+1
        BNE.N    ??create_name_35
        ORRS     R8,R8,#0x10
// 1750 		if ((b & 0x0C) == 0x04) cf |= NS_BODY;	/* NT flag (Filename has only small capital) */
??create_name_35:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        ANDS     R0,R10,#0xC
        CMP      R0,#+4
        BNE.N    ??create_name_34
        ORRS     R8,R8,#0x8
// 1751 	}
// 1752 
// 1753 	dj->fn[NS] = cf;	/* SFN is created */
??create_name_34:
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+24]
        STRB     R8,[R0, #+11]
// 1754 
// 1755 	return FR_OK;
        MOVS     R0,#+0
??create_name_9:
        POP      {R1,R4-R11,PC}   ;; return
??create_name_28:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+32
        BEQ.N    ??create_name_27
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+46
        BNE.N    ??create_name_36
        CMP      R4,R5
        BNE.N    ??create_name_27
??create_name_36:
        CMP      R9,R11
        BCS.N    ??create_name_37
        CMP      R4,R5
        BNE.N    ??create_name_38
??create_name_37:
        CMP      R11,#+11
        BNE.N    ??create_name_39
        ORRS     R8,R8,#0x3
        B.N      ??create_name_29
??create_name_39:
        CMP      R4,R5
        BEQ.N    ??create_name_40
        ORRS     R8,R8,#0x3
??create_name_40:
        CMP      R5,R4
        BCC.N    ??create_name_29
??create_name_41:
        MOVS     R4,R5
        MOVS     R9,#+8
        MOVS     R11,#+11
        LSLS     R10,R10,#+2
        B.N      ??create_name_26
??create_name_38:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+128
        BCC.N    ??create_name_42
        MOVS     R1,#+0
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       ff_convert
        MOVS     R7,R0
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+0
        BEQ.N    ??create_name_43
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        LDR.W    R0,??DataTable11_1
        ADDS     R0,R7,R0
        LDRB     R7,[R0, #-128]
??create_name_43:
        ORRS     R8,R8,#0x2
??create_name_42:
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        CMP      R7,#+0
        BEQ.N    ??create_name_44
        UXTH     R7,R7            ;; ZeroExt  R7,R7,#+16,#+16
        MOVS     R1,R7
        LDR.W    R0,??DataTable11_2
        BL       chk_chr
        CMP      R0,#+0
        BEQ.N    ??create_name_45
??create_name_44:
        MOVS     R7,#+95
        ORRS     R8,R8,#0x3
        B.N      ??create_name_46
??create_name_45:
        SUBS     R0,R7,#+65
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+26
        BCS.N    ??create_name_47
        ORRS     R10,R10,#0x2
        B.N      ??create_name_46
??create_name_47:
        SUBS     R0,R7,#+97
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+26
        BCS.N    ??create_name_46
        ORRS     R10,R10,#0x1
        SUBS     R7,R7,#+32
??create_name_46:
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+24]
        STRB     R7,[R9, R0]
        ADDS     R9,R9,#+1
        B.N      ??create_name_26
// 1756 
// 1757 
// 1758 #else	/* Non-LFN configuration */
// 1759 	BYTE b, c, d, *sfn;
// 1760 	UINT ni, si, i;
// 1761 	const char *p;
// 1762 
// 1763 	/* Create file name in directory form */
// 1764 	for (p = *path; *p == '/' || *p == '\\'; p++) ;	/* Strip duplicated separator */
// 1765 	sfn = dj->fn;
// 1766 	mem_set(sfn, ' ', 11);
// 1767 	si = i = b = 0; ni = 8;
// 1768 #if _FS_RPATH
// 1769 	if (p[si] == '.') { /* Is this a dot entry? */
// 1770 		for (;;) {
// 1771 			c = (BYTE)p[si++];
// 1772 			if (c != '.' || si >= 3) break;
// 1773 			sfn[i++] = c;
// 1774 		}
// 1775 		if (c != '/' && c != '\\' && c > ' ') return FR_INVALID_NAME;
// 1776 		*path = &p[si];									/* Return pointer to the next segment */
// 1777 		sfn[NS] = (c <= ' ') ? NS_LAST | NS_DOT : NS_DOT;	/* Set last segment flag if end of path */
// 1778 		return FR_OK;
// 1779 	}
// 1780 #endif
// 1781 	for (;;) {
// 1782 		c = (BYTE)p[si++];
// 1783 		if (c <= ' ' || c == '/' || c == '\\') break;	/* Break on end of segment */
// 1784 		if (c == '.' || i >= ni) {
// 1785 			if (ni != 8 || c != '.') return FR_INVALID_NAME;
// 1786 			i = 8; ni = 11;
// 1787 			b <<= 2; continue;
// 1788 		}
// 1789 		if (c >= 0x80) {				/* Extended char? */
// 1790 			b |= 3;						/* Eliminate NT flag */
// 1791 #ifdef _EXCVT
// 1792 			c = excvt[c-0x80];			/* Upper conversion (SBCS) */
// 1793 #else
// 1794 #if !_DF1S	/* ASCII only cfg */
// 1795 			return FR_INVALID_NAME;
// 1796 #endif
// 1797 #endif
// 1798 		}
// 1799 		if (IsDBCS1(c)) {				/* Check if it is a DBC 1st byte (always false on SBCS cfg) */
// 1800 			d = (BYTE)p[si++];			/* Get 2nd byte */
// 1801 			if (!IsDBCS2(d) || i >= ni - 1)	/* Reject invalid DBC */
// 1802 				return FR_INVALID_NAME;
// 1803 			sfn[i++] = c;
// 1804 			sfn[i++] = d;
// 1805 		} else {						/* Single byte code */
// 1806 			if (chk_chr("\"*+,:;<=>\?[]|\x7F", c))	/* Reject illegal chrs for SFN */
// 1807 				return FR_INVALID_NAME;
// 1808 			if (IsUpper(c)) {			/* ASCII large capital? */
// 1809 				b |= 2;
// 1810 			} else {
// 1811 				if (IsLower(c)) {		/* ASCII small capital? */
// 1812 					b |= 1; c -= 0x20;
// 1813 				}
// 1814 			}
// 1815 			sfn[i++] = c;
// 1816 		}
// 1817 	}
// 1818 	*path = &p[si];						/* Return pointer to the next segment */
// 1819 	c = (c <= ' ') ? NS_LAST : 0;		/* Set last segment flag if end of path */
// 1820 
// 1821 	if (!i) return FR_INVALID_NAME;		/* Reject nul string */
// 1822 	if (sfn[0] == DDE) sfn[0] = NDDE;	/* When first char collides with DDE, replace it with 0x05 */
// 1823 
// 1824 	if (ni == 8) b <<= 2;
// 1825 	if ((b & 0x03) == 0x01) c |= NS_EXT;	/* NT flag (Name extension has only small capital) */
// 1826 	if ((b & 0x0C) == 0x04) c |= NS_BODY;	/* NT flag (Name body has only small capital) */
// 1827 
// 1828 	sfn[NS] = c;		/* Store NT flag, File name is created */
// 1829 
// 1830 	return FR_OK;
// 1831 #endif
// 1832 }

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
??excvt:
        DATA
        DC8 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140
        DC8 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153
        DC8 138, 155, 140, 141, 142, 143, 160, 161, 162, 163, 164, 165, 166
        DC8 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 163
        DC8 180, 181, 182, 183, 184, 165, 170, 187, 188, 189, 188, 175, 192
        DC8 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205
        DC8 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218
        DC8 219, 220, 221, 222, 223, 192, 193, 194, 195, 196, 197, 198, 199
        DC8 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212
        DC8 213, 214, 247, 216, 217, 218, 219, 220, 221, 222, 255
// 1833 
// 1834 
// 1835 
// 1836 
// 1837 /*-----------------------------------------------------------------------*/
// 1838 /* Get file information from directory entry                             */
// 1839 /*-----------------------------------------------------------------------*/
// 1840 #if _FS_MINIMIZE <= 1

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1841 static
// 1842 void get_fileinfo (		/* No return code */
// 1843 	DIR *dj,			/* Pointer to the directory object */
// 1844 	FILINFO *fno	 	/* Pointer to the file information to be filled */
// 1845 )
// 1846 {
get_fileinfo:
        PUSH     {R3-R7,LR}
        MOVS     R4,R1
// 1847 	UINT i;
// 1848 	BYTE nt, *dir;
// 1849 	TCHAR *p, c;
// 1850 
// 1851 
// 1852 	p = fno->fname;
        ADDW     R1,R4,#+9
// 1853 	if (dj->sect) {
        LDR      R2,[R0, #+16]
        CMP      R2,#+0
        BEQ.N    ??get_fileinfo_0
// 1854 		dir = dj->dir;
        LDR      R2,[R0, #+20]
// 1855 		nt = dir[DIR_NTres];		/* NT flag */
        LDRB     R3,[R2, #+12]
// 1856 		for (i = 0; i < 8; i++) {	/* Copy name body */
        MOVS     R5,#+0
        B.N      ??get_fileinfo_1
// 1857 			c = dir[i];
// 1858 			if (c == ' ') break;
// 1859 			if (c == NDDE) c = (TCHAR)DDE;
??get_fileinfo_2:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+5
        BNE.N    ??get_fileinfo_3
        MOVS     R6,#+229
// 1860 			if (_USE_LFN && (nt & NS_BODY) && IsUpper(c)) c += 0x20;
??get_fileinfo_3:
        LSLS     R7,R3,#+28
        BPL.N    ??get_fileinfo_4
        SUBS     R7,R6,#+65
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+26
        BCS.N    ??get_fileinfo_4
        ADDS     R6,R6,#+32
// 1861 #if _LFN_UNICODE
// 1862 			if (IsDBCS1(c) && i < 7 && IsDBCS2(dir[i+1]))
// 1863 				c = (c << 8) | dir[++i];
// 1864 			c = ff_convert(c, 1);
// 1865 			if (!c) c = '?';
// 1866 #endif
// 1867 			*p++ = c;
??get_fileinfo_4:
        STRB     R6,[R1, #+0]
        ADDS     R1,R1,#+1
        ADDS     R5,R5,#+1
??get_fileinfo_1:
        CMP      R5,#+8
        BCS.N    ??get_fileinfo_5
        LDRB     R6,[R5, R2]
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+32
        BNE.N    ??get_fileinfo_2
// 1868 		}
// 1869 		if (dir[8] != ' ') {		/* Copy name extension */
??get_fileinfo_5:
        LDRB     R5,[R2, #+8]
        CMP      R5,#+32
        BEQ.N    ??get_fileinfo_6
// 1870 			*p++ = '.';
        MOVS     R5,#+46
        STRB     R5,[R1, #+0]
        ADDS     R1,R1,#+1
// 1871 			for (i = 8; i < 11; i++) {
        MOVS     R5,#+8
        B.N      ??get_fileinfo_7
// 1872 				c = dir[i];
// 1873 				if (c == ' ') break;
// 1874 				if (_USE_LFN && (nt & NS_EXT) && IsUpper(c)) c += 0x20;
??get_fileinfo_8:
        LSLS     R7,R3,#+27
        BPL.N    ??get_fileinfo_9
        SUBS     R7,R6,#+65
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+26
        BCS.N    ??get_fileinfo_9
        ADDS     R6,R6,#+32
// 1875 #if _LFN_UNICODE
// 1876 				if (IsDBCS1(c) && i < 10 && IsDBCS2(dir[i+1]))
// 1877 					c = (c << 8) | dir[++i];
// 1878 				c = ff_convert(c, 1);
// 1879 				if (!c) c = '?';
// 1880 #endif
// 1881 				*p++ = c;
??get_fileinfo_9:
        STRB     R6,[R1, #+0]
        ADDS     R1,R1,#+1
        ADDS     R5,R5,#+1
??get_fileinfo_7:
        CMP      R5,#+11
        BCS.N    ??get_fileinfo_6
        LDRB     R6,[R5, R2]
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+32
        BNE.N    ??get_fileinfo_8
// 1882 			}
// 1883 		}
// 1884 		fno->fattrib = dir[DIR_Attr];				/* Attribute */
??get_fileinfo_6:
        LDRB     R3,[R2, #+11]
        STRB     R3,[R4, #+8]
// 1885 		fno->fsize = LD_DWORD(dir+DIR_FileSize);	/* Size */
        LDRB     R3,[R2, #+31]
        LDRB     R5,[R2, #+30]
        LSLS     R5,R5,#+16
        ORRS     R3,R5,R3, LSL #+24
        LDRB     R5,[R2, #+29]
        ORRS     R3,R3,R5, LSL #+8
        LDRB     R5,[R2, #+28]
        ORRS     R3,R5,R3
        STR      R3,[R4, #+0]
// 1886 		fno->fdate = LD_WORD(dir+DIR_WrtDate);		/* Date */
        LDRB     R3,[R2, #+25]
        LDRB     R5,[R2, #+24]
        ORRS     R3,R5,R3, LSL #+8
        STRH     R3,[R4, #+4]
// 1887 		fno->ftime = LD_WORD(dir+DIR_WrtTime);		/* Time */
        LDRB     R3,[R2, #+23]
        LDRB     R2,[R2, #+22]
        ORRS     R2,R2,R3, LSL #+8
        STRH     R2,[R4, #+6]
// 1888 	}
// 1889 	*p = 0;		/* Terminate SFN str by a \0 */
??get_fileinfo_0:
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
// 1890 
// 1891 #if _USE_LFN
// 1892 	if (fno->lfname && fno->lfsize) {
        LDR      R1,[R4, #+24]
        CMP      R1,#+0
        BEQ.N    ??get_fileinfo_10
        LDR      R1,[R4, #+28]
        CMP      R1,#+0
        BEQ.N    ??get_fileinfo_10
// 1893 		TCHAR *tp = fno->lfname;
        LDR      R6,[R4, #+24]
// 1894 		WCHAR w, *lfn;
// 1895 
// 1896 		i = 0;
        MOVS     R5,#+0
// 1897 		if (dj->sect && dj->lfn_idx != 0xFFFF) {/* Get LFN if available */
        LDR      R1,[R0, #+16]
        CMP      R1,#+0
        BEQ.N    ??get_fileinfo_11
        LDRH     R1,[R0, #+32]
        MOVW     R2,#+65535
        CMP      R1,R2
        BEQ.N    ??get_fileinfo_11
// 1898 			lfn = dj->lfn;
        LDR      R7,[R0, #+28]
        B.N      ??get_fileinfo_12
// 1899 			while ((w = *lfn++) != 0) {			/* Get an LFN char */
// 1900 #if !_LFN_UNICODE
// 1901 				w = ff_convert(w, 0);			/* Unicode -> OEM conversion */
// 1902 				if (!w) { i = 0; break; }		/* Could not convert, no LFN */
// 1903 				if (_DF1S && w >= 0x100)		/* Put 1st byte if it is a DBC (always false on SBCS cfg) */
// 1904 					tp[i++] = (TCHAR)(w >> 8);
// 1905 #endif
// 1906 				if (i >= fno->lfsize - 1) { i = 0; break; }	/* Buffer overflow, no LFN */
// 1907 				tp[i++] = (TCHAR)w;
??get_fileinfo_13:
        STRB     R0,[R5, R6]
        ADDS     R5,R5,#+1
??get_fileinfo_12:
        LDRH     R0,[R7, #+0]
        ADDS     R7,R7,#+2
        MOVS     R1,R0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BEQ.N    ??get_fileinfo_11
        MOVS     R1,#+0
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        BL       ff_convert
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,#+0
        BNE.N    ??get_fileinfo_14
        MOVS     R5,#+0
        B.N      ??get_fileinfo_11
??get_fileinfo_14:
        LDR      R1,[R4, #+28]
        SUBS     R1,R1,#+1
        CMP      R5,R1
        BCC.N    ??get_fileinfo_13
        MOVS     R5,#+0
// 1908 			}
// 1909 		}
// 1910 		tp[i] = 0;	/* Terminate the LFN str by a \0 */
??get_fileinfo_11:
        MOVS     R0,#+0
        STRB     R0,[R5, R6]
// 1911 	}
// 1912 #endif
// 1913 }
??get_fileinfo_10:
        POP      {R0,R4-R7,PC}    ;; return
// 1914 #endif /* _FS_MINIMIZE <= 1 */
// 1915 
// 1916 
// 1917 
// 1918 
// 1919 /*-----------------------------------------------------------------------*/
// 1920 /* Follow a file path                                                    */
// 1921 /*-----------------------------------------------------------------------*/
// 1922 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1923 static
// 1924 FRESULT follow_path (	/* FR_OK(0): successful, !=0: error code */
// 1925 	DIR *dj,			/* Directory object to return last directory and found object */
// 1926 	const TCHAR *path	/* Full-path string to find a file or directory */
// 1927 )
// 1928 {
follow_path:
        PUSH     {R0,R1,R4,LR}
        MOVS     R4,R0
// 1929 	FRESULT res;
// 1930 	BYTE *dir, ns;
// 1931 
// 1932 
// 1933 #if _FS_RPATH
// 1934 	if (*path == '/' || *path == '\\') { /* There is a heading separator */
        LDR      R0,[SP, #+4]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+47
        BEQ.N    ??follow_path_0
        LDR      R0,[SP, #+4]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+92
        BNE.N    ??follow_path_1
// 1935 		path++;	dj->sclust = 0;		/* Strip it and start from the root dir */
??follow_path_0:
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+4]
        MOVS     R0,#+0
        STR      R0,[R4, #+8]
        B.N      ??follow_path_2
// 1936 	} else {							/* No heading separator */
// 1937 		dj->sclust = dj->fs->cdir;	/* Start from the current dir */
??follow_path_1:
        LDR      R0,[R4, #+0]
        LDR      R0,[R0, #+24]
        STR      R0,[R4, #+8]
// 1938 	}
// 1939 #else
// 1940 	if (*path == '/' || *path == '\\')	/* Strip heading separator if exist */
// 1941 		path++;
// 1942 	dj->sclust = 0;						/* Start from the root dir */
// 1943 #endif
// 1944 
// 1945 	if ((UINT)*path < ' ') {			/* Nul path means the start directory itself */
??follow_path_2:
        LDR      R0,[SP, #+4]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+32
        BCS.N    ??follow_path_3
// 1946 		res = dir_sdi(dj, 0);
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
// 1947 		dj->dir = 0;
        MOVS     R1,#+0
        STR      R1,[R4, #+20]
// 1948 
// 1949 	} else {							/* Follow path */
// 1950 		for (;;) {
// 1951 			res = create_name(dj, &path);	/* Get a segment */
// 1952 			if (res != FR_OK) break;
// 1953 			res = dir_find(dj);				/* Find it */
// 1954 			ns = *(dj->fn+NS);
// 1955 			if (res != FR_OK) {				/* Failed to find the object */
// 1956 				if (res != FR_NO_FILE) break;	/* Abort if any hard error occured */
// 1957 				/* Object not found */
// 1958 				if (_FS_RPATH && (ns & NS_DOT)) {	/* If dot entry is not exit */
// 1959 					dj->sclust = 0; dj->dir = 0;	/* It is the root dir */
// 1960 					res = FR_OK;
// 1961 					if (!(ns & NS_LAST)) continue;
// 1962 				} else {							/* Could not find the object */
// 1963 					if (!(ns & NS_LAST)) res = FR_NO_PATH;
// 1964 				}
// 1965 				break;
// 1966 			}
// 1967 			if (ns & NS_LAST) break;			/* Last segment match. Function completed. */
// 1968 			dir = dj->dir;						/* There is next segment. Follow the sub directory */
// 1969 			if (!(dir[DIR_Attr] & AM_DIR)) {	/* Cannot follow because it is a file */
// 1970 				res = FR_NO_PATH; break;
// 1971 			}
// 1972 			dj->sclust = LD_CLUST(dir);
// 1973 		}
// 1974 	}
// 1975 
// 1976 	return res;
??follow_path_4:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R2,R4,PC}    ;; return
??follow_path_5:
        MOVS     R0,#+0
        STR      R0,[R4, #+8]
        MOVS     R0,#+0
        STR      R0,[R4, #+20]
        MOVS     R0,#+0
        LSLS     R1,R1,#+29
        BMI.N    ??follow_path_6
??follow_path_3:
        ADD      R1,SP,#+4
        MOVS     R0,R4
        BL       create_name
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??follow_path_4
??follow_path_7:
        MOVS     R0,R4
        BL       dir_find
        LDR      R1,[R4, #+24]
        LDRB     R1,[R1, #+11]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??follow_path_8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+4
        BNE.N    ??follow_path_4
??follow_path_9:
        LSLS     R2,R1,#+26
        BMI.N    ??follow_path_5
        LSLS     R1,R1,#+29
        BMI.N    ??follow_path_6
        MOVS     R0,#+5
??follow_path_6:
        B.N      ??follow_path_4
??follow_path_8:
        LSLS     R1,R1,#+29
        BMI.N    ??follow_path_4
??follow_path_10:
        LDR      R0,[R4, #+20]
        LDRB     R1,[R0, #+11]
        LSLS     R1,R1,#+27
        BMI.N    ??follow_path_11
        MOVS     R0,#+5
        B.N      ??follow_path_4
??follow_path_11:
        LDRB     R1,[R0, #+21]
        LDRB     R2,[R0, #+20]
        ORRS     R1,R2,R1, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRB     R2,[R0, #+27]
        LDRB     R0,[R0, #+26]
        ORRS     R0,R0,R2, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        ORRS     R0,R0,R1, LSL #+16
        STR      R0,[R4, #+8]
        B.N      ??follow_path_3
// 1977 }
// 1978 
// 1979 
// 1980 
// 1981 
// 1982 /*-----------------------------------------------------------------------*/
// 1983 /* Load a sector and check if it is an FAT Volume Boot Record            */
// 1984 /*-----------------------------------------------------------------------*/
// 1985 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1986 static
// 1987 BYTE check_fs (	/* 0:FAT-VBR, 1:Valid BR but not FAT, 2:Not a BR, 3:Disk error */
// 1988 	FATFS *fs,	/* File system object */
// 1989 	DWORD sect	/* Sector# (lba) to check if it is an FAT boot record or not */
// 1990 )
// 1991 {
check_fs:
        PUSH     {R4,LR}
        MOVS     R4,R0
// 1992 	if (LPLD_Disk_Read(fs->drv, fs->win, sect, 1) != RES_OK)	/* Load boot record */
        MOVS     R3,#+1
        MOVS     R2,R1
        ADDS     R1,R4,#+52
        LDRB     R0,[R4, #+1]
        BL       LPLD_Disk_Read
        CMP      R0,#+0
        BEQ.N    ??check_fs_0
// 1993 		return 3;
        MOVS     R0,#+3
        B.N      ??check_fs_1
// 1994 	if (LD_WORD(&fs->win[BS_55AA]) != 0xAA55)		/* Check record signature (always placed at offset 510 even if the sector size is >512) */
??check_fs_0:
        LDRB     R0,[R4, #+563]
        LDRB     R1,[R4, #+562]
        ORRS     R0,R1,R0, LSL #+8
        MOVW     R1,#+43605
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,R1
        BEQ.N    ??check_fs_2
// 1995 		return 2;
        MOVS     R0,#+2
        B.N      ??check_fs_1
// 1996 
// 1997 	if ((LD_DWORD(&fs->win[BS_FilSysType]) & 0xFFFFFF) == 0x544146)	/* Check "FAT" string */
??check_fs_2:
        LDRB     R0,[R4, #+108]
        LDRB     R1,[R4, #+107]
        LSLS     R1,R1,#+8
        ORRS     R0,R1,R0, LSL #+16
        LDRB     R1,[R4, #+106]
        ORRS     R0,R1,R0
        LDR.W    R1,??DataTable13  ;; 0x544146
        CMP      R0,R1
        BNE.N    ??check_fs_3
// 1998 		return 0;
        MOVS     R0,#+0
        B.N      ??check_fs_1
// 1999 	if ((LD_DWORD(&fs->win[BS_FilSysType32]) & 0xFFFFFF) == 0x544146)
??check_fs_3:
        LDRB     R0,[R4, #+136]
        LDRB     R1,[R4, #+135]
        LSLS     R1,R1,#+8
        ORRS     R0,R1,R0, LSL #+16
        LDRB     R1,[R4, #+134]
        ORRS     R0,R1,R0
        LDR.W    R1,??DataTable13  ;; 0x544146
        CMP      R0,R1
        BNE.N    ??check_fs_4
// 2000 		return 0;
        MOVS     R0,#+0
        B.N      ??check_fs_1
// 2001 
// 2002 	return 1;
??check_fs_4:
        MOVS     R0,#+1
??check_fs_1:
        POP      {R4,PC}          ;; return
// 2003 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     LfnOfs
// 2004 
// 2005 
// 2006 
// 2007 
// 2008 /*-----------------------------------------------------------------------*/
// 2009 /* Check if the file system object is valid or not                       */
// 2010 /*-----------------------------------------------------------------------*/
// 2011 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2012 static
// 2013 FRESULT chk_mounted (	/* FR_OK(0): successful, !=0: any error occurred */
// 2014 	const TCHAR **path,	/* Pointer to pointer to the path name (drive number) */
// 2015 	FATFS **rfs,		/* Pointer to pointer to the found file system object */
// 2016 	BYTE chk_wp			/* !=0: Check media write protection for write access */
// 2017 )
// 2018 {
chk_mounted:
        PUSH     {R3-R7,LR}
        MOVS     R5,R2
// 2019 	BYTE fmt, b, pi, *tbl;
// 2020 	UINT vol;
// 2021 	DSTATUS stat;
// 2022 	DWORD bsect, fasize, tsect, sysect, nclst, szbfat;
// 2023 	WORD nrsv;
// 2024 	const TCHAR *p = *path;
        LDR      R2,[R0, #+0]
// 2025 	FATFS *fs;
// 2026 
// 2027 	/* Get logical drive number from the path name */
// 2028 	vol = p[0] - '0';					/* Is there a drive number? */
        LDRB     R3,[R2, #+0]
        SUBS     R6,R3,#+48
// 2029 	if (vol <= 9 && p[1] == ':') {		/* Found a drive number, get and strip it */
        CMP      R6,#+10
        BCS.N    ??chk_mounted_0
        LDRB     R3,[R2, #+1]
        CMP      R3,#+58
        BNE.N    ??chk_mounted_0
// 2030 		p += 2; *path = p;				/* Return pointer to the path name */
        ADDS     R2,R2,#+2
        STR      R2,[R0, #+0]
        B.N      ??chk_mounted_1
// 2031 	} else {							/* No drive number is given */
// 2032 #if _FS_RPATH
// 2033 		vol = CurrVol;					/* Use current drive */
??chk_mounted_0:
        LDR.W    R0,??DataTable13_1
        LDRB     R6,[R0, #+0]
// 2034 #else
// 2035 		vol = 0;						/* Use drive 0 */
// 2036 #endif
// 2037 	}
// 2038 
// 2039 	/* Check if the file system object is valid or not */
// 2040 	if (vol >= _VOLUMES) 				/* Is the drive number valid? */
??chk_mounted_1:
        CMP      R6,#+0
        BEQ.N    ??chk_mounted_2
// 2041 		return FR_INVALID_DRIVE;
        MOVS     R0,#+11
        B.N      ??chk_mounted_3
// 2042 	*rfs = fs = FatFs[vol];				/* Return pointer to the corresponding file system object */
??chk_mounted_2:
        LDR.W    R0,??DataTable13_2
        LDR      R4,[R0, R6, LSL #+2]
        STR      R4,[R1, #+0]
// 2043 	if (!fs) return FR_NOT_ENABLED;		/* Is the file system object available? */
        CMP      R4,#+0
        BNE.N    ??chk_mounted_4
        MOVS     R0,#+12
        B.N      ??chk_mounted_3
// 2044 
// 2045 	ENTER_FF(fs);						/* Lock file system */
// 2046 
// 2047 	if (fs->fs_type) {					/* If the logical drive has been mounted */
??chk_mounted_4:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_5
// 2048 		stat = LPLD_Disk_Status(fs->drv);
        LDRB     R0,[R4, #+1]
        BL       LPLD_Disk_Status
// 2049 		if (!(stat & STA_NOINIT)) {		/* and the physical drive is kept initialized (has not been changed), */
        MOVS     R1,R0
        LSLS     R1,R1,#+31
        BMI.N    ??chk_mounted_5
// 2050 			if (!_FS_READONLY && chk_wp && (stat & STA_PROTECT))	/* Check write protection if needed */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??chk_mounted_6
        LSLS     R0,R0,#+29
        BPL.N    ??chk_mounted_6
// 2051 				return FR_WRITE_PROTECTED;
        MOVS     R0,#+10
        B.N      ??chk_mounted_3
// 2052 			return FR_OK;				/* The file system object is valid */
??chk_mounted_6:
        MOVS     R0,#+0
        B.N      ??chk_mounted_3
// 2053 		}
// 2054 	}
// 2055 
// 2056 	/* The file system object is not valid. */
// 2057 	/* Following code attempts to mount the volume. (analyze BPB and initialize the fs object) */
// 2058 
// 2059 	fs->fs_type = 0;					/* Clear the file system object */
??chk_mounted_5:
        MOVS     R0,#+0
        STRB     R0,[R4, #+0]
// 2060 	fs->drv = LD2PD(vol);				/* Bind the logical drive and a physical drive */
        STRB     R6,[R4, #+1]
// 2061 	stat = LPLD_Disk_Initialize(fs->drv);	/* Initialize low level disk I/O layer */
        LDRB     R0,[R4, #+1]
        BL       LPLD_Disk_Initialize
// 2062 	if (stat & STA_NOINIT)				/* Check if the initialization succeeded */
        MOVS     R1,R0
        LSLS     R1,R1,#+31
        BPL.N    ??chk_mounted_7
// 2063 		return FR_NOT_READY;			/* Failed to initialize due to no media or hard error */
        MOVS     R0,#+3
        B.N      ??chk_mounted_3
// 2064 	if (!_FS_READONLY && chk_wp && (stat & STA_PROTECT))	/* Check disk write protection if needed */
??chk_mounted_7:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??chk_mounted_8
        LSLS     R0,R0,#+29
        BPL.N    ??chk_mounted_8
// 2065 		return FR_WRITE_PROTECTED;
        MOVS     R0,#+10
        B.N      ??chk_mounted_3
// 2066 #if _MAX_SS != 512						/* Get disk sector size (variable sector size cfg only) */
// 2067 	if (LPLD_Disk_IOC(fs->drv, GET_SECTOR_SIZE, &fs->ssize) != RES_OK)
// 2068 		return FR_DISK_ERR;
// 2069 #endif
// 2070 	/* Search FAT partition on the drive. Supports only generic partitionings, FDISK and SFD. */
// 2071 	fmt = check_fs(fs, bsect = 0);		/* Load sector 0 and check if it is an FAT-VBR (in SFD) */
??chk_mounted_8:
        MOVS     R5,#+0
        MOVS     R1,R5
        MOVS     R0,R4
        BL       check_fs
        MOVS     R6,R0
// 2072 	if (LD2PT(vol) && !fmt) fmt = 1;	/* Force non-SFD if the volume is forced partition */
// 2073 	if (fmt == 1) {						/* Not an FAT-VBR, the physical drive can be partitioned */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+1
        BNE.N    ??chk_mounted_9
// 2074 		/* Check the partition listed in the partition table */
// 2075 		pi = LD2PT(vol);
        MOVS     R0,#+0
// 2076 		if (pi) pi--;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_10
        SUBS     R0,R0,#+1
// 2077 		tbl = &fs->win[MBR_Table + pi * SZ_PTE];/* Partition table */
??chk_mounted_10:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        ADDS     R0,R4,R0, LSL #+4
        ADDW     R0,R0,#+498
// 2078 		if (tbl[4]) {						/* Is the partition existing? */
        LDRB     R1,[R0, #+4]
        CMP      R1,#+0
        BEQ.N    ??chk_mounted_9
// 2079 			bsect = LD_DWORD(&tbl[8]);		/* Partition offset in LBA */
        LDRB     R1,[R0, #+11]
        LDRB     R2,[R0, #+10]
        LSLS     R2,R2,#+16
        ORRS     R1,R2,R1, LSL #+24
        LDRB     R2,[R0, #+9]
        ORRS     R1,R1,R2, LSL #+8
        LDRB     R0,[R0, #+8]
        ORRS     R5,R0,R1
// 2080 			fmt = check_fs(fs, bsect);		/* Check the partition */
        MOVS     R1,R5
        MOVS     R0,R4
        BL       check_fs
        MOVS     R6,R0
// 2081 		}
// 2082 	}
// 2083 	if (fmt == 3) return FR_DISK_ERR;
??chk_mounted_9:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??chk_mounted_11
        MOVS     R0,#+1
        B.N      ??chk_mounted_3
// 2084 	if (fmt) return FR_NO_FILESYSTEM;		/* No FAT volume is found */
??chk_mounted_11:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??chk_mounted_12
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2085 
// 2086 	/* An FAT volume is found. Following code initializes the file system object */
// 2087 
// 2088 	if (LD_WORD(fs->win+BPB_BytsPerSec) != SS(fs))		/* (BPB_BytsPerSec must be equal to the physical sector size) */
??chk_mounted_12:
        LDRB     R0,[R4, #+64]
        LDRB     R1,[R4, #+63]
        ORRS     R0,R1,R0, LSL #+8
        MOV      R1,#+512
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,R1
        BEQ.N    ??chk_mounted_13
// 2089 		return FR_NO_FILESYSTEM;
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2090 
// 2091 	fasize = LD_WORD(fs->win+BPB_FATSz16);				/* Number of sectors per FAT */
??chk_mounted_13:
        LDRB     R0,[R4, #+75]
        LDRB     R1,[R4, #+74]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
// 2092 	if (!fasize) fasize = LD_DWORD(fs->win+BPB_FATSz32);
        CMP      R0,#+0
        BNE.N    ??chk_mounted_14
        LDRB     R0,[R4, #+91]
        LDRB     R1,[R4, #+90]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+89]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+88]
        ORRS     R0,R1,R0
// 2093 	fs->fsize = fasize;
??chk_mounted_14:
        STR      R0,[R4, #+32]
// 2094 
// 2095 	fs->n_fats = b = fs->win[BPB_NumFATs];				/* Number of FAT copies */
        LDRB     R1,[R4, #+68]
        STRB     R1,[R4, #+3]
// 2096 	if (b != 1 && b != 2) return FR_NO_FILESYSTEM;		/* (Must be 1 or 2) */
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+1
        BEQ.N    ??chk_mounted_15
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+2
        BEQ.N    ??chk_mounted_15
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2097 	fasize *= b;										/* Number of sectors for FAT area */
??chk_mounted_15:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        MULS     R0,R1,R0
// 2098 
// 2099 	fs->csize = b = fs->win[BPB_SecPerClus];			/* Number of sectors per cluster */
        LDRB     R1,[R4, #+65]
        STRB     R1,[R4, #+2]
// 2100 	if (!b || (b & (b - 1))) return FR_NO_FILESYSTEM;	/* (Must be power of 2) */
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??chk_mounted_16
        SUBS     R2,R1,#+1
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        TST      R1,R2
        BEQ.N    ??chk_mounted_17
??chk_mounted_16:
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2101 
// 2102 	fs->n_rootdir = LD_WORD(fs->win+BPB_RootEntCnt);	/* Number of root directory entries */
??chk_mounted_17:
        LDRB     R1,[R4, #+70]
        LDRB     R2,[R4, #+69]
        ORRS     R1,R2,R1, LSL #+8
        STRH     R1,[R4, #+8]
// 2103 	if (fs->n_rootdir % (SS(fs) / SZ_DIR)) return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must be sector aligned) */
        LDRH     R1,[R4, #+8]
        MOVS     R2,#+16
        UDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        CMP      R3,#+0
        BEQ.N    ??chk_mounted_18
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2104 
// 2105 	tsect = LD_WORD(fs->win+BPB_TotSec16);				/* Number of sectors on the volume */
??chk_mounted_18:
        LDRB     R1,[R4, #+72]
        LDRB     R2,[R4, #+71]
        ORRS     R2,R2,R1, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
// 2106 	if (!tsect) tsect = LD_DWORD(fs->win+BPB_TotSec32);
        CMP      R2,#+0
        BNE.N    ??chk_mounted_19
        LDRB     R1,[R4, #+87]
        LDRB     R2,[R4, #+86]
        LSLS     R2,R2,#+16
        ORRS     R1,R2,R1, LSL #+24
        LDRB     R2,[R4, #+85]
        ORRS     R1,R1,R2, LSL #+8
        LDRB     R2,[R4, #+84]
        ORRS     R2,R2,R1
// 2107 
// 2108 	nrsv = LD_WORD(fs->win+BPB_RsvdSecCnt);				/* Number of reserved sectors */
??chk_mounted_19:
        LDRB     R1,[R4, #+67]
        LDRB     R3,[R4, #+66]
        ORRS     R1,R3,R1, LSL #+8
// 2109 	if (!nrsv) return FR_NO_FILESYSTEM;					/* (BPB_RsvdSecCnt must not be 0) */
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R1,#+0
        BNE.N    ??chk_mounted_20
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2110 
// 2111 	/* Determine the FAT sub type */
// 2112 	sysect = nrsv + fasize + fs->n_rootdir / (SS(fs) / SZ_DIR);	/* RSV+FAT+DIR */
??chk_mounted_20:
        UXTAH    R3,R0,R1
        LDRH     R6,[R4, #+8]
        ADDS     R3,R3,R6, LSR #+4
// 2113 	if (tsect < sysect) return FR_NO_FILESYSTEM;		/* (Invalid volume size) */
        CMP      R2,R3
        BCS.N    ??chk_mounted_21
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2114 	nclst = (tsect - sysect) / fs->csize;				/* Number of clusters */
??chk_mounted_21:
        SUBS     R2,R2,R3
        LDRB     R6,[R4, #+2]
        UDIV     R2,R2,R6
// 2115 	if (!nclst) return FR_NO_FILESYSTEM;				/* (Invalid volume size) */
        CMP      R2,#+0
        BNE.N    ??chk_mounted_22
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2116 	fmt = FS_FAT12;
??chk_mounted_22:
        MOVS     R6,#+1
// 2117 	if (nclst >= MIN_FAT16) fmt = FS_FAT16;
        MOVW     R7,#+4086
        CMP      R2,R7
        BCC.N    ??chk_mounted_23
        MOVS     R6,#+2
// 2118 	if (nclst >= MIN_FAT32) fmt = FS_FAT32;
??chk_mounted_23:
        MOVW     R7,#+65526
        CMP      R2,R7
        BCC.N    ??chk_mounted_24
        MOVS     R6,#+3
// 2119 
// 2120 	/* Boundaries and Limits */
// 2121 	fs->n_fatent = nclst + 2;							/* Number of FAT entries */
??chk_mounted_24:
        ADDS     R2,R2,#+2
        STR      R2,[R4, #+28]
// 2122 	fs->database = bsect + sysect;						/* Data start sector */
        ADDS     R2,R3,R5
        STR      R2,[R4, #+44]
// 2123 	fs->fatbase = bsect + nrsv; 						/* FAT start sector */
        UXTAH    R1,R5,R1
        STR      R1,[R4, #+36]
// 2124 	if (fmt == FS_FAT32) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??chk_mounted_25
// 2125 		if (fs->n_rootdir) return FR_NO_FILESYSTEM;		/* (BPB_RootEntCnt must be 0) */
        LDRH     R0,[R4, #+8]
        CMP      R0,#+0
        BEQ.N    ??chk_mounted_26
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2126 		fs->dirbase = LD_DWORD(fs->win+BPB_RootClus);	/* Root directory start cluster */
??chk_mounted_26:
        LDRB     R0,[R4, #+99]
        LDRB     R1,[R4, #+98]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+97]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+96]
        ORRS     R0,R1,R0
        STR      R0,[R4, #+40]
// 2127 		szbfat = fs->n_fatent * 4;						/* (Required FAT size) */
        LDR      R0,[R4, #+28]
        LSLS     R0,R0,#+2
        B.N      ??chk_mounted_27
// 2128 	} else {
// 2129 		if (!fs->n_rootdir)	return FR_NO_FILESYSTEM;	/* (BPB_RootEntCnt must not be 0) */
??chk_mounted_25:
        LDRH     R1,[R4, #+8]
        CMP      R1,#+0
        BNE.N    ??chk_mounted_28
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2130 		fs->dirbase = fs->fatbase + fasize;				/* Root directory start sector */
??chk_mounted_28:
        LDR      R1,[R4, #+36]
        ADDS     R0,R0,R1
        STR      R0,[R4, #+40]
// 2131 		szbfat = (fmt == FS_FAT16) ?					/* (Required FAT size) */
// 2132 			fs->n_fatent * 2 : fs->n_fatent * 3 / 2 + (fs->n_fatent & 1);
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+2
        BNE.N    ??chk_mounted_29
        LDR      R0,[R4, #+28]
        LSLS     R0,R0,#+1
        B.N      ??chk_mounted_27
??chk_mounted_29:
        LDR      R0,[R4, #+28]
        MOVS     R1,#+3
        MULS     R0,R1,R0
        LDRB     R1,[R4, #+28]
        ANDS     R1,R1,#0x1
        ADDS     R0,R1,R0, LSR #+1
// 2133 	}
// 2134 	if (fs->fsize < (szbfat + (SS(fs) - 1)) / SS(fs))	/* (BPB_FATSz must not be less than required) */
??chk_mounted_27:
        LDR      R1,[R4, #+32]
        ADDW     R0,R0,#+511
        CMP      R1,R0, LSR #+9
        BCS.N    ??chk_mounted_30
// 2135 		return FR_NO_FILESYSTEM;
        MOVS     R0,#+13
        B.N      ??chk_mounted_3
// 2136 
// 2137 #if !_FS_READONLY
// 2138 	/* Initialize cluster allocation information */
// 2139 	fs->free_clust = 0xFFFFFFFF;
??chk_mounted_30:
        MOVS     R0,#-1
        STR      R0,[R4, #+16]
// 2140 	fs->last_clust = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+12]
// 2141 
// 2142 	/* Get fsinfo if available */
// 2143 	if (fmt == FS_FAT32) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+3
        BNE.N    ??chk_mounted_31
// 2144 	 	fs->fsi_flag = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+5]
// 2145 		fs->fsi_sector = bsect + LD_WORD(fs->win+BPB_FSInfo);
        LDRB     R0,[R4, #+101]
        LDRB     R1,[R4, #+100]
        ORRS     R0,R1,R0, LSL #+8
        UXTAH    R0,R5,R0
        STR      R0,[R4, #+20]
// 2146 		if (LPLD_Disk_Read(fs->drv, fs->win, fs->fsi_sector, 1) == RES_OK &&
// 2147 			LD_WORD(fs->win+BS_55AA) == 0xAA55 &&
// 2148 			LD_DWORD(fs->win+FSI_LeadSig) == 0x41615252 &&
// 2149 			LD_DWORD(fs->win+FSI_StrucSig) == 0x61417272) {
        MOVS     R3,#+1
        LDR      R2,[R4, #+20]
        ADDS     R1,R4,#+52
        LDRB     R0,[R4, #+1]
        BL       LPLD_Disk_Read
        CMP      R0,#+0
        BNE.N    ??chk_mounted_31
        LDRB     R0,[R4, #+563]
        LDRB     R1,[R4, #+562]
        ORRS     R0,R1,R0, LSL #+8
        MOVW     R1,#+43605
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        CMP      R0,R1
        BNE.N    ??chk_mounted_31
        LDRB     R0,[R4, #+55]
        LDRB     R1,[R4, #+54]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+53]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+52]
        ORRS     R0,R1,R0
        LDR.W    R1,??DataTable13_3  ;; 0x41615252
        CMP      R0,R1
        BNE.N    ??chk_mounted_31
        LDRB     R0,[R4, #+539]
        LDRB     R1,[R4, #+538]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+537]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+536]
        ORRS     R0,R1,R0
        LDR.W    R1,??DataTable13_4  ;; 0x61417272
        CMP      R0,R1
        BNE.N    ??chk_mounted_31
// 2150 				fs->last_clust = LD_DWORD(fs->win+FSI_Nxt_Free);
        LDRB     R0,[R4, #+547]
        LDRB     R1,[R4, #+546]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+545]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+544]
        ORRS     R0,R1,R0
        STR      R0,[R4, #+12]
// 2151 				fs->free_clust = LD_DWORD(fs->win+FSI_Free_Count);
        LDRB     R0,[R4, #+543]
        LDRB     R1,[R4, #+542]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R4, #+541]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R4, #+540]
        ORRS     R0,R1,R0
        STR      R0,[R4, #+16]
// 2152 		}
// 2153 	}
// 2154 #endif
// 2155 	fs->fs_type = fmt;		/* FAT sub-type */
??chk_mounted_31:
        STRB     R6,[R4, #+0]
// 2156 	fs->id = ++Fsid;		/* File system mount ID */
        LDR.W    R0,??DataTable13_5
        LDRH     R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR.W    R1,??DataTable13_5
        STRH     R0,[R1, #+0]
        STRH     R0,[R4, #+6]
// 2157 	fs->winsect = 0;		/* Invalidate sector cache */
        MOVS     R0,#+0
        STR      R0,[R4, #+48]
// 2158 	fs->wflag = 0;
        MOVS     R0,#+0
        STRB     R0,[R4, #+4]
// 2159 #if _FS_RPATH
// 2160 	fs->cdir = 0;			/* Current directory (root dir) */
        MOVS     R0,#+0
        STR      R0,[R4, #+24]
// 2161 #endif
// 2162 #if _FS_SHARE				/* Clear file lock semaphores */
// 2163 	clear_lock(fs);
        MOVS     R0,R4
        BL       clear_lock
// 2164 #endif
// 2165 
// 2166 	return FR_OK;
        MOVS     R0,#+0
??chk_mounted_3:
        POP      {R1,R4-R7,PC}    ;; return
// 2167 }
// 2168 
// 2169 
// 2170 
// 2171 
// 2172 /*-----------------------------------------------------------------------*/
// 2173 /* Check if the file/dir object is valid or not                          */
// 2174 /*-----------------------------------------------------------------------*/
// 2175 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2176 static
// 2177 FRESULT validate (	/* FR_OK(0): The object is valid, !=0: Invalid */
// 2178 	FATFS *fs,		/* Pointer to the file system object */
// 2179 	WORD id			/* Member id of the target object to be checked */
// 2180 )
// 2181 {
validate:
        PUSH     {R7,LR}
// 2182 	if (!fs || !fs->fs_type || fs->id != id)
        CMP      R0,#+0
        BEQ.N    ??validate_0
        LDRB     R2,[R0, #+0]
        CMP      R2,#+0
        BEQ.N    ??validate_0
        LDRH     R2,[R0, #+6]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        CMP      R2,R1
        BEQ.N    ??validate_1
// 2183 		return FR_INVALID_OBJECT;
??validate_0:
        MOVS     R0,#+9
        B.N      ??validate_2
// 2184 
// 2185 	ENTER_FF(fs);		/* Lock file system */
// 2186 
// 2187 	if (LPLD_Disk_Status(fs->drv) & STA_NOINIT)
??validate_1:
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Status
        LSLS     R0,R0,#+31
        BPL.N    ??validate_3
// 2188 		return FR_NOT_READY;
        MOVS     R0,#+3
        B.N      ??validate_2
// 2189 
// 2190 	return FR_OK;
??validate_3:
        MOVS     R0,#+0
??validate_2:
        POP      {R1,PC}          ;; return
// 2191 }
// 2192 
// 2193 
// 2194 
// 2195 
// 2196 /*--------------------------------------------------------------------------
// 2197 
// 2198    Public Functions
// 2199 
// 2200 --------------------------------------------------------------------------*/
// 2201 
// 2202 
// 2203 
// 2204 /*-----------------------------------------------------------------------*/
// 2205 /* Mount/Unmount a Logical Drive                                         */
// 2206 /*-----------------------------------------------------------------------*/
// 2207 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2208 FRESULT f_mount (
// 2209 	BYTE vol,		/* Logical drive number to be mounted/unmounted */
// 2210 	FATFS *fs		/* Pointer to new file system object (NULL for unmount)*/
// 2211 )
// 2212 {
f_mount:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 2213 	FATFS *rfs;
// 2214 
// 2215 
// 2216 	if (vol >= _VOLUMES)		/* Check if the drive number is valid */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+1
        BCC.N    ??f_mount_0
// 2217 		return FR_INVALID_DRIVE;
        MOVS     R0,#+11
        B.N      ??f_mount_1
// 2218 	rfs = FatFs[vol];			/* Get current fs object */
??f_mount_0:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.W    R0,??DataTable13_2
        LDR      R6,[R0, R4, LSL #+2]
// 2219 
// 2220 	if (rfs) {
        CMP      R6,#+0
        BEQ.N    ??f_mount_2
// 2221 #if _FS_SHARE
// 2222 		clear_lock(rfs);
        MOVS     R0,R6
        BL       clear_lock
// 2223 #endif
// 2224 #if _FS_REENTRANT				/* Discard sync object of the current volume */
// 2225 		if (!ff_del_syncobj(rfs->sobj)) return FR_INT_ERR;
// 2226 #endif
// 2227 		rfs->fs_type = 0;		/* Clear old fs object */
        MOVS     R0,#+0
        STRB     R0,[R6, #+0]
// 2228 	}
// 2229 
// 2230 	if (fs) {
??f_mount_2:
        CMP      R5,#+0
        BEQ.N    ??f_mount_3
// 2231 		fs->fs_type = 0;		/* Clear new fs object */
        MOVS     R0,#+0
        STRB     R0,[R5, #+0]
// 2232 #if _FS_REENTRANT				/* Create sync object for the new volume */
// 2233 		if (!ff_cre_syncobj(vol, &fs->sobj)) return FR_INT_ERR;
// 2234 #endif
// 2235 	}
// 2236 	FatFs[vol] = fs;			/* Register new fs object */
??f_mount_3:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        LDR.W    R0,??DataTable13_2
        STR      R5,[R0, R4, LSL #+2]
// 2237 
// 2238 	return FR_OK;
        MOVS     R0,#+0
??f_mount_1:
        POP      {R4-R6,PC}       ;; return
// 2239 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11:
        DC32     `?<Constant "\\"*:<>?|\\177">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_1:
        DC32     ??excvt

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_2:
        DC32     `?<Constant "+,;=[]">`
// 2240 
// 2241 
// 2242 
// 2243 
// 2244 /*-----------------------------------------------------------------------*/
// 2245 /* Open or Create a File                                                 */
// 2246 /*-----------------------------------------------------------------------*/
// 2247 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2248 FRESULT f_open (
// 2249 	FIL *fp,			/* Pointer to the blank file object */
// 2250 	const TCHAR *path,	/* Pointer to the file name */
// 2251 	BYTE mode			/* Access mode and file open mode flags */
// 2252 )
// 2253 {
f_open:
        PUSH     {R1,R4-R10,LR}
        SUB      SP,SP,#+52
        MOVS     R4,R0
        MOVS     R6,R2
// 2254 	FRESULT res;
// 2255 	DIR dj;
// 2256 	BYTE *dir;
// 2257 	DEF_NAMEBUF;
// 2258 
// 2259 
// 2260 	fp->fs = 0;			/* Clear file object */
        MOVS     R0,#+0
        STR      R0,[R4, #+0]
// 2261 
// 2262 #if !_FS_READONLY
// 2263 	mode &= FA_READ | FA_WRITE | FA_CREATE_ALWAYS | FA_OPEN_ALWAYS | FA_CREATE_NEW;
        ANDS     R6,R6,#0x1F
// 2264 	res = chk_mounted(&path, &dj.fs, (BYTE)(mode & ~FA_READ));
        ANDS     R2,R6,#0xFE
        ADD      R1,SP,#+0
        ADD      R0,SP,#+52
        BL       chk_mounted
        MOVS     R7,R0
// 2265 #else
// 2266 	mode &= FA_READ;
// 2267 	res = chk_mounted(&path, &dj.fs, 0);
// 2268 #endif
// 2269 	INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_open_0
        MOVS     R0,#+17
        B.N      ??f_open_1
??f_open_0:
        STR      R5,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 2270 	if (res == FR_OK)
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??f_open_2
// 2271 		res = follow_path(&dj, path);	/* Follow the file path */
        LDR      R1,[SP, #+52]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R7,R0
// 2272 	dir = dj.dir;
??f_open_2:
        LDR      R8,[SP, #+20]
// 2273 
// 2274 #if !_FS_READONLY	/* R/W configuration */
// 2275 	if (res == FR_OK) {
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??f_open_3
// 2276 		if (!dir)	/* Current dir itself */
        CMP      R8,#+0
        BNE.N    ??f_open_4
// 2277 			res = FR_INVALID_NAME;
        MOVS     R7,#+6
        B.N      ??f_open_3
// 2278 #if _FS_SHARE
// 2279 		else
// 2280 			res = chk_lock(&dj, (mode & ~FA_READ) ? 1 : 0);
??f_open_4:
        MOVS     R0,#+254
        TST      R6,R0
        BEQ.N    ??f_open_5
        MOVS     R1,#+1
        B.N      ??f_open_6
??f_open_5:
        MOVS     R1,#+0
??f_open_6:
        ADD      R0,SP,#+0
        BL       chk_lock
        MOVS     R7,R0
// 2281 #endif
// 2282 	}
// 2283 	/* Create or Open a file */
// 2284 	if (mode & (FA_CREATE_ALWAYS | FA_OPEN_ALWAYS | FA_CREATE_NEW)) {
??f_open_3:
        MOVS     R0,#+28
        TST      R6,R0
        BEQ.N    ??f_open_7
// 2285 		DWORD dw, cl;
// 2286 
// 2287 		if (res != FR_OK) {					/* No file, create new */
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BEQ.N    ??f_open_8
// 2288 			if (res == FR_NO_FILE)			/* There is no file to open, create a new entry */
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+4
        BNE.N    ??f_open_9
// 2289 #if _FS_SHARE
// 2290 				res = enq_lock() ? dir_register(&dj) : FR_TOO_MANY_OPEN_FILES;
        BL       enq_lock
        CMP      R0,#+0
        BEQ.N    ??f_open_10
        ADD      R0,SP,#+0
        BL       dir_register
        MOVS     R7,R0
        B.N      ??f_open_11
??f_open_10:
        MOVS     R7,#+18
// 2291 #else
// 2292 				res = dir_register(&dj);
// 2293 #endif
// 2294 			mode |= FA_CREATE_ALWAYS;		/* File is created */
??f_open_11:
??f_open_9:
        ORRS     R6,R6,#0x8
// 2295 			dir = dj.dir;					/* New entry */
        LDR      R8,[SP, #+20]
        B.N      ??f_open_12
// 2296 		}
// 2297 		else {								/* Any object is already existing */
// 2298 			if (dir[DIR_Attr] & (AM_RDO | AM_DIR)) {	/* Cannot overwrite it (R/O or DIR) */
??f_open_8:
        LDRB     R0,[R8, #+11]
        MOVS     R1,#+17
        TST      R0,R1
        BEQ.N    ??f_open_13
// 2299 				res = FR_DENIED;
        MOVS     R7,#+7
        B.N      ??f_open_12
// 2300 			} else {
// 2301 				if (mode & FA_CREATE_NEW)	/* Cannot create as new file */
??f_open_13:
        LSLS     R0,R6,#+29
        BPL.N    ??f_open_12
// 2302 					res = FR_EXIST;
        MOVS     R7,#+8
// 2303 			}
// 2304 		}
// 2305 		if (res == FR_OK && (mode & FA_CREATE_ALWAYS)) {	/* Truncate it if overwrite mode */
??f_open_12:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??f_open_14
        LSLS     R0,R6,#+28
        BPL.N    ??f_open_14
// 2306 			dw = get_fattime();					/* Created time */
        BL       get_fattime
        MOV      R9,R0
// 2307 			ST_DWORD(dir+DIR_CrtTime, dw);
        STRB     R9,[R8, #+14]
        MOV      R0,R9
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R8, #+15]
        LSRS     R0,R9,#+16
        STRB     R0,[R8, #+16]
        LSRS     R0,R9,#+24
        STRB     R0,[R8, #+17]
// 2308 			dir[DIR_Attr] = 0;					/* Reset attribute */
        MOVS     R0,#+0
        STRB     R0,[R8, #+11]
// 2309 			ST_DWORD(dir+DIR_FileSize, 0);		/* size = 0 */
        MOVS     R0,#+0
        STRB     R0,[R8, #+28]
        MOVS     R0,#+0
        STRB     R0,[R8, #+29]
        MOVS     R0,#+0
        STRB     R0,[R8, #+30]
        MOVS     R0,#+0
        STRB     R0,[R8, #+31]
// 2310 			cl = LD_CLUST(dir);					/* Get start cluster */
        LDRB     R0,[R8, #+21]
        LDRB     R1,[R8, #+20]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRB     R1,[R8, #+27]
        LDRB     R2,[R8, #+26]
        ORRS     R1,R2,R1, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ORRS     R10,R1,R0, LSL #+16
// 2311 			ST_CLUST(dir, 0);					/* cluster = 0 */
        MOVS     R0,#+0
        STRB     R0,[R8, #+26]
        MOVS     R0,#+0
        STRB     R0,[R8, #+27]
        MOVS     R0,#+0
        STRB     R0,[R8, #+20]
        MOVS     R0,#+0
        STRB     R0,[R8, #+21]
// 2312 			dj.fs->wflag = 1;
        LDR      R0,[SP, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
// 2313 			if (cl) {							/* Remove the cluster chain if exist */
        CMP      R10,#+0
        BEQ.N    ??f_open_14
// 2314 				dw = dj.fs->winsect;
        LDR      R0,[SP, #+0]
        LDR      R9,[R0, #+48]
// 2315 				res = remove_chain(dj.fs, cl);
        MOV      R1,R10
        LDR      R0,[SP, #+0]
        BL       remove_chain
        MOVS     R7,R0
// 2316 				if (res == FR_OK) {
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??f_open_14
// 2317 					dj.fs->last_clust = cl - 1;	/* Reuse the cluster hole */
        LDR      R0,[SP, #+0]
        SUBS     R1,R10,#+1
        STR      R1,[R0, #+12]
// 2318 					res = move_window(dj.fs, dw);
        MOV      R1,R9
        LDR      R0,[SP, #+0]
        BL       move_window
        MOVS     R7,R0
        B.N      ??f_open_14
// 2319 				}
// 2320 			}
// 2321 		}
// 2322 	}
// 2323 	else {	/* Open an existing file */
// 2324 		if (res == FR_OK) {						/* Follow succeeded */
??f_open_7:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??f_open_14
// 2325 			if (dir[DIR_Attr] & AM_DIR) {		/* It is a directory */
        LDRB     R0,[R8, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_open_15
// 2326 				res = FR_NO_FILE;
        MOVS     R7,#+4
        B.N      ??f_open_14
// 2327 			} else {
// 2328 				if ((mode & FA_WRITE) && (dir[DIR_Attr] & AM_RDO)) /* R/O violation */
??f_open_15:
        LSLS     R0,R6,#+30
        BPL.N    ??f_open_14
        LDRB     R0,[R8, #+11]
        LSLS     R0,R0,#+31
        BPL.N    ??f_open_14
// 2329 					res = FR_DENIED;
        MOVS     R7,#+7
// 2330 			}
// 2331 		}
// 2332 	}
// 2333 	if (res == FR_OK) {
??f_open_14:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??f_open_16
// 2334 		if (mode & FA_CREATE_ALWAYS)			/* Set file change flag if created or overwritten */
        LSLS     R0,R6,#+28
        BPL.N    ??f_open_17
// 2335 			mode |= FA__WRITTEN;
        ORRS     R6,R6,#0x20
// 2336 		fp->dir_sect = dj.fs->winsect;			/* Pointer to the directory entry */
??f_open_17:
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+48]
        STR      R0,[R4, #+28]
// 2337 		fp->dir_ptr = dir;
        STR      R8,[R4, #+32]
// 2338 #if _FS_SHARE
// 2339 		fp->lockid = inc_lock(&dj, (mode & ~FA_READ) ? 1 : 0);
        MOVS     R0,#+254
        TST      R6,R0
        BEQ.N    ??f_open_18
        MOVS     R1,#+1
        B.N      ??f_open_19
??f_open_18:
        MOVS     R1,#+0
??f_open_19:
        ADD      R0,SP,#+0
        BL       inc_lock
        STR      R0,[R4, #+40]
// 2340 		if (!fp->lockid) res = FR_INT_ERR;
        LDR      R0,[R4, #+40]
        CMP      R0,#+0
        BNE.N    ??f_open_16
        MOVS     R7,#+2
// 2341 #endif
// 2342 	}
// 2343 
// 2344 #else				/* R/O configuration */
// 2345 	if (res == FR_OK) {					/* Follow succeeded */
// 2346 		if (!dir) {						/* Current dir itself */
// 2347 			res = FR_INVALID_NAME;
// 2348 		} else {
// 2349 			if (dir[DIR_Attr] & AM_DIR)	/* It is a directory */
// 2350 				res = FR_NO_FILE;
// 2351 		}
// 2352 	}
// 2353 #endif
// 2354 	FREE_BUF();
??f_open_16:
        MOVS     R0,R5
        BL       ff_memfree
// 2355 
// 2356 	if (res == FR_OK) {
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+0
        BNE.N    ??f_open_20
// 2357 		fp->flag = mode;					/* File access mode */
        STRB     R6,[R4, #+6]
// 2358 		fp->sclust = LD_CLUST(dir);			/* File start cluster */
        LDRB     R0,[R8, #+21]
        LDRB     R1,[R8, #+20]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRB     R1,[R8, #+27]
        LDRB     R2,[R8, #+26]
        ORRS     R1,R2,R1, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ORRS     R0,R1,R0, LSL #+16
        STR      R0,[R4, #+16]
// 2359 		fp->fsize = LD_DWORD(dir+DIR_FileSize);	/* File size */
        LDRB     R0,[R8, #+31]
        LDRB     R1,[R8, #+30]
        LSLS     R1,R1,#+16
        ORRS     R0,R1,R0, LSL #+24
        LDRB     R1,[R8, #+29]
        ORRS     R0,R0,R1, LSL #+8
        LDRB     R1,[R8, #+28]
        ORRS     R0,R1,R0
        STR      R0,[R4, #+12]
// 2360 		fp->fptr = 0;						/* File pointer */
        MOVS     R0,#+0
        STR      R0,[R4, #+8]
// 2361 		fp->dsect = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+24]
// 2362 #if _USE_FASTSEEK
// 2363 		fp->cltbl = 0;						/* Normal seek mode */
        MOVS     R0,#+0
        STR      R0,[R4, #+36]
// 2364 #endif
// 2365 		fp->fs = dj.fs; fp->id = dj.fs->id;	/* Validate file object */
        LDR      R0,[SP, #+0]
        STR      R0,[R4, #+0]
        LDR      R0,[SP, #+0]
        LDRH     R0,[R0, #+6]
        STRH     R0,[R4, #+4]
// 2366 	}
// 2367 
// 2368 	LEAVE_FF(dj.fs, res);
??f_open_20:
        MOVS     R0,R7
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_open_1:
        ADD      SP,SP,#+56
        POP      {R4-R10,PC}      ;; return
// 2369 }
// 2370 
// 2371 
// 2372 
// 2373 
// 2374 /*-----------------------------------------------------------------------*/
// 2375 /* Read File                                                             */
// 2376 /*-----------------------------------------------------------------------*/
// 2377 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2378 FRESULT f_read (
// 2379 	FIL *fp, 		/* Pointer to the file object */
// 2380 	void *buff,		/* Pointer to data buffer */
// 2381 	UINT btr,		/* Number of bytes to read */
// 2382 	UINT *br		/* Pointer to number of bytes read */
// 2383 )
// 2384 {
f_read:
        PUSH     {R4-R10,LR}
        MOVS     R5,R0
        MOVS     R6,R2
        MOVS     R7,R3
// 2385 	FRESULT res;
// 2386 	DWORD clst, sect, remain;
// 2387 	UINT rcnt, cc;
// 2388 	BYTE csect, *rbuff = buff;
        MOVS     R4,R1
// 2389 
// 2390 
// 2391 	*br = 0;	/* Initialize byte counter */
        MOVS     R0,#+0
        STR      R0,[R7, #+0]
// 2392 
// 2393 	res = validate(fp->fs, fp->id);				/* Check validity */
        LDRH     R1,[R5, #+4]
        LDR      R0,[R5, #+0]
        BL       validate
// 2394 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_read_0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??f_read_1
// 2395 	if (fp->flag & FA__ERROR)					/* Aborted file? */
??f_read_0:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+24
        BPL.N    ??f_read_2
// 2396 		LEAVE_FF(fp->fs, FR_INT_ERR);
        MOVS     R0,#+2
        B.N      ??f_read_1
// 2397 	if (!(fp->flag & FA_READ)) 					/* Check access mode */
??f_read_2:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+31
        BMI.N    ??f_read_3
// 2398 		LEAVE_FF(fp->fs, FR_DENIED);
        MOVS     R0,#+7
        B.N      ??f_read_1
// 2399 	remain = fp->fsize - fp->fptr;
??f_read_3:
        LDR      R0,[R5, #+12]
        LDR      R1,[R5, #+8]
        SUBS     R0,R0,R1
// 2400 	if (btr > remain) btr = (UINT)remain;		/* Truncate btr by remaining bytes */
        CMP      R0,R6
        BCS.N    ??f_read_4
        MOVS     R6,R0
        B.N      ??f_read_4
// 2401 
// 2402 	for ( ;  btr;								/* Repeat until all data read */
// 2403 		rbuff += rcnt, fp->fptr += rcnt, *br += rcnt, btr -= rcnt) {
// 2404 		if ((fp->fptr % SS(fp->fs)) == 0) {		/* On the sector boundary? */
// 2405 			csect = (BYTE)(fp->fptr / SS(fp->fs) & (fp->fs->csize - 1));	/* Sector offset in the cluster */
// 2406 			if (!csect) {						/* On the cluster boundary? */
// 2407 				if (fp->fptr == 0) {			/* On the top of the file? */
// 2408 					clst = fp->sclust;			/* Follow from the origin */
// 2409 				} else {						/* Middle or end of the file */
// 2410 #if _USE_FASTSEEK
// 2411 					if (fp->cltbl)
// 2412 						clst = clmt_clust(fp, fp->fptr);	/* Get cluster# from the CLMT */
// 2413 					else
// 2414 #endif
// 2415 						clst = get_fat(fp->fs, fp->clust);	/* Follow cluster chain on the FAT */
// 2416 				}
// 2417 				if (clst < 2) ABORT(fp->fs, FR_INT_ERR);
// 2418 				if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 2419 				fp->clust = clst;				/* Update current cluster */
// 2420 			}
// 2421 			sect = clust2sect(fp->fs, fp->clust);	/* Get current sector */
// 2422 			if (!sect) ABORT(fp->fs, FR_INT_ERR);
// 2423 			sect += csect;
// 2424 			cc = btr / SS(fp->fs);				/* When remaining bytes >= sector size, */
// 2425 			if (cc) {							/* Read maximum contiguous sectors directly */
// 2426 				if (csect + cc > fp->fs->csize)	/* Clip at cluster boundary */
// 2427 					cc = fp->fs->csize - csect;
// 2428 				if (LPLD_Disk_Read(fp->fs->drv, rbuff, sect, (BYTE)cc) != RES_OK)
// 2429 					ABORT(fp->fs, FR_DISK_ERR);
// 2430 #if !_FS_READONLY && _FS_MINIMIZE <= 2			/* Replace one of the read sectors with cached data if it contains a dirty sector */
// 2431 #if _FS_TINY
// 2432 				if (fp->fs->wflag && fp->fs->winsect - sect < cc)
// 2433 					mem_cpy(rbuff + ((fp->fs->winsect - sect) * SS(fp->fs)), fp->fs->win, SS(fp->fs));
// 2434 #else
// 2435 				if ((fp->flag & FA__DIRTY) && fp->dsect - sect < cc)
// 2436 					mem_cpy(rbuff + ((fp->dsect - sect) * SS(fp->fs)), fp->buf, SS(fp->fs));
// 2437 #endif
// 2438 #endif
// 2439 				rcnt = SS(fp->fs) * cc;			/* Number of bytes transferred */
// 2440 				continue;
// 2441 			}
// 2442 #if !_FS_TINY
// 2443 			if (fp->dsect != sect) {			/* Load data sector if not in cache */
// 2444 #if !_FS_READONLY
// 2445 				if (fp->flag & FA__DIRTY) {		/* Write-back dirty sector cache */
// 2446 					if (LPLD_Disk_Write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
// 2447 						ABORT(fp->fs, FR_DISK_ERR);
// 2448 					fp->flag &= ~FA__DIRTY;
// 2449 				}
// 2450 #endif
// 2451 				if (LPLD_Disk_Read(fp->fs->drv, fp->buf, sect, 1) != RES_OK)	/* Fill sector cache */
// 2452 					ABORT(fp->fs, FR_DISK_ERR);
// 2453 			}
// 2454 #endif
// 2455 			fp->dsect = sect;
??f_read_5:
        STR      R9,[R5, #+24]
// 2456 		}
// 2457 		rcnt = SS(fp->fs) - (fp->fptr % SS(fp->fs));	/* Get partial sector data from sector buffer */
??f_read_6:
        MOV      R0,#+512
        LDR      R1,[R5, #+8]
        MOV      R2,#+512
        UDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        SUBS     R8,R0,R3
// 2458 		if (rcnt > btr) rcnt = btr;
        CMP      R6,R8
        BCS.N    ??f_read_7
        MOV      R8,R6
// 2459 #if _FS_TINY
// 2460 		if (move_window(fp->fs, fp->dsect))		/* Move sector window */
// 2461 			ABORT(fp->fs, FR_DISK_ERR);
// 2462 		mem_cpy(rbuff, &fp->fs->win[fp->fptr % SS(fp->fs)], rcnt);	/* Pick partial sector */
// 2463 #else
// 2464 		mem_cpy(rbuff, &fp->buf[fp->fptr % SS(fp->fs)], rcnt);	/* Pick partial sector */
??f_read_7:
        MOV      R2,R8
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R3,R0,R1
        MLS      R3,R3,R1,R0
        ADDS     R0,R3,R5
        ADDS     R1,R0,#+44
        MOVS     R0,R4
        BL       mem_cpy
??f_read_8:
        ADDS     R4,R8,R4
        LDR      R0,[R5, #+8]
        ADDS     R0,R8,R0
        STR      R0,[R5, #+8]
        LDR      R0,[R7, #+0]
        ADDS     R0,R8,R0
        STR      R0,[R7, #+0]
        SUBS     R6,R6,R8
??f_read_4:
        CMP      R6,#+0
        BEQ.W    ??f_read_9
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BNE.N    ??f_read_6
        LDR      R0,[R5, #+8]
        LSRS     R0,R0,#+9
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        ANDS     R8,R1,R0
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_read_10
        LDR      R0,[R5, #+8]
        CMP      R0,#+0
        BNE.N    ??f_read_11
        LDR      R0,[R5, #+16]
        B.N      ??f_read_12
??f_read_11:
        LDR      R0,[R5, #+36]
        CMP      R0,#+0
        BEQ.N    ??f_read_13
        LDR      R1,[R5, #+8]
        MOVS     R0,R5
        BL       clmt_clust
        B.N      ??f_read_12
??f_read_13:
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       get_fat
??f_read_12:
        CMP      R0,#+2
        BCS.N    ??f_read_14
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_read_1
??f_read_14:
        CMN      R0,#+1
        BNE.N    ??f_read_15
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
??f_read_15:
        STR      R0,[R5, #+20]
??f_read_10:
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       clust2sect
        MOV      R9,R0
        CMP      R9,#+0
        BNE.N    ??f_read_16
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_read_1
??f_read_16:
        UXTAB    R9,R9,R8
        LSRS     R10,R6,#+9
        CMP      R10,#+0
        BEQ.N    ??f_read_17
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+2]
        UXTAB    R1,R10,R8
        CMP      R0,R1
        BCS.N    ??f_read_18
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+2]
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        SUBS     R10,R0,R8
??f_read_18:
        MOV      R3,R10
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOV      R2,R9
        MOVS     R1,R4
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Read
        CMP      R0,#+0
        BEQ.N    ??f_read_19
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
??f_read_19:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_read_20
        LDR      R0,[R5, #+24]
        SUBS     R0,R0,R9
        CMP      R0,R10
        BCS.N    ??f_read_20
        MOV      R2,#+512
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+24]
        SUBS     R0,R0,R9
        MOV      R3,#+512
        MLA      R0,R3,R0,R4
        BL       mem_cpy
??f_read_20:
        MOV      R0,#+512
        MUL      R8,R0,R10
        B.N      ??f_read_8
??f_read_17:
        LDR      R0,[R5, #+24]
        CMP      R0,R9
        BEQ.W    ??f_read_5
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_read_21
        MOVS     R3,#+1
        LDR      R2,[R5, #+24]
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Write
        CMP      R0,#+0
        BEQ.N    ??f_read_22
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
??f_read_22:
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
??f_read_21:
        MOVS     R3,#+1
        MOV      R2,R9
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Read
        CMP      R0,#+0
        BEQ.W    ??f_read_5
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_read_1
// 2465 #endif
// 2466 	}
// 2467 
// 2468 	LEAVE_FF(fp->fs, FR_OK);
??f_read_9:
        MOVS     R0,#+0
??f_read_1:
        POP      {R4-R10,PC}      ;; return
// 2469 }
// 2470 
// 2471 
// 2472 
// 2473 
// 2474 #if !_FS_READONLY
// 2475 /*-----------------------------------------------------------------------*/
// 2476 /* Write File                                                            */
// 2477 /*-----------------------------------------------------------------------*/
// 2478 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2479 FRESULT f_write (
// 2480 	FIL *fp,			/* Pointer to the file object */
// 2481 	const void *buff,	/* Pointer to the data to be written */
// 2482 	UINT btw,			/* Number of bytes to write */
// 2483 	UINT *bw			/* Pointer to number of bytes written */
// 2484 )
// 2485 {
f_write:
        PUSH     {R4-R10,LR}
        MOVS     R5,R0
        MOVS     R6,R2
        MOVS     R7,R3
// 2486 	FRESULT res;
// 2487 	DWORD clst, sect;
// 2488 	UINT wcnt, cc;
// 2489 	const BYTE *wbuff = buff;
        MOVS     R4,R1
// 2490 	BYTE csect;
// 2491 
// 2492 
// 2493 	*bw = 0;	/* Initialize byte counter */
        MOVS     R0,#+0
        STR      R0,[R7, #+0]
// 2494 
// 2495 	res = validate(fp->fs, fp->id);			/* Check validity */
        LDRH     R1,[R5, #+4]
        LDR      R0,[R5, #+0]
        BL       validate
// 2496 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_write_0
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??f_write_1
// 2497 	if (fp->flag & FA__ERROR)				/* Aborted file? */
??f_write_0:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+24
        BPL.N    ??f_write_2
// 2498 		LEAVE_FF(fp->fs, FR_INT_ERR);
        MOVS     R0,#+2
        B.N      ??f_write_1
// 2499 	if (!(fp->flag & FA_WRITE))				/* Check access mode */
??f_write_2:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+30
        BMI.N    ??f_write_3
// 2500 		LEAVE_FF(fp->fs, FR_DENIED);
        MOVS     R0,#+7
        B.N      ??f_write_1
// 2501 	if ((DWORD)(fp->fsize + btw) < fp->fsize) btw = 0;	/* File size cannot reach 4GB */
??f_write_3:
        LDR      R0,[R5, #+12]
        ADDS     R0,R6,R0
        LDR      R1,[R5, #+12]
        CMP      R0,R1
        BCS.N    ??f_write_4
        MOVS     R6,#+0
        B.N      ??f_write_4
// 2502 
// 2503 	for ( ;  btw;							/* Repeat until all data written */
// 2504 		wbuff += wcnt, fp->fptr += wcnt, *bw += wcnt, btw -= wcnt) {
// 2505 		if ((fp->fptr % SS(fp->fs)) == 0) {	/* On the sector boundary? */
// 2506 			csect = (BYTE)(fp->fptr / SS(fp->fs) & (fp->fs->csize - 1));	/* Sector offset in the cluster */
// 2507 			if (!csect) {					/* On the cluster boundary? */
// 2508 				if (fp->fptr == 0) {		/* On the top of the file? */
// 2509 					clst = fp->sclust;		/* Follow from the origin */
// 2510 					if (clst == 0)			/* When no cluster is allocated, */
// 2511 						fp->sclust = clst = create_chain(fp->fs, 0);	/* Create a new cluster chain */
// 2512 				} else {					/* Middle or end of the file */
// 2513 #if _USE_FASTSEEK
// 2514 					if (fp->cltbl)
// 2515 						clst = clmt_clust(fp, fp->fptr);	/* Get cluster# from the CLMT */
// 2516 					else
// 2517 #endif
// 2518 						clst = create_chain(fp->fs, fp->clust);	/* Follow or stretch cluster chain on the FAT */
// 2519 				}
// 2520 				if (clst == 0) break;		/* Could not allocate a new cluster (disk full) */
// 2521 				if (clst == 1) ABORT(fp->fs, FR_INT_ERR);
// 2522 				if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 2523 				fp->clust = clst;			/* Update current cluster */
// 2524 			}
// 2525 #if _FS_TINY
// 2526 			if (fp->fs->winsect == fp->dsect && move_window(fp->fs, 0))	/* Write-back sector cache */
// 2527 				ABORT(fp->fs, FR_DISK_ERR);
// 2528 #else
// 2529 			if (fp->flag & FA__DIRTY) {		/* Write-back sector cache */
// 2530 				if (LPLD_Disk_Write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
// 2531 					ABORT(fp->fs, FR_DISK_ERR);
// 2532 				fp->flag &= ~FA__DIRTY;
// 2533 			}
// 2534 #endif
// 2535 			sect = clust2sect(fp->fs, fp->clust);	/* Get current sector */
// 2536 			if (!sect) ABORT(fp->fs, FR_INT_ERR);
// 2537 			sect += csect;
// 2538 			cc = btw / SS(fp->fs);			/* When remaining bytes >= sector size, */
// 2539 			if (cc) {						/* Write maximum contiguous sectors directly */
// 2540 				if (csect + cc > fp->fs->csize)	/* Clip at cluster boundary */
// 2541 					cc = fp->fs->csize - csect;
// 2542 				if (LPLD_Disk_Write(fp->fs->drv, wbuff, sect, (BYTE)cc) != RES_OK)
// 2543 					ABORT(fp->fs, FR_DISK_ERR);
// 2544 #if _FS_TINY
// 2545 				if (fp->fs->winsect - sect < cc) {	/* Refill sector cache if it gets invalidated by the direct write */
// 2546 					mem_cpy(fp->fs->win, wbuff + ((fp->fs->winsect - sect) * SS(fp->fs)), SS(fp->fs));
// 2547 					fp->fs->wflag = 0;
// 2548 				}
// 2549 #else
// 2550 				if (fp->dsect - sect < cc) { /* Refill sector cache if it gets invalidated by the direct write */
// 2551 					mem_cpy(fp->buf, wbuff + ((fp->dsect - sect) * SS(fp->fs)), SS(fp->fs));
// 2552 					fp->flag &= ~FA__DIRTY;
// 2553 				}
// 2554 #endif
// 2555 				wcnt = SS(fp->fs) * cc;		/* Number of bytes transferred */
// 2556 				continue;
// 2557 			}
// 2558 #if _FS_TINY
// 2559 			if (fp->fptr >= fp->fsize) {	/* Avoid silly cache filling at growing edge */
// 2560 				if (move_window(fp->fs, 0)) ABORT(fp->fs, FR_DISK_ERR);
// 2561 				fp->fs->winsect = sect;
// 2562 			}
// 2563 #else
// 2564 			if (fp->dsect != sect) {		/* Fill sector cache with file data */
// 2565 				if (fp->fptr < fp->fsize &&
// 2566 					LPLD_Disk_Read(fp->fs->drv, fp->buf, sect, 1) != RES_OK)
// 2567 						ABORT(fp->fs, FR_DISK_ERR);
// 2568 			}
// 2569 #endif
// 2570 			fp->dsect = sect;
??f_write_5:
        STR      R9,[R5, #+24]
// 2571 		}
// 2572 		wcnt = SS(fp->fs) - (fp->fptr % SS(fp->fs));/* Put partial sector into file I/O buffer */
??f_write_6:
        MOV      R0,#+512
        LDR      R1,[R5, #+8]
        MOV      R2,#+512
        UDIV     R3,R1,R2
        MLS      R3,R3,R2,R1
        SUBS     R8,R0,R3
// 2573 		if (wcnt > btw) wcnt = btw;
        CMP      R6,R8
        BCS.N    ??f_write_7
        MOV      R8,R6
// 2574 #if _FS_TINY
// 2575 		if (move_window(fp->fs, fp->dsect))	/* Move sector window */
// 2576 			ABORT(fp->fs, FR_DISK_ERR);
// 2577 		mem_cpy(&fp->fs->win[fp->fptr % SS(fp->fs)], wbuff, wcnt);	/* Fit partial sector */
// 2578 		fp->fs->wflag = 1;
// 2579 #else
// 2580 		mem_cpy(&fp->buf[fp->fptr % SS(fp->fs)], wbuff, wcnt);	/* Fit partial sector */
??f_write_7:
        MOV      R2,R8
        MOVS     R1,R4
        LDR      R0,[R5, #+8]
        MOV      R3,#+512
        UDIV     R12,R0,R3
        MLS      R12,R12,R3,R0
        ADDS     R0,R12,R5
        ADDS     R0,R0,#+44
        BL       mem_cpy
// 2581 		fp->flag |= FA__DIRTY;
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x40
        STRB     R0,[R5, #+6]
??f_write_8:
        ADDS     R4,R8,R4
        LDR      R0,[R5, #+8]
        ADDS     R0,R8,R0
        STR      R0,[R5, #+8]
        LDR      R0,[R7, #+0]
        ADDS     R0,R8,R0
        STR      R0,[R7, #+0]
        SUBS     R6,R6,R8
??f_write_4:
        CMP      R6,#+0
        BEQ.N    ??f_write_9
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BNE.N    ??f_write_6
        LDR      R0,[R5, #+8]
        LSRS     R0,R0,#+9
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        ANDS     R8,R1,R0
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_write_10
        LDR      R0,[R5, #+8]
        CMP      R0,#+0
        BNE.N    ??f_write_11
        LDR      R0,[R5, #+16]
        CMP      R0,#+0
        BNE.N    ??f_write_12
        MOVS     R1,#+0
        LDR      R0,[R5, #+0]
        BL       create_chain
        STR      R0,[R5, #+16]
        B.N      ??f_write_12
??f_write_11:
        LDR      R0,[R5, #+36]
        CMP      R0,#+0
        BEQ.N    ??f_write_13
        LDR      R1,[R5, #+8]
        MOVS     R0,R5
        BL       clmt_clust
        B.N      ??f_write_12
??f_write_13:
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       create_chain
??f_write_12:
        CMP      R0,#+0
        BNE.N    ??f_write_14
// 2582 #endif
// 2583 	}
// 2584 
// 2585 	if (fp->fptr > fp->fsize) fp->fsize = fp->fptr;	/* Update file size if needed */
??f_write_9:
        LDR      R0,[R5, #+12]
        LDR      R1,[R5, #+8]
        CMP      R0,R1
        BCS.N    ??f_write_15
        LDR      R0,[R5, #+8]
        STR      R0,[R5, #+12]
// 2586 	fp->flag |= FA__WRITTEN;						/* Set file change flag */
??f_write_15:
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x20
        STRB     R0,[R5, #+6]
// 2587 
// 2588 	LEAVE_FF(fp->fs, FR_OK);
        MOVS     R0,#+0
??f_write_1:
        POP      {R4-R10,PC}      ;; return
??f_write_14:
        CMP      R0,#+1
        BNE.N    ??f_write_16
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_write_1
??f_write_16:
        CMN      R0,#+1
        BNE.N    ??f_write_17
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
??f_write_17:
        STR      R0,[R5, #+20]
??f_write_10:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_write_18
        MOVS     R3,#+1
        LDR      R2,[R5, #+24]
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Write
        CMP      R0,#+0
        BEQ.N    ??f_write_19
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
??f_write_19:
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
??f_write_18:
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       clust2sect
        MOV      R9,R0
        CMP      R9,#+0
        BNE.N    ??f_write_20
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_write_1
??f_write_20:
        UXTAB    R9,R9,R8
        LSRS     R10,R6,#+9
        CMP      R10,#+0
        BEQ.N    ??f_write_21
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+2]
        UXTAB    R1,R10,R8
        CMP      R0,R1
        BCS.N    ??f_write_22
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+2]
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        SUBS     R10,R0,R8
??f_write_22:
        MOV      R3,R10
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        MOV      R2,R9
        MOVS     R1,R4
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Write
        CMP      R0,#+0
        BEQ.N    ??f_write_23
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
??f_write_23:
        LDR      R0,[R5, #+24]
        SUBS     R0,R0,R9
        CMP      R0,R10
        BCS.N    ??f_write_24
        MOV      R2,#+512
        LDR      R0,[R5, #+24]
        SUBS     R0,R0,R9
        MOV      R1,#+512
        MLA      R1,R1,R0,R4
        ADDS     R0,R5,#+44
        BL       mem_cpy
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
??f_write_24:
        MOV      R0,#+512
        MUL      R8,R0,R10
        B.N      ??f_write_8
??f_write_21:
        LDR      R0,[R5, #+24]
        CMP      R0,R9
        BEQ.W    ??f_write_5
        LDR      R0,[R5, #+8]
        LDR      R1,[R5, #+12]
        CMP      R0,R1
        BCS.W    ??f_write_5
        MOVS     R3,#+1
        MOV      R2,R9
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Read
        CMP      R0,#+0
        BEQ.W    ??f_write_5
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_write_1
// 2589 }
// 2590 
// 2591 
// 2592 
// 2593 
// 2594 /*-----------------------------------------------------------------------*/
// 2595 /* Synchronize the File Object                                           */
// 2596 /*-----------------------------------------------------------------------*/
// 2597 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2598 FRESULT f_sync (
// 2599 	FIL *fp		/* Pointer to the file object */
// 2600 )
// 2601 {
f_sync:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
// 2602 	FRESULT res;
// 2603 	DWORD tim;
// 2604 	BYTE *dir;
// 2605 
// 2606 
// 2607 	res = validate(fp->fs, fp->id);		/* Check validity of the object */
        LDRH     R1,[R4, #+4]
        LDR      R0,[R4, #+0]
        BL       validate
// 2608 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_sync_0
// 2609 		if (fp->flag & FA__WRITTEN) {	/* Has the file been written? */
        LDRB     R1,[R4, #+6]
        LSLS     R1,R1,#+26
        BPL.N    ??f_sync_0
// 2610 #if !_FS_TINY	/* Write-back dirty buffer */
// 2611 			if (fp->flag & FA__DIRTY) {
        LDRB     R0,[R4, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_sync_1
// 2612 				if (LPLD_Disk_Write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R4, #+24]
        ADDS     R1,R4,#+44
        LDR      R0,[R4, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Write
        CMP      R0,#+0
        BEQ.N    ??f_sync_2
// 2613 					LEAVE_FF(fp->fs, FR_DISK_ERR);
        MOVS     R0,#+1
        B.N      ??f_sync_3
// 2614 				fp->flag &= ~FA__DIRTY;
??f_sync_2:
        LDRB     R0,[R4, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R4, #+6]
// 2615 			}
// 2616 #endif
// 2617 			/* Update the directory entry */
// 2618 			res = move_window(fp->fs, fp->dir_sect);
??f_sync_1:
        LDR      R1,[R4, #+28]
        LDR      R0,[R4, #+0]
        BL       move_window
// 2619 			if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_sync_0
// 2620 				dir = fp->dir_ptr;
        LDR      R5,[R4, #+32]
// 2621 				dir[DIR_Attr] |= AM_ARC;					/* Set archive bit */
        LDRB     R0,[R5, #+11]
        ORRS     R0,R0,#0x20
        STRB     R0,[R5, #+11]
// 2622 				ST_DWORD(dir+DIR_FileSize, fp->fsize);		/* Update file size */
        LDR      R0,[R4, #+12]
        STRB     R0,[R5, #+28]
        LDR      R0,[R4, #+12]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+29]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+16
        STRB     R0,[R5, #+30]
        LDR      R0,[R4, #+12]
        LSRS     R0,R0,#+24
        STRB     R0,[R5, #+31]
// 2623 				ST_CLUST(dir, fp->sclust);					/* Update start cluster */
        LDR      R0,[R4, #+16]
        STRB     R0,[R5, #+26]
        LDR      R0,[R4, #+16]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+27]
        LDR      R0,[R4, #+16]
        LSRS     R0,R0,#+16
        STRB     R0,[R5, #+20]
        LDR      R0,[R4, #+16]
        LSRS     R0,R0,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R5, #+21]
// 2624 				tim = get_fattime();						/* Update updated time */
        BL       get_fattime
// 2625 				ST_DWORD(dir+DIR_WrtTime, tim);
        STRB     R0,[R5, #+22]
        MOVS     R1,R0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R5, #+23]
        LSRS     R1,R0,#+16
        STRB     R1,[R5, #+24]
        LSRS     R0,R0,#+24
        STRB     R0,[R5, #+25]
// 2626 				fp->flag &= ~FA__WRITTEN;
        LDRB     R0,[R4, #+6]
        ANDS     R0,R0,#0xDF
        STRB     R0,[R4, #+6]
// 2627 				fp->fs->wflag = 1;
        LDR      R0,[R4, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
// 2628 				res = sync(fp->fs);
        LDR      R0,[R4, #+0]
        BL       sync
// 2629 			}
// 2630 		}
// 2631 	}
// 2632 
// 2633 	LEAVE_FF(fp->fs, res);
??f_sync_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_sync_3:
        POP      {R1,R4,R5,PC}    ;; return
// 2634 }
// 2635 
// 2636 #endif /* !_FS_READONLY */
// 2637 
// 2638 
// 2639 
// 2640 
// 2641 /*-----------------------------------------------------------------------*/
// 2642 /* Close File                                                            */
// 2643 /*-----------------------------------------------------------------------*/
// 2644 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2645 FRESULT f_close (
// 2646 	FIL *fp		/* Pointer to the file object to be closed */
// 2647 )
// 2648 {
f_close:
        PUSH     {R4,LR}
        MOVS     R4,R0
// 2649 	FRESULT res;
// 2650 
// 2651 #if _FS_READONLY
// 2652 	FATFS *fs = fp->fs;
// 2653 	res = validate(fs, fp->id);
// 2654 	if (res == FR_OK) fp->fs = 0;	/* Discard file object */
// 2655 	LEAVE_FF(fs, res);
// 2656 
// 2657 #else
// 2658 	res = f_sync(fp);		/* Flush cached data */
        MOVS     R0,R4
        BL       f_sync
// 2659 #if _FS_SHARE
// 2660 	if (res == FR_OK) {		/* Decrement open counter */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_close_0
// 2661 #if _FS_REENTRANT
// 2662 		res = validate(fp->fs, fp->id);
// 2663 		if (res == FR_OK) {
// 2664 			res = dec_lock(fp->lockid);	
// 2665 			unlock_fs(fp->fs, FR_OK);
// 2666 		}
// 2667 #else
// 2668 		res = dec_lock(fp->lockid);
        LDR      R0,[R4, #+40]
        BL       dec_lock
// 2669 #endif
// 2670 	}
// 2671 #endif
// 2672 	if (res == FR_OK) fp->fs = 0;	/* Discard file object */
??f_close_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_close_1
        MOVS     R1,#+0
        STR      R1,[R4, #+0]
// 2673 	return res;
??f_close_1:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R4,PC}          ;; return
// 2674 #endif
// 2675 }
// 2676 
// 2677 
// 2678 
// 2679 
// 2680 /*-----------------------------------------------------------------------*/
// 2681 /* Current Drive/Directory Handlings                                     */
// 2682 /*-----------------------------------------------------------------------*/
// 2683 
// 2684 #if _FS_RPATH >= 1
// 2685 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2686 FRESULT f_chdrive (
// 2687 	BYTE drv		/* Drive number */
// 2688 )
// 2689 {
// 2690 	if (drv >= _VOLUMES) return FR_INVALID_DRIVE;
f_chdrive:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BCC.N    ??f_chdrive_0
        MOVS     R0,#+11
        B.N      ??f_chdrive_1
// 2691 
// 2692 	CurrVol = drv;
??f_chdrive_0:
        LDR.N    R1,??DataTable13_1
        STRB     R0,[R1, #+0]
// 2693 
// 2694 	return FR_OK;
        MOVS     R0,#+0
??f_chdrive_1:
        BX       LR               ;; return
// 2695 }
// 2696 
// 2697 
// 2698 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2699 FRESULT f_chdir (
// 2700 	const TCHAR *path	/* Pointer to the directory path */
// 2701 )
// 2702 {
f_chdir:
        PUSH     {R0,R4,R5,LR}
        SUB      SP,SP,#+48
// 2703 	FRESULT res;
// 2704 	DIR dj;
// 2705 	DEF_NAMEBUF;
// 2706 
// 2707 
// 2708 	res = chk_mounted(&path, &dj.fs, 0);
        MOVS     R2,#+0
        ADD      R1,SP,#+0
        ADD      R0,SP,#+48
        BL       chk_mounted
        MOVS     R4,R0
// 2709 	if (res == FR_OK) {
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_chdir_0
// 2710 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_chdir_1
        MOVS     R0,#+17
        B.N      ??f_chdir_2
??f_chdir_1:
        STR      R5,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 2711 		res = follow_path(&dj, path);		/* Follow the path */
        LDR      R1,[SP, #+48]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R4,R0
// 2712 		FREE_BUF();
        MOVS     R0,R5
        BL       ff_memfree
// 2713 		if (res == FR_OK) {					/* Follow completed */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BNE.N    ??f_chdir_3
// 2714 			if (!dj.dir) {
        LDR      R0,[SP, #+20]
        CMP      R0,#+0
        BNE.N    ??f_chdir_4
// 2715 				dj.fs->cdir = dj.sclust;	/* Start directory itself */
        LDR      R0,[SP, #+0]
        LDR      R1,[SP, #+8]
        STR      R1,[R0, #+24]
        B.N      ??f_chdir_3
// 2716 			} else {
// 2717 				if (dj.dir[DIR_Attr] & AM_DIR)	/* Reached to the directory */
??f_chdir_4:
        LDR      R0,[SP, #+20]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_chdir_5
// 2718 					dj.fs->cdir = LD_CLUST(dj.dir);
        LDR      R0,[SP, #+20]
        LDRB     R0,[R0, #+21]
        LDR      R1,[SP, #+20]
        LDRB     R1,[R1, #+20]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR      R1,[SP, #+20]
        LDRB     R1,[R1, #+27]
        LDR      R2,[SP, #+20]
        LDRB     R2,[R2, #+26]
        ORRS     R1,R2,R1, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ORRS     R0,R1,R0, LSL #+16
        LDR      R1,[SP, #+0]
        STR      R0,[R1, #+24]
        B.N      ??f_chdir_3
// 2719 				else
// 2720 					res = FR_NO_PATH;		/* Reached but a file */
??f_chdir_5:
        MOVS     R4,#+5
// 2721 			}
// 2722 		}
// 2723 		if (res == FR_NO_FILE) res = FR_NO_PATH;
??f_chdir_3:
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+4
        BNE.N    ??f_chdir_0
        MOVS     R4,#+5
// 2724 	}
// 2725 
// 2726 	LEAVE_FF(dj.fs, res);
??f_chdir_0:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_chdir_2:
        ADD      SP,SP,#+52
        POP      {R4,R5,PC}       ;; return
// 2727 }
// 2728 
// 2729 
// 2730 #if _FS_RPATH >= 2

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2731 FRESULT f_getcwd (
// 2732 	TCHAR *path,	/* Pointer to the directory path */
// 2733 	UINT sz_path	/* Size of path */
// 2734 )
// 2735 {
f_getcwd:
        PUSH     {R0,R4-R8,LR}
        SUB      SP,SP,#+84
        MOVS     R4,R1
// 2736 	FRESULT res;
// 2737 	DIR dj;
// 2738 	UINT i, n;
// 2739 	DWORD ccl;
// 2740 	TCHAR *tp;
// 2741 	FILINFO fno;
// 2742 	DEF_NAMEBUF;
// 2743 
// 2744 
// 2745 	*path = 0;
        LDR      R0,[SP, #+84]
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
// 2746 	res = chk_mounted((const TCHAR**)&path, &dj.fs, 0);	/* Get current volume */
        MOVS     R2,#+0
        ADD      R1,SP,#+0
        ADD      R0,SP,#+84
        BL       chk_mounted
        MOVS     R6,R0
// 2747 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.W    ??f_getcwd_0
// 2748 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_getcwd_1
        MOVS     R0,#+17
        B.N      ??f_getcwd_2
??f_getcwd_1:
        STR      R5,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 2749 		i = sz_path;		/* Bottom of buffer (dir stack base) */
        MOVS     R7,R4
// 2750 		dj.sclust = dj.fs->cdir;			/* Start to follow upper dir from current dir */
        LDR      R0,[SP, #+0]
        LDR      R0,[R0, #+24]
        STR      R0,[SP, #+8]
        B.N      ??f_getcwd_3
// 2751 		while ((ccl = dj.sclust) != 0) {	/* Repeat while current dir is a sub-dir */
// 2752 			res = dir_sdi(&dj, 1);			/* Get parent dir */
// 2753 			if (res != FR_OK) break;
// 2754 			res = dir_read(&dj);
// 2755 			if (res != FR_OK) break;
// 2756 			dj.sclust = LD_CLUST(dj.dir);	/* Goto parent dir */
// 2757 			res = dir_sdi(&dj, 0);
// 2758 			if (res != FR_OK) break;
// 2759 			do {							/* Find the entry links to the child dir */
// 2760 				res = dir_read(&dj);
// 2761 				if (res != FR_OK) break;
// 2762 				if (ccl == LD_CLUST(dj.dir)) break;	/* Found the entry */
// 2763 				res = dir_next(&dj, 0);	
// 2764 			} while (res == FR_OK);
// 2765 			if (res == FR_NO_FILE) res = FR_INT_ERR;/* It cannot be 'not found'. */
// 2766 			if (res != FR_OK) break;
// 2767 #if _USE_LFN
// 2768 			fno.lfname = path;
// 2769 			fno.lfsize = i;
// 2770 #endif
// 2771 			get_fileinfo(&dj, &fno);		/* Get the dir name and push it to the buffer */
// 2772 			tp = fno.fname;
// 2773 			if (_USE_LFN && *path) tp = path;
// 2774 			for (n = 0; tp[n]; n++) ;
// 2775 			if (i < n + 3) {
// 2776 				res = FR_NOT_ENOUGH_CORE; break;
// 2777 			}
// 2778 			while (n) path[--i] = tp[--n];
??f_getcwd_4:
        SUBS     R7,R7,#+1
        SUBS     R1,R1,#+1
        LDR      R2,[SP, #+84]
        LDRB     R3,[R1, R0]
        STRB     R3,[R7, R2]
??f_getcwd_5:
        CMP      R1,#+0
        BNE.N    ??f_getcwd_4
// 2779 			path[--i] = '/';
        SUBS     R7,R7,#+1
        LDR      R0,[SP, #+84]
        MOVS     R1,#+47
        STRB     R1,[R7, R0]
??f_getcwd_3:
        LDR      R8,[SP, #+8]
        CMP      R8,#+0
        BEQ.N    ??f_getcwd_6
        MOVS     R1,#+1
        ADD      R0,SP,#+0
        BL       dir_sdi
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_6
??f_getcwd_7:
        ADD      R0,SP,#+0
        BL       dir_read
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_6
??f_getcwd_8:
        LDR      R0,[SP, #+20]
        LDRB     R0,[R0, #+21]
        LDR      R1,[SP, #+20]
        LDRB     R1,[R1, #+20]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR      R1,[SP, #+20]
        LDRB     R1,[R1, #+27]
        LDR      R2,[SP, #+20]
        LDRB     R2,[R2, #+26]
        ORRS     R1,R2,R1, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ORRS     R0,R1,R0, LSL #+16
        STR      R0,[SP, #+8]
        MOVS     R1,#+0
        ADD      R0,SP,#+0
        BL       dir_sdi
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_6
??f_getcwd_9:
        ADD      R0,SP,#+0
        BL       dir_read
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_10
??f_getcwd_11:
        LDR      R0,[SP, #+20]
        LDRB     R0,[R0, #+21]
        LDR      R1,[SP, #+20]
        LDRB     R1,[R1, #+20]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR      R1,[SP, #+20]
        LDRB     R1,[R1, #+27]
        LDR      R2,[SP, #+20]
        LDRB     R2,[R2, #+26]
        ORRS     R1,R2,R1, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ORRS     R0,R1,R0, LSL #+16
        CMP      R8,R0
        BEQ.N    ??f_getcwd_10
??f_getcwd_12:
        MOVS     R1,#+0
        ADD      R0,SP,#+0
        BL       dir_next
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??f_getcwd_9
??f_getcwd_10:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_getcwd_13
        MOVS     R6,#+2
??f_getcwd_13:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_6
??f_getcwd_14:
        LDR      R0,[SP, #+84]
        STR      R0,[SP, #+72]
        STR      R7,[SP, #+76]
        ADD      R1,SP,#+48
        ADD      R0,SP,#+0
        BL       get_fileinfo
        ADD      R0,SP,#+57
        LDR      R1,[SP, #+84]
        LDRB     R1,[R1, #+0]
        CMP      R1,#+0
        BEQ.N    ??f_getcwd_15
        LDR      R0,[SP, #+84]
??f_getcwd_15:
        MOVS     R1,#+0
        B.N      ??f_getcwd_16
??f_getcwd_17:
        ADDS     R1,R1,#+1
??f_getcwd_16:
        LDRB     R2,[R1, R0]
        CMP      R2,#+0
        BNE.N    ??f_getcwd_17
        ADDS     R2,R1,#+3
        CMP      R7,R2
        BCS.N    ??f_getcwd_5
        MOVS     R6,#+17
// 2780 		}
// 2781 		tp = path;
??f_getcwd_6:
        LDR      R0,[SP, #+84]
// 2782 		if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_getcwd_18
// 2783 			*tp++ = '0' + CurrVol;			/* Put drive number */
        LDR.N    R1,??DataTable13_1
        LDRB     R1,[R1, #+0]
        ADDS     R1,R1,#+48
        STRB     R1,[R0, #+0]
        ADDS     R0,R0,#+1
// 2784 			*tp++ = ':';
        MOVS     R1,#+58
        STRB     R1,[R0, #+0]
        ADDS     R0,R0,#+1
// 2785 			if (i == sz_path) {				/* Root-dir */
        CMP      R7,R4
        BNE.N    ??f_getcwd_19
// 2786 				*tp++ = '/';
        MOVS     R1,#+47
        STRB     R1,[R0, #+0]
        ADDS     R0,R0,#+1
        B.N      ??f_getcwd_18
// 2787 			} else {						/* Sub-dir */
// 2788 				do		/* Add stacked path str */
// 2789 					*tp++ = path[i++];
??f_getcwd_19:
        LDR      R1,[SP, #+84]
        LDRB     R1,[R7, R1]
        STRB     R1,[R0, #+0]
        ADDS     R7,R7,#+1
        ADDS     R0,R0,#+1
// 2790 				while (i < sz_path);
        CMP      R7,R4
        BCC.N    ??f_getcwd_19
// 2791 			}
// 2792 		}
// 2793 		*tp = 0;
??f_getcwd_18:
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
// 2794 		FREE_BUF();
        MOVS     R0,R5
        BL       ff_memfree
// 2795 	}
// 2796 
// 2797 	LEAVE_FF(dj.fs, res);
??f_getcwd_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_getcwd_2:
        ADD      SP,SP,#+88
        POP      {R4-R8,PC}       ;; return
// 2798 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13:
        DC32     0x544146

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_1:
        DC32     CurrVol

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_2:
        DC32     FatFs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_3:
        DC32     0x41615252

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_4:
        DC32     0x61417272

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_5:
        DC32     Fsid
// 2799 #endif /* _FS_RPATH >= 2 */
// 2800 #endif /* _FS_RPATH >= 1 */
// 2801 
// 2802 
// 2803 
// 2804 #if _FS_MINIMIZE <= 2
// 2805 /*-----------------------------------------------------------------------*/
// 2806 /* Seek File R/W Pointer                                                 */
// 2807 /*-----------------------------------------------------------------------*/
// 2808 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2809 FRESULT f_lseek (
// 2810 	FIL *fp,		/* Pointer to the file object */
// 2811 	DWORD ofs		/* File pointer from top of file */
// 2812 )
// 2813 {
f_lseek:
        PUSH     {R3-R11,LR}
        MOVS     R5,R0
        MOVS     R6,R1
// 2814 	FRESULT res;
// 2815 
// 2816 
// 2817 	res = validate(fp->fs, fp->id);		/* Check validity of the object */
        LDRH     R1,[R5, #+4]
        LDR      R0,[R5, #+0]
        BL       validate
        MOVS     R4,R0
// 2818 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+0
        BEQ.N    ??f_lseek_0
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        B.N      ??f_lseek_1
// 2819 	if (fp->flag & FA__ERROR)			/* Check abort flag */
??f_lseek_0:
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+24
        BPL.N    ??f_lseek_2
// 2820 		LEAVE_FF(fp->fs, FR_INT_ERR);
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2821 
// 2822 #if _USE_FASTSEEK
// 2823 	if (fp->cltbl) {	/* Fast seek */
??f_lseek_2:
        LDR      R0,[R5, #+36]
        CMP      R0,#+0
        BEQ.W    ??f_lseek_3
// 2824 		DWORD cl, pcl, ncl, tcl, dsc, tlen, ulen, *tbl;
// 2825 
// 2826 		if (ofs == CREATE_LINKMAP) {	/* Create CLMT */
        CMN      R6,#+1
        BNE.N    ??f_lseek_4
// 2827 			tbl = fp->cltbl;
        LDR      R10,[R5, #+36]
// 2828 			tlen = *tbl++; ulen = 2;	/* Given table size and required table size */
        LDR      R8,[R10, #+0]
        ADDS     R10,R10,#+4
        MOVS     R9,#+2
// 2829 			cl = fp->sclust;			/* Top of the chain */
        LDR      R0,[R5, #+16]
// 2830 			if (cl) {
        CMP      R0,#+0
        BEQ.N    ??f_lseek_5
// 2831 				do {
// 2832 					/* Get a fragment */
// 2833 					tcl = cl; ncl = 0; ulen += 2;	/* Top, length and used items */
??f_lseek_6:
        MOVS     R7,R0
        MOVS     R6,#+0
        ADDS     R9,R9,#+2
// 2834 					do {
// 2835 						pcl = cl; ncl++;
??f_lseek_7:
        MOV      R11,R0
        ADDS     R6,R6,#+1
// 2836 						cl = get_fat(fp->fs, cl);
        MOVS     R1,R0
        LDR      R0,[R5, #+0]
        BL       get_fat
// 2837 						if (cl <= 1) ABORT(fp->fs, FR_INT_ERR);
        CMP      R0,#+2
        BCS.N    ??f_lseek_8
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2838 						if (cl == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
??f_lseek_8:
        CMN      R0,#+1
        BNE.N    ??f_lseek_9
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2839 					} while (cl == pcl + 1);
??f_lseek_9:
        ADDS     R1,R11,#+1
        CMP      R0,R1
        BEQ.N    ??f_lseek_7
// 2840 					if (ulen <= tlen) {		/* Store the length and top of the fragment */
        CMP      R8,R9
        BCC.N    ??f_lseek_10
// 2841 						*tbl++ = ncl; *tbl++ = tcl;
        STR      R6,[R10, #+0]
        ADDS     R10,R10,#+4
        STR      R7,[R10, #+0]
        ADDS     R10,R10,#+4
// 2842 					}
// 2843 				} while (cl < fp->fs->n_fatent);	/* Repeat until end of chain */
??f_lseek_10:
        LDR      R1,[R5, #+0]
        LDR      R1,[R1, #+28]
        CMP      R0,R1
        BCC.N    ??f_lseek_6
// 2844 			}
// 2845 			*fp->cltbl = ulen;	/* Number of items used */
??f_lseek_5:
        LDR      R0,[R5, #+36]
        STR      R9,[R0, #+0]
// 2846 			if (ulen <= tlen)
        CMP      R8,R9
        BCC.N    ??f_lseek_11
// 2847 				*tbl = 0;		/* Terminate table */
        MOVS     R0,#+0
        STR      R0,[R10, #+0]
        B.N      ??f_lseek_12
// 2848 			else
// 2849 				res = FR_NOT_ENOUGH_CORE;	/* Given table size is smaller than required */
??f_lseek_11:
        MOVS     R4,#+17
        B.N      ??f_lseek_12
// 2850 
// 2851 		} else {						/* Fast seek */
// 2852 			if (ofs > fp->fsize)		/* Clip offset at the file size */
??f_lseek_4:
        LDR      R0,[R5, #+12]
        CMP      R0,R6
        BCS.N    ??f_lseek_13
// 2853 				ofs = fp->fsize;
        LDR      R6,[R5, #+12]
// 2854 			fp->fptr = ofs;				/* Set file pointer */
??f_lseek_13:
        STR      R6,[R5, #+8]
// 2855 			if (ofs) {
        CMP      R6,#+0
        BEQ.W    ??f_lseek_12
// 2856 				fp->clust = clmt_clust(fp, ofs - 1);
        SUBS     R1,R6,#+1
        MOVS     R0,R5
        BL       clmt_clust
        STR      R0,[R5, #+20]
// 2857 				dsc = clust2sect(fp->fs, fp->clust);
        LDR      R1,[R5, #+20]
        LDR      R0,[R5, #+0]
        BL       clust2sect
        MOVS     R7,R0
// 2858 				if (!dsc) ABORT(fp->fs, FR_INT_ERR);
        CMP      R7,#+0
        BNE.N    ??f_lseek_14
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2859 				dsc += (ofs - 1) / SS(fp->fs) & (fp->fs->csize - 1);
??f_lseek_14:
        SUBS     R0,R6,#+1
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+2]
        SUBS     R1,R1,#+1
        ANDS     R0,R1,R0, LSR #+9
        ADDS     R7,R0,R7
// 2860 				if (fp->fptr % SS(fp->fs) && dsc != fp->dsect) {	/* Refill sector cache if needed */
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BEQ.W    ??f_lseek_12
        LDR      R0,[R5, #+24]
        CMP      R7,R0
        BEQ.W    ??f_lseek_12
// 2861 #if !_FS_TINY
// 2862 #if !_FS_READONLY
// 2863 					if (fp->flag & FA__DIRTY) {		/* Write-back dirty sector cache */
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_lseek_15
// 2864 						if (LPLD_Disk_Write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R5, #+24]
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Write
        CMP      R0,#+0
        BEQ.N    ??f_lseek_16
// 2865 							ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2866 						fp->flag &= ~FA__DIRTY;
??f_lseek_16:
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
// 2867 					}
// 2868 #endif
// 2869 					if (LPLD_Disk_Read(fp->fs->drv, fp->buf, dsc, 1) != RES_OK)	/* Load current sector */
??f_lseek_15:
        MOVS     R3,#+1
        MOVS     R2,R7
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Read
        CMP      R0,#+0
        BEQ.N    ??f_lseek_17
// 2870 						ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2871 #endif
// 2872 					fp->dsect = dsc;
??f_lseek_17:
        STR      R7,[R5, #+24]
        B.N      ??f_lseek_12
// 2873 				}
// 2874 			}
// 2875 		}
// 2876 	} else
// 2877 #endif
// 2878 
// 2879 	/* Normal Seek */
// 2880 	{
// 2881 		DWORD clst, bcs, nsect, ifptr;
// 2882 
// 2883 		if (ofs > fp->fsize					/* In read-only mode, clip offset with the file size */
// 2884 #if !_FS_READONLY
// 2885 			 && !(fp->flag & FA_WRITE)
// 2886 #endif
// 2887 			) ofs = fp->fsize;
??f_lseek_3:
        LDR      R0,[R5, #+12]
        CMP      R0,R6
        BCS.N    ??f_lseek_18
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+30
        BMI.N    ??f_lseek_18
        LDR      R6,[R5, #+12]
// 2888 
// 2889 		ifptr = fp->fptr;
??f_lseek_18:
        LDR      R0,[R5, #+8]
// 2890 		fp->fptr = nsect = 0;
        MOVS     R7,#+0
        STR      R7,[R5, #+8]
// 2891 		if (ofs) {
        CMP      R6,#+0
        BEQ.N    ??f_lseek_19
// 2892 			bcs = (DWORD)fp->fs->csize * SS(fp->fs);	/* Cluster size (byte) */
        LDR      R1,[R5, #+0]
        LDRB     R1,[R1, #+2]
        MOV      R2,#+512
        MUL      R8,R2,R1
// 2893 			if (ifptr > 0 &&
// 2894 				(ofs - 1) / bcs >= (ifptr - 1) / bcs) {	/* When seek to same or following cluster, */
        CMP      R0,#+0
        BEQ.N    ??f_lseek_20
        SUBS     R1,R0,#+1
        UDIV     R1,R1,R8
        SUBS     R2,R6,#+1
        UDIV     R2,R2,R8
        CMP      R2,R1
        BCC.N    ??f_lseek_20
// 2895 				fp->fptr = (ifptr - 1) & ~(bcs - 1);	/* start from the current cluster */
        SUBS     R0,R0,#+1
        SUBS     R1,R8,#+1
        BICS     R0,R0,R1
        STR      R0,[R5, #+8]
// 2896 				ofs -= fp->fptr;
        LDR      R0,[R5, #+8]
        SUBS     R6,R6,R0
// 2897 				clst = fp->clust;
        LDR      R1,[R5, #+20]
        B.N      ??f_lseek_21
// 2898 			} else {									/* When seek to back cluster, */
// 2899 				clst = fp->sclust;						/* start from the first cluster */
??f_lseek_20:
        LDR      R1,[R5, #+16]
// 2900 #if !_FS_READONLY
// 2901 				if (clst == 0) {						/* If no cluster chain, create a new chain */
        CMP      R1,#+0
        BNE.N    ??f_lseek_22
// 2902 					clst = create_chain(fp->fs, 0);
        MOVS     R1,#+0
        LDR      R0,[R5, #+0]
        BL       create_chain
        MOVS     R1,R0
// 2903 					if (clst == 1) ABORT(fp->fs, FR_INT_ERR);
        CMP      R1,#+1
        BNE.N    ??f_lseek_23
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2904 					if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
??f_lseek_23:
        CMN      R1,#+1
        BNE.N    ??f_lseek_24
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2905 					fp->sclust = clst;
??f_lseek_24:
        STR      R1,[R5, #+16]
// 2906 				}
// 2907 #endif
// 2908 				fp->clust = clst;
??f_lseek_22:
        STR      R1,[R5, #+20]
// 2909 			}
// 2910 			if (clst != 0) {
??f_lseek_21:
        CMP      R1,#+0
        BNE.N    ??f_lseek_25
        B.N      ??f_lseek_19
// 2911 				while (ofs > bcs) {						/* Cluster following loop */
// 2912 #if !_FS_READONLY
// 2913 					if (fp->flag & FA_WRITE) {			/* Check if in write mode or not */
// 2914 						clst = create_chain(fp->fs, clst);	/* Force stretch if in write mode */
// 2915 						if (clst == 0) {				/* When disk gets full, clip file size */
// 2916 							ofs = bcs; break;
// 2917 						}
// 2918 					} else
// 2919 #endif
// 2920 						clst = get_fat(fp->fs, clst);	/* Follow cluster chain if not in write mode */
// 2921 					if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 2922 					if (clst <= 1 || clst >= fp->fs->n_fatent) ABORT(fp->fs, FR_INT_ERR);
// 2923 					fp->clust = clst;
??f_lseek_26:
        STR      R1,[R5, #+20]
// 2924 					fp->fptr += bcs;
        LDR      R0,[R5, #+8]
        ADDS     R0,R8,R0
        STR      R0,[R5, #+8]
// 2925 					ofs -= bcs;
        SUBS     R6,R6,R8
??f_lseek_25:
        CMP      R8,R6
        BCS.N    ??f_lseek_27
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+30
        BPL.N    ??f_lseek_28
        LDR      R0,[R5, #+0]
        BL       create_chain
        MOVS     R1,R0
        CMP      R1,#+0
        BNE.N    ??f_lseek_29
        MOV      R6,R8
// 2926 				}
// 2927 				fp->fptr += ofs;
??f_lseek_27:
        LDR      R0,[R5, #+8]
        ADDS     R0,R6,R0
        STR      R0,[R5, #+8]
// 2928 				if (ofs % SS(fp->fs)) {
        MOV      R0,#+512
        UDIV     R2,R6,R0
        MLS      R2,R2,R0,R6
        CMP      R2,#+0
        BEQ.N    ??f_lseek_19
// 2929 					nsect = clust2sect(fp->fs, clst);	/* Current sector */
        LDR      R0,[R5, #+0]
        BL       clust2sect
        MOVS     R7,R0
// 2930 					if (!nsect) ABORT(fp->fs, FR_INT_ERR);
        CMP      R7,#+0
        BNE.N    ??f_lseek_30
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
??f_lseek_28:
        LDR      R0,[R5, #+0]
        BL       get_fat
        MOVS     R1,R0
??f_lseek_29:
        CMN      R1,#+1
        BNE.N    ??f_lseek_31
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
??f_lseek_31:
        CMP      R1,#+2
        BCC.N    ??f_lseek_32
        LDR      R0,[R5, #+0]
        LDR      R0,[R0, #+28]
        CMP      R1,R0
        BCC.N    ??f_lseek_26
??f_lseek_32:
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+2
        B.N      ??f_lseek_1
// 2931 					nsect += ofs / SS(fp->fs);
??f_lseek_30:
        ADDS     R7,R7,R6, LSR #+9
// 2932 				}
// 2933 			}
// 2934 		}
// 2935 		if (fp->fptr % SS(fp->fs) && nsect != fp->dsect) {	/* Fill sector cache if needed */
??f_lseek_19:
        LDR      R0,[R5, #+8]
        MOV      R1,#+512
        UDIV     R2,R0,R1
        MLS      R2,R2,R1,R0
        CMP      R2,#+0
        BEQ.N    ??f_lseek_33
        LDR      R0,[R5, #+24]
        CMP      R7,R0
        BEQ.N    ??f_lseek_33
// 2936 #if !_FS_TINY
// 2937 #if !_FS_READONLY
// 2938 			if (fp->flag & FA__DIRTY) {			/* Write-back dirty sector cache */
        LDRB     R0,[R5, #+6]
        LSLS     R0,R0,#+25
        BPL.N    ??f_lseek_34
// 2939 				if (LPLD_Disk_Write(fp->fs->drv, fp->buf, fp->dsect, 1) != RES_OK)
        MOVS     R3,#+1
        LDR      R2,[R5, #+24]
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Write
        CMP      R0,#+0
        BEQ.N    ??f_lseek_35
// 2940 					ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2941 				fp->flag &= ~FA__DIRTY;
??f_lseek_35:
        LDRB     R0,[R5, #+6]
        ANDS     R0,R0,#0xBF
        STRB     R0,[R5, #+6]
// 2942 			}
// 2943 #endif
// 2944 			if (LPLD_Disk_Read(fp->fs->drv, fp->buf, nsect, 1) != RES_OK)	/* Fill sector cache */
??f_lseek_34:
        MOVS     R3,#+1
        MOVS     R2,R7
        ADDS     R1,R5,#+44
        LDR      R0,[R5, #+0]
        LDRB     R0,[R0, #+1]
        BL       LPLD_Disk_Read
        CMP      R0,#+0
        BEQ.N    ??f_lseek_36
// 2945 				ABORT(fp->fs, FR_DISK_ERR);
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x80
        STRB     R0,[R5, #+6]
        MOVS     R0,#+1
        B.N      ??f_lseek_1
// 2946 #endif
// 2947 			fp->dsect = nsect;
??f_lseek_36:
        STR      R7,[R5, #+24]
// 2948 		}
// 2949 #if !_FS_READONLY
// 2950 		if (fp->fptr > fp->fsize) {			/* Set file change flag if the file size is extended */
??f_lseek_33:
        LDR      R0,[R5, #+12]
        LDR      R1,[R5, #+8]
        CMP      R0,R1
        BCS.N    ??f_lseek_12
// 2951 			fp->fsize = fp->fptr;
        LDR      R0,[R5, #+8]
        STR      R0,[R5, #+12]
// 2952 			fp->flag |= FA__WRITTEN;
        LDRB     R0,[R5, #+6]
        ORRS     R0,R0,#0x20
        STRB     R0,[R5, #+6]
// 2953 		}
// 2954 #endif
// 2955 	}
// 2956 
// 2957 	LEAVE_FF(fp->fs, res);
??f_lseek_12:
        MOVS     R0,R4
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_lseek_1:
        POP      {R1,R4-R11,PC}   ;; return
// 2958 }
// 2959 
// 2960 
// 2961 
// 2962 #if _FS_MINIMIZE <= 1
// 2963 /*-----------------------------------------------------------------------*/
// 2964 /* Create a Directroy Object                                             */
// 2965 /*-----------------------------------------------------------------------*/
// 2966 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2967 FRESULT f_opendir (
// 2968 	DIR *dj,			/* Pointer to directory object to create */
// 2969 	const TCHAR *path	/* Pointer to the directory path */
// 2970 )
// 2971 {
f_opendir:
        PUSH     {R1,R4-R6,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R0
// 2972 	FRESULT res;
// 2973 	DEF_NAMEBUF;
// 2974 
// 2975 
// 2976 	res = chk_mounted(&path, &dj->fs, 0);
        MOVS     R2,#+0
        MOVS     R1,R4
        ADD      R0,SP,#+12
        BL       chk_mounted
        MOVS     R5,R0
// 2977 	if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_opendir_0
// 2978 		INIT_BUF(*dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R6,R0
        CMP      R6,#+0
        BNE.N    ??f_opendir_1
        MOVS     R0,#+17
        B.N      ??f_opendir_2
??f_opendir_1:
        STR      R6,[R4, #+28]
        ADD      R0,SP,#+0
        STR      R0,[R4, #+24]
// 2979 		res = follow_path(dj, path);			/* Follow the path to the directory */
        LDR      R1,[SP, #+12]
        MOVS     R0,R4
        BL       follow_path
        MOVS     R5,R0
// 2980 		FREE_BUF();
        MOVS     R0,R6
        BL       ff_memfree
// 2981 		if (res == FR_OK) {						/* Follow completed */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_opendir_3
// 2982 			if (dj->dir) {						/* It is not the root dir */
        LDR      R0,[R4, #+20]
        CMP      R0,#+0
        BEQ.N    ??f_opendir_4
// 2983 				if (dj->dir[DIR_Attr] & AM_DIR) {	/* The object is a directory */
        LDR      R0,[R4, #+20]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_opendir_5
// 2984 					dj->sclust = LD_CLUST(dj->dir);
        LDR      R0,[R4, #+20]
        LDRB     R0,[R0, #+21]
        LDR      R1,[R4, #+20]
        LDRB     R1,[R1, #+20]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDR      R1,[R4, #+20]
        LDRB     R1,[R1, #+27]
        LDR      R2,[R4, #+20]
        LDRB     R2,[R2, #+26]
        ORRS     R1,R2,R1, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ORRS     R0,R1,R0, LSL #+16
        STR      R0,[R4, #+8]
        B.N      ??f_opendir_4
// 2985 				} else {						/* The object is not a directory */
// 2986 					res = FR_NO_PATH;
??f_opendir_5:
        MOVS     R5,#+5
// 2987 				}
// 2988 			}
// 2989 			if (res == FR_OK) {
??f_opendir_4:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_opendir_3
// 2990 				dj->id = dj->fs->id;
        LDR      R0,[R4, #+0]
        LDRH     R0,[R0, #+6]
        STRH     R0,[R4, #+4]
// 2991 				res = dir_sdi(dj, 0);			/* Rewind dir */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
        MOVS     R5,R0
// 2992 			}
// 2993 		}
// 2994 		if (res == FR_NO_FILE) res = FR_NO_PATH;
??f_opendir_3:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+4
        BNE.N    ??f_opendir_0
        MOVS     R5,#+5
// 2995 	}
// 2996 
// 2997 	LEAVE_FF(dj->fs, res);
??f_opendir_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_opendir_2:
        ADD      SP,SP,#+16
        POP      {R4-R6,PC}       ;; return
// 2998 }
// 2999 
// 3000 
// 3001 
// 3002 
// 3003 /*-----------------------------------------------------------------------*/
// 3004 /* Read Directory Entry in Sequense                                      */
// 3005 /*-----------------------------------------------------------------------*/
// 3006 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3007 FRESULT f_readdir (
// 3008 	DIR *dj,			/* Pointer to the open directory object */
// 3009 	FILINFO *fno		/* Pointer to file information to return */
// 3010 )
// 3011 {
f_readdir:
        PUSH     {R1-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 3012 	FRESULT res;
// 3013 	DEF_NAMEBUF;
// 3014 
// 3015 
// 3016 	res = validate(dj->fs, dj->id);			/* Check validity of the object */
        LDRH     R1,[R4, #+4]
        LDR      R0,[R4, #+0]
        BL       validate
        MOVS     R6,R0
// 3017 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_readdir_0
// 3018 		if (!fno) {
        CMP      R5,#+0
        BNE.N    ??f_readdir_1
// 3019 			res = dir_sdi(dj, 0);			/* Rewind the directory object */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_sdi
        MOVS     R6,R0
        B.N      ??f_readdir_0
// 3020 		} else {
// 3021 			INIT_BUF(*dj);
??f_readdir_1:
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R7,R0
        CMP      R7,#+0
        BNE.N    ??f_readdir_2
        MOVS     R0,#+17
        B.N      ??f_readdir_3
??f_readdir_2:
        STR      R7,[R4, #+28]
        ADD      R0,SP,#+0
        STR      R0,[R4, #+24]
// 3022 			res = dir_read(dj);				/* Read an directory item */
        MOVS     R0,R4
        BL       dir_read
        MOVS     R6,R0
// 3023 			if (res == FR_NO_FILE) {		/* Reached end of dir */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_readdir_4
// 3024 				dj->sect = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+16]
// 3025 				res = FR_OK;
        MOVS     R6,#+0
// 3026 			}
// 3027 			if (res == FR_OK) {				/* A valid entry is found */
??f_readdir_4:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_readdir_5
// 3028 				get_fileinfo(dj, fno);		/* Get the object information */
        MOVS     R1,R5
        MOVS     R0,R4
        BL       get_fileinfo
// 3029 				res = dir_next(dj, 0);		/* Increment index for next */
        MOVS     R1,#+0
        MOVS     R0,R4
        BL       dir_next
        MOVS     R6,R0
// 3030 				if (res == FR_NO_FILE) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_readdir_5
// 3031 					dj->sect = 0;
        MOVS     R0,#+0
        STR      R0,[R4, #+16]
// 3032 					res = FR_OK;
        MOVS     R6,#+0
// 3033 				}
// 3034 			}
// 3035 			FREE_BUF();
??f_readdir_5:
        MOVS     R0,R7
        BL       ff_memfree
// 3036 		}
// 3037 	}
// 3038 
// 3039 	LEAVE_FF(dj->fs, res);
??f_readdir_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_readdir_3:
        POP      {R1-R7,PC}       ;; return
// 3040 }
// 3041 
// 3042 
// 3043 
// 3044 #if _FS_MINIMIZE == 0
// 3045 /*-----------------------------------------------------------------------*/
// 3046 /* Get File Status                                                       */
// 3047 /*-----------------------------------------------------------------------*/
// 3048 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3049 FRESULT f_stat (
// 3050 	const TCHAR *path,	/* Pointer to the file path */
// 3051 	FILINFO *fno		/* Pointer to file information to return */
// 3052 )
// 3053 {
f_stat:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+52
        MOVS     R4,R1
// 3054 	FRESULT res;
// 3055 	DIR dj;
// 3056 	DEF_NAMEBUF;
// 3057 
// 3058 
// 3059 	res = chk_mounted(&path, &dj.fs, 0);
        MOVS     R2,#+0
        ADD      R1,SP,#+12
        ADD      R0,SP,#+52
        BL       chk_mounted
        MOVS     R5,R0
// 3060 	if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_stat_0
// 3061 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R6,R0
        CMP      R6,#+0
        BNE.N    ??f_stat_1
        MOVS     R0,#+17
        B.N      ??f_stat_2
??f_stat_1:
        STR      R6,[SP, #+40]
        ADD      R0,SP,#+0
        STR      R0,[SP, #+36]
// 3062 		res = follow_path(&dj, path);	/* Follow the file path */
        LDR      R1,[SP, #+52]
        ADD      R0,SP,#+12
        BL       follow_path
        MOVS     R5,R0
// 3063 		if (res == FR_OK) {				/* Follow completed */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_stat_3
// 3064 			if (dj.dir)		/* Found an object */
        LDR      R0,[SP, #+32]
        CMP      R0,#+0
        BEQ.N    ??f_stat_4
// 3065 				get_fileinfo(&dj, fno);
        MOVS     R1,R4
        ADD      R0,SP,#+12
        BL       get_fileinfo
        B.N      ??f_stat_3
// 3066 			else			/* It is root dir */
// 3067 				res = FR_INVALID_NAME;
??f_stat_4:
        MOVS     R5,#+6
// 3068 		}
// 3069 		FREE_BUF();
??f_stat_3:
        MOVS     R0,R6
        BL       ff_memfree
// 3070 	}
// 3071 
// 3072 	LEAVE_FF(dj.fs, res);
??f_stat_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_stat_2:
        ADD      SP,SP,#+56
        POP      {R4-R6,PC}       ;; return
// 3073 }
// 3074 
// 3075 
// 3076 
// 3077 #if !_FS_READONLY
// 3078 /*-----------------------------------------------------------------------*/
// 3079 /* Get Number of Free Clusters                                           */
// 3080 /*-----------------------------------------------------------------------*/
// 3081 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3082 FRESULT f_getfree (
// 3083 	const TCHAR *path,	/* Pointer to the logical drive number (root dir) */
// 3084 	DWORD *nclst,		/* Pointer to the variable to return number of free clusters */
// 3085 	FATFS **fatfs		/* Pointer to pointer to corresponding file system object to return */
// 3086 )
// 3087 {
f_getfree:
        PUSH     {R0,R4-R10,LR}
        SUB      SP,SP,#+4
        MOVS     R5,R1
        MOVS     R6,R2
// 3088 	FRESULT res;
// 3089 	DWORD n, clst, sect, stat;
// 3090 	UINT i;
// 3091 	BYTE fat, *p;
// 3092 
// 3093 
// 3094 	/* Get drive number */
// 3095 	res = chk_mounted(&path, fatfs, 0);
        MOVS     R2,#+0
        MOVS     R1,R6
        ADD      R0,SP,#+4
        BL       chk_mounted
        MOV      R8,R0
// 3096 	if (res == FR_OK) {
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_getfree_0
// 3097 		/* If free_clust is valid, return it without full cluster scan */
// 3098 		if ((*fatfs)->free_clust <= (*fatfs)->n_fatent - 2) {
        LDR      R0,[R6, #+0]
        LDR      R0,[R0, #+28]
        SUBS     R0,R0,#+2
        LDR      R1,[R6, #+0]
        LDR      R1,[R1, #+16]
        CMP      R0,R1
        BCC.N    ??f_getfree_1
// 3099 			*nclst = (*fatfs)->free_clust;
        LDR      R0,[R6, #+0]
        LDR      R0,[R0, #+16]
        STR      R0,[R5, #+0]
        B.N      ??f_getfree_0
// 3100 		} else {
// 3101 			/* Get number of free clusters */
// 3102 			fat = (*fatfs)->fs_type;
??f_getfree_1:
        LDR      R0,[R6, #+0]
        LDRB     R7,[R0, #+0]
// 3103 			n = 0;
        MOVS     R9,#+0
// 3104 			if (fat == FS_FAT12) {
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+1
        BNE.N    ??f_getfree_2
// 3105 				clst = 2;
        MOVS     R4,#+2
// 3106 				do {
// 3107 					stat = get_fat(*fatfs, clst);
??f_getfree_3:
        MOVS     R1,R4
        LDR      R0,[R6, #+0]
        BL       get_fat
// 3108 					if (stat == 0xFFFFFFFF) { res = FR_DISK_ERR; break; }
        CMN      R0,#+1
        BNE.N    ??f_getfree_4
        MOVS     R8,#+1
        B.N      ??f_getfree_5
// 3109 					if (stat == 1) { res = FR_INT_ERR; break; }
??f_getfree_4:
        CMP      R0,#+1
        BNE.N    ??f_getfree_6
        MOVS     R8,#+2
        B.N      ??f_getfree_5
// 3110 					if (stat == 0) n++;
??f_getfree_6:
        CMP      R0,#+0
        BNE.N    ??f_getfree_7
        ADDS     R9,R9,#+1
// 3111 				} while (++clst < (*fatfs)->n_fatent);
??f_getfree_7:
        ADDS     R4,R4,#+1
        LDR      R0,[R6, #+0]
        LDR      R0,[R0, #+28]
        CMP      R4,R0
        BCC.N    ??f_getfree_3
        B.N      ??f_getfree_5
// 3112 			} else {
// 3113 				clst = (*fatfs)->n_fatent;
??f_getfree_2:
        LDR      R0,[R6, #+0]
        LDR      R4,[R0, #+28]
// 3114 				sect = (*fatfs)->fatbase;
        LDR      R0,[R6, #+0]
        LDR      R10,[R0, #+36]
// 3115 				i = 0; p = 0;
        MOVS     R1,#+0
        MOVS     R0,#+0
// 3116 				do {
// 3117 					if (!i) {
??f_getfree_8:
        CMP      R1,#+0
        BNE.N    ??f_getfree_9
// 3118 						res = move_window(*fatfs, sect++);
        MOV      R1,R10
        LDR      R0,[R6, #+0]
        BL       move_window
        MOV      R8,R0
        ADDS     R10,R10,#+1
// 3119 						if (res != FR_OK) break;
        UXTB     R8,R8            ;; ZeroExt  R8,R8,#+24,#+24
        CMP      R8,#+0
        BNE.N    ??f_getfree_5
// 3120 						p = (*fatfs)->win;
??f_getfree_10:
        LDR      R0,[R6, #+0]
        ADDW     R0,R0,#+52
// 3121 						i = SS(*fatfs);
        MOV      R1,#+512
// 3122 					}
// 3123 					if (fat == FS_FAT16) {
??f_getfree_9:
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+2
        BNE.N    ??f_getfree_11
// 3124 						if (LD_WORD(p) == 0) n++;
        LDRB     R2,[R0, #+1]
        LDRB     R3,[R0, #+0]
        ORRS     R2,R3,R2, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        CMP      R2,#+0
        BNE.N    ??f_getfree_12
        ADDS     R9,R9,#+1
// 3125 						p += 2; i -= 2;
??f_getfree_12:
        ADDS     R0,R0,#+2
        SUBS     R1,R1,#+2
        B.N      ??f_getfree_13
// 3126 					} else {
// 3127 						if ((LD_DWORD(p) & 0x0FFFFFFF) == 0) n++;
??f_getfree_11:
        LDRB     R2,[R0, #+3]
        LDRB     R3,[R0, #+2]
        LSLS     R3,R3,#+16
        ORRS     R2,R3,R2, LSL #+24
        LDRB     R3,[R0, #+1]
        ORRS     R2,R2,R3, LSL #+8
        LDRB     R3,[R0, #+0]
        ORRS     R2,R3,R2
        LSLS     R2,R2,#+4
        BNE.N    ??f_getfree_14
        ADDS     R9,R9,#+1
// 3128 						p += 4; i -= 4;
??f_getfree_14:
        ADDS     R0,R0,#+4
        SUBS     R1,R1,#+4
// 3129 					}
// 3130 				} while (--clst);
??f_getfree_13:
        SUBS     R4,R4,#+1
        CMP      R4,#+0
        BNE.N    ??f_getfree_8
// 3131 			}
// 3132 			(*fatfs)->free_clust = n;
??f_getfree_5:
        LDR      R0,[R6, #+0]
        STR      R9,[R0, #+16]
// 3133 			if (fat == FS_FAT32) (*fatfs)->fsi_flag = 1;
        UXTB     R7,R7            ;; ZeroExt  R7,R7,#+24,#+24
        CMP      R7,#+3
        BNE.N    ??f_getfree_15
        LDR      R0,[R6, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+5]
// 3134 			*nclst = n;
??f_getfree_15:
        STR      R9,[R5, #+0]
// 3135 		}
// 3136 	}
// 3137 	LEAVE_FF(*fatfs, res);
??f_getfree_0:
        MOV      R0,R8
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R2,R4-R10,PC}  ;; return
// 3138 }
// 3139 
// 3140 
// 3141 
// 3142 
// 3143 /*-----------------------------------------------------------------------*/
// 3144 /* Truncate File                                                         */
// 3145 /*-----------------------------------------------------------------------*/
// 3146 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3147 FRESULT f_truncate (
// 3148 	FIL *fp		/* Pointer to the file object */
// 3149 )
// 3150 {
f_truncate:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
// 3151 	FRESULT res;
// 3152 	DWORD ncl;
// 3153 
// 3154 
// 3155 	res = validate(fp->fs, fp->id);		/* Check validity of the object */
        LDRH     R1,[R4, #+4]
        LDR      R0,[R4, #+0]
        BL       validate
// 3156 	if (res == FR_OK) {
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_0
// 3157 		if (fp->flag & FA__ERROR) {			/* Check abort flag */
        LDRB     R1,[R4, #+6]
        LSLS     R1,R1,#+24
        BPL.N    ??f_truncate_1
// 3158 			res = FR_INT_ERR;
        MOVS     R0,#+2
        B.N      ??f_truncate_0
// 3159 		} else {
// 3160 			if (!(fp->flag & FA_WRITE))		/* Check access mode */
??f_truncate_1:
        LDRB     R1,[R4, #+6]
        LSLS     R1,R1,#+30
        BMI.N    ??f_truncate_0
// 3161 				res = FR_DENIED;
        MOVS     R0,#+7
// 3162 		}
// 3163 	}
// 3164 	if (res == FR_OK) {
??f_truncate_0:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_2
// 3165 		if (fp->fsize > fp->fptr) {
        LDR      R1,[R4, #+8]
        LDR      R2,[R4, #+12]
        CMP      R1,R2
        BCS.N    ??f_truncate_3
// 3166 			fp->fsize = fp->fptr;	/* Set file size to current R/W point */
        LDR      R0,[R4, #+8]
        STR      R0,[R4, #+12]
// 3167 			fp->flag |= FA__WRITTEN;
        LDRB     R0,[R4, #+6]
        ORRS     R0,R0,#0x20
        STRB     R0,[R4, #+6]
// 3168 			if (fp->fptr == 0) {	/* When set file size to zero, remove entire cluster chain */
        LDR      R0,[R4, #+8]
        CMP      R0,#+0
        BNE.N    ??f_truncate_4
// 3169 				res = remove_chain(fp->fs, fp->sclust);
        LDR      R1,[R4, #+16]
        LDR      R0,[R4, #+0]
        BL       remove_chain
// 3170 				fp->sclust = 0;
        MOVS     R1,#+0
        STR      R1,[R4, #+16]
        B.N      ??f_truncate_3
// 3171 			} else {				/* When truncate a part of the file, remove remaining clusters */
// 3172 				ncl = get_fat(fp->fs, fp->clust);
??f_truncate_4:
        LDR      R1,[R4, #+20]
        LDR      R0,[R4, #+0]
        BL       get_fat
        MOVS     R5,R0
// 3173 				res = FR_OK;
        MOVS     R0,#+0
// 3174 				if (ncl == 0xFFFFFFFF) res = FR_DISK_ERR;
        CMN      R5,#+1
        BNE.N    ??f_truncate_5
        MOVS     R0,#+1
// 3175 				if (ncl == 1) res = FR_INT_ERR;
??f_truncate_5:
        CMP      R5,#+1
        BNE.N    ??f_truncate_6
        MOVS     R0,#+2
// 3176 				if (res == FR_OK && ncl < fp->fs->n_fatent) {
??f_truncate_6:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_3
        LDR      R1,[R4, #+0]
        LDR      R1,[R1, #+28]
        CMP      R5,R1
        BCS.N    ??f_truncate_3
// 3177 					res = put_fat(fp->fs, fp->clust, 0x0FFFFFFF);
        MVNS     R2,#-268435456
        LDR      R1,[R4, #+20]
        LDR      R0,[R4, #+0]
        BL       put_fat
// 3178 					if (res == FR_OK) res = remove_chain(fp->fs, ncl);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??f_truncate_3
        MOVS     R1,R5
        LDR      R0,[R4, #+0]
        BL       remove_chain
// 3179 				}
// 3180 			}
// 3181 		}
// 3182 		if (res != FR_OK) fp->flag |= FA__ERROR;
??f_truncate_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_truncate_2
        LDRB     R1,[R4, #+6]
        ORRS     R1,R1,#0x80
        STRB     R1,[R4, #+6]
// 3183 	}
// 3184 
// 3185 	LEAVE_FF(fp->fs, res);
??f_truncate_2:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        POP      {R1,R4,R5,PC}    ;; return
// 3186 }
// 3187 
// 3188 
// 3189 
// 3190 
// 3191 /*-----------------------------------------------------------------------*/
// 3192 /* Delete a File or Directory                                            */
// 3193 /*-----------------------------------------------------------------------*/
// 3194 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3195 FRESULT f_unlink (
// 3196 	const TCHAR *path		/* Pointer to the file or directory path */
// 3197 )
// 3198 {
f_unlink:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+84
// 3199 	FRESULT res;
// 3200 	DIR dj, sdj;
// 3201 	BYTE *dir;
// 3202 	DWORD dclst;
// 3203 	DEF_NAMEBUF;
// 3204 
// 3205 
// 3206 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+0
        ADD      R0,SP,#+84
        BL       chk_mounted
        MOVS     R5,R0
// 3207 	if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_0
// 3208 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R4,R0
        CMP      R4,#+0
        BNE.N    ??f_unlink_1
        MOVS     R0,#+17
        B.N      ??f_unlink_2
??f_unlink_1:
        STR      R4,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 3209 		res = follow_path(&dj, path);		/* Follow the file path */
        LDR      R1,[SP, #+84]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R5,R0
// 3210 		if (_FS_RPATH && res == FR_OK && (dj.fn[NS] & NS_DOT))
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_3
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_unlink_3
// 3211 			res = FR_INVALID_NAME;			/* Cannot remove dot entry */
        MOVS     R5,#+6
// 3212 #if _FS_SHARE
// 3213 		if (res == FR_OK) res = chk_lock(&dj, 2);	/* Cannot remove open file */
??f_unlink_3:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_4
        MOVS     R1,#+2
        ADD      R0,SP,#+0
        BL       chk_lock
        MOVS     R5,R0
// 3214 #endif
// 3215 		if (res == FR_OK) {					/* The object is accessible */
??f_unlink_4:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_5
// 3216 			dir = dj.dir;
        LDR      R0,[SP, #+20]
// 3217 			if (!dir) {
        CMP      R0,#+0
        BNE.N    ??f_unlink_6
// 3218 				res = FR_INVALID_NAME;		/* Cannot remove the start directory */
        MOVS     R5,#+6
        B.N      ??f_unlink_7
// 3219 			} else {
// 3220 				if (dir[DIR_Attr] & AM_RDO)
??f_unlink_6:
        LDRB     R1,[R0, #+11]
        LSLS     R1,R1,#+31
        BPL.N    ??f_unlink_7
// 3221 					res = FR_DENIED;		/* Cannot remove R/O object */
        MOVS     R5,#+7
// 3222 			}
// 3223 			dclst = LD_CLUST(dir);
??f_unlink_7:
        LDRB     R1,[R0, #+21]
        LDRB     R2,[R0, #+20]
        ORRS     R1,R2,R1, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LDRB     R2,[R0, #+27]
        LDRB     R3,[R0, #+26]
        ORRS     R2,R3,R2, LSL #+8
        UXTH     R2,R2            ;; ZeroExt  R2,R2,#+16,#+16
        ORRS     R6,R2,R1, LSL #+16
// 3224 			if (res == FR_OK && (dir[DIR_Attr] & AM_DIR)) {	/* Is it a sub-dir? */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_8
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_unlink_8
// 3225 				if (dclst < 2) {
        CMP      R6,#+2
        BCS.N    ??f_unlink_9
// 3226 					res = FR_INT_ERR;
        MOVS     R5,#+2
        B.N      ??f_unlink_8
// 3227 				} else {
// 3228 					mem_cpy(&sdj, &dj, sizeof(DIR));	/* Check if the sub-dir is empty or not */
??f_unlink_9:
        MOVS     R2,#+36
        ADD      R1,SP,#+0
        ADD      R0,SP,#+48
        BL       mem_cpy
// 3229 					sdj.sclust = dclst;
        STR      R6,[SP, #+56]
// 3230 					res = dir_sdi(&sdj, 2);		/* Exclude dot entries */
        MOVS     R1,#+2
        ADD      R0,SP,#+48
        BL       dir_sdi
        MOVS     R5,R0
// 3231 					if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_8
// 3232 						res = dir_read(&sdj);
        ADD      R0,SP,#+48
        BL       dir_read
        MOVS     R5,R0
// 3233 						if (res == FR_OK			/* Not empty dir */
// 3234 #if _FS_RPATH
// 3235 						|| dclst == sdj.fs->cdir	/* Current dir */
// 3236 #endif
// 3237 						) res = FR_DENIED;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BEQ.N    ??f_unlink_10
        LDR      R0,[SP, #+48]
        LDR      R0,[R0, #+24]
        CMP      R6,R0
        BNE.N    ??f_unlink_11
??f_unlink_10:
        MOVS     R5,#+7
// 3238 						if (res == FR_NO_FILE) res = FR_OK;	/* Empty */
??f_unlink_11:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+4
        BNE.N    ??f_unlink_8
        MOVS     R5,#+0
// 3239 					}
// 3240 				}
// 3241 			}
// 3242 			if (res == FR_OK) {
??f_unlink_8:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_5
// 3243 				res = dir_remove(&dj);		/* Remove the directory entry */
        ADD      R0,SP,#+0
        BL       dir_remove
        MOVS     R5,R0
// 3244 				if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_5
// 3245 					if (dclst)				/* Remove the cluster chain if exist */
        CMP      R6,#+0
        BEQ.N    ??f_unlink_12
// 3246 						res = remove_chain(dj.fs, dclst);
        MOVS     R1,R6
        LDR      R0,[SP, #+0]
        BL       remove_chain
        MOVS     R5,R0
// 3247 					if (res == FR_OK) res = sync(dj.fs);
??f_unlink_12:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_unlink_5
        LDR      R0,[SP, #+0]
        BL       sync
        MOVS     R5,R0
// 3248 				}
// 3249 			}
// 3250 		}
// 3251 		FREE_BUF();
??f_unlink_5:
        MOVS     R0,R4
        BL       ff_memfree
// 3252 	}
// 3253 	LEAVE_FF(dj.fs, res);
??f_unlink_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_unlink_2:
        ADD      SP,SP,#+88
        POP      {R4-R6,PC}       ;; return
// 3254 }
// 3255 
// 3256 
// 3257 
// 3258 
// 3259 /*-----------------------------------------------------------------------*/
// 3260 /* Create a Directory                                                    */
// 3261 /*-----------------------------------------------------------------------*/
// 3262 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3263 FRESULT f_mkdir (
// 3264 	const TCHAR *path		/* Pointer to the directory path */
// 3265 )
// 3266 {
f_mkdir:
        PUSH     {R0,R4-R10,LR}
        SUB      SP,SP,#+52
// 3267 	FRESULT res;
// 3268 	DIR dj;
// 3269 	BYTE *dir, n;
// 3270 	DWORD dsc, dcl, pcl, tim = get_fattime();
        BL       get_fattime
        MOVS     R4,R0
// 3271 	DEF_NAMEBUF;
// 3272 
// 3273 
// 3274 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+0
        ADD      R0,SP,#+52
        BL       chk_mounted
        MOVS     R6,R0
// 3275 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.W    ??f_mkdir_0
// 3276 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_mkdir_1
        MOVS     R0,#+17
        B.N      ??f_mkdir_2
??f_mkdir_1:
        STR      R5,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 3277 		res = follow_path(&dj, path);			/* Follow the file path */
        LDR      R1,[SP, #+52]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R6,R0
// 3278 		if (res == FR_OK) res = FR_EXIST;		/* Any object with same name is already existing */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_mkdir_3
        MOVS     R6,#+8
// 3279 		if (_FS_RPATH && res == FR_NO_FILE && (dj.fn[NS] & NS_DOT))
??f_mkdir_3:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_mkdir_4
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_mkdir_4
// 3280 			res = FR_INVALID_NAME;
        MOVS     R6,#+6
// 3281 		if (res == FR_NO_FILE) {				/* Can create a new directory */
??f_mkdir_4:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.W    ??f_mkdir_5
// 3282 			dcl = create_chain(dj.fs, 0);		/* Allocate a cluster for the new directory table */
        MOVS     R1,#+0
        LDR      R0,[SP, #+0]
        BL       create_chain
        MOVS     R7,R0
// 3283 			res = FR_OK;
        MOVS     R6,#+0
// 3284 			if (dcl == 0) res = FR_DENIED;		/* No space to allocate a new cluster */
        CMP      R7,#+0
        BNE.N    ??f_mkdir_6
        MOVS     R6,#+7
// 3285 			if (dcl == 1) res = FR_INT_ERR;
??f_mkdir_6:
        CMP      R7,#+1
        BNE.N    ??f_mkdir_7
        MOVS     R6,#+2
// 3286 			if (dcl == 0xFFFFFFFF) res = FR_DISK_ERR;
??f_mkdir_7:
        CMN      R7,#+1
        BNE.N    ??f_mkdir_8
        MOVS     R6,#+1
// 3287 			if (res == FR_OK)					/* Flush FAT */
??f_mkdir_8:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_mkdir_9
// 3288 				res = move_window(dj.fs, 0);
        MOVS     R1,#+0
        LDR      R0,[SP, #+0]
        BL       move_window
        MOVS     R6,R0
// 3289 			if (res == FR_OK) {					/* Initialize the new directory table */
??f_mkdir_9:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_mkdir_10
// 3290 				dsc = clust2sect(dj.fs, dcl);
        MOVS     R1,R7
        LDR      R0,[SP, #+0]
        BL       clust2sect
        MOV      R8,R0
// 3291 				dir = dj.fs->win;
        LDR      R0,[SP, #+0]
        ADDW     R9,R0,#+52
// 3292 				mem_set(dir, 0, SS(dj.fs));
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R9
        BL       mem_set
// 3293 				mem_set(dir+DIR_Name, ' ', 8+3);	/* Create "." entry */
        MOVS     R2,#+11
        MOVS     R1,#+32
        MOV      R0,R9
        BL       mem_set
// 3294 				dir[DIR_Name] = '.';
        MOVS     R0,#+46
        STRB     R0,[R9, #+0]
// 3295 				dir[DIR_Attr] = AM_DIR;
        MOVS     R0,#+16
        STRB     R0,[R9, #+11]
// 3296 				ST_DWORD(dir+DIR_WrtTime, tim);
        STRB     R4,[R9, #+22]
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+23]
        LSRS     R0,R4,#+16
        STRB     R0,[R9, #+24]
        LSRS     R0,R4,#+24
        STRB     R0,[R9, #+25]
// 3297 				ST_CLUST(dir, dcl);
        STRB     R7,[R9, #+26]
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+27]
        LSRS     R0,R7,#+16
        STRB     R0,[R9, #+20]
        LSRS     R0,R7,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+21]
// 3298 				mem_cpy(dir+SZ_DIR, dir, SZ_DIR); 	/* Create ".." entry */
        MOVS     R2,#+32
        MOV      R1,R9
        ADDS     R0,R9,#+32
        BL       mem_cpy
// 3299 				dir[33] = '.'; pcl = dj.sclust;
        MOVS     R0,#+46
        STRB     R0,[R9, #+33]
        LDR      R0,[SP, #+8]
// 3300 				if (dj.fs->fs_type == FS_FAT32 && pcl == dj.fs->dirbase)
        LDR      R1,[SP, #+0]
        LDRB     R1,[R1, #+0]
        CMP      R1,#+3
        BNE.N    ??f_mkdir_11
        LDR      R1,[SP, #+0]
        LDR      R1,[R1, #+40]
        CMP      R0,R1
        BNE.N    ??f_mkdir_11
// 3301 					pcl = 0;
        MOVS     R0,#+0
// 3302 				ST_CLUST(dir+SZ_DIR, pcl);
??f_mkdir_11:
        STRB     R0,[R9, #+58]
        MOVS     R1,R0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R9, #+59]
        LSRS     R1,R0,#+16
        STRB     R1,[R9, #+52]
        LSRS     R0,R0,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+53]
// 3303 				for (n = dj.fs->csize; n; n--) {	/* Write dot entries and clear following sectors */
        LDR      R0,[SP, #+0]
        LDRB     R10,[R0, #+2]
        B.N      ??f_mkdir_12
// 3304 					dj.fs->winsect = dsc++;
// 3305 					dj.fs->wflag = 1;
// 3306 					res = move_window(dj.fs, 0);
// 3307 					if (res != FR_OK) break;
// 3308 					mem_set(dir, 0, SS(dj.fs));
??f_mkdir_13:
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R9
        BL       mem_set
        SUBS     R10,R10,#+1
??f_mkdir_12:
        UXTB     R10,R10          ;; ZeroExt  R10,R10,#+24,#+24
        CMP      R10,#+0
        BEQ.N    ??f_mkdir_10
        LDR      R0,[SP, #+0]
        STR      R8,[R0, #+48]
        ADDS     R8,R8,#+1
        LDR      R0,[SP, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
        MOVS     R1,#+0
        LDR      R0,[SP, #+0]
        BL       move_window
        MOVS     R6,R0
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??f_mkdir_13
// 3309 				}
// 3310 			}
// 3311 			if (res == FR_OK) res = dir_register(&dj);	/* Register the object to the directoy */
??f_mkdir_10:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_mkdir_14
        ADD      R0,SP,#+0
        BL       dir_register
        MOVS     R6,R0
// 3312 			if (res != FR_OK) {
??f_mkdir_14:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BEQ.N    ??f_mkdir_15
// 3313 				remove_chain(dj.fs, dcl);			/* Could not register, remove cluster chain */
        MOVS     R1,R7
        LDR      R0,[SP, #+0]
        BL       remove_chain
        B.N      ??f_mkdir_5
// 3314 			} else {
// 3315 				dir = dj.dir;
??f_mkdir_15:
        LDR      R9,[SP, #+20]
// 3316 				dir[DIR_Attr] = AM_DIR;				/* Attribute */
        MOVS     R0,#+16
        STRB     R0,[R9, #+11]
// 3317 				ST_DWORD(dir+DIR_WrtTime, tim);		/* Created time */
        STRB     R4,[R9, #+22]
        MOVS     R0,R4
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+23]
        LSRS     R0,R4,#+16
        STRB     R0,[R9, #+24]
        LSRS     R0,R4,#+24
        STRB     R0,[R9, #+25]
// 3318 				ST_CLUST(dir, dcl);					/* Table start cluster */
        STRB     R7,[R9, #+26]
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+27]
        LSRS     R0,R7,#+16
        STRB     R0,[R9, #+20]
        LSRS     R0,R7,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R9, #+21]
// 3319 				dj.fs->wflag = 1;
        LDR      R0,[SP, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
// 3320 				res = sync(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync
        MOVS     R6,R0
// 3321 			}
// 3322 		}
// 3323 		FREE_BUF();
??f_mkdir_5:
        MOVS     R0,R5
        BL       ff_memfree
// 3324 	}
// 3325 
// 3326 	LEAVE_FF(dj.fs, res);
??f_mkdir_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_mkdir_2:
        ADD      SP,SP,#+56
        POP      {R4-R10,PC}      ;; return
// 3327 }
// 3328 
// 3329 
// 3330 
// 3331 
// 3332 /*-----------------------------------------------------------------------*/
// 3333 /* Change Attribute                                                      */
// 3334 /*-----------------------------------------------------------------------*/
// 3335 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3336 FRESULT f_chmod (
// 3337 	const TCHAR *path,	/* Pointer to the file path */
// 3338 	BYTE value,			/* Attribute bits */
// 3339 	BYTE mask			/* Attribute mask to change */
// 3340 )
// 3341 {
f_chmod:
        PUSH     {R0,R4-R7,LR}
        SUB      SP,SP,#+48
        MOVS     R4,R1
        MOVS     R5,R2
// 3342 	FRESULT res;
// 3343 	DIR dj;
// 3344 	BYTE *dir;
// 3345 	DEF_NAMEBUF;
// 3346 
// 3347 
// 3348 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+0
        ADD      R0,SP,#+48
        BL       chk_mounted
        MOVS     R6,R0
// 3349 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_chmod_0
// 3350 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R7,R0
        CMP      R7,#+0
        BNE.N    ??f_chmod_1
        MOVS     R0,#+17
        B.N      ??f_chmod_2
??f_chmod_1:
        STR      R7,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 3351 		res = follow_path(&dj, path);		/* Follow the file path */
        LDR      R1,[SP, #+48]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R6,R0
// 3352 		FREE_BUF();
        MOVS     R0,R7
        BL       ff_memfree
// 3353 		if (_FS_RPATH && res == FR_OK && (dj.fn[NS] & NS_DOT))
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_chmod_3
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_chmod_3
// 3354 			res = FR_INVALID_NAME;
        MOVS     R6,#+6
// 3355 		if (res == FR_OK) {
??f_chmod_3:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_chmod_0
// 3356 			dir = dj.dir;
        LDR      R0,[SP, #+20]
// 3357 			if (!dir) {						/* Is it a root directory? */
        CMP      R0,#+0
        BNE.N    ??f_chmod_4
// 3358 				res = FR_INVALID_NAME;
        MOVS     R6,#+6
        B.N      ??f_chmod_0
// 3359 			} else {						/* File or sub directory */
// 3360 				mask &= AM_RDO|AM_HID|AM_SYS|AM_ARC;	/* Valid attribute mask */
??f_chmod_4:
        ANDS     R5,R5,#0x27
// 3361 				dir[DIR_Attr] = (value & mask) | (dir[DIR_Attr] & (BYTE)~mask);	/* Apply attribute change */
        ANDS     R1,R5,R4
        LDRB     R2,[R0, #+11]
        BICS     R2,R2,R5
        ORRS     R1,R2,R1
        STRB     R1,[R0, #+11]
// 3362 				dj.fs->wflag = 1;
        LDR      R0,[SP, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
// 3363 				res = sync(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync
        MOVS     R6,R0
// 3364 			}
// 3365 		}
// 3366 	}
// 3367 
// 3368 	LEAVE_FF(dj.fs, res);
??f_chmod_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_chmod_2:
        ADD      SP,SP,#+52
        POP      {R4-R7,PC}       ;; return
// 3369 }
// 3370 
// 3371 
// 3372 
// 3373 
// 3374 /*-----------------------------------------------------------------------*/
// 3375 /* Change Timestamp                                                      */
// 3376 /*-----------------------------------------------------------------------*/
// 3377 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3378 FRESULT f_utime (
// 3379 	const TCHAR *path,	/* Pointer to the file/directory name */
// 3380 	const FILINFO *fno	/* Pointer to the time stamp to be set */
// 3381 )
// 3382 {
f_utime:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+52
        MOVS     R4,R1
// 3383 	FRESULT res;
// 3384 	DIR dj;
// 3385 	BYTE *dir;
// 3386 	DEF_NAMEBUF;
// 3387 
// 3388 
// 3389 	res = chk_mounted(&path, &dj.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+0
        ADD      R0,SP,#+52
        BL       chk_mounted
        MOVS     R5,R0
// 3390 	if (res == FR_OK) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_utime_0
// 3391 		INIT_BUF(dj);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R6,R0
        CMP      R6,#+0
        BNE.N    ??f_utime_1
        MOVS     R0,#+17
        B.N      ??f_utime_2
??f_utime_1:
        STR      R6,[SP, #+28]
        ADD      R0,SP,#+36
        STR      R0,[SP, #+24]
// 3392 		res = follow_path(&dj, path);	/* Follow the file path */
        LDR      R1,[SP, #+52]
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R5,R0
// 3393 		FREE_BUF();
        MOVS     R0,R6
        BL       ff_memfree
// 3394 		if (_FS_RPATH && res == FR_OK && (dj.fn[NS] & NS_DOT))
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_utime_3
        LDR      R0,[SP, #+24]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_utime_3
// 3395 			res = FR_INVALID_NAME;
        MOVS     R5,#+6
// 3396 		if (res == FR_OK) {
??f_utime_3:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+0
        BNE.N    ??f_utime_0
// 3397 			dir = dj.dir;
        LDR      R0,[SP, #+20]
// 3398 			if (!dir) {					/* Root directory */
        CMP      R0,#+0
        BNE.N    ??f_utime_4
// 3399 				res = FR_INVALID_NAME;
        MOVS     R5,#+6
        B.N      ??f_utime_0
// 3400 			} else {					/* File or sub-directory */
// 3401 				ST_WORD(dir+DIR_WrtTime, fno->ftime);
??f_utime_4:
        LDRH     R1,[R4, #+6]
        STRB     R1,[R0, #+22]
        LDRH     R1,[R4, #+6]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+23]
// 3402 				ST_WORD(dir+DIR_WrtDate, fno->fdate);
        LDRH     R1,[R4, #+4]
        STRB     R1,[R0, #+24]
        LDRH     R1,[R4, #+4]
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R0, #+25]
// 3403 				dj.fs->wflag = 1;
        LDR      R0,[SP, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
// 3404 				res = sync(dj.fs);
        LDR      R0,[SP, #+0]
        BL       sync
        MOVS     R5,R0
// 3405 			}
// 3406 		}
// 3407 	}
// 3408 
// 3409 	LEAVE_FF(dj.fs, res);
??f_utime_0:
        MOVS     R0,R5
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_utime_2:
        ADD      SP,SP,#+56
        POP      {R4-R6,PC}       ;; return
// 3410 }
// 3411 
// 3412 
// 3413 
// 3414 
// 3415 /*-----------------------------------------------------------------------*/
// 3416 /* Rename File/Directory                                                 */
// 3417 /*-----------------------------------------------------------------------*/
// 3418 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3419 FRESULT f_rename (
// 3420 	const TCHAR *path_old,	/* Pointer to the old name */
// 3421 	const TCHAR *path_new	/* Pointer to the new name */
// 3422 )
// 3423 {
f_rename:
        PUSH     {R0,R4-R6,LR}
        SUB      SP,SP,#+108
        MOVS     R4,R1
// 3424 	FRESULT res;
// 3425 	DIR djo, djn;
// 3426 	BYTE buf[21], *dir;
// 3427 	DWORD dw;
// 3428 	DEF_NAMEBUF;
// 3429 
// 3430 
// 3431 	res = chk_mounted(&path_old, &djo.fs, 1);
        MOVS     R2,#+1
        ADD      R1,SP,#+36
        ADD      R0,SP,#+108
        BL       chk_mounted
        MOVS     R6,R0
// 3432 	if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.W    ??f_rename_0
// 3433 		djn.fs = djo.fs;
        LDR      R0,[SP, #+36]
        STR      R0,[SP, #+0]
// 3434 		INIT_BUF(djo);
        MOVS     R0,#+130
        BL       ff_memalloc
        MOVS     R5,R0
        CMP      R5,#+0
        BNE.N    ??f_rename_1
        MOVS     R0,#+17
        B.N      ??f_rename_2
??f_rename_1:
        STR      R5,[SP, #+64]
        ADD      R0,SP,#+72
        STR      R0,[SP, #+60]
// 3435 		res = follow_path(&djo, path_old);		/* Check old object */
        LDR      R1,[SP, #+108]
        ADD      R0,SP,#+36
        BL       follow_path
        MOVS     R6,R0
// 3436 		if (_FS_RPATH && res == FR_OK && (djo.fn[NS] & NS_DOT))
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_3
        LDR      R0,[SP, #+60]
        LDRB     R0,[R0, #+11]
        LSLS     R0,R0,#+26
        BPL.N    ??f_rename_3
// 3437 			res = FR_INVALID_NAME;
        MOVS     R6,#+6
// 3438 #if _FS_SHARE
// 3439 		if (res == FR_OK) res = chk_lock(&djo, 2);
??f_rename_3:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_4
        MOVS     R1,#+2
        ADD      R0,SP,#+36
        BL       chk_lock
        MOVS     R6,R0
// 3440 #endif
// 3441 		if (res == FR_OK) {						/* Old object is found */
??f_rename_4:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.W    ??f_rename_5
// 3442 			if (!djo.dir) {						/* Is root dir? */
        LDR      R0,[SP, #+56]
        CMP      R0,#+0
        BNE.N    ??f_rename_6
// 3443 				res = FR_NO_FILE;
        MOVS     R6,#+4
        B.N      ??f_rename_5
// 3444 			} else {
// 3445 				mem_cpy(buf, djo.dir+DIR_Attr, 21);		/* Save the object information except for name */
??f_rename_6:
        MOVS     R2,#+21
        LDR      R0,[SP, #+56]
        ADDS     R1,R0,#+11
        ADD      R0,SP,#+84
        BL       mem_cpy
// 3446 				mem_cpy(&djn, &djo, sizeof(DIR));		/* Check new object */
        MOVS     R2,#+36
        ADD      R1,SP,#+36
        ADD      R0,SP,#+0
        BL       mem_cpy
// 3447 				res = follow_path(&djn, path_new);
        MOVS     R1,R4
        ADD      R0,SP,#+0
        BL       follow_path
        MOVS     R6,R0
// 3448 				if (res == FR_OK) res = FR_EXIST;		/* The new object name is already existing */
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_7
        MOVS     R6,#+8
// 3449 				if (res == FR_NO_FILE) { 				/* Is it a valid path and no name collision? */
??f_rename_7:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+4
        BNE.N    ??f_rename_5
// 3450 /* Start critical section that any interruption or error can cause cross-link */
// 3451 					res = dir_register(&djn);			/* Register the new entry */
        ADD      R0,SP,#+0
        BL       dir_register
        MOVS     R6,R0
// 3452 					if (res == FR_OK) {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_5
// 3453 						dir = djn.dir;					/* Copy object information except for name */
        LDR      R4,[SP, #+20]
// 3454 						mem_cpy(dir+13, buf+2, 19);
        MOVS     R2,#+19
        ADD      R1,SP,#+86
        ADDS     R0,R4,#+13
        BL       mem_cpy
// 3455 						dir[DIR_Attr] = buf[0] | AM_ARC;
        LDRB     R0,[SP, #+84]
        ORRS     R0,R0,#0x20
        STRB     R0,[R4, #+11]
// 3456 						djo.fs->wflag = 1;
        LDR      R0,[SP, #+36]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
// 3457 						if (djo.sclust != djn.sclust && (dir[DIR_Attr] & AM_DIR)) {		/* Update .. entry in the directory if needed */
        LDR      R0,[SP, #+44]
        LDR      R1,[SP, #+8]
        CMP      R0,R1
        BEQ.N    ??f_rename_8
        LDRB     R0,[R4, #+11]
        LSLS     R0,R0,#+27
        BPL.N    ??f_rename_8
// 3458 							dw = clust2sect(djn.fs, LD_CLUST(dir));
        LDRB     R0,[R4, #+21]
        LDRB     R1,[R4, #+20]
        ORRS     R0,R1,R0, LSL #+8
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LDRB     R1,[R4, #+27]
        LDRB     R2,[R4, #+26]
        ORRS     R1,R2,R1, LSL #+8
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        ORRS     R1,R1,R0, LSL #+16
        LDR      R0,[SP, #+0]
        BL       clust2sect
// 3459 							if (!dw) {
        CMP      R0,#+0
        BNE.N    ??f_rename_9
// 3460 								res = FR_INT_ERR;
        MOVS     R6,#+2
        B.N      ??f_rename_8
// 3461 							} else {
// 3462 								res = move_window(djn.fs, dw);
??f_rename_9:
        MOVS     R1,R0
        LDR      R0,[SP, #+0]
        BL       move_window
        MOVS     R6,R0
// 3463 								dir = djn.fs->win+SZ_DIR;	/* .. entry */
        LDR      R0,[SP, #+0]
        ADDW     R4,R0,#+84
// 3464 								if (res == FR_OK && dir[1] == '.') {
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_8
        LDRB     R0,[R4, #+1]
        CMP      R0,#+46
        BNE.N    ??f_rename_8
// 3465 									dw = (djn.fs->fs_type == FS_FAT32 && djn.sclust == djn.fs->dirbase) ? 0 : djn.sclust;
        LDR      R0,[SP, #+0]
        LDRB     R0,[R0, #+0]
        CMP      R0,#+3
        BNE.N    ??f_rename_10
        LDR      R0,[SP, #+8]
        LDR      R1,[SP, #+0]
        LDR      R1,[R1, #+40]
        CMP      R0,R1
        BNE.N    ??f_rename_10
        MOVS     R0,#+0
        B.N      ??f_rename_11
??f_rename_10:
        LDR      R0,[SP, #+8]
// 3466 									ST_CLUST(dir, dw);
??f_rename_11:
        STRB     R0,[R4, #+26]
        MOVS     R1,R0
        UXTH     R1,R1            ;; ZeroExt  R1,R1,#+16,#+16
        LSRS     R1,R1,#+8
        STRB     R1,[R4, #+27]
        LSRS     R1,R0,#+16
        STRB     R1,[R4, #+20]
        LSRS     R0,R0,#+16
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R4, #+21]
// 3467 									djn.fs->wflag = 1;
        LDR      R0,[SP, #+0]
        MOVS     R1,#+1
        STRB     R1,[R0, #+4]
// 3468 								}
// 3469 							}
// 3470 						}
// 3471 						if (res == FR_OK) {
??f_rename_8:
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_5
// 3472 							res = dir_remove(&djo);		/* Remove old entry */
        ADD      R0,SP,#+36
        BL       dir_remove
        MOVS     R6,R0
// 3473 							if (res == FR_OK)
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        CMP      R6,#+0
        BNE.N    ??f_rename_5
// 3474 								res = sync(djo.fs);
        LDR      R0,[SP, #+36]
        BL       sync
        MOVS     R6,R0
// 3475 						}
// 3476 					}
// 3477 /* End critical section */
// 3478 				}
// 3479 			}
// 3480 		}
// 3481 		FREE_BUF();
??f_rename_5:
        MOVS     R0,R5
        BL       ff_memfree
// 3482 	}
// 3483 	LEAVE_FF(djo.fs, res);
??f_rename_0:
        MOVS     R0,R6
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_rename_2:
        ADD      SP,SP,#+112
        POP      {R4-R6,PC}       ;; return
// 3484 }
// 3485 
// 3486 #endif /* !_FS_READONLY */
// 3487 #endif /* _FS_MINIMIZE == 0 */
// 3488 #endif /* _FS_MINIMIZE <= 1 */
// 3489 #endif /* _FS_MINIMIZE <= 2 */
// 3490 
// 3491 
// 3492 
// 3493 /*-----------------------------------------------------------------------*/
// 3494 /* Forward data to the stream directly (available on only tiny cfg)      */
// 3495 /*-----------------------------------------------------------------------*/
// 3496 #if _USE_FORWARD && _FS_TINY
// 3497 
// 3498 FRESULT f_forward (
// 3499 	FIL *fp, 						/* Pointer to the file object */
// 3500 	UINT (*func)(const BYTE*,UINT),	/* Pointer to the streaming function */
// 3501 	UINT btr,						/* Number of bytes to forward */
// 3502 	UINT *bf						/* Pointer to number of bytes forwarded */
// 3503 )
// 3504 {
// 3505 	FRESULT res;
// 3506 	DWORD remain, clst, sect;
// 3507 	UINT rcnt;
// 3508 	BYTE csect;
// 3509 
// 3510 
// 3511 	*bf = 0;	/* Initialize byte counter */
// 3512 
// 3513 	res = validate(fp->fs, fp->id);					/* Check validity of the object */
// 3514 	if (res != FR_OK) LEAVE_FF(fp->fs, res);
// 3515 	if (fp->flag & FA__ERROR)						/* Check error flag */
// 3516 		LEAVE_FF(fp->fs, FR_INT_ERR);
// 3517 	if (!(fp->flag & FA_READ))						/* Check access mode */
// 3518 		LEAVE_FF(fp->fs, FR_DENIED);
// 3519 
// 3520 	remain = fp->fsize - fp->fptr;
// 3521 	if (btr > remain) btr = (UINT)remain;			/* Truncate btr by remaining bytes */
// 3522 
// 3523 	for ( ;  btr && (*func)(0, 0);					/* Repeat until all data transferred or stream becomes busy */
// 3524 		fp->fptr += rcnt, *bf += rcnt, btr -= rcnt) {
// 3525 		csect = (BYTE)(fp->fptr / SS(fp->fs) & (fp->fs->csize - 1));	/* Sector offset in the cluster */
// 3526 		if ((fp->fptr % SS(fp->fs)) == 0) {			/* On the sector boundary? */
// 3527 			if (!csect) {							/* On the cluster boundary? */
// 3528 				clst = (fp->fptr == 0) ?			/* On the top of the file? */
// 3529 					fp->sclust : get_fat(fp->fs, fp->clust);
// 3530 				if (clst <= 1) ABORT(fp->fs, FR_INT_ERR);
// 3531 				if (clst == 0xFFFFFFFF) ABORT(fp->fs, FR_DISK_ERR);
// 3532 				fp->clust = clst;					/* Update current cluster */
// 3533 			}
// 3534 		}
// 3535 		sect = clust2sect(fp->fs, fp->clust);		/* Get current data sector */
// 3536 		if (!sect) ABORT(fp->fs, FR_INT_ERR);
// 3537 		sect += csect;
// 3538 		if (move_window(fp->fs, sect))				/* Move sector window */
// 3539 			ABORT(fp->fs, FR_DISK_ERR);
// 3540 		fp->dsect = sect;
// 3541 		rcnt = SS(fp->fs) - (WORD)(fp->fptr % SS(fp->fs));	/* Forward data from sector window */
// 3542 		if (rcnt > btr) rcnt = btr;
// 3543 		rcnt = (*func)(&fp->fs->win[(WORD)fp->fptr % SS(fp->fs)], rcnt);
// 3544 		if (!rcnt) ABORT(fp->fs, FR_INT_ERR);
// 3545 	}
// 3546 
// 3547 	LEAVE_FF(fp->fs, FR_OK);
// 3548 }
// 3549 #endif /* _USE_FORWARD */
// 3550 
// 3551 
// 3552 
// 3553 #if _USE_MKFS && !_FS_READONLY
// 3554 /*-----------------------------------------------------------------------*/
// 3555 /* Create File System on the Drive                                       */
// 3556 /*-----------------------------------------------------------------------*/
// 3557 #define N_ROOTDIR	512		/* Number of root dir entries for FAT12/16 */
// 3558 #define N_FATS		1		/* Number of FAT copies (1 or 2) */
// 3559 
// 3560 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3561 FRESULT f_mkfs (
// 3562 	BYTE drv,		/* Logical drive number */
// 3563 	BYTE sfd,		/* Partitioning rule 0:FDISK, 1:SFD */
// 3564 	UINT au			/* Allocation unit size [bytes] */
// 3565 )
// 3566 {
f_mkfs:
        PUSH     {R4-R11,LR}
        SUB      SP,SP,#+28
        MOV      R11,R1
        MOVS     R4,R2
// 3567 	static const WORD vst[] = { 1024,   512,  256,  128,   64,    32,   16,    8,    4,    2,   0};
// 3568 	static const WORD cst[] = {32768, 16384, 8192, 4096, 2048, 16384, 8192, 4096, 2048, 1024, 512};
// 3569 	BYTE fmt, md, sys, *tbl, pdrv, part;
// 3570 	DWORD n_clst, vs, n, wsect;
// 3571 	UINT i;
// 3572 	DWORD b_vol, b_fat, b_dir, b_data;	/* LBA */
// 3573 	DWORD n_vol, n_rsv, n_fat, n_dir;	/* Size */
// 3574 	FATFS *fs;
// 3575 	DSTATUS stat;
// 3576 
// 3577 
// 3578 	/* Check mounted drive and clear work area */
// 3579 	if (drv >= _VOLUMES) return FR_INVALID_DRIVE;
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+1
        BCC.N    ??f_mkfs_0
        MOVS     R0,#+11
        B.N      ??f_mkfs_1
// 3580 	if (sfd > 1) return FR_INVALID_PARAMETER;
??f_mkfs_0:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+2
        BCC.N    ??f_mkfs_2
        MOVS     R0,#+19
        B.N      ??f_mkfs_1
// 3581 	if (au & (au - 1)) return FR_INVALID_PARAMETER;
??f_mkfs_2:
        SUBS     R1,R4,#+1
        TST      R4,R1
        BEQ.N    ??f_mkfs_3
        MOVS     R0,#+19
        B.N      ??f_mkfs_1
// 3582 	fs = FatFs[drv];
??f_mkfs_3:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        LDR.W    R1,??DataTable14
        LDR      R1,[R1, R0, LSL #+2]
        STR      R1,[SP, #+12]
// 3583 	if (!fs) return FR_NOT_ENABLED;
        LDR      R1,[SP, #+12]
        CMP      R1,#+0
        BNE.N    ??f_mkfs_4
        MOVS     R0,#+12
        B.N      ??f_mkfs_1
// 3584 	fs->fs_type = 0;
??f_mkfs_4:
        LDR      R1,[SP, #+12]
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
// 3585 	pdrv = LD2PD(drv);	/* Physical drive */
        STRB     R0,[SP, #+8]
// 3586 	part = LD2PT(drv);	/* Partition (0:auto detect, 1-4:get from partition table)*/
        MOVS     R5,#+0
// 3587 
// 3588 	/* Get disk statics */
// 3589 	stat = LPLD_Disk_Initialize(pdrv);
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_Initialize
// 3590 	if (stat & STA_NOINIT) return FR_NOT_READY;
        MOVS     R1,R0
        LSLS     R1,R1,#+31
        BPL.N    ??f_mkfs_5
        MOVS     R0,#+3
        B.N      ??f_mkfs_1
// 3591 	if (stat & STA_PROTECT) return FR_WRITE_PROTECTED;
??f_mkfs_5:
        LSLS     R0,R0,#+29
        BPL.N    ??f_mkfs_6
        MOVS     R0,#+10
        B.N      ??f_mkfs_1
// 3592 #if _MAX_SS != 512					/* Get disk sector size */
// 3593 	if (LPLD_Disk_IOC(pdrv, GET_SECTOR_SIZE, &SS(fs)) != RES_OK || SS(fs) > _MAX_SS)
// 3594 		return FR_DISK_ERR;
// 3595 #endif
// 3596 	if (_MULTI_PARTITION && part) {
// 3597 		/* Get partition information from partition table in the MBR */
// 3598 		if (LPLD_Disk_Read(pdrv, fs->win, 0, 1) != RES_OK) return FR_DISK_ERR;
// 3599 		if (LD_WORD(fs->win+BS_55AA) != 0xAA55) return FR_MKFS_ABORTED;
// 3600 		tbl = &fs->win[MBR_Table + (part - 1) * SZ_PTE];
// 3601 		if (!tbl[4]) return FR_MKFS_ABORTED;	/* No partition? */
// 3602 		b_vol = LD_DWORD(tbl+8);	/* Volume start sector */
// 3603 		n_vol = LD_DWORD(tbl+12);	/* Volume size */
// 3604 	} else {
// 3605 		/* Create a partition in this function */
// 3606 		if (LPLD_Disk_IOC(pdrv, GET_SECTOR_COUNT, &n_vol) != RES_OK || n_vol < 128)
??f_mkfs_6:
        ADD      R2,SP,#+4
        MOVS     R1,#+1
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_IOC
        CMP      R0,#+0
        BNE.N    ??f_mkfs_7
        LDR      R0,[SP, #+4]
        CMP      R0,#+128
        BCS.N    ??f_mkfs_8
// 3607 			return FR_DISK_ERR;
??f_mkfs_7:
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3608 		b_vol = (sfd) ? 0 : 63;		/* Volume start sector */
??f_mkfs_8:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+0
        BEQ.N    ??f_mkfs_9
        MOVS     R7,#+0
        B.N      ??f_mkfs_10
??f_mkfs_9:
        MOVS     R7,#+63
// 3609 		n_vol -= b_vol;				/* Volume size */
??f_mkfs_10:
        LDR      R0,[SP, #+4]
        SUBS     R0,R0,R7
        STR      R0,[SP, #+4]
// 3610 	}
// 3611 
// 3612 	if (!au) {				/* AU auto selection */
        CMP      R4,#+0
        BNE.N    ??f_mkfs_11
// 3613 		vs = n_vol / (2000 / (SS(fs) / 512));
        LDR      R0,[SP, #+4]
        MOV      R1,#+2000
        UDIV     R0,R0,R1
// 3614 		for (i = 0; vs < vst[i]; i++) ;
        MOVS     R10,#+0
        B.N      ??f_mkfs_12
??f_mkfs_13:
        ADDS     R10,R10,#+1
??f_mkfs_12:
        LDR.W    R1,??DataTable14_1
        LDRH     R1,[R1, R10, LSL #+1]
        CMP      R0,R1
        BCC.N    ??f_mkfs_13
// 3615 		au = cst[i];
        LDR.W    R0,??DataTable14_2
        LDRH     R4,[R0, R10, LSL #+1]
// 3616 	}
// 3617 	au /= SS(fs);		/* Number of sectors per cluster */
??f_mkfs_11:
        LSRS     R4,R4,#+9
// 3618 	if (au == 0) au = 1;
        CMP      R4,#+0
        BNE.N    ??f_mkfs_14
        MOVS     R4,#+1
// 3619 	if (au > 128) au = 128;
??f_mkfs_14:
        CMP      R4,#+129
        BCC.N    ??f_mkfs_15
        MOVS     R4,#+128
// 3620 
// 3621 	/* Pre-compute number of clusters and FAT syb-type */
// 3622 	n_clst = n_vol / au;
??f_mkfs_15:
        LDR      R0,[SP, #+4]
        UDIV     R6,R0,R4
// 3623 	fmt = FS_FAT12;
        MOVS     R5,#+1
// 3624 	if (n_clst >= MIN_FAT16) fmt = FS_FAT16;
        MOVW     R0,#+4086
        CMP      R6,R0
        BCC.N    ??f_mkfs_16
        MOVS     R5,#+2
// 3625 	if (n_clst >= MIN_FAT32) fmt = FS_FAT32;
??f_mkfs_16:
        MOVW     R0,#+65526
        CMP      R6,R0
        BCC.N    ??f_mkfs_17
        MOVS     R5,#+3
// 3626 
// 3627 	/* Determine offset and size of FAT structure */
// 3628 	if (fmt == FS_FAT32) {
??f_mkfs_17:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_18
// 3629 		n_fat = ((n_clst * 4) + 8 + SS(fs) - 1) / SS(fs);
        LSLS     R0,R6,#+2
        ADDW     R0,R0,#+519
        LSRS     R9,R0,#+9
// 3630 		n_rsv = 32;
        MOVS     R8,#+32
// 3631 		n_dir = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+16]
        B.N      ??f_mkfs_19
// 3632 	} else {
// 3633 		n_fat = (fmt == FS_FAT12) ? (n_clst * 3 + 1) / 2 + 3 : (n_clst * 2) + 4;
??f_mkfs_18:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+1
        BNE.N    ??f_mkfs_20
        MOVS     R0,#+3
        MUL      R0,R0,R6
        ADDS     R0,R0,#+1
        LSRS     R0,R0,#+1
        ADDS     R9,R0,#+3
        B.N      ??f_mkfs_21
??f_mkfs_20:
        LSLS     R0,R6,#+1
        ADDS     R9,R0,#+4
// 3634 		n_fat = (n_fat + SS(fs) - 1) / SS(fs);
??f_mkfs_21:
        ADDW     R0,R9,#+511
        LSRS     R9,R0,#+9
// 3635 		n_rsv = 1;
        MOVS     R8,#+1
// 3636 		n_dir = (DWORD)N_ROOTDIR * SZ_DIR / SS(fs);
        MOVS     R0,#+32
        STR      R0,[SP, #+16]
// 3637 	}
// 3638 	b_fat = b_vol + n_rsv;				/* FAT area start sector */
??f_mkfs_19:
        ADDS     R0,R8,R7
        STR      R0,[SP, #+20]
// 3639 	b_dir = b_fat + n_fat * N_FATS;		/* Directory area start sector */
        LDR      R0,[SP, #+20]
        ADDS     R0,R9,R0
// 3640 	b_data = b_dir + n_dir;				/* Data area start sector */
        LDR      R1,[SP, #+16]
        ADDS     R6,R1,R0
// 3641 	if (n_vol < b_data + au - b_vol) return FR_MKFS_ABORTED;	/* Too small volume */
        LDR      R0,[SP, #+4]
        ADDS     R1,R4,R6
        SUBS     R1,R1,R7
        CMP      R0,R1
        BCS.N    ??f_mkfs_22
        MOVS     R0,#+14
        B.N      ??f_mkfs_1
// 3642 
// 3643 	/* Align data start sector to erase block boundary (for flash memory media) */
// 3644 	if (LPLD_Disk_IOC(pdrv, GET_BLOCK_SIZE, &n) != RES_OK || !n || n > 32768) n = 1;
??f_mkfs_22:
        ADD      R2,SP,#+0
        MOVS     R1,#+3
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_IOC
        CMP      R0,#+0
        BNE.N    ??f_mkfs_23
        LDR      R0,[SP, #+0]
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_23
        LDR      R0,[SP, #+0]
        CMP      R0,#+32768
        BLS.N    ??f_mkfs_24
??f_mkfs_23:
        MOVS     R0,#+1
        STR      R0,[SP, #+0]
// 3645 	n = (b_data + n - 1) & ~(n - 1);	/* Next nearest erase block from current data start */
??f_mkfs_24:
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,R6
        SUBS     R0,R0,#+1
        LDR      R1,[SP, #+0]
        SUBS     R1,R1,#+1
        BICS     R0,R0,R1
        STR      R0,[SP, #+0]
// 3646 	n = (n - b_data) / N_FATS;
        LDR      R0,[SP, #+0]
        SUBS     R0,R0,R6
        MOVS     R1,#+1
        UDIV     R0,R0,R1
        STR      R0,[SP, #+0]
// 3647 	if (fmt == FS_FAT32) {		/* FAT32: Move FAT offset */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_25
// 3648 		n_rsv += n;
        LDR      R0,[SP, #+0]
        ADDS     R8,R0,R8
// 3649 		b_fat += n;
        LDR      R0,[SP, #+20]
        LDR      R1,[SP, #+0]
        ADDS     R0,R1,R0
        STR      R0,[SP, #+20]
        B.N      ??f_mkfs_26
// 3650 	} else {					/* FAT12/16: Expand FAT size */
// 3651 		n_fat += n;
??f_mkfs_25:
        LDR      R0,[SP, #+0]
        ADDS     R9,R0,R9
// 3652 	}
// 3653 
// 3654 	/* Determine number of clusters and final check of validity of the FAT sub-type */
// 3655 	n_clst = (n_vol - n_rsv - n_fat * N_FATS - n_dir) / au;
??f_mkfs_26:
        LDR      R0,[SP, #+4]
        SUBS     R0,R0,R8
        SUBS     R0,R0,R9
        LDR      R1,[SP, #+16]
        SUBS     R0,R0,R1
        UDIV     R6,R0,R4
// 3656 	if (   (fmt == FS_FAT16 && n_clst < MIN_FAT16)
// 3657 		|| (fmt == FS_FAT32 && n_clst < MIN_FAT32))
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+2
        BNE.N    ??f_mkfs_27
        MOVW     R0,#+4086
        CMP      R6,R0
        BCC.N    ??f_mkfs_28
??f_mkfs_27:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_29
        MOVW     R0,#+65526
        CMP      R6,R0
        BCS.N    ??f_mkfs_29
// 3658 		return FR_MKFS_ABORTED;
??f_mkfs_28:
        MOVS     R0,#+14
        B.N      ??f_mkfs_1
// 3659 
// 3660 	switch (fmt) {	/* Determine system ID for partition table */
??f_mkfs_29:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        MOVS     R0,R5
        CMP      R0,#+1
        BEQ.N    ??f_mkfs_30
        CMP      R0,#+2
        BEQ.N    ??f_mkfs_31
        B.N      ??f_mkfs_32
// 3661 	case FS_FAT12:	sys = 0x01; break;
??f_mkfs_30:
        MOVS     R10,#+1
        B.N      ??f_mkfs_33
// 3662 	case FS_FAT16:	sys = (n_vol < 0x10000) ? 0x04 : 0x06; break;
??f_mkfs_31:
        LDR      R0,[SP, #+4]
        CMP      R0,#+65536
        BCS.N    ??f_mkfs_34
        MOVS     R10,#+4
        B.N      ??f_mkfs_35
??f_mkfs_34:
        MOVS     R10,#+6
??f_mkfs_35:
        B.N      ??f_mkfs_33
// 3663 	default: 		sys = 0x0C;
??f_mkfs_32:
        MOVS     R10,#+12
// 3664 	}
// 3665 
// 3666 	if (_MULTI_PARTITION && part) {
// 3667 		/* Update system ID in the partition table */
// 3668 		tbl = &fs->win[MBR_Table + (part - 1) * SZ_PTE];
// 3669 		tbl[4] = sys;
// 3670 		if (LPLD_Disk_Write(pdrv, fs->win, 0, 1) != RES_OK) return FR_DISK_ERR;
// 3671 		md = 0xF8;
// 3672 	} else {
// 3673 		if (sfd) {	/* No patition table (SFD) */
??f_mkfs_33:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+0
        BEQ.N    ??f_mkfs_36
// 3674 			md = 0xF0;
        MOVS     R0,#+240
        STRB     R0,[SP, #+9]
        B.N      ??f_mkfs_37
// 3675 		} else {	/* Create partition table (FDISK) */
// 3676 			mem_set(fs->win, 0, SS(fs));
??f_mkfs_36:
        MOV      R2,#+512
        MOVS     R1,#+0
        LDR      R0,[SP, #+12]
        ADDS     R0,R0,#+52
        BL       mem_set
// 3677 			tbl = fs->win+MBR_Table;	/* Create partiton table for single partition in the drive */
        LDR      R0,[SP, #+12]
        ADDW     R11,R0,#+498
// 3678 			tbl[1] = 1;						/* Partition start head */
        MOVS     R0,#+1
        STRB     R0,[R11, #+1]
// 3679 			tbl[2] = 1;						/* Partition start sector */
        MOVS     R0,#+1
        STRB     R0,[R11, #+2]
// 3680 			tbl[3] = 0;						/* Partition start cylinder */
        MOVS     R0,#+0
        STRB     R0,[R11, #+3]
// 3681 			tbl[4] = sys;					/* System type */
        STRB     R10,[R11, #+4]
// 3682 			tbl[5] = 254;					/* Partition end head */
        MOVS     R0,#+254
        STRB     R0,[R11, #+5]
// 3683 			n = (b_vol + n_vol) / 63 / 255;
        LDR      R0,[SP, #+4]
        ADDS     R0,R0,R7
        MOVS     R1,#+63
        UDIV     R0,R0,R1
        MOVS     R1,#+255
        UDIV     R0,R0,R1
        STR      R0,[SP, #+0]
// 3684 			tbl[6] = (BYTE)((n >> 2) | 63);	/* Partiiton end sector */
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+2
        ORRS     R0,R0,#0x3F
        STRB     R0,[R11, #+6]
// 3685 			tbl[7] = (BYTE)n;				/* End cylinder */
        LDR      R0,[SP, #+0]
        STRB     R0,[R11, #+7]
// 3686 			ST_DWORD(tbl+8, 63);			/* Partition start in LBA */
        MOVS     R0,#+63
        STRB     R0,[R11, #+8]
        MOVS     R0,#+0
        STRB     R0,[R11, #+9]
        MOVS     R0,#+0
        STRB     R0,[R11, #+10]
        MOVS     R0,#+0
        STRB     R0,[R11, #+11]
// 3687 			ST_DWORD(tbl+12, n_vol);		/* Partition size in LBA */
        LDR      R0,[SP, #+4]
        STRB     R0,[R11, #+12]
        LDR      R0,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+13]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+16
        STRB     R0,[R11, #+14]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+24
        STRB     R0,[R11, #+15]
// 3688 			ST_WORD(fs->win+BS_55AA, 0xAA55);	/* MBR signature */
        LDR      R0,[SP, #+12]
        MOVS     R1,#+85
        STRB     R1,[R0, #+562]
        LDR      R0,[SP, #+12]
        MOVS     R1,#+170
        STRB     R1,[R0, #+563]
// 3689 			if (LPLD_Disk_Write(pdrv, fs->win, 0, 1) != RES_OK)	/* Write it to the MBR sector */
        MOVS     R3,#+1
        MOVS     R2,#+0
        LDR      R0,[SP, #+12]
        ADDS     R1,R0,#+52
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_Write
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_38
// 3690 				return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3691 			md = 0xF8;
??f_mkfs_38:
        MOVS     R0,#+248
        STRB     R0,[SP, #+9]
// 3692 		}
// 3693 	}
// 3694 
// 3695 	/* Create BPB in the VBR */
// 3696 	tbl = fs->win;							/* Clear sector */
??f_mkfs_37:
        LDR      R0,[SP, #+12]
        ADDW     R11,R0,#+52
// 3697 	mem_set(tbl, 0, SS(fs));
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R11
        BL       mem_set
// 3698 	mem_cpy(tbl, "\xEB\xFE\x90" "MSDOS5.0", 11);/* Boot jump code, OEM name */
        MOVS     R2,#+11
        LDR.W    R1,??DataTable14_3
        MOV      R0,R11
        BL       mem_cpy
// 3699 	i = SS(fs);								/* Sector size */
        MOV      R10,#+512
// 3700 	ST_WORD(tbl+BPB_BytsPerSec, i);
        STRB     R10,[R11, #+11]
        UXTH     R10,R10          ;; ZeroExt  R10,R10,#+16,#+16
        LSRS     R0,R10,#+8
        STRB     R0,[R11, #+12]
// 3701 	tbl[BPB_SecPerClus] = (BYTE)au;			/* Sectors per cluster */
        STRB     R4,[R11, #+13]
// 3702 	ST_WORD(tbl+BPB_RsvdSecCnt, n_rsv);		/* Reserved sectors */
        STRB     R8,[R11, #+14]
        UXTH     R8,R8            ;; ZeroExt  R8,R8,#+16,#+16
        LSRS     R0,R8,#+8
        STRB     R0,[R11, #+15]
// 3703 	tbl[BPB_NumFATs] = N_FATS;				/* Number of FATs */
        MOVS     R0,#+1
        STRB     R0,[R11, #+16]
// 3704 	i = (fmt == FS_FAT32) ? 0 : N_ROOTDIR;	/* Number of rootdir entries */
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_39
        MOVS     R10,#+0
        B.N      ??f_mkfs_40
??f_mkfs_39:
        MOV      R10,#+512
// 3705 	ST_WORD(tbl+BPB_RootEntCnt, i);
??f_mkfs_40:
        STRB     R10,[R11, #+17]
        UXTH     R10,R10          ;; ZeroExt  R10,R10,#+16,#+16
        LSRS     R0,R10,#+8
        STRB     R0,[R11, #+18]
// 3706 	if (n_vol < 0x10000) {					/* Number of total sectors */
        LDR      R0,[SP, #+4]
        CMP      R0,#+65536
        BCS.N    ??f_mkfs_41
// 3707 		ST_WORD(tbl+BPB_TotSec16, n_vol);
        LDR      R0,[SP, #+4]
        STRB     R0,[R11, #+19]
        LDR      R0,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+20]
        B.N      ??f_mkfs_42
// 3708 	} else {
// 3709 		ST_DWORD(tbl+BPB_TotSec32, n_vol);
??f_mkfs_41:
        LDR      R0,[SP, #+4]
        STRB     R0,[R11, #+32]
        LDR      R0,[SP, #+4]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+33]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+16
        STRB     R0,[R11, #+34]
        LDR      R0,[SP, #+4]
        LSRS     R0,R0,#+24
        STRB     R0,[R11, #+35]
// 3710 	}
// 3711 	tbl[BPB_Media] = md;					/* Media descriptor */
??f_mkfs_42:
        LDRB     R0,[SP, #+9]
        STRB     R0,[R11, #+21]
// 3712 	ST_WORD(tbl+BPB_SecPerTrk, 63);			/* Number of sectors per track */
        MOVS     R0,#+63
        STRB     R0,[R11, #+24]
        MOVS     R0,#+0
        STRB     R0,[R11, #+25]
// 3713 	ST_WORD(tbl+BPB_NumHeads, 255);			/* Number of heads */
        MOVS     R0,#+255
        STRB     R0,[R11, #+26]
        MOVS     R0,#+0
        STRB     R0,[R11, #+27]
// 3714 	ST_DWORD(tbl+BPB_HiddSec, b_vol);		/* Hidden sectors */
        STRB     R7,[R11, #+28]
        MOVS     R0,R7
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+29]
        LSRS     R0,R7,#+16
        STRB     R0,[R11, #+30]
        LSRS     R0,R7,#+24
        STRB     R0,[R11, #+31]
// 3715 	n = get_fattime();						/* Use current time as VSN */
        BL       get_fattime
        STR      R0,[SP, #+0]
// 3716 	if (fmt == FS_FAT32) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_43
// 3717 		ST_DWORD(tbl+BS_VolID32, n);		/* VSN */
        LDR      R0,[SP, #+0]
        STRB     R0,[R11, #+67]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+68]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R11, #+69]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R11, #+70]
// 3718 		ST_DWORD(tbl+BPB_FATSz32, n_fat);	/* Number of sectors per FAT */
        STRB     R9,[R11, #+36]
        MOV      R0,R9
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+37]
        LSRS     R0,R9,#+16
        STRB     R0,[R11, #+38]
        LSRS     R0,R9,#+24
        STRB     R0,[R11, #+39]
// 3719 		ST_DWORD(tbl+BPB_RootClus, 2);		/* Root directory start cluster (2) */
        MOVS     R0,#+2
        STRB     R0,[R11, #+44]
        MOVS     R0,#+0
        STRB     R0,[R11, #+45]
        MOVS     R0,#+0
        STRB     R0,[R11, #+46]
        MOVS     R0,#+0
        STRB     R0,[R11, #+47]
// 3720 		ST_WORD(tbl+BPB_FSInfo, 1);			/* FSInfo record offset (VBR+1) */
        MOVS     R0,#+1
        STRB     R0,[R11, #+48]
        MOVS     R0,#+0
        STRB     R0,[R11, #+49]
// 3721 		ST_WORD(tbl+BPB_BkBootSec, 6);		/* Backup boot record offset (VBR+6) */
        MOVS     R0,#+6
        STRB     R0,[R11, #+50]
        MOVS     R0,#+0
        STRB     R0,[R11, #+51]
// 3722 		tbl[BS_DrvNum32] = 0x80;			/* Drive number */
        MOVS     R0,#+128
        STRB     R0,[R11, #+64]
// 3723 		tbl[BS_BootSig32] = 0x29;			/* Extended boot signature */
        MOVS     R0,#+41
        STRB     R0,[R11, #+66]
// 3724 		mem_cpy(tbl+BS_VolLab32, "NO NAME    " "FAT32   ", 19);	/* Volume label, FAT signature */
        MOVS     R2,#+19
        LDR.N    R1,??DataTable14_4
        ADDS     R0,R11,#+71
        BL       mem_cpy
        B.N      ??f_mkfs_44
// 3725 	} else {
// 3726 		ST_DWORD(tbl+BS_VolID, n);			/* VSN */
??f_mkfs_43:
        LDR      R0,[SP, #+0]
        STRB     R0,[R11, #+39]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+40]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R11, #+41]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R11, #+42]
// 3727 		ST_WORD(tbl+BPB_FATSz16, n_fat);	/* Number of sectors per FAT */
        STRB     R9,[R11, #+22]
        MOV      R0,R9
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+23]
// 3728 		tbl[BS_DrvNum] = 0x80;				/* Drive number */
        MOVS     R0,#+128
        STRB     R0,[R11, #+36]
// 3729 		tbl[BS_BootSig] = 0x29;				/* Extended boot signature */
        MOVS     R0,#+41
        STRB     R0,[R11, #+38]
// 3730 		mem_cpy(tbl+BS_VolLab, "NO NAME    " "FAT     ", 19);	/* Volume label, FAT signature */
        MOVS     R2,#+19
        LDR.N    R1,??DataTable14_5
        ADDS     R0,R11,#+43
        BL       mem_cpy
// 3731 	}
// 3732 	ST_WORD(tbl+BS_55AA, 0xAA55);			/* Signature (Offset is fixed here regardless of sector size) */
??f_mkfs_44:
        MOVS     R0,#+85
        STRB     R0,[R11, #+510]
        MOVS     R0,#+170
        STRB     R0,[R11, #+511]
// 3733 	if (LPLD_Disk_Write(pdrv, tbl, b_vol, 1) != RES_OK)	/* Write it to the VBR sector */
        MOVS     R3,#+1
        MOVS     R2,R7
        MOV      R1,R11
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_Write
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_45
// 3734 		return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3735 	if (fmt == FS_FAT32)							/* Write backup VBR if needed (VBR+6) */
??f_mkfs_45:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_46
// 3736 		LPLD_Disk_Write(pdrv, tbl, b_vol + 6, 1);
        MOVS     R3,#+1
        ADDS     R2,R7,#+6
        MOV      R1,R11
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_Write
// 3737 
// 3738 	/* Initialize FAT area */
// 3739 	wsect = b_fat;
??f_mkfs_46:
        LDR      R8,[SP, #+20]
// 3740 	for (i = 0; i < N_FATS; i++) {		/* Initialize each FAT copy */
        MOVS     R10,#+0
        B.N      ??f_mkfs_47
??f_mkfs_48:
        ADDS     R10,R10,#+1
??f_mkfs_47:
        CMP      R10,#+0
        BNE.N    ??f_mkfs_49
// 3741 		mem_set(tbl, 0, SS(fs));			/* 1st sector of the FAT  */
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R11
        BL       mem_set
// 3742 		n = md;								/* Media descriptor byte */
        LDRB     R0,[SP, #+9]
        STR      R0,[SP, #+0]
// 3743 		if (fmt != FS_FAT32) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BEQ.N    ??f_mkfs_50
// 3744 			n |= (fmt == FS_FAT12) ? 0x00FFFF00 : 0xFFFFFF00;
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+1
        BNE.N    ??f_mkfs_51
        LDR.N    R0,??DataTable14_6  ;; 0xffff00
        B.N      ??f_mkfs_52
??f_mkfs_51:
        MVNS     R0,#+255
??f_mkfs_52:
        LDR      R1,[SP, #+0]
        ORRS     R0,R0,R1
        STR      R0,[SP, #+0]
// 3745 			ST_DWORD(tbl+0, n);				/* Reserve cluster #0-1 (FAT12/16) */
        LDR      R0,[SP, #+0]
        STRB     R0,[R11, #+0]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+1]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R11, #+2]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R11, #+3]
        B.N      ??f_mkfs_53
// 3746 		} else {
// 3747 			n |= 0xFFFFFF00;
??f_mkfs_50:
        LDR      R0,[SP, #+0]
        ORNS     R0,R0,#+255
        STR      R0,[SP, #+0]
// 3748 			ST_DWORD(tbl+0, n);				/* Reserve cluster #0-1 (FAT32) */
        LDR      R0,[SP, #+0]
        STRB     R0,[R11, #+0]
        LDR      R0,[SP, #+0]
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+1]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+16
        STRB     R0,[R11, #+2]
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+24
        STRB     R0,[R11, #+3]
// 3749 			ST_DWORD(tbl+4, 0xFFFFFFFF);
        MOVS     R0,#+255
        STRB     R0,[R11, #+4]
        MOVS     R0,#+255
        STRB     R0,[R11, #+5]
        MOVS     R0,#+255
        STRB     R0,[R11, #+6]
        MOVS     R0,#+255
        STRB     R0,[R11, #+7]
// 3750 			ST_DWORD(tbl+8, 0x0FFFFFFF);	/* Reserve cluster #2 for root dir */
        MOVS     R0,#+255
        STRB     R0,[R11, #+8]
        MOVS     R0,#+255
        STRB     R0,[R11, #+9]
        MOVS     R0,#+255
        STRB     R0,[R11, #+10]
        MOVS     R0,#+15
        STRB     R0,[R11, #+11]
// 3751 		}
// 3752 		if (LPLD_Disk_Write(pdrv, tbl, wsect++, 1) != RES_OK)
??f_mkfs_53:
        MOVS     R3,#+1
        MOV      R2,R8
        MOV      R1,R11
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_Write
        ADDS     R8,R8,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_54
// 3753 			return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3754 		mem_set(tbl, 0, SS(fs));			/* Fill following FAT entries with zero */
??f_mkfs_54:
        MOV      R2,#+512
        MOVS     R1,#+0
        MOV      R0,R11
        BL       mem_set
// 3755 		for (n = 1; n < n_fat; n++) {		/* This loop may take a time on FAT32 volume due to many single sector writes */
        MOVS     R0,#+1
        STR      R0,[SP, #+0]
        B.N      ??f_mkfs_55
??f_mkfs_56:
        LDR      R0,[SP, #+0]
        ADDS     R0,R0,#+1
        STR      R0,[SP, #+0]
??f_mkfs_55:
        LDR      R0,[SP, #+0]
        CMP      R0,R9
        BCS.N    ??f_mkfs_48
// 3756 			if (LPLD_Disk_Write(pdrv, tbl, wsect++, 1) != RES_OK)
        MOVS     R3,#+1
        MOV      R2,R8
        MOV      R1,R11
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_Write
        ADDS     R8,R8,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_56
// 3757 				return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3758 		}
// 3759 	}
// 3760 
// 3761 	/* Initialize root directory */
// 3762 	i = (fmt == FS_FAT32) ? au : n_dir;
??f_mkfs_49:
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_57
        MOV      R10,R4
        B.N      ??f_mkfs_58
??f_mkfs_57:
        LDR      R10,[SP, #+16]
// 3763 	do {
// 3764 		if (LPLD_Disk_Write(pdrv, tbl, wsect++, 1) != RES_OK)
??f_mkfs_58:
        MOVS     R3,#+1
        MOV      R2,R8
        MOV      R1,R11
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_Write
        ADDS     R8,R8,#+1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??f_mkfs_59
// 3765 			return FR_DISK_ERR;
        MOVS     R0,#+1
        B.N      ??f_mkfs_1
// 3766 	} while (--i);
??f_mkfs_59:
        SUBS     R10,R10,#+1
        CMP      R10,#+0
        BNE.N    ??f_mkfs_58
// 3767 
// 3768 #if _USE_ERASE	/* Erase data area if needed */
// 3769 	{
// 3770 		DWORD eb[2];
// 3771 
// 3772 		eb[0] = wsect; eb[1] = wsect + (n_clst - ((fmt == FS_FAT32) ? 1 : 0)) * au - 1;
// 3773 		LPLD_Disk_IOC(pdrv, CTRL_ERASE_SECTOR, eb);
// 3774 	}
// 3775 #endif
// 3776 
// 3777 	/* Create FSInfo if needed */
// 3778 	if (fmt == FS_FAT32) {
        UXTB     R5,R5            ;; ZeroExt  R5,R5,#+24,#+24
        CMP      R5,#+3
        BNE.N    ??f_mkfs_60
// 3779 		ST_DWORD(tbl+FSI_LeadSig, 0x41615252);
        MOVS     R0,#+82
        STRB     R0,[R11, #+0]
        MOVS     R0,#+82
        STRB     R0,[R11, #+1]
        MOVS     R0,#+97
        STRB     R0,[R11, #+2]
        MOVS     R0,#+65
        STRB     R0,[R11, #+3]
// 3780 		ST_DWORD(tbl+FSI_StrucSig, 0x61417272);
        MOVS     R0,#+114
        STRB     R0,[R11, #+484]
        MOVS     R0,#+114
        STRB     R0,[R11, #+485]
        MOVS     R0,#+65
        STRB     R0,[R11, #+486]
        MOVS     R0,#+97
        STRB     R0,[R11, #+487]
// 3781 		ST_DWORD(tbl+FSI_Free_Count, n_clst - 1);	/* Number of free clusters */
        MOVS     R0,R6
        SUBS     R0,R0,#+1
        STRB     R0,[R11, #+488]
        MOVS     R0,R6
        SUBS     R0,R0,#+1
        UXTH     R0,R0            ;; ZeroExt  R0,R0,#+16,#+16
        LSRS     R0,R0,#+8
        STRB     R0,[R11, #+489]
        SUBS     R0,R6,#+1
        LSRS     R0,R0,#+16
        STRB     R0,[R11, #+490]
        SUBS     R0,R6,#+1
        LSRS     R0,R0,#+24
        STRB     R0,[R11, #+491]
// 3782 		ST_DWORD(tbl+FSI_Nxt_Free, 2);				/* Last allocated cluster# */
        MOVS     R0,#+2
        STRB     R0,[R11, #+492]
        MOVS     R0,#+0
        STRB     R0,[R11, #+493]
        MOVS     R0,#+0
        STRB     R0,[R11, #+494]
        MOVS     R0,#+0
        STRB     R0,[R11, #+495]
// 3783 		ST_WORD(tbl+BS_55AA, 0xAA55);
        MOVS     R0,#+85
        STRB     R0,[R11, #+510]
        MOVS     R0,#+170
        STRB     R0,[R11, #+511]
// 3784 		LPLD_Disk_Write(pdrv, tbl, b_vol + 1, 1);	/* Write original (VBR+1) */
        MOVS     R3,#+1
        ADDS     R2,R7,#+1
        MOV      R1,R11
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_Write
// 3785 		LPLD_Disk_Write(pdrv, tbl, b_vol + 7, 1);	/* Write backup (VBR+7) */
        MOVS     R3,#+1
        ADDS     R2,R7,#+7
        MOV      R1,R11
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_Write
// 3786 	}
// 3787 
// 3788 	return (LPLD_Disk_IOC(pdrv, CTRL_SYNC, 0) == RES_OK) ? FR_OK : FR_DISK_ERR;
??f_mkfs_60:
        MOVS     R2,#+0
        MOVS     R1,#+0
        LDRB     R0,[SP, #+8]
        BL       LPLD_Disk_IOC
        CMP      R0,#+0
        BNE.N    ??f_mkfs_61
        MOVS     R0,#+0
        B.N      ??f_mkfs_62
??f_mkfs_61:
        MOVS     R0,#+1
??f_mkfs_62:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??f_mkfs_1:
        ADD      SP,SP,#+28
        POP      {R4-R11,PC}      ;; return
// 3789 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14:
        DC32     FatFs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_1:
        DC32     ??vst

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_2:
        DC32     ??cst

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_3:
        DC32     `?<Constant "\\353\\376\\220MSDOS5.0">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_4:
        DC32     `?<Constant "NO NAME    FAT32   ">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_5:
        DC32     `?<Constant "NO NAME    FAT     ">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_6:
        DC32     0xffff00

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
??vst:
        DATA
        DC16 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 0
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
??cst:
        DATA
        DC16 32768, 16384, 8192, 4096, 2048, 16384, 8192, 4096, 2048, 1024, 512
        DC8 0, 0
// 3790 
// 3791 
// 3792 #if _MULTI_PARTITION == 2
// 3793 /*-----------------------------------------------------------------------*/
// 3794 /* Divide Physical Drive                                                 */
// 3795 /*-----------------------------------------------------------------------*/
// 3796 
// 3797 FRESULT f_fdisk (
// 3798 	BYTE pdrv,			/* Physical drive number */
// 3799 	const DWORD szt[],	/* Pointer to the size table for each partitions */
// 3800 	void* work			/* Pointer to the working buffer */
// 3801 )
// 3802 {
// 3803 	UINT i, n, sz_cyl, tot_cyl, b_cyl, e_cyl, p_cyl;
// 3804 	BYTE s_hd, e_hd, *p, *buf = (BYTE*)work;
// 3805 	DSTATUS stat;
// 3806 	DWORD sz_disk, sz_part, s_part;
// 3807 
// 3808 
// 3809 	stat = LPLD_Disk_Initialize(pdrv);
// 3810 	if (stat & STA_NOINIT) return FR_NOT_READY;
// 3811 	if (stat & STA_PROTECT) return FR_WRITE_PROTECTED;
// 3812 	if (LPLD_Disk_IOC(pdrv, GET_SECTOR_COUNT, &sz_disk)) return FR_DISK_ERR;
// 3813 
// 3814 	/* Determine CHS in the table regardless of the drive geometry */
// 3815 	for (n = 16; n < 256 && sz_disk / n / 63 > 1024; n *= 2) ;
// 3816 	if (n == 256) n--;
// 3817 	e_hd = n - 1;
// 3818 	sz_cyl = 63 * n;
// 3819 	tot_cyl = sz_disk / sz_cyl;
// 3820 
// 3821 	/* Create partition table */
// 3822 	mem_set(buf, 0, _MAX_SS);
// 3823 	p = buf + MBR_Table; b_cyl = 0;
// 3824 	for (i = 0; i < 4; i++, p += SZ_PTE) {
// 3825 		p_cyl = (szt[i] <= 100) ? (DWORD)tot_cyl * szt[i] / 100 : szt[i] / sz_cyl;
// 3826 		if (!p_cyl) continue;
// 3827 		s_part = (DWORD)sz_cyl * b_cyl;
// 3828 		sz_part = (DWORD)sz_cyl * p_cyl;
// 3829 		if (i == 0) {	/* Exclude first track of cylinder 0 */
// 3830 			s_hd = 1;
// 3831 			s_part += 63; sz_part -= 63;
// 3832 		} else {
// 3833 			s_hd = 0;
// 3834 		}
// 3835 		e_cyl = b_cyl + p_cyl - 1;
// 3836 		if (e_cyl >= tot_cyl) return FR_INVALID_PARAMETER;
// 3837 
// 3838 		/* Set partition table */
// 3839 		p[1] = s_hd;						/* Start head */
// 3840 		p[2] = (BYTE)((b_cyl >> 2) + 1);	/* Start sector */
// 3841 		p[3] = (BYTE)b_cyl;					/* Start cylinder */
// 3842 		p[4] = 0x06;						/* System type (temporary setting) */
// 3843 		p[5] = e_hd;						/* End head */
// 3844 		p[6] = (BYTE)((e_cyl >> 2) + 63);	/* End sector */
// 3845 		p[7] = (BYTE)e_cyl;					/* End cylinder */
// 3846 		ST_DWORD(p + 8, s_part);			/* Start sector in LBA */
// 3847 		ST_DWORD(p + 12, sz_part);			/* Partition size */
// 3848 
// 3849 		/* Next partition */
// 3850 		b_cyl += p_cyl;
// 3851 	}
// 3852 	ST_WORD(p, 0xAA55);
// 3853 
// 3854 	/* Write it to the MBR */
// 3855 	return (LPLD_Disk_Write(pdrv, buf, 0, 1) || LPLD_Disk_IOC(pdrv, CTRL_SYNC, 0)) ? FR_DISK_ERR : FR_OK;
// 3856 }
// 3857 
// 3858 
// 3859 #endif /* _MULTI_PARTITION == 2 */
// 3860 #endif /* _USE_MKFS && !_FS_READONLY */
// 3861 
// 3862 
// 3863 
// 3864 
// 3865 #if _USE_STRFUNC
// 3866 /*-----------------------------------------------------------------------*/
// 3867 /* Get a string from the file                                            */
// 3868 /*-----------------------------------------------------------------------*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3869 TCHAR* f_gets (
// 3870 	TCHAR* buff,	/* Pointer to the string buffer to read */
// 3871 	int len,		/* Size of string buffer (characters) */
// 3872 	FIL* fil		/* Pointer to the file object */
// 3873 )
// 3874 {
f_gets:
        PUSH     {R2-R8,LR}
        MOVS     R4,R0
        MOVS     R7,R1
        MOV      R8,R2
// 3875 	int n = 0;
        MOVS     R5,#+0
// 3876 	TCHAR c, *p = buff;
        MOVS     R6,R4
        B.N      ??f_gets_0
// 3877 	BYTE s[2];
// 3878 	UINT rc;
// 3879 
// 3880 
// 3881 	while (n < len - 1) {			/* Read bytes until buffer gets filled */
// 3882 		f_read(fil, s, 1, &rc);
// 3883 		if (rc != 1) break;			/* Break on EOF or error */
// 3884 		c = s[0];
// 3885 #if _LFN_UNICODE					/* Read a character in UTF-8 encoding */
// 3886 		if (c >= 0x80) {
// 3887 			if (c < 0xC0) continue;	/* Skip stray trailer */
// 3888 			if (c < 0xE0) {			/* Two-byte sequense */
// 3889 				f_read(fil, s, 1, &rc);
// 3890 				if (rc != 1) break;
// 3891 				c = ((c & 0x1F) << 6) | (s[0] & 0x3F);
// 3892 				if (c < 0x80) c = '?';
// 3893 			} else {
// 3894 				if (c < 0xF0) {		/* Three-byte sequense */
// 3895 					f_read(fil, s, 2, &rc);
// 3896 					if (rc != 2) break;
// 3897 					c = (c << 12) | ((s[0] & 0x3F) << 6) | (s[1] & 0x3F);
// 3898 					if (c < 0x800) c = '?';
// 3899 				} else {			/* Reject four-byte sequense */
// 3900 					c = '?';
// 3901 				}
// 3902 			}
// 3903 		}
// 3904 #endif
// 3905 #if _USE_STRFUNC >= 2
// 3906 		if (c == '\r') continue;	/* Strip '\r' */
??f_gets_1:
??f_gets_0:
        SUBS     R0,R7,#+1
        CMP      R5,R0
        BGE.N    ??f_gets_2
        ADD      R3,SP,#+0
        MOVS     R2,#+1
        ADD      R1,SP,#+4
        MOV      R0,R8
        BL       f_read
        LDR      R0,[SP, #+0]
        CMP      R0,#+1
        BNE.N    ??f_gets_2
??f_gets_3:
        LDRB     R0,[SP, #+4]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+13
        BEQ.N    ??f_gets_1
// 3907 #endif
// 3908 		*p++ = c;
        STRB     R0,[R6, #+0]
        ADDS     R6,R6,#+1
// 3909 		n++;
        ADDS     R5,R5,#+1
// 3910 		if (c == '\n') break;		/* Break on EOL */
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+10
        BNE.N    ??f_gets_0
// 3911 	}
// 3912 	*p = 0;
??f_gets_2:
        MOVS     R0,#+0
        STRB     R0,[R6, #+0]
// 3913 	return n ? buff : 0;			/* When no data read (eof or error), return with error. */
        CMP      R5,#+0
        BNE.N    ??f_gets_4
??f_gets_5:
        MOVS     R4,#+0
??f_gets_4:
        MOVS     R0,R4
        POP      {R1,R2,R4-R8,PC}  ;; return
// 3914 }
// 3915 
// 3916 
// 3917 
// 3918 #if !_FS_READONLY
// 3919 #include <stdarg.h>
// 3920 /*-----------------------------------------------------------------------*/
// 3921 /* Put a character to the file                                           */
// 3922 /*-----------------------------------------------------------------------*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3923 int f_putc (
// 3924 	TCHAR c,	/* A character to be output */
// 3925 	FIL* fil	/* Pointer to the file object */
// 3926 )
// 3927 {
f_putc:
        PUSH     {R4,R5,LR}
        SUB      SP,SP,#+12
        MOVS     R4,R0
        MOVS     R5,R1
// 3928 	UINT bw, btw;
// 3929 	BYTE s[3];
// 3930 
// 3931 
// 3932 #if _USE_STRFUNC >= 2
// 3933 	if (c == '\n') f_putc ('\r', fil);	/* LF -> CRLF conversion */
        UXTB     R4,R4            ;; ZeroExt  R4,R4,#+24,#+24
        CMP      R4,#+10
        BNE.N    ??f_putc_0
        MOVS     R1,R5
        MOVS     R0,#+13
        BL       f_putc
// 3934 #endif
// 3935 
// 3936 #if _LFN_UNICODE	/* Write the character in UTF-8 encoding */
// 3937 	if (c < 0x80) {			/* 7-bit */
// 3938 		s[0] = (BYTE)c;
// 3939 		btw = 1;
// 3940 	} else {
// 3941 		if (c < 0x800) {	/* 11-bit */
// 3942 			s[0] = (BYTE)(0xC0 | (c >> 6));
// 3943 			s[1] = (BYTE)(0x80 | (c & 0x3F));
// 3944 			btw = 2;
// 3945 		} else {			/* 16-bit */
// 3946 			s[0] = (BYTE)(0xE0 | (c >> 12));
// 3947 			s[1] = (BYTE)(0x80 | ((c >> 6) & 0x3F));
// 3948 			s[2] = (BYTE)(0x80 | (c & 0x3F));
// 3949 			btw = 3;
// 3950 		}
// 3951 	}
// 3952 #else				/* Write the character without conversion */
// 3953 	s[0] = (BYTE)c;
??f_putc_0:
        STRB     R4,[SP, #+0]
// 3954 	btw = 1;
        MOVS     R4,#+1
// 3955 #endif
// 3956 	f_write(fil, s, btw, &bw);		/* Write the char to the file */
        ADD      R3,SP,#+4
        MOVS     R2,R4
        ADD      R1,SP,#+0
        MOVS     R0,R5
        BL       f_write
// 3957 	return (bw == btw) ? 1 : EOF;	/* Return the result */
        LDR      R0,[SP, #+4]
        CMP      R0,R4
        BNE.N    ??f_putc_1
        MOVS     R0,#+1
        B.N      ??f_putc_2
??f_putc_1:
        MOVS     R0,#-1
??f_putc_2:
        POP      {R1-R5,PC}       ;; return
// 3958 }
// 3959 
// 3960 
// 3961 
// 3962 
// 3963 /*-----------------------------------------------------------------------*/
// 3964 /* Put a string to the file                                              */
// 3965 /*-----------------------------------------------------------------------*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3966 int f_puts (
// 3967 	const TCHAR* str,	/* Pointer to the string to be output */
// 3968 	FIL* fil			/* Pointer to the file object */
// 3969 )
// 3970 {
f_puts:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
// 3971 	int n;
// 3972 
// 3973 
// 3974 	for (n = 0; *str; str++, n++) {
        MOVS     R6,#+0
        B.N      ??f_puts_0
??f_puts_1:
        ADDS     R4,R4,#+1
        ADDS     R6,R6,#+1
??f_puts_0:
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BEQ.N    ??f_puts_2
// 3975 		if (f_putc(*str, fil) == EOF) return EOF;
        MOVS     R1,R5
        LDRB     R0,[R4, #+0]
        BL       f_putc
        CMN      R0,#+1
        BNE.N    ??f_puts_1
        MOVS     R0,#-1
        B.N      ??f_puts_3
// 3976 	}
// 3977 	return n;
??f_puts_2:
        MOVS     R0,R6
??f_puts_3:
        POP      {R4-R6,PC}       ;; return
// 3978 }
// 3979 
// 3980 
// 3981 
// 3982 
// 3983 /*-----------------------------------------------------------------------*/
// 3984 /* Put a formatted string to the file                                    */
// 3985 /*-----------------------------------------------------------------------*/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 3986 int f_printf (
// 3987 	FIL* fil,			/* Pointer to the file object */
// 3988 	const TCHAR* str,	/* Pointer to the format string */
// 3989 	...					/* Optional arguments... */
// 3990 )
// 3991 {
f_printf:
        PUSH     {R0,R2,R3}
        PUSH     {R0-R11,LR}
        MOVS     R5,R1
// 3992 	va_list arp;
// 3993 	BYTE f, r;
// 3994 	UINT i, j, w;
// 3995 	ULONG v;
// 3996 	TCHAR c, d, s[16], *p;
// 3997 	int res, chc, cc;
// 3998 
// 3999 
// 4000 	va_start(arp, str);
        ADD      R7,SP,#+56
// 4001 
// 4002 	for (cc = res = 0; cc != EOF; res += cc) {
        MOVS     R0,#+0
        MOVS     R4,R0
        B.N      ??f_printf_0
// 4003 		c = *str++;
// 4004 		if (c == 0) break;			/* End of string */
// 4005 		if (c != '%') {				/* Non escape character */
// 4006 			cc = f_putc(c, fil);
// 4007 			if (cc != EOF) cc = 1;
// 4008 			continue;
// 4009 		}
// 4010 		w = f = 0;
// 4011 		c = *str++;
// 4012 		if (c == '0') {				/* Flag: '0' padding */
// 4013 			f = 1; c = *str++;
// 4014 		} else {
// 4015 			if (c == '-') {			/* Flag: left justified */
// 4016 				f = 2; c = *str++;
// 4017 			}
// 4018 		}
// 4019 		while (IsDigit(c)) {		/* Precision */
// 4020 			w = w * 10 + c - '0';
// 4021 			c = *str++;
// 4022 		}
// 4023 		if (c == 'l' || c == 'L') {	/* Prefix: Size is long int */
// 4024 			f |= 4; c = *str++;
// 4025 		}
// 4026 		if (!c) break;
// 4027 		d = c;
// 4028 		if (IsLower(d)) d -= 0x20;
// 4029 		switch (d) {				/* Type is... */
// 4030 		case 'S' :					/* String */
// 4031 			p = va_arg(arp, TCHAR*);
// 4032 			for (j = 0; p[j]; j++) ;
// 4033 			chc = 0;
// 4034 			if (!(f & 2)) {
// 4035 				while (j++ < w) chc += (cc = f_putc(' ', fil));
// 4036 			}
// 4037 			chc += (cc = f_puts(p, fil));
// 4038 			while (j++ < w) chc += (cc = f_putc(' ', fil));
// 4039 			if (cc != EOF) cc = chc;
// 4040 			continue;
// 4041 		case 'C' :					/* Character */
// 4042 			cc = f_putc((TCHAR)va_arg(arp, int), fil); continue;
// 4043 		case 'B' :					/* Binary */
// 4044 			r = 2; break;
// 4045 		case 'O' :					/* Octal */
// 4046 			r = 8; break;
// 4047 		case 'D' :					/* Signed decimal */
// 4048 		case 'U' :					/* Unsigned decimal */
// 4049 			r = 10; break;
// 4050 		case 'X' :					/* Hexdecimal */
// 4051 			r = 16; break;
// 4052 		default:					/* Unknown type (passthrough) */
// 4053 			cc = f_putc(c, fil); continue;
// 4054 		}
// 4055 
// 4056 		/* Get an argument and put it in numeral */
// 4057 		v = (f & 4) ? (ULONG)va_arg(arp, long) : ((d == 'D') ? (ULONG)(long)va_arg(arp, int) : (ULONG)va_arg(arp, unsigned int));
// 4058 		if (d == 'D' && (v & 0x80000000)) {
// 4059 			v = 0 - v;
// 4060 			f |= 8;
// 4061 		}
// 4062 		i = 0;
// 4063 		do {
// 4064 			d = (TCHAR)(v % r); v /= r;
// 4065 			if (d > 9) d += (c == 'x') ? 0x27 : 0x07;
// 4066 			s[i++] = d + '0';
// 4067 		} while (v && i < sizeof(s) / sizeof(s[0]));
// 4068 		if (f & 8) s[i++] = '-';
// 4069 		j = i; d = (f & 1) ? '0' : ' ';
// 4070 		res = 0;
// 4071 		while (!(f & 2) && j++ < w) res += (cc = f_putc(d, fil));
// 4072 		do res += (cc = f_putc(s[--i], fil)); while(i);
// 4073 		while (j++ < w) res += (cc = f_putc(' ', fil));
// 4074 		if (cc != EOF) cc = res;
??f_printf_1:
        CMN      R0,#+1
        BEQ.N    ??f_printf_2
        MOVS     R0,R4
??f_printf_2:
        ADDS     R4,R0,R4
??f_printf_0:
        CMN      R0,#+1
        BEQ.N    ??f_printf_3
        LDRB     R2,[R5, #+0]
        ADDS     R5,R5,#+1
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??f_printf_4
// 4075 	}
// 4076 
// 4077 	va_end(arp);
// 4078 	return (cc == EOF) ? cc : res;
??f_printf_3:
        CMN      R0,#+1
        BNE.W    ??f_printf_5
        B.N      ??f_printf_6
??f_printf_4:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+37
        BEQ.N    ??f_printf_7
        LDR      R1,[SP, #+52]
        MOVS     R0,R2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        CMN      R0,#+1
        BEQ.N    ??f_printf_8
        MOVS     R0,#+1
??f_printf_8:
        B.N      ??f_printf_2
??f_printf_7:
        MOVS     R6,#+0
        MOV      R8,R6
        UXTB     R6,R6            ;; ZeroExt  R6,R6,#+24,#+24
        LDRB     R2,[R5, #+0]
        ADDS     R5,R5,#+1
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+48
        BNE.N    ??f_printf_9
        MOVS     R8,#+1
        LDRB     R2,[R5, #+0]
        ADDS     R5,R5,#+1
        B.N      ??f_printf_10
??f_printf_9:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+45
        BNE.N    ??f_printf_10
        MOVS     R8,#+2
        LDRB     R2,[R5, #+0]
        ADDS     R5,R5,#+1
        B.N      ??f_printf_10
??f_printf_11:
        MOVS     R1,#+10
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MLA      R1,R1,R6,R2
        SUBS     R6,R1,#+48
        LDRB     R2,[R5, #+0]
        ADDS     R5,R5,#+1
??f_printf_10:
        SUBS     R1,R2,#+48
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+10
        BCC.N    ??f_printf_11
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+108
        BEQ.N    ??f_printf_12
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+76
        BNE.N    ??f_printf_13
??f_printf_12:
        ORRS     R8,R8,#0x4
        LDRB     R2,[R5, #+0]
        ADDS     R5,R5,#+1
??f_printf_13:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BEQ.N    ??f_printf_3
??f_printf_14:
        MOV      R11,R2
        SUBS     R0,R11,#+97
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+26
        BCS.N    ??f_printf_15
        SUBS     R11,R11,#+32
??f_printf_15:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        MOV      R0,R11
        CMP      R0,#+66
        BEQ.N    ??f_printf_16
        CMP      R0,#+67
        BEQ.N    ??f_printf_17
        CMP      R0,#+68
        BEQ.N    ??f_printf_18
        CMP      R0,#+79
        BEQ.N    ??f_printf_19
        CMP      R0,#+83
        BEQ.N    ??f_printf_20
        CMP      R0,#+85
        BEQ.N    ??f_printf_18
        CMP      R0,#+88
        BEQ.N    ??f_printf_21
        B.N      ??f_printf_22
??f_printf_20:
        LDR      R10,[R7, #+0]
        ADDS     R7,R7,#+4
        MOVS     R9,#+0
        B.N      ??f_printf_23
??f_printf_24:
        ADDS     R9,R9,#+1
??f_printf_23:
        LDRB     R0,[R9, R10]
        CMP      R0,#+0
        BNE.N    ??f_printf_24
        MOVS     R11,#+0
        LSLS     R0,R8,#+30
        BMI.N    ??f_printf_25
        B.N      ??f_printf_26
??f_printf_27:
        LDR      R1,[SP, #+52]
        MOVS     R0,#+32
        BL       f_putc
        ADDS     R11,R0,R11
??f_printf_26:
        MOV      R0,R9
        ADDS     R9,R0,#+1
        CMP      R0,R6
        BCC.N    ??f_printf_27
??f_printf_25:
        LDR      R1,[SP, #+52]
        MOV      R0,R10
        BL       f_puts
        ADDS     R11,R0,R11
        B.N      ??f_printf_28
??f_printf_29:
        LDR      R1,[SP, #+52]
        MOVS     R0,#+32
        BL       f_putc
        ADDS     R11,R0,R11
??f_printf_28:
        MOV      R1,R9
        ADDS     R9,R1,#+1
        CMP      R1,R6
        BCC.N    ??f_printf_29
        CMN      R0,#+1
        BEQ.N    ??f_printf_30
        MOV      R0,R11
??f_printf_30:
        B.N      ??f_printf_2
??f_printf_17:
        MOVS     R0,R7
        ADDS     R7,R0,#+4
        LDR      R1,[SP, #+52]
        LDR      R0,[R0, #+0]
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        B.N      ??f_printf_2
??f_printf_16:
        MOVS     R0,#+2
??f_printf_31:
        LSLS     R1,R8,#+29
        BPL.N    ??f_printf_32
        LDR      R1,[R7, #+0]
        ADDS     R7,R7,#+4
        B.N      ??f_printf_33
??f_printf_19:
        MOVS     R0,#+8
        B.N      ??f_printf_31
??f_printf_18:
        MOVS     R0,#+10
        B.N      ??f_printf_31
??f_printf_21:
        MOVS     R0,#+16
        B.N      ??f_printf_31
??f_printf_22:
        LDR      R1,[SP, #+52]
        MOVS     R0,R2
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        B.N      ??f_printf_2
??f_printf_32:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+68
        BNE.N    ??f_printf_34
        LDR      R1,[R7, #+0]
        ADDS     R7,R7,#+4
        B.N      ??f_printf_33
??f_printf_34:
        LDR      R1,[R7, #+0]
        ADDS     R7,R7,#+4
??f_printf_33:
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+68
        BNE.N    ??f_printf_35
        CMP      R1,#+0
        BPL.N    ??f_printf_35
        RSBS     R1,R1,#+0
        ORRS     R8,R8,#0x8
??f_printf_35:
        MOVS     R10,#+0
??f_printf_36:
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UDIV     R3,R1,R0
        MLS      R11,R0,R3,R1
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        UDIV     R1,R1,R0
        UXTB     R11,R11          ;; ZeroExt  R11,R11,#+24,#+24
        CMP      R11,#+10
        BCC.N    ??f_printf_37
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+120
        BNE.N    ??f_printf_38
        MOVS     R3,#+39
        B.N      ??f_printf_39
??f_printf_38:
        MOVS     R3,#+7
??f_printf_39:
        ADDS     R11,R3,R11
??f_printf_37:
        ADD      R3,SP,#+0
        ADDS     R4,R11,#+48
        STRB     R4,[R10, R3]
        ADDS     R10,R10,#+1
        CMP      R1,#+0
        BEQ.N    ??f_printf_40
        CMP      R10,#+16
        BCC.N    ??f_printf_36
??f_printf_40:
        LSLS     R0,R8,#+28
        BPL.N    ??f_printf_41
        ADD      R0,SP,#+0
        MOVS     R1,#+45
        STRB     R1,[R10, R0]
        ADDS     R10,R10,#+1
??f_printf_41:
        MOV      R9,R10
        LSLS     R0,R8,#+31
        BPL.N    ??f_printf_42
        MOVS     R11,#+48
        B.N      ??f_printf_43
??f_printf_42:
        MOVS     R11,#+32
??f_printf_43:
        MOVS     R4,#+0
        B.N      ??f_printf_44
??f_printf_45:
        LDR      R1,[SP, #+52]
        MOV      R0,R11
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        BL       f_putc
        ADDS     R4,R0,R4
??f_printf_44:
        LSLS     R0,R8,#+30
        BMI.N    ??f_printf_46
        MOV      R0,R9
        ADDS     R9,R0,#+1
        CMP      R0,R6
        BCC.N    ??f_printf_45
??f_printf_46:
        SUBS     R10,R10,#+1
        LDR      R1,[SP, #+52]
        ADD      R0,SP,#+0
        LDRB     R0,[R10, R0]
        BL       f_putc
        ADDS     R4,R0,R4
        CMP      R10,#+0
        BNE.N    ??f_printf_46
??f_printf_47:
        MOV      R1,R9
        ADDS     R9,R1,#+1
        CMP      R1,R6
        BCS.W    ??f_printf_1
        LDR      R1,[SP, #+52]
        MOVS     R0,#+32
        BL       f_putc
        ADDS     R4,R0,R4
        B.N      ??f_printf_47
??f_printf_5:
        MOVS     R0,R4
??f_printf_6:
        ADD      SP,SP,#+16
        POP      {R4-R11}
        LDR      PC,[SP], #+16    ;; return
// 4079 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 4080 
// 4081 #endif /* !_FS_READONLY */
// 4082 #endif /* _USE_STRFUNC */
// 
//    103 bytes in section .bss
//    264 bytes in section .rodata
// 14 060 bytes in section .text
// 
// 14 060 bytes of CODE  memory
//    264 bytes of CONST memory
//    103 bytes of DATA  memory
//
//Errors: none
//Warnings: 1
