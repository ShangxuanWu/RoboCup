/*
 * 文件名:	crt0.s
 * 目的:	Kinetis底层执行代码
 *	
 */

;         AREA   Crt0, CODE, READONLY      ; name this block of code



  	SECTION .noinit : CODE
  	EXPORT  __startup
__startup

    MOV     r0,#0                   ; 初始化全局寄存器
	MOV     r1,#0
	MOV     r2,#0
	MOV     r3,#0
	MOV     r4,#0
	MOV     r5,#0
	MOV     r6,#0
	MOV     r7,#0
	MOV     r8,#0
	MOV     r9,#0
	MOV     r10,#0
	MOV     r11,#0
	MOV     r12,#0
	CPSIE   i                    ; 屏蔽中断
        import start
        BL      start                ; 调用C语言函数start
__done
        B       __done


        END
