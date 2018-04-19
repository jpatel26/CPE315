
   .syntax unified
   @intadd by Jasmine Patel

   .arch armv6
   .fpu vfp

   @--------------

   .global intsub
intsub:
   push {r1, r2, lr}
   mvn r1, r1 /* r1 gets r1 flipped(-b) */
   mov r2, r0 /* mov a to r2 for safe keeping */
   mov r0, #1 /* move 1 into r0 */
   bl intadd /* adds 1 to complete flip(-b) */
   mov r1, r0 /* move result into r1 */
   mov r0, r2 /* move a into r0 */
   bl intadd /* adds a and -b */
   pop {r1, r2, pc}
