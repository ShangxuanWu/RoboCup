///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    06/Jul/2014  14:13:53 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  F:\robot _init\robot\lib\LPLD\FML_DiskIO.c              /
//    Command line =  "F:\robot _init\robot\lib\LPLD\FML_DiskIO.c" -D IAR -D  /
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
//                    st\FML_DiskIO.s                                         /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME FML_DiskIO

        #define SHT_PROGBITS 0x1

        EXTERN LPLD_SDHC_InitCard
        EXTERN LPLD_SDHC_ReadBlocks
        EXTERN LPLD_SDHC_WriteBlocks
        EXTERN sdcard_ptr

        PUBLIC LPLD_Disk_IOC
        PUBLIC LPLD_Disk_Initialize
        PUBLIC LPLD_Disk_Read
        PUBLIC LPLD_Disk_Status
        PUBLIC LPLD_Disk_Write

// F:\robot _init\robot\lib\LPLD\FML_DiskIO.c
//    1 /*
//    2  * --------------"拉普兰德K60底层库"-----------------
//    3  *
//    4  * 测试硬件平台:LPLD_K60 Card
//    5  * 版权所有:北京拉普兰德电子技术有限公司
//    6  * 网络销售:http://laplenden.taobao.com
//    7  * 公司门户:http://www.lpld.cn
//    8  *
//    9  * 文件名: FML_DiskIO.c
//   10  * 用途: 磁盘底层模块相关函数，需调用SDHC底层驱动
//   11  * 最后修改日期: 20130214
//   12  *
//   13  * 开发者使用协议:
//   14  *  本代码面向所有使用者开放源代码，开发者可以随意修改源代码。但本段及以上注释应
//   15  *  予以保留，不得更改或删除原版权所有者姓名。二次开发者可以加注二次版权所有者，
//   16  *  但应在遵守此协议的基础上，开放源代码、不得出售代码本身。
//   17  */
//   18 
//   19 #include "common.h"
//   20 #include "HAL_SDHC.h"
//   21 #include "FML_DiskIO.h"
//   22 
//   23 extern SDCARD_STRUCT_PTR        sdcard_ptr;
//   24 
//   25 /******************************************************************************
//   26 *
//   27 *   公共函数
//   28 *
//   29 ******************************************************************************/
//   30 
//   31 
//   32 /*
//   33  * LPLD_Disk_Initialize
//   34  * 磁盘初始化
//   35  * 
//   36  * 参数:
//   37  *    drv--物理磁盘号，只能为0
//   38  *
//   39  * 输出:
//   40  *    RES_OK--成功
//   41  *    RES_ERROR--读/写错误
//   42  *    RES_WRPRT--写保护
//   43  *    RES_NOTRDY--未准备好
//   44  *    RES_PARERR--参数错误
//   45  *    RES_NONRSPNS--未响应 
//   46  */
//   47 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   48 DSTATUS LPLD_Disk_Initialize(uint8 drv)
//   49 {
LPLD_Disk_Initialize:
        PUSH     {R7,LR}
//   50   if(drv)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LPLD_Disk_Initialize_0
//   51     return RES_PARERR;
        MOVS     R0,#+4
        B.N      ??LPLD_Disk_Initialize_1
//   52  
//   53   return LPLD_SDHC_InitCard();
??LPLD_Disk_Initialize_0:
        BL       LPLD_SDHC_InitCard
??LPLD_Disk_Initialize_1:
        POP      {R1,PC}          ;; return
//   54 }
//   55 
//   56 /*
//   57  * LPLD_Disk_Status
//   58  * 返回磁盘状态
//   59  * 
//   60  * 参数:
//   61  *    drv--物理磁盘号，只能为0
//   62  *
//   63  * 输出:
//   64  *    RES_OK--成功
//   65  *    RES_ERROR--读/写错误
//   66  *    RES_WRPRT--写保护
//   67  *    RES_NOTRDY--未准备好
//   68  *    RES_PARERR--参数错误
//   69  *    RES_NONRSPNS--未响应 
//   70  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   71 DSTATUS LPLD_Disk_Status(uint8 drv)
//   72 {
//   73   return sdcard_ptr->STATUS;
LPLD_Disk_Status:
        LDR.N    R0,??DataTable1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+20]
        BX       LR               ;; return
