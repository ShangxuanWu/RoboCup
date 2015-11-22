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
//    2  * --------------"��������K60�ײ��"-----------------
//    3  *
//    4  * ����Ӳ��ƽ̨:LPLD_K60 Card
//    5  * ��Ȩ����:�����������µ��Ӽ������޹�˾
//    6  * ��������:http://laplenden.taobao.com
//    7  * ��˾�Ż�:http://www.lpld.cn
//    8  *
//    9  * �ļ���: FML_DiskIO.c
//   10  * ��;: ���̵ײ�ģ����غ����������SDHC�ײ�����
//   11  * ����޸�����: 20130214
//   12  *
//   13  * ������ʹ��Э��:
//   14  *  ��������������ʹ���߿���Դ���룬�����߿��������޸�Դ���롣�����μ�����ע��Ӧ
//   15  *  ���Ա��������ø��Ļ�ɾ��ԭ��Ȩ���������������ο����߿��Լ�ע���ΰ�Ȩ�����ߣ�
//   16  *  ��Ӧ�����ش�Э��Ļ����ϣ�����Դ���롢���ó��۴��뱾��
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
//   27 *   ��������
//   28 *
//   29 ******************************************************************************/
//   30 
//   31 
//   32 /*
//   33  * LPLD_Disk_Initialize
//   34  * ���̳�ʼ��
//   35  * 
//   36  * ����:
//   37  *    drv--������̺ţ�ֻ��Ϊ0
//   38  *
//   39  * ���:
//   40  *    RES_OK--�ɹ�
//   41  *    RES_ERROR--��/д����
//   42  *    RES_WRPRT--д����
//   43  *    RES_NOTRDY--δ׼����
//   44  *    RES_PARERR--��������
//   45  *    RES_NONRSPNS--δ��Ӧ 
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
//   58  * ���ش���״̬
//   59  * 
//   60  * ����:
//   61  *    drv--������̺ţ�ֻ��Ϊ0
//   62  *
//   63  * ���:
//   64  *    RES_OK--�ɹ�
//   65  *    RES_ERROR--��/д����
//   66  *    RES_WRPRT--д����
//   67  *    RES_NOTRDY--δ׼����
//   68  *    RES_PARERR--��������
//   69  *    RES_NONRSPNS--δ��Ӧ 
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
//   79  * �����̵�һ����������
//   80  * 
//   81  * ����:
//   82  *    drv--������̺ţ�ֻ��Ϊ0
//   83  *    buff--���ݶ�������ĵ�ַָ��
//   84  *    sector--������ʼ��
//   85  *    count--������������
//   86  *
//   87  * ���:
//   88  *    RES_OK--�ɹ�
//   89  *    RES_ERROR--��/д����
//   90  *    RES_WRPRT--д����
//   91  *    RES_NOTRDY--δ׼����
//   92  *    RES_PARERR--��������
//   93  *    RES_NONRSPNS--δ��Ӧ 
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
//  103 //�������ϵͳΪֻ�����򲻱������º���
//  104 #if	_READONLY == 0
//  105 /*
//  106  * LPLD_Disk_Write
//  107  * д���̵�һ����������
//  108  * 
//  109  * ����:
//  110  *    drv--������̺ţ�ֻ��Ϊ0
//  111  *    buff--���ݶ�������ĵ�ַָ��
//  112  *    sector--������ʼ��
//  113  *    count--������������
//  114  *
//  115  * ���:
//  116  *    RES_OK--�ɹ�
//  117  *    RES_ERROR--��/д����
//  118  *    RES_WRPRT--д����
//  119  *    RES_NOTRDY--δ׼����
//  120  *    RES_PARERR--��������
//  121  *    RES_NONRSPNS--δ��Ӧ 
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
//  136  * ���̹��ܿ��ƺ���
//  137  * 
//  138  * ����:
//  139  *    drv--������̺ţ�ֻ��Ϊ0
//  140  *    ctrl--��������
//  141  *    buff--IO�����������ݵ�ָ��
//  142  *
//  143  * ���:
//  144  *    RES_OK--�ɹ�
//  145  *    RES_ERROR--��/д����
//  146  *    RES_WRPRT--д����
//  147  *    RES_NOTRDY--δ׼����
//  148  *    RES_PARERR--��������
//  149  *    RES_NONRSPNS--δ��Ӧ 
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
//  164       ȷ�����������Ѿ����д��������Ĵ���. 
//  165       ������IOģ����һ����д���棬��������������. ���������ֻ��ģʽʹ��.
//  166       */
//  167       // ��POLLINGģʽ�У�����д��������ɡ�
//  168       break;
//  169     case GET_SECTOR_SIZE:
//  170       /*
//  171       ��WORD��ָ���������ʽ����������С.
//  172       ����������ڿɱ�������С������, 
//  173       _MAX_SS Ϊ 512.
//  174       */
//  175       if(buff == NULL)
//  176         result = RES_PARERR;
//  177       else
//  178         *(uint32*)buff = IO_SDCARD_BLOCK_SIZE;
//  179       
//  180       break;
//  181     case GET_SECTOR_COUNT:
//  182       /*
//  183       ��UINT32��ָ���������ʽ���ش��̵Ŀ���������. 
//  184       ���������f_mkfs���������Ծ����ɴ������ľ�. 
//  185       */
//  186       if(buff == NULL)
//  187         result = RES_PARERR;
//  188       else
//  189         *(uint32*)buff = sdcard_ptr->NUM_BLOCKS;
//  190       break;
//  191     case GET_BLOCK_SIZE:
//  192       /*
//  193       ��UINT32���͵�ָ��������ط���flash�ڴ��в�����������.
//  194       �Ϸ�����ֵΪ2��1��32768�η�.
//  195       ����1���������С������豸δ֪.
//  196       ���������f_mkfs�������ò���ͼ�������������߽�������ݶ���.
//  197       */
//  198       result = RES_PARERR;
//  199       break;
//  200     case CTRL_ERASE_SECTOR:
//  201       /*
//  202       ������UINT32����ָ������ָ����flash�ڴ�,{<start sector>, <end sector>}.
//  203       �������Ϊ��flash�ڴ�,���������Ч.
//  204       FatFsϵͳ��������,�������ʧ��Ҳ����Ӱ���ļ�����.
//  205       ��_USE_ERASEΪ1ʱ�ƶ�һ����������ô�����.
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
