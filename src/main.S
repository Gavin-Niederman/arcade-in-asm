.section boot, "ax"
.global \
    _boot, \
    __stack_top, \
    vexDisplayRectFill

_boot:
    ldr sp, =__stack_top
    @ Call vexDisplayRectFill with (0, 0, 100, 100)
    ldr r12, =vexDisplayRectFill
    mov r0, #0
    mov r1, #0
    mov r2, #100
    mov r3, #100
    bx r12
1:  b 1b