//   74 }
//   75 
//   76 
//   77 /*
//   78  * LPLD_Disk_Read
//   79  * 读磁盘的一个或多个扇区
//   80  * 
//   81  * 参数:
//   82  *    drv--物理磁盘号，只能为0
//   83  *    buff--数据读出所存的地址指针
//   84  *    sector--扇区起始号
//   85  *    count--所读的扇区数
//   86  *
//   87  * 输出:
//   88  *    RES_OK--成功
//   89  *    RES_ERROR--读/写错误
//   90  *    RES_WRPRT--写保护
//   91  *    RES_NOTRDY--未准备好
//   92  *    RES_PARERR--参数错误
//   93  *    RES_NONRSPNS--未响应 
//   94  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   95 DRESULT LPLD_Disk_Read(uint8 drv, uint8* buff, uint32 sector, uint8 count)
//   96 {
LPLD_Disk_Read:
        PUSH     {R4,LR}
        MOVS     R4,R1
        MOVS     R1,R2
        MOVS     R2,R3
//   97   if(drv || (count == 0))
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_Disk_Read_0
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??LPLD_Disk_Read_1
//   98     return RES_PARERR;
??LPLD_Disk_Read_0:
        MOVS     R0,#+4
        B.N      ??LPLD_Disk_Read_2
//   99 
//  100   return LPLD_SDHC_ReadBlocks(buff, sector, count);
??LPLD_Disk_Read_1:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R0,R4
        BL       LPLD_SDHC_ReadBlocks
??LPLD_Disk_Read_2:
        POP      {R4,PC}          ;; return
//  101 }
//  102 
//  103 //如果磁盘系统为只读，则不编译以下函数
//  104 #if	_READONLY == 0
//  105 /*
//  106  * LPLD_Disk_Write
//  107  * 写磁盘的一个或多个扇区
//  108  * 
//  109  * 参数:
//  110  *    drv--物理磁盘号，只能为0
//  111  *    buff--数据读出所存的地址指针
//  112  *    sector--扇区起始号
//  113  *    count--所读的扇区数
//  114  *
//  115  * 输出:
//  116  *    RES_OK--成功
//  117  *    RES_ERROR--读/写错误
//  118  *    RES_WRPRT--写保护
//  119  *    RES_NOTRDY--未准备好
//  120  *    RES_PARERR--参数错误
//  121  *    RES_NONRSPNS--未响应 
//  122  */
//  123 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  124 DRESULT LPLD_Disk_Write(uint8 drv, const uint8* buff, uint32 sector, uint8 count)
//  125 {
LPLD_Disk_Write:
        PUSH     {R4,LR}
        MOVS     R4,R1
        MOVS     R1,R2
        MOVS     R2,R3
//  126   if(drv || (count == 0))
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BNE.N    ??LPLD_Disk_Write_0
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        CMP      R2,#+0
        BNE.N    ??LPLD_Disk_Write_1
//  127     return RES_PARERR;
??LPLD_Disk_Write_0:
        MOVS     R0,#+4
        B.N      ??LPLD_Disk_Write_2
//  128   
//  129   return LPLD_SDHC_WriteBlocks((uint8*)buff, sector, count);
??LPLD_Disk_Write_1:
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        MOVS     R0,R4
        BL       LPLD_SDHC_WriteBlocks
??LPLD_Disk_Write_2:
        POP      {R4,PC}          ;; return
//  130 }
//  131 #endif
//  132 
//  133 
//  134 /*
//  135  * LPLD_Disk_IOC
//  136  * 磁盘功能控制函数
//  137  * 
//  138  * 参数:
//  139  *    drv--物理磁盘号，只能为0
//  140  *    ctrl--控制命令
//  141  *    buff--IO操作所需数据的指针
//  142  *
//  143  * 输出:
//  144  *    RES_OK--成功
//  145  *    RES_ERROR--读/写错误
//  146  *    RES_WRPRT--写保护
//  147  *    RES_NOTRDY--未准备好
//  148  *    RES_PARERR--参数错误
//  149  *    RES_NONRSPNS--未响应 
//  150  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  151 DRESULT LPLD_Disk_IOC(uint8 drv, uint8 ctrl, void* buff)
//  152 {
//  153   DRESULT result = RES_OK;
LPLD_Disk_IOC:
        MOVS     R3,#+0
//  154   
//  155   if(drv)
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        CMP      R0,#+0
        BEQ.N    ??LPLD_Disk_IOC_0
//  156     return RES_PARERR;
        MOVS     R0,#+4
        B.N      ??LPLD_Disk_IOC_1
