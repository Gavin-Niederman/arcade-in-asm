.section .text, "ax"
.global vexDisplayRectFill, vexControllerGet, vexTasksRun, vexDeviceMotorVoltageSet, vexDeviceGetByIndex

@ All of these function should just forward to the real function in the jumptable

@ vexDisplayRectFill(int x1, int y1, int x2, int y2);
@ Found at 0x37fc670
vexDisplayRectFill:
    push {lr}
    ldr r12, =0x37fc670
    ldr r12, [r12]
    blx r12
    pop {r12}
    bx r12
@ vexControllerGet(uchar id, uchar channel) -> int
@ found at 0x37fc1a4
vexControllerGet:
    push {lr}

    ldr r12, =0x37fc1a4
    ldr r12, [r12]
    blx r12

    pop {r12}
    bx r12

@ void vexDeviceGetByIndex(uint index) -> void*
@ found at 0x37fc19c
vexDeviceGetByIndex:
    push {lr}

    ldr r12, =0x37fc19c
    ldr r12, [r12]
    blx r12

    pop {r12}
    bx r12
@ void vexDeviceMotorVoltageSet(*void device, int voltage);
@ found at 0x37fc35c
vexDeviceMotorVoltageSet:
    push {lr}

    ldr r12, =0x37fc35c
    ldr r12, [r12]
    blx r12

    pop {r12}
    bx r12
@ vexTasksRun()
@ found at 0x37fc05c
vexTasksRun:
    push {lr}

    ldr r12, =0x37fc05c
    ldr r12, [r12]
    blx r12

    pop {r12}
    bx r12