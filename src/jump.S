.section .text, "ax"
.global vexDisplayRectFill, vexControllerGet, vexTasksRun, vexDeviceMotorVoltageSet, vexDeviceGetByIndex

@ All of these function should just forward to the real function in the jumptable

@ vexDisplayRectFill(int x1, int y1, int x2, int y2);
@ Found at 0x37fc668
vexDisplayRectFill:
    ldr r12, =0x37fc668
    blx r12
    bx lr
@ vexControllerGet(uchar id, uchar channel) -> int
@ found at 0x37fc1a4
vexControllerGet:
    ldr r12, =0x37fc1a4
    blx r12
    bx lr

@ void vexDeviceGetByIndex(uint index) -> void*
@ found at 0x37fc19c
vexDeviceGetByIndex:
    ldr r12, =0x37fc19c
    blx r12
    bx lr
@ void vexDeviceMotorVoltageSet(*void device, int voltage);
@ found at 0x37fc35c
vexDeviceMotorVoltageSet:
    ldr r12, =0x37fc35c
    blx r12
    bx lr
@ vexTasksRun()
@ found at 0x37fc05c
vexTasksRun:
    ldr r12, =0x37fc05c
    blx r12
    bx lr