//  157   
//  158   
//  159   
//  160   switch(ctrl)
??LPLD_Disk_IOC_0:
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        CMP      R1,#+0
        BEQ.N    ??LPLD_Disk_IOC_2
        CMP      R1,#+2
        BEQ.N    ??LPLD_Disk_IOC_3
        BCC.N    ??LPLD_Disk_IOC_4
        CMP      R1,#+4
        BEQ.N    ??LPLD_Disk_IOC_5
        BCC.N    ??LPLD_Disk_IOC_6
        B.N      ??LPLD_Disk_IOC_7
//  161   {
//  162     case CTRL_SYNC:
//  163       /*
//  164       确定磁盘驱动已经完成写操作挂起的处理. 
//  165       当磁盘IO模块有一个会写缓存，会立即擦除扇区. 该命令不能再只读模式使用.
//  166       */
//  167       // 在POLLING模式中，所有写操作已完成。
//  168       break;
//  169     case GET_SECTOR_SIZE:
//  170       /*
//  171       以WORD型指针变量的形式返回扇区大小.
//  172       此命令不能用在可变扇区大小的配置, 
//  173       _MAX_SS 为 512.
//  174       */
//  175       if(buff == NULL)
//  176         result = RES_PARERR;
//  177       else
//  178         *(uint32*)buff = IO_SDCARD_BLOCK_SIZE;
//  179       
//  180       break;
//  181     case GET_SECTOR_COUNT:
//  182       /*
//  183       以UINT32型指针变量的形式返回磁盘的可用扇区数. 
//  184       该命令仅被f_mkfs函数调用以决定可创建多大的卷. 
//  185       */
//  186       if(buff == NULL)
//  187         result = RES_PARERR;
//  188       else
//  189         *(uint32*)buff = sdcard_ptr->NUM_BLOCKS;
//  190       break;
//  191     case GET_BLOCK_SIZE:
//  192       /*
//  193       以UINT32类型的指针变量返回返回flash内存中擦除的扇区数.
//  194       合法的数值为2的1至32768次方.
//  195       返回1代表擦除大小或磁盘设备未知.
//  196       该命令仅被f_mkfs函数调用并试图将擦除的扇区边界进行数据对齐.
//  197       */
//  198       result = RES_PARERR;
//  199       break;
//  200     case CTRL_ERASE_SECTOR:
//  201       /*
//  202       擦除由UINT32类型指针数组指定的flash内存,{<start sector>, <end sector>}.
//  203       如果介质为非flash内存,则该命令无效.
//  204       FatFs系统不会检查结果,如果擦除失败也不会影响文件函数.
//  205       当_USE_ERASE为1时移动一个簇链会调用此命令.
//  206       */
//  207       result = RES_PARERR;
//  208       break;
//  209     default:
//  210       return RES_PARERR;
//  211     
//  212   }
//  213     
//  214 
//  215 
//  216 
//  217   return result;
??LPLD_Disk_IOC_2:
??LPLD_Disk_IOC_8:
        MOVS     R0,R3
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
??LPLD_Disk_IOC_1:
        BX       LR               ;; return
??LPLD_Disk_IOC_3:
        CMP      R2,#+0
        BNE.N    ??LPLD_Disk_IOC_9
        MOVS     R3,#+4
        B.N      ??LPLD_Disk_IOC_10
??LPLD_Disk_IOC_9:
        MOV      R0,#+512
        STR      R0,[R2, #+0]
??LPLD_Disk_IOC_10:
        B.N      ??LPLD_Disk_IOC_8
??LPLD_Disk_IOC_4:
        CMP      R2,#+0
        BNE.N    ??LPLD_Disk_IOC_11
        MOVS     R3,#+4
        B.N      ??LPLD_Disk_IOC_12
??LPLD_Disk_IOC_11:
        LDR.N    R0,??DataTable1
        LDR      R0,[R0, #+0]
        LDR      R0,[R0, #+4]
        STR      R0,[R2, #+0]
??LPLD_Disk_IOC_12:
        B.N      ??LPLD_Disk_IOC_8
??LPLD_Disk_IOC_6:
        MOVS     R3,#+4
        B.N      ??LPLD_Disk_IOC_8
??LPLD_Disk_IOC_5:
        MOVS     R3,#+4
        B.N      ??LPLD_Disk_IOC_8
??LPLD_Disk_IOC_7:
        MOVS     R0,#+4
        B.N      ??LPLD_Disk_IOC_1
//  218 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     sdcard_ptr

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  219 
// 
// 182 bytes in section .text
// 
// 182 bytes of CODE memory
//
//Errors: none
//Warnings: none
