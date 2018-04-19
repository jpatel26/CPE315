
   .syntax unified
   @intadd by Jasmine Patel

   .arch armv6
   .fpu vfp

   @--------------

   .global intmul
intmul:
   push {r1, r2, r3, r4, r5, lr} /* r1 = multiplier, r0 = multiplicand */
   mov r2, #1 /* set r2 = 1 */
   mov r4, #0 /* r4 = product register */
   mov r3, #0 /* set r3 = 0, this is the counter */
   b step1 /* branch to step 1 */

step1:
   push {r0, r1} /* save registers before call to intadd */
   mov r0, r3 /* move the counter into r0 */
   mov r1, r2 /* move 1 into r1 */
   bl intadd /* call intadd to increment counter */
   mov r3, r0 /* increment counter */
   pop {r0, r1} /* restore registers after call to intadd */
   and r5, r1, r2 /* check if last bit of multiplier is 1 */
   cmp r5, r2 /* compare Multiplier0 with 1 */
   beq step1a  /* if Multiplier0 = 0, branch to step 2 */
   b step2 /* else, branch to step1a */

step1a:
   push {r0, r1} /* save r0 and r1 before function call */
   mov r1, r4 /* move product into r1 */
   bl intadd /* call to intadd, adds product and multiplicand */
   mov r4, r0 /* move result into r4 */
   pop {r0, r1} /* restore regiesters */
   b step2 /* branch to step 2 */

step2: 
   lsl r0, #1 /* shift Multiplicand register left 1 bit */
   lsr r1, #1 /* shift Multiplier register right 1 bit */
   cmp r3, #32 /* compare counter with 32 */
   beq endif /* if count == 32, endif */
   b step1 /* else, branch to step1 */

endif:
   mov r0, r4 /* move product into r0 */
   pop {r1, r2, r3, r4, r5, pc}
