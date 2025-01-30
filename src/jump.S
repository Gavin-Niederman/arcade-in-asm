.section .text, "ax"
.global vexDisplayRectFill

@ All of these function should just forward to the real function in the jumptable

@ void vexDisplayRectFill(int x1, int y1, int x2, int y2);
@ Found at 0x37fc668
vexDisplayRectFill:
    ldr r12, =0x37fc668
    bx r12