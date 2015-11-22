///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.30.1.53127/W32 for ARM    25/Sep/2013  21:07:15 /
// Copyright 1999-2011 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  D:\中国机器人大赛\robot_project\lib\cpu\start.c         /
//    Command line =  D:\中国机器人大赛\robot_project\lib\cpu\start.c -D IAR  /
//                    -D LPLD_K60 -lCN D:\中国机器人大赛\robot_project\projec /
//                    t\LPLD_Template\iar\RAM\List\ -lB                       /
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
//                    ar\RAM\List\start.s                                     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME start

        #define SHT_PROGBITS 0x1

        EXTERN common_startup
        EXTERN main
        EXTERN printf
        EXTERN sysinit
        EXTERN wdog_disable

        PUBLIC cpu_identify
        PUBLIC flash_identify
        PUBLIC start

// D:\中国机器人大赛\robot_project\lib\cpu\start.c
//    1 /*
//    2  * File:	start.c
//    3  * Purpose:	Kinetis启动例程. 
//    4  *
//    5  * Notes:		
//    6  */
//    7 
//    8 #include "start.h"
//    9 #include "common.h"
//   10 #include "wdog.h"
//   11 #include "sysinit.h"
//   12 
//   13 /********************************************************************/
//   14 /*
//   15  * 描述: Kinetis启动代码
//   16  * 返回值: 无
//   17  *
//   18  * This function calls all of the needed starup routines and then 
//   19  * branches to the main process.
//   20  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   21 void start(void)
//   22 {
start:
        PUSH     {R7,LR}
//   23 	/* 禁用看门狗定时器 */
//   24 	wdog_disable();
        BL       wdog_disable
//   25 
//   26 	/* 复制需要用到的中断向量表和数据段到RAM中 */
//   27 	common_startup();
        BL       common_startup
//   28 
//   29 	/* 执行处理器初始化 */
//   30 	sysinit();
        BL       sysinit
//   31         
//   32 #if(defined(DEBUG_PRINT))   
//   33 
//   34 	if (MC_SRSH & MC_SRSH_SW_MASK)
        LDR.W    R0,??DataTable2  ;; 0x4007e000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??start_0
//   35 		printf("Software Reset\r\n");
        LDR.W    R0,??DataTable2_1
        BL       printf
//   36 	if (MC_SRSH & MC_SRSH_LOCKUP_MASK)
??start_0:
        LDR.W    R0,??DataTable2  ;; 0x4007e000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??start_1
//   37 		printf("Core Lockup Event Reset\r\n");
        LDR.W    R0,??DataTable2_2
        BL       printf
//   38 	if (MC_SRSH & MC_SRSH_JTAG_MASK)
??start_1:
        LDR.W    R0,??DataTable2  ;; 0x4007e000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??start_2
//   39 		printf("JTAG Reset\r\n");
        LDR.W    R0,??DataTable2_3
        BL       printf
//   40 	
//   41 	if (MC_SRSL & MC_SRSL_POR_MASK)
??start_2:
        LDR.W    R0,??DataTable2_4  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??start_3
//   42 		printf("Power-on Reset\r\n");
        LDR.W    R0,??DataTable2_5
        BL       printf
//   43 	if (MC_SRSL & MC_SRSL_PIN_MASK)
??start_3:
        LDR.W    R0,??DataTable2_4  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BPL.N    ??start_4
//   44 		printf("External Pin Reset\r\n");
        LDR.W    R0,??DataTable2_6
        BL       printf
//   45 	if (MC_SRSL & MC_SRSL_COP_MASK)
??start_4:
        LDR.W    R0,??DataTable2_4  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL.N    ??start_5
//   46 		printf("Watchdog(COP) Reset\r\n");
        LDR.W    R0,??DataTable2_7
        BL       printf
//   47 	if (MC_SRSL & MC_SRSL_LOC_MASK)
??start_5:
        LDR.W    R0,??DataTable2_4  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL.N    ??start_6
//   48 		printf("Loss of Clock Reset\r\n");
        LDR.W    R0,??DataTable2_8
        BL       printf
//   49 	if (MC_SRSL & MC_SRSL_LVD_MASK)
??start_6:
        LDR.W    R0,??DataTable2_4  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL.N    ??start_7
//   50 		printf("Low-voltage Detect Reset\r\n");
        LDR.W    R0,??DataTable2_9
        BL       printf
//   51 	if (MC_SRSL & MC_SRSL_WAKEUP_MASK)
??start_7:
        LDR.W    R0,??DataTable2_4  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+31
        BPL.N    ??start_8
