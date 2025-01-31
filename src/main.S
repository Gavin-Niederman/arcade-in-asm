.section .text, "ax"
.global \
    main, \
    vexDisplayRectFill, \
    vexControllerGet, \
    vexTasksRun, \
    vexSerialWriteChar, \
    __aeabi_idiv

@ Takes controller input and converts it to left and right motor speeds
@ args: r0=x, r1=y
@ returns: r0=left, r1=right
arcade_drive:
    push {lr}
    push {r0, r1}
    
    @ calculate ratio of controller range to motor range (127 -> 12000)
    mov r0, #12000
    mov r1, #127

    bl __aeabi_idiv
    mov r12, r0

    pop {r0, r1}

    add r2, r1, r0
    sub r3, r1, r0

    mul r2, r12
    mul r3, r12

    mov r0, r2
    mov r1, r3

    pop {r12}
    bx r12

@ Takes wheel speeds and displays it on the screen
@ args: r0=left, r1=right
visualize_speeds:
    push {lr}
    push {r1}

    @ store loop count
    mov r12, #0
    push {r12}

    cmp r0, #0
    bxeq lr
    cmp r1, #0
    bxeq lr

1:  cmp r0, #0
    
    pop {r12}
    add r12, r12, #1
    push {r12}

    @ save the val
    mov r3, r0

    @ divide by 10
    mov r1, #10
    bl __aeabi_idiv

    mov r4, #10
    @ get the truncated value
    mul r1, r0, r4
    @ find the remainder
    sub r1, r0, r1

    add r1, r1, #48
    @ call vexSerialWriteChar with (1, rem + 48 (0))
    mov r0, #1
    bl vexSerialWriteChar

    mov r0, r3

    beq 1b

    @ Print space 
    mov r0, #1
    mov r1, #32
    bl vexSerialWriteChar

    @ Print the other number
    pop {r12}
    pop {r0}
    cmp r12, #1
    beq 1b

    @ Print newline
    mov r0, #1
    mov r1, #10
    bl vexSerialWriteChar

    pop {r12}
    bx r12


main:
    @ Call vexDisplayRectFill with (75, 25, 100, right speed)
    @ mov r0, #0
    @ mov r1, #0
    @ mov r2, #100
    @ mov r3, #100
    @ bl vexDisplayRectFill

    @ Call vexDeviceGetByIndex with 1
    mov r0, #0
    bl vexDeviceGetByIndex
    @ Save the pointer in r6
    mov r6, r0
    @ Call vexDeviceGetByIndex with 2
    mov r0, #1
    bl vexDeviceGetByIndex
    @ Save the pointer in r7
    mov r7, r0

    @ Call vexControllerGet with (maser, 2 (right joystick x))
1:  mov r0, #0
    mov r1, #2
    bl vexControllerGet
    @ save the result in r4
    mov r4, r0
    @ Call vexControllerGet with (master, 1 (left joystick y))
    mov r0, #0
    mov r1, #1
    bl vexControllerGet
    @ save the result in r5
    mov r5, r0

    @ Call arcade_drive with r5, r4
    mov r0, r5
    mov r1, r4
    bl arcade_drive
    mov r8, r0
    mov r9, r1
    @ bl visualize_speeds

    @ Call vexDeviceMotorVoltageSet with r6, r9
    mov r0, r6
    mov r1, r9
    bl vexDeviceMotorVoltageSet
    @ Call vexDeviceMotorVoltageSet with r7, r8
    mov r1, r8
    mov r0, r7
    bl vexDeviceMotorVoltageSet

    @ Call vexTasksRun
    bl vexTasksRun

    @ Loop back to 1
    b 1b
