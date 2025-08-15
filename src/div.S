.section .text, "ax"
.global divsi3

// divsi3: signed 32-bit integer division
// Arguments:
//   r0 = dividend
//   r1 = divisor
// Returns:
//   r0 = quotient
divsi3:
    cmp     r1, #0
    beq     Ldiv0                @ division by zero trap/handler

    eor     ip, r0, r1            @ save sign of result in ip
    rsbmi   r1, r1, #0            @ make divisor positive if negative

    subs    r2, r1, #1            @ check if divisor is 1 or -1
    beq     Ldiv_by_one

    movs    r3, r0
    rsbmi   r3, r0, #0            @ make dividend positive if negative

    cmp     r3, r1
    bls     Lsmall_dividend       @ if |dividend| < |divisor|, result is 0

    tst     r1, r2                @ check if divisor is power of 2
    beq     Lpower_of_two

    // Generic division loop
    mov     r0, #0
    mov     r2, #1

1:  cmp     r1, r3
    lslle   r1, r1, #1
    lslls   r2, r2, #1
    ble     1b

2:  cmp     r3, r1
    subcs   r3, r3, r1
    orrcs   r0, r0, r2
    lsr     r1, r1, #1
    lsr     r2, r2, #1
    cmp     r2, #0
    bne     2b

    cmp     ip, #0
    rsbmi   r0, r0, #0
    bx      lr

Ldiv_by_one:
    teq     ip, r0
    rsbmi   r0, r0, #0
    bx      lr

Lsmall_dividend:
    movlo   r0, #0
    moveq   r0, ip, asr #31
    orreq   r0, r0, #1
    bx      lr

Lpower_of_two:
    clz     r2, r1
    rsb     r2, r2, #31
    mov     r0, r3, lsr r2
    cmp     ip, #0
    rsbmi   r0, r0, #0
    bx      lr

// Division by zero handler stub
Ldiv0:
    b       Ldiv0                 @ hang or replace with a trap
