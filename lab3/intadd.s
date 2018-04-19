   .syntax unified
   @intadd by Jasmine Patel

   .arch armv6
   .fpu vfp

   @--------------

   .global intadd
intadd:
   push {r1, r2, r3, r4, lr}
   and r2, #0 /* make r2 = to 0, this will be carry */
   and r3, #0 /* make r3 = to 0, this will be the sum */
   and r4, #0 /* r4 = 0 */
   eor r3, r0, r1 /* sum = a exclusive or b */
   and r2, r0, r1 /* carry = a and b */
   cmp r2, r4 /* compare the carry to 0 */
   bne loop /* branch to loop if carry > 0 */
   b endif /* branch to endif */

loop:
   lsl r2, #1 /* carry << 1 */
   mov r0, r3 /* move the sum into a */
   mov r1, r2 /* move the carry into b */
   eor r3, r0, r1 /* sum = a exclusive or b */
   and r2, r0, r1 /* carry = a and b */
   cmp r2, r4 /* compare the carry to 0 */
   bne loop /* back to loop */
   b endif /* branch to endif */

endif:
   mov r0, r3 /* move the sum into the return value */
   pop {r1, r2, r3, r4, pc}
   

