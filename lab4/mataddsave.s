    /* This function has 5 parameters, and the declaration in the
       C-language would look like:

       void matadd (int **C, int **A, int **B, int height, int width)

       C, A, B, and height will be passed in r0-r3, respectively, and
       width will be passed on the stack.

       You need to write a function that computes the sum C = A + B.

       A, B, and C are arrays of arrays (matrices), so for all elements,
       C[i][j] = A[i][j] + B[i][j]

       You should start with two for-loops that iterate over the height and
       width of the matrices, load each element from A and B, compute the
       sum, then store the result to the correct element of C. 

       This function will be called multiple times by the driver, 
       so don't modify matrices A or B in your implementation.

       As usual, your function must obey correct ARM register usage
       and calling conventions. */

	.arch armv7-a
	.text
	.align	2
	.global	matadd
	.syntax unified
	.arm

matadd:
   push {r0, r1, r2, r3, r4, r5, r6,r7, r8, r9, r10, r11, r12, lr} /* push registers to stack */ 
   ldr r4, [sp, #56] /* load width into r1 */
   lsl r3, #2       /* multiply height by 4 */
   lsl r4, #2       /* multiply width by 4 */
row_loop:
   cmp r3, #0       /* compare height to 0. If <= 0, then end */
   ble end_row_loop
   sub r3, r3, #4   /* decrement height by 4 */
   mov r8, r4       /* reset width counter, get ready to iter new row columns */
column_loop:
   cmp r8, #0       /* compare width with 0, If <= 0, end */
   ble row_loop
   sub r8, r8, #4   /* decrement width by 4 */

   ldr r5, [r1, r3] /* load address of A[height] into r5 */
   ldr r5, [r5, r8] /* load A[height][width] into r5 */
   ldr r7, [r2, r3] /* load address of B[height] into r7 */
   ldr r7, [r7, r8] /* load /* B[height][width] */
   add r7, r7, r5   /* add a[i][j] to b[i][j] into r7 */ 
   ldr r6, [r0, r3] /* load the address of C[height] into r6 */
   str r7, [r6, r8] /* store a[i][j] + b[i][j] into c[i][j] */

   b column_loop    /* loop again (back to guard) */

end_row_loop:
   pop {r0, r1, r2, r3, r4, r5, r6,r7, r8, r9, r10, r11, r12, pc} /* restore registers */

