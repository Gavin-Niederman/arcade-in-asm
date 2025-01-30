.section boot, "ax"
.global \
    _boot, \
    __stack_top, \
    main

_boot:
    ldr sp, =__stack_top
    ldr r12, =main
    bx r12
    