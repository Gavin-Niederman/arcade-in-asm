.section .text, "ax"
.global \
    main, \
    vexDisplayRectFill, \
    vexControllerGet, \
    vexTasksRun, \
    arcade_drive,

@ Takes controller input and converts it to left and right motor speeds
@ args: r0=x, r1=y
@ returns: r0=left, r1=right
arcade_drive:
    @ left
    add r2, r0, r1
    @ right
    sub r3, r0, r1
    mov r0, r2
    mov r1, r3
    bx lr

main:
    @ Call vexDisplayRectFill with (0, 0, 100, 100)
    mov r0, #0
    mov r1, #0
    mov r2, #100
    mov r3, #100
    bl vexDisplayRectFill

    @ Call vexDeviceGetByIndex with 1
    mov r0, #1
    bl vexDeviceGetByIndex
    @ Save the pointer in r6
    mov r6, r0
    @ Call vexDeviceGetByIndex with 2
    mov r0, #2
    bl vexDeviceGetByIndex
    @ Save the pointer in r7
    mov r7, r0

    @ Call vexControllerGet with (maser, 0 (left joystick x))
1:  mov r0, #0
    mov r1, #0
    bl vexControllerGet
    @ save the result in r4
    mov r4, r0
    @ Call vexControllerGet with (master, 3 (right joystick y))
    mov r0, #0
    mov r1, #3
    bl vexControllerGet
    @ save the result in r5
    mov r5, r0
    @ Call arcade_drive with r4, r5
    mov r0, r4
    mov r1, r5
    bl arcade_drive
    mov r8, r0

    @ Call vexDeviceMotorVoltageSet with r6, r0
    mov r1, r0
    mov r0, r6
    bl vexDeviceMotorVoltageSet
    @ Call vexDeviceMotorVoltageSet with r7, r8
    mov r1, r8
    mov r0, r7
    bl vexDeviceMotorVoltageSet

    @ Call vexTasksRun
    bl vexTasksRun

    @ Loop back to 1
    b 1b
