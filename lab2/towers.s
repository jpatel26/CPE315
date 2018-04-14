.arch armv6
	.fpu vfp
	.text

@ print function is complete, no modifications needed
    .global	print
print:
	stmfd	sp!, {r3, lr}
	mov	r3, r0
	mov	r2, r1
	ldr	r0, startstring
	mov	r1, r3
	bl	printf
	ldmfd	sp!, {r3, pc}

startstring:
	 .word	string0

    .global	towers
towers:
   push {r3, r4, lr} /* registers to use */
   /* r3 = steps, r4 = peg */
   push {r0, r1, r2} /* input parameters */
   /* r0 = numDisks, r1 = start, r2 = goal */

if:
   cmp r0, #2 /* compare numDisks and 2 */
   bge else   /* if not base case !(d < 2), leave */
   push {r0, r1} /* save registers before we call print */
   mov r0, r1 /* move start to the first param */
   mov r1, r2 /* move goal to the second param */
   bl print /* call to print */
   pop {r0, r1} /* restore registers */
   mov r0, #1 /* set 1 as return value */
   mov r3, r0 /* set steps = 1 */
   b endif/* go to end of function */

else:
   mov r4, #6 /* move 6 into peg */
   sub r4, r4, r1 /* subtract start */
   sub r4, r4, r2 /* subtract goal */
   push {r0, r1, r2} /* save registers before call to towers */
   sub r0, r0, #1 /* subtract 1 from disks */
   mov r2, r4 /* set peg as goal */
   bl towers /* first call to towers */
   mov r3, r0 /* set steps to return value */
   pop {r0, r1, r2} /* restore registers */
   push {r0} /* save registers before call to towers */
   mov r0, #1 /* set numDisks to 1, other params are fine */
   bl towers /* second call to towers */ 
   add r3, r3, r0 /* add return value to steps */
   pop {r0} /* restore r0 */
   push {r0, r1} /* save registers before call to towers */
   sub r0, r0, #1 /* subtract 1 from disks */
   mov r1, r4 /* set peg as start, goal is fine */
   bl towers /* third call to towers */
   add r3, r3, r0 /* add return values to steps */
   pop {r0, r1} /* restore registers */
   mov r0, r3 /* set the return value as steps */
   b endif /* go to the end of the function */

endif:
   pop {r0, r1, r2}
   mov r0, r3 /* set the return value */ 
   pop {r3, r4, pc} 
   
   
   /* Restore Registers */

@ Function main is complete, no modifications needed
    .global	main
main:
	str	lr, [sp, #-4]!
	sub	sp, sp, #20
	ldr	r0, printdata
	bl	printf
	ldr	r0, printdata+4
	add	r1, sp, #12
	bl	scanf
	ldr	r0, [sp, #12]
	mov	r1, #1
	mov	r2, #3
	bl	towers
	str	r0, [sp]
	ldr	r0, printdata+8
	ldr	r1, [sp, #12]
	mov	r2, #1
	mov	r3, #3
	bl	printf
	mov	r0, #0
	add	sp, sp, #20
	ldr	pc, [sp], #4
end:

printdata:
	.word	string1
	.word	string2
	.word	string3

string0:
	.asciz	"Move from peg %d to peg %d\n"
string1:
	.asciz	"Enter number of discs to be moved: "
string2:
	.asciz	"%d"
	.space	1
string3:
	.ascii	"\n%d discs moved from peg %d to peg %d in %d steps."
	.ascii	"\012\000"