//   52 		printf("LLWU Reset\r\n");	
        LDR.W    R0,??DataTable2_10
        BL       printf
//   53 	
//   54 
//   55 	/* Determine specific Kinetis device and revision */
//   56 	cpu_identify();
??start_8:
        BL       cpu_identify
//   57 #endif
//   58 	
//   59 	/* 执行main主函数 */
//   60 	main();
        BL       main
//   61 
//   62 	/* 无限等待 */
//   63 	while(1);
??start_9:
        B.N      ??start_9
//   64 }
//   65 /********************************************************************/
//   66 /*!
//   67  * \brief   Kinetis Identify
//   68  * \return  None
//   69  *
//   70  * This is primarly a reporting function that displays information
//   71  * about the specific CPU to the default terminal including:
//   72  * - Kinetis family
//   73  * - package
//   74  * - die revision
//   75  * - P-flash size
//   76  * - Ram size
//   77  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   78 void cpu_identify (void)
//   79 {
cpu_identify:
        PUSH     {R7,LR}
//   80     /* Determine the Kinetis family */
//   81     switch((SIM_SDID & SIM_SDID_FAMID(0x7))>>SIM_SDID_FAMID_SHIFT) 
        LDR.W    R0,??DataTable2_11  ;; 0x40048024
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+4
        ANDS     R0,R0,#0x7
        CMP      R0,#+0
        BEQ.N    ??cpu_identify_0
        CMP      R0,#+2
        BEQ.N    ??cpu_identify_1
        BCC.N    ??cpu_identify_2
        CMP      R0,#+4
        BEQ.N    ??cpu_identify_3
        BCC.N    ??cpu_identify_4
        CMP      R0,#+6
        BEQ.N    ??cpu_identify_5
        BCC.N    ??cpu_identify_6
        CMP      R0,#+7
        BEQ.N    ??cpu_identify_7
        B.N      ??cpu_identify_8
//   82     {  
//   83     	case 0x0:
//   84     		printf("\nK10-");
??cpu_identify_0:
        LDR.N    R0,??DataTable2_12
        BL       printf
//   85     		break;
        B.N      ??cpu_identify_9
//   86     	case 0x1:
//   87     		printf("\nK20-");
??cpu_identify_2:
        LDR.N    R0,??DataTable2_13
        BL       printf
//   88     		break;
        B.N      ??cpu_identify_9
//   89     	case 0x2:
//   90     		printf("\nK30-");
??cpu_identify_1:
        LDR.N    R0,??DataTable2_14
        BL       printf
//   91     		break;
        B.N      ??cpu_identify_9
//   92     	case 0x3:
//   93     		printf("\nK40-");
??cpu_identify_4:
        LDR.N    R0,??DataTable2_15
        BL       printf
//   94     		break;
        B.N      ??cpu_identify_9
//   95     	case 0x4:
//   96     		printf("\nK60-");
??cpu_identify_3:
        LDR.N    R0,??DataTable2_16
        BL       printf
//   97     		break;
        B.N      ??cpu_identify_9
//   98     	case 0x5:
//   99     		printf("\nK70-");
??cpu_identify_6:
        LDR.N    R0,??DataTable2_17
        BL       printf
//  100     		break;
        B.N      ??cpu_identify_9
//  101     	case 0x6:
//  102     		printf("\nK50-");
??cpu_identify_5:
        LDR.N    R0,??DataTable2_18
        BL       printf
//  103     		break;
        B.N      ??cpu_identify_9
//  104     	case 0x7:
//  105     		printf("\nK53-");
??cpu_identify_7:
        LDR.N    R0,??DataTable2_19
        BL       printf
//  106     		break;
        B.N      ??cpu_identify_9
//  107 	default:
//  108 		printf("\nUnrecognized Kinetis family device.\n");  
??cpu_identify_8:
        LDR.N    R0,??DataTable2_20
        BL       printf
