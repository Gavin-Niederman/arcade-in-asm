.section .boot, "ax"
.global \
    _boot, \
    __stack_top, \
    main

_boot:
    ldr sp, =__stack_top
    b main
    bx lr

.section .code_signature, "a"
.global CODE_SIGNATURE

CODE_SIGNATURE:
    @ XVX5
    .word 0x35585658
    .word 0
    .word 2
    .word 0
    .word 0
    .word 0
    .word 0