//  109 		break;  	
//  110     }
//  111 
//  112     /* Determine the package size */
//  113     switch((SIM_SDID & SIM_SDID_PINID(0xF))>>SIM_SDID_PINID_SHIFT) 
??cpu_identify_9:
        LDR.N    R0,??DataTable2_11  ;; 0x40048024
        LDR      R0,[R0, #+0]
        ANDS     R0,R0,#0xF
        CMP      R0,#+2
        BEQ.N    ??cpu_identify_10
        CMP      R0,#+4
        BEQ.N    ??cpu_identify_11
        CMP      R0,#+5
        BEQ.N    ??cpu_identify_12
        CMP      R0,#+6
        BEQ.N    ??cpu_identify_13
        CMP      R0,#+7
        BEQ.N    ??cpu_identify_14
        CMP      R0,#+8
        BEQ.N    ??cpu_identify_15
        CMP      R0,#+9
        BEQ.N    ??cpu_identify_16
        CMP      R0,#+10
        BEQ.N    ??cpu_identify_17
        CMP      R0,#+12
        BEQ.N    ??cpu_identify_18
        CMP      R0,#+14
        BEQ.N    ??cpu_identify_19
        B.N      ??cpu_identify_20
//  114     {  
//  115     	case 0x2:
//  116     		printf("32pin       \n");
??cpu_identify_10:
        LDR.N    R0,??DataTable2_21
        BL       printf
//  117     		break;
        B.N      ??cpu_identify_21
//  118     	case 0x4:
//  119     		printf("48pin       \n");
??cpu_identify_11:
        LDR.N    R0,??DataTable2_22
        BL       printf
//  120     		break;
        B.N      ??cpu_identify_21
//  121     	case 0x5:
//  122     		printf("64pin       \n");
??cpu_identify_12:
        LDR.N    R0,??DataTable2_23
        BL       printf
//  123     		break;
        B.N      ??cpu_identify_21
//  124     	case 0x6:
//  125     		printf("80pin       \n");
??cpu_identify_13:
        LDR.N    R0,??DataTable2_24
        BL       printf
//  126     		break;
        B.N      ??cpu_identify_21
//  127     	case 0x7:
//  128     		printf("81pin       \n");
??cpu_identify_14:
        LDR.N    R0,??DataTable2_25
        BL       printf
//  129     		break;
        B.N      ??cpu_identify_21
//  130     	case 0x8:
//  131     		printf("100pin      \n");
??cpu_identify_15:
        LDR.N    R0,??DataTable2_26
        BL       printf
//  132     		break;
        B.N      ??cpu_identify_21
//  133     	case 0x9:
//  134     		printf("104pin      \n");
??cpu_identify_16:
        LDR.N    R0,??DataTable2_27
        BL       printf
//  135     		break;
        B.N      ??cpu_identify_21
//  136     	case 0xA:
//  137     		printf("144pin      \n");
??cpu_identify_17:
        LDR.N    R0,??DataTable2_28
        BL       printf
//  138     		break;
        B.N      ??cpu_identify_21
//  139     	case 0xC:
//  140     		printf("196pin      \n");
??cpu_identify_18:
        LDR.N    R0,??DataTable2_29
        BL       printf
//  141     		break;
        B.N      ??cpu_identify_21
//  142     	case 0xE:
//  143     		printf("256pin      \n");
??cpu_identify_19:
        LDR.N    R0,??DataTable2_30
        BL       printf
//  144     		break;
        B.N      ??cpu_identify_21
//  145 	default:
//  146 		printf("\nUnrecognized Kinetis package code.      \n");  
??cpu_identify_20:
        LDR.N    R0,??DataTable2_31
        BL       printf
//  147 		break;  	
//  148     }                
//  149 
//  150     /* Determine the revision ID */
//  151     
//  152     switch((SIM_SDID & SIM_SDID_REVID(0xF))>>SIM_SDID_REVID_SHIFT) 
??cpu_identify_21:
        LDR.N    R0,??DataTable2_11  ;; 0x40048024
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+12
        ANDS     R0,R0,#0xF
        CMP      R0,#+0
        BEQ.N    ??cpu_identify_22
        CMP      R0,#+2
        BEQ.N    ??cpu_identify_23
        BCC.N    ??cpu_identify_24
        B.N      ??cpu_identify_25
//  153     { 
//  154    
//  155     case 0x0:
//  156     		printf("Silicon rev 1.0   \n ");
??cpu_identify_22:
        LDR.N    R0,??DataTable2_32
        BL       printf
//  157     		break;
        B.N      ??cpu_identify_26
//  158     case 0x1:
//  159     		printf("Silicon rev 1.1  \n ");
??cpu_identify_24:
        LDR.N    R0,??DataTable2_33
        BL       printf
//  160     		break;
        B.N      ??cpu_identify_26
//  161     case 0x2:
//  162     		printf("Silicon rev 1.2  \n ");
??cpu_identify_23:
        LDR.N    R0,??DataTable2_34
        BL       printf
//  163     		break;
        B.N      ??cpu_identify_26
//  164     default:
//  165 		printf("\nThis version of software doesn't recognize the revision code.");  
??cpu_identify_25:
        LDR.N    R0,??DataTable2_35
        BL       printf
//  166 		break;  
//  167     }
//  168     
//  169     /* Determine the flash revision */
//  170     flash_identify();  
??cpu_identify_26:
        BL       flash_identify
//  171     
//  172     
//  173     /* Determine the P-flash size */
//  174     switch((SIM_FCFG1 & SIM_FCFG1_PFSIZE(0xF))>>SIM_FCFG1_PFSIZE_SHIFT)
        LDR.N    R0,??DataTable2_36  ;; 0x4004804c
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+24
        ANDS     R0,R0,#0xF
        CMP      R0,#+7
        BEQ.N    ??cpu_identify_27
        CMP      R0,#+9
        BEQ.N    ??cpu_identify_28
        CMP      R0,#+11
        BEQ.N    ??cpu_identify_29
        CMP      R0,#+15
        BEQ.N    ??cpu_identify_30
        B.N      ??cpu_identify_31
//  175     {
//  176     	case 0x7:
//  177     		printf("128 kBytes of P-flash	\n");
??cpu_identify_27:
        LDR.N    R0,??DataTable2_37
        BL       printf
//  178     		break;
        B.N      ??cpu_identify_32
//  179     	case 0x9:
//  180     		printf("256 kBytes of P-flash	\n");
??cpu_identify_28:
        LDR.N    R0,??DataTable2_38
        BL       printf
//  181     		break;
        B.N      ??cpu_identify_32
//  182         case 0xB:
//  183     		printf("512 kBytes of P-flash	\n");
??cpu_identify_29:
        LDR.N    R0,??DataTable2_39
        BL       printf
//  184     		break;
        B.N      ??cpu_identify_32
//  185     	case 0xF:
//  186     		printf("512 kBytes of P-flash	\n");
??cpu_identify_30:
        LDR.N    R0,??DataTable2_39
        BL       printf
//  187     		break;
        B.N      ??cpu_identify_32
//  188 	default:
//  189 		printf("ERR!! Undefined P-flash size\n");  
??cpu_identify_31:
        LDR.N    R0,??DataTable2_40
        BL       printf
//  190 		break;  		
//  191     }
//  192     
//  193     /* Determine if the part has P-flash only or P-flash and FlexNVM */
//  194     if (SIM_FCFG2 & SIM_FCFG2_PFLSH_MASK)  
??cpu_identify_32:
        LDR.N    R0,??DataTable2_41  ;; 0x40048050
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+8
        BPL.N    ??cpu_identify_33
//  195       printf("P-flash only\n");
        LDR.N    R0,??DataTable2_42
        BL       printf
        B.N      ??cpu_identify_34
//  196     else
//  197       /* if part has FlexNVM determine the FlexNVM size*/
//  198       switch((SIM_FCFG1 & SIM_FCFG1_NVMSIZE(0xF))>>SIM_FCFG1_NVMSIZE_SHIFT)
??cpu_identify_33:
        LDR.N    R0,??DataTable2_36  ;; 0x4004804c
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+28
        CMP      R0,#+0
        BEQ.N    ??cpu_identify_35
        CMP      R0,#+7
        BEQ.N    ??cpu_identify_36
        CMP      R0,#+9
        BEQ.N    ??cpu_identify_37
        CMP      R0,#+15
        BEQ.N    ??cpu_identify_38
        B.N      ??cpu_identify_39
//  199       {
//  200       	case 0x0:
//  201       		printf("0 kBytes of FlexNVM\n");
??cpu_identify_35:
        LDR.N    R0,??DataTable2_43
        BL       printf
//  202       		break;
        B.N      ??cpu_identify_34
//  203     	case 0x7:
//  204       		printf("128 kBytes of FlexNVM\n");
??cpu_identify_36:
        LDR.N    R0,??DataTable2_44
        BL       printf
//  205     		break;
        B.N      ??cpu_identify_34
//  206         case 0x9:
//  207       		printf("256 kBytes of FlexNVM\n");
??cpu_identify_37:
        LDR.N    R0,??DataTable2_45
        BL       printf
//  208     		break;
        B.N      ??cpu_identify_34
//  209     	case 0xF:
//  210       		printf("256 kBytes of FlexNVM\n");
??cpu_identify_38:
        LDR.N    R0,??DataTable2_45
        BL       printf
//  211     		break;
        B.N      ??cpu_identify_34
//  212 	default:
//  213 		printf("ERR!! Undefined FlexNVM size\n");  
??cpu_identify_39:
        LDR.N    R0,??DataTable2_46
        BL       printf
//  214 		break;  		
//  215       }
//  216       
//  217 
//  218     /* Determine the RAM size */
//  219     switch((SIM_SOPT1 & SIM_SOPT1_RAMSIZE(0xF))>>SIM_SOPT1_RAMSIZE_SHIFT)
??cpu_identify_34:
        LDR.N    R0,??DataTable2_47  ;; 0x40047000
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+12
        ANDS     R0,R0,#0xF
        CMP      R0,#+5
        BEQ.N    ??cpu_identify_40
        CMP      R0,#+7
        BEQ.N    ??cpu_identify_41
        CMP      R0,#+8
        BEQ.N    ??cpu_identify_42
        CMP      R0,#+9
        BEQ.N    ??cpu_identify_43
        B.N      ??cpu_identify_44
//  220     {
//  221     	case 0x5:
//  222     		printf("32 kBytes of RAM\n\n");
??cpu_identify_40:
        LDR.N    R0,??DataTable2_48
        BL       printf
//  223     		break;
        B.N      ??cpu_identify_45
//  224     	case 0x7:
//  225     		printf("64 kBytes of RAM\n\n");
??cpu_identify_41:
        LDR.N    R0,??DataTable2_49
        BL       printf
//  226     		break;
        B.N      ??cpu_identify_45
//  227     	case 0x8:
//  228     		printf("96 kBytes of RAM\n\n");
??cpu_identify_42:
        LDR.N    R0,??DataTable2_50
        BL       printf
//  229     		break;
        B.N      ??cpu_identify_45
//  230     	case 0x9:
//  231     		printf("128 kBytes of RAM\n\n");
??cpu_identify_43:
        LDR.N    R0,??DataTable2_51
        BL       printf
//  232     		break;
        B.N      ??cpu_identify_45
//  233 		default:
//  234 			printf("ERR!! Undefined RAM size\n\n");  
??cpu_identify_44:
        LDR.N    R0,??DataTable2_52
        BL       printf
//  235 			break;  		
//  236     }
//  237 
//  238 }
??cpu_identify_45:
        POP      {R0,PC}          ;; return
//  239 /********************************************************************/
//  240 /*!
//  241  * \brief   Flash闪存识别
//  242  * \return  None
//  243  *
//  244  * This is primarly a reporting function that displays information
//  245  * about the specific flash parameters and flash version ID for 
//  246  * the current device. These parameters are obtained using a special
//  247  * flash command call "read resource." The first four bytes returned
//  248  * are the flash parameter revision, and the second four bytes are
//  249  * the flash version ID.
//  250  */

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  251 void flash_identify (void)
//  252 {
flash_identify:
        PUSH     {R7,LR}
//  253     uint8_t fccob4,fccob5,fccob6,fccob7;
//  254     
//  255     /* Get the flash parameter version */
//  256 
//  257     /* Write the flash FCCOB registers with the values for a read resource command */
//  258     FTFL_FCCOB0 = 0x03;
        LDR.N    R0,??DataTable2_53  ;; 0x40020007
        MOVS     R1,#+3
        STRB     R1,[R0, #+0]
//  259     FTFL_FCCOB1 = 0x00;
        LDR.N    R0,??DataTable2_54  ;; 0x40020006
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  260     FTFL_FCCOB2 = 0x00;
        LDR.N    R0,??DataTable2_55  ;; 0x40020005
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  261     FTFL_FCCOB3 = 0x00;
        LDR.N    R0,??DataTable2_56  ;; 0x40020004
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  262     FTFL_FCCOB8 = 0x01;
        LDR.N    R0,??DataTable2_57  ;; 0x4002000f
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  263 
//  264     /* All required FCCOBx registers are written, so launch the command */
//  265     FTFL_FSTAT = FTFL_FSTAT_CCIF_MASK;
        LDR.N    R0,??DataTable2_58  ;; 0x40020000
        MOVS     R1,#+128
        STRB     R1,[R0, #+0]
//  266 
//  267     /* Wait for the command to complete */
//  268     while(!(FTFL_FSTAT & FTFL_FSTAT_CCIF_MASK));
??flash_identify_0:
        LDR.N    R0,??DataTable2_58  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??flash_identify_0
//  269     
//  270     fccob4 = FTFL_FCCOB4;
        LDR.N    R0,??DataTable2_59  ;; 0x4002000b
        LDRB     R1,[R0, #+0]
//  271     fccob5 = FTFL_FCCOB5;
        LDR.N    R0,??DataTable2_60  ;; 0x4002000a
        LDRB     R2,[R0, #+0]
//  272     fccob6 = FTFL_FCCOB6;
        LDR.N    R0,??DataTable2_61  ;; 0x40020009
        LDRB     R3,[R0, #+0]
//  273     fccob7 = FTFL_FCCOB7;
        LDR.N    R0,??DataTable2_62  ;; 0x40020008
        LDRB     R0,[R0, #+0]
//  274     printf("Flash parameter version %d.%d.%d.%d\n",fccob4,fccob5,fccob6,fccob7);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R0,[SP, #+0]
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.N    R0,??DataTable2_63
        BL       printf
//  275 
//  276     /* Get the flash version ID */   
//  277 
//  278     /* Write the flash FCCOB registers with the values for a read resource command */
//  279     FTFL_FCCOB0 = 0x03;
        LDR.N    R0,??DataTable2_53  ;; 0x40020007
        MOVS     R1,#+3
        STRB     R1,[R0, #+0]
//  280     FTFL_FCCOB1 = 0x00;
        LDR.N    R0,??DataTable2_54  ;; 0x40020006
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  281     FTFL_FCCOB2 = 0x00;
        LDR.N    R0,??DataTable2_55  ;; 0x40020005
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  282     FTFL_FCCOB3 = 0x04;
        LDR.N    R0,??DataTable2_56  ;; 0x40020004
        MOVS     R1,#+4
        STRB     R1,[R0, #+0]
//  283     FTFL_FCCOB8 = 0x01;
        LDR.N    R0,??DataTable2_57  ;; 0x4002000f
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  284 
//  285     /* All required FCCOBx registers are written, so launch the command */
//  286     FTFL_FSTAT = FTFL_FSTAT_CCIF_MASK;
        LDR.N    R0,??DataTable2_58  ;; 0x40020000
        MOVS     R1,#+128
        STRB     R1,[R0, #+0]
//  287 
//  288     /* Wait for the command to complete */
//  289     while(!(FTFL_FSTAT & FTFL_FSTAT_CCIF_MASK));
??flash_identify_1:
        LDR.N    R0,??DataTable2_58  ;; 0x40020000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL.N    ??flash_identify_1
//  290 
//  291     fccob4 = FTFL_FCCOB4;
        LDR.N    R0,??DataTable2_59  ;; 0x4002000b
        LDRB     R1,[R0, #+0]
//  292     fccob5 = FTFL_FCCOB5;
        LDR.N    R0,??DataTable2_60  ;; 0x4002000a
        LDRB     R2,[R0, #+0]
//  293     fccob6 = FTFL_FCCOB6;
        LDR.N    R0,??DataTable2_61  ;; 0x40020009
        LDRB     R3,[R0, #+0]
//  294     fccob7 = FTFL_FCCOB7;
        LDR.N    R0,??DataTable2_62  ;; 0x40020008
        LDRB     R0,[R0, #+0]
//  295     printf("Flash version ID %d.%d.%d.%d\n",fccob4,fccob5,fccob6,fccob7);
        UXTB     R0,R0            ;; ZeroExt  R0,R0,#+24,#+24
        STR      R0,[SP, #+0]
        UXTB     R3,R3            ;; ZeroExt  R3,R3,#+24,#+24
        UXTB     R2,R2            ;; ZeroExt  R2,R2,#+24,#+24
        UXTB     R1,R1            ;; ZeroExt  R1,R1,#+24,#+24
        LDR.N    R0,??DataTable2_64
        BL       printf
//  296     
//  297     /* Clear all of the flags in the flash status register */
//  298     FTFL_FSTAT = 0xFF;
        LDR.N    R0,??DataTable2_58  ;; 0x40020000
        MOVS     R1,#+255
        STRB     R1,[R0, #+0]
//  299 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     0x4007e000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_1:
        DC32     `?<Constant "Software Reset\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_2:
        DC32     `?<Constant "Core Lockup Event Res...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_3:
        DC32     `?<Constant "JTAG Reset\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_4:
        DC32     0x4007e001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_5:
        DC32     `?<Constant "Power-on Reset\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_6:
        DC32     `?<Constant "External Pin Reset\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_7:
        DC32     `?<Constant "Watchdog(COP) Reset\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_8:
        DC32     `?<Constant "Loss of Clock Reset\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_9:
        DC32     `?<Constant "Low-voltage Detect Re...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_10:
        DC32     `?<Constant "LLWU Reset\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_11:
        DC32     0x40048024

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_12:
        DC32     `?<Constant "\\nK10-">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_13:
        DC32     `?<Constant "\\nK20-">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_14:
        DC32     `?<Constant "\\nK30-">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_15:
        DC32     `?<Constant "\\nK40-">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_16:
        DC32     `?<Constant "\\nK60-">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_17:
        DC32     `?<Constant "\\nK70-">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_18:
        DC32     `?<Constant "\\nK50-">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_19:
        DC32     `?<Constant "\\nK53-">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_20:
        DC32     `?<Constant "\\nUnrecognized Kinetis...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_21:
        DC32     `?<Constant "32pin       \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_22:
        DC32     `?<Constant "48pin       \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_23:
        DC32     `?<Constant "64pin       \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_24:
        DC32     `?<Constant "80pin       \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_25:
        DC32     `?<Constant "81pin       \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_26:
        DC32     `?<Constant "100pin      \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_27:
        DC32     `?<Constant "104pin      \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_28:
        DC32     `?<Constant "144pin      \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_29:
        DC32     `?<Constant "196pin      \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_30:
        DC32     `?<Constant "256pin      \\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_31:
        DC32     `?<Constant "\\nUnrecognized Kinetis...">_1`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_32:
        DC32     `?<Constant "Silicon rev 1.0   \\n ">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_33:
        DC32     `?<Constant "Silicon rev 1.1  \\n ">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_34:
        DC32     `?<Constant "Silicon rev 1.2  \\n ">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_35:
        DC32     `?<Constant "\\nThis version of soft...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_36:
        DC32     0x4004804c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_37:
        DC32     `?<Constant "128 kBytes of P-flash\\t\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_38:
        DC32     `?<Constant "256 kBytes of P-flash\\t\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_39:
        DC32     `?<Constant "512 kBytes of P-flash\\t\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_40:
        DC32     `?<Constant "ERR!! Undefined P-fla...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_41:
        DC32     0x40048050

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_42:
        DC32     `?<Constant "P-flash only\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_43:
        DC32     `?<Constant "0 kBytes of FlexNVM\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_44:
        DC32     `?<Constant "128 kBytes of FlexNVM\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_45:
        DC32     `?<Constant "256 kBytes of FlexNVM\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_46:
        DC32     `?<Constant "ERR!! Undefined FlexN...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_47:
        DC32     0x40047000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_48:
        DC32     `?<Constant "32 kBytes of RAM\\n\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_49:
        DC32     `?<Constant "64 kBytes of RAM\\n\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_50:
        DC32     `?<Constant "96 kBytes of RAM\\n\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_51:
        DC32     `?<Constant "128 kBytes of RAM\\n\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_52:
        DC32     `?<Constant "ERR!! Undefined RAM s...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_53:
        DC32     0x40020007

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_54:
        DC32     0x40020006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_55:
        DC32     0x40020005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_56:
        DC32     0x40020004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_57:
        DC32     0x4002000f

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_58:
        DC32     0x40020000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_59:
        DC32     0x4002000b

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_60:
        DC32     0x4002000a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_61:
        DC32     0x40020009

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_62:
        DC32     0x40020008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_63:
        DC32     `?<Constant "Flash parameter versi...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2_64:
        DC32     `?<Constant "Flash version ID %d.%...">`

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Software Reset\\r\\n">`:
        DATA
        DC8 "Software Reset\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Core Lockup Event Res...">`:
        DATA
        DC8 "Core Lockup Event Reset\015\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "JTAG Reset\\r\\n">`:
        DATA
        DC8 "JTAG Reset\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Power-on Reset\\r\\n">`:
        DATA
        DC8 "Power-on Reset\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "External Pin Reset\\r\\n">`:
        DATA
        DC8 "External Pin Reset\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Watchdog(COP) Reset\\r\\n">`:
        DATA
        DC8 "Watchdog(COP) Reset\015\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Loss of Clock Reset\\r\\n">`:
        DATA
        DC8 "Loss of Clock Reset\015\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Low-voltage Detect Re...">`:
        DATA
        DC8 "Low-voltage Detect Reset\015\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "LLWU Reset\\r\\n">`:
        DATA
        DC8 "LLWU Reset\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nK10-">`:
        DATA
        DC8 "\012K10-"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nK20-">`:
        DATA
        DC8 "\012K20-"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nK30-">`:
        DATA
        DC8 "\012K30-"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nK40-">`:
        DATA
        DC8 "\012K40-"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nK60-">`:
        DATA
        DC8 "\012K60-"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nK70-">`:
        DATA
        DC8 "\012K70-"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nK50-">`:
        DATA
        DC8 "\012K50-"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nK53-">`:
        DATA
        DC8 "\012K53-"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nUnrecognized Kinetis...">`:
        DATA
        DC8 "\012Unrecognized Kinetis family device.\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "32pin       \\n">`:
        DATA
        DC8 "32pin       \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "48pin       \\n">`:
        DATA
        DC8 "48pin       \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "64pin       \\n">`:
        DATA
        DC8 "64pin       \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "80pin       \\n">`:
        DATA
        DC8 "80pin       \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "81pin       \\n">`:
        DATA
        DC8 "81pin       \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "100pin      \\n">`:
        DATA
        DC8 "100pin      \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "104pin      \\n">`:
        DATA
        DC8 "104pin      \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "144pin      \\n">`:
        DATA
        DC8 "144pin      \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "196pin      \\n">`:
        DATA
        DC8 "196pin      \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "256pin      \\n">`:
        DATA
        DC8 "256pin      \012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nUnrecognized Kinetis...">_1`:
        DATA
        DC8 "\012Unrecognized Kinetis package code.      \012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Silicon rev 1.0   \\n ">`:
        DATA
        DC8 "Silicon rev 1.0   \012 "
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Silicon rev 1.1  \\n ">`:
        DATA
        DC8 "Silicon rev 1.1  \012 "

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Silicon rev 1.2  \\n ">`:
        DATA
        DC8 "Silicon rev 1.2  \012 "

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\nThis version of soft...">`:
        DATA
        DC8 0AH, 54H, 68H, 69H, 73H, 20H, 76H, 65H
        DC8 72H, 73H, 69H, 6FH, 6EH, 20H, 6FH, 66H
        DC8 20H, 73H, 6FH, 66H, 74H, 77H, 61H, 72H
        DC8 65H, 20H, 64H, 6FH, 65H, 73H, 6EH, 27H
        DC8 74H, 20H, 72H, 65H, 63H, 6FH, 67H, 6EH
        DC8 69H, 7AH, 65H, 20H, 74H, 68H, 65H, 20H
        DC8 72H, 65H, 76H, 69H, 73H, 69H, 6FH, 6EH
        DC8 20H, 63H, 6FH, 64H, 65H, 2EH, 0
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "128 kBytes of P-flash\\t\\n">`:
        DATA
        DC8 "128 kBytes of P-flash\t\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "256 kBytes of P-flash\\t\\n">`:
        DATA
        DC8 "256 kBytes of P-flash\t\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "512 kBytes of P-flash\\t\\n">`:
        DATA
        DC8 "512 kBytes of P-flash\t\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "ERR!! Undefined P-fla...">`:
        DATA
        DC8 "ERR!! Undefined P-flash size\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "P-flash only\\n">`:
        DATA
        DC8 "P-flash only\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "0 kBytes of FlexNVM\\n">`:
        DATA
        DC8 "0 kBytes of FlexNVM\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "128 kBytes of FlexNVM\\n">`:
        DATA
        DC8 "128 kBytes of FlexNVM\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "256 kBytes of FlexNVM\\n">`:
        DATA
        DC8 "256 kBytes of FlexNVM\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "ERR!! Undefined FlexN...">`:
        DATA
        DC8 "ERR!! Undefined FlexNVM size\012"
        DC8 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "32 kBytes of RAM\\n\\n">`:
        DATA
        DC8 "32 kBytes of RAM\012\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "64 kBytes of RAM\\n\\n">`:
        DATA
        DC8 "64 kBytes of RAM\012\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "96 kBytes of RAM\\n\\n">`:
        DATA
        DC8 "96 kBytes of RAM\012\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "128 kBytes of RAM\\n\\n">`:
        DATA
        DC8 "128 kBytes of RAM\012\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "ERR!! Undefined RAM s...">`:
        DATA
        DC8 "ERR!! Undefined RAM size\012\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Flash parameter versi...">`:
        DATA
        DC8 "Flash parameter version %d.%d.%d.%d\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "Flash version ID %d.%...">`:
        DATA
        DC8 "Flash version ID %d.%d.%d.%d\012"
        DC8 0, 0

        END
//  300 /********************************************************************/
//  301 
// 
// 1 040 bytes in section .rodata
// 1 124 bytes in section .text
// 
// 1 124 bytes of CODE  memory
// 1 040 bytes of CONST memory
//
//Errors: none
//Warnings: none
