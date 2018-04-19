    .syntax unified

    @ Template file for Lab 3
    @ Jasmine Patel

    .arch armv6
    .fpu vfp 

    @ --------------------------------
    .global main
main:
    @ driver function main lives here, modify this for your other functions
      push {r0, r1, r2, r3, r4, r5, r6, r7, lr} /* save registers + lr */
loop:
      ldr r0, startstring /* load the startstring into r0 */
      bl printf /* prompt for the first int */
      ldr r0, =scanint /* load format specifier */
      mov r1, sp /* save sp to r1 */
      bl scanf /* scan first int from user */
      ldr r4, [sp] /* move the 1st scanned int into r4 */ 
      ldr r0, startstring2 /* load the next prompt into r0 */
      bl printf /* prompt for the second int */
      ldr r0, =scanint /* load format specifier */
      mov r1, sp /* save sp to r1 */
      bl scanf /* scan in 2nd int */
      ldr r5, [sp] /* move second int into r5 */
      ldr r0, startstring3 /* load third prompt */
      bl printf /* print third prompt */
      ldr r0, =scanchar /* load format specifier */
      mov r1, sp /* save sp to r1 */
      bl scanf /* scan operation type */
      ldr r1, =adding /* put address of + in r1 */
      ldrb r1, [r1] /* put the actual character + into r1 */
      ldrb r0, [sp] /* put users value into r0 */
      cmp r0, r1 /* compare users and + */
      beq goadd /* if equal, branch to add */
      ldr r1, =subtracting /* put address of - in r1 */
      ldrb r1, [r1] /* put the actual character - into r1 */
      ldrb r0, [sp] /* put users value into r0 */
      cmp r0, r1 /* compare users and - */
      beq gosub /* if equal, branch to subtract */
      ldr r1, =multiplying /* put address of * in r1 */
      ldrb r1, [r1] /* put the actual character * into r1 */
      ldrb r0, [sp] /* put users value into r0 */
      cmp r0, r1 /* compare users and * */
      beq gomul /* if equal, branch to multiply */
      ldr r0, startstring6 /* load invalid option message */
      bl printf /* print message */
      b again /* branch to again */

result:
   mov r1, r0 /* mov result into r1 */
   ldr r0, startstring4 /* load printing thing */
   bl printf /* print result is: */
   b again /* branch to again */
   
   
goadd:
   push {r1} /* save registers before calling add function */
   mov r0, r4 /* put first int into r0 */
   mov r1, r5 /* put second int into r1 */
   bl intadd /* call to intadd function */
   pop {r1} /* restore registers */
   b result /* branch to result */

gosub:
   push {r1} /* save registers before calling subtract function */
   mov r0, r4 /* put first int into r0 */
   mov r1, r5 /* put second int into r0 */
   bl intsub /* call intsub function */
   pop {r1} /* restore registers */
   b result /* branch to result */

gomul:   
   push {r1} /* save registers before calling mult function */
   mov r0, r4 /* put first int into r0 */
   mov r1, r5 /* put second int into r0 */
   bl intmul /* call intmul function */
   pop {r1} /* restore registers */
   b result /* branch to result */
   
again:
   ldr r0, startstring5 /* load "Again?" into r0 */
   bl printf /* print prompt */
   ldr r0, =scanchar /* load format specifier */
   mov r1, sp /* save sp in r1 */
   bl scanf /* scan user's answer */
   ldr r1, =no /* put address of n into r1 */
   ldrb r1, [r1] /* put the actual character 'n' into r1 */
   ldrb r0, [sp] /* put the users value into r0 */
   cmp r0, r1 /* compare users and 'n' */
   beq endif /* if equal, endif */
   ldr r1, =yes /* put address of y into r1 */
   ldrb r1, [r1] /* put y into r1 */
   ldrb r0, [sp] /* put user val into r0 */
   cmp r0, r1 /* compare users answer to char 'n' */
   beq loop /* if it is y, loop */

endif:
   pop {r0, r1, r2, r3, r4, r5, r6, r7, pc}


    @ You'll need to scan characters for the operation and to determine
    @ if the program should repeat.
    @ To scan a character, and compare it to another, do the following
    @  ldr     r0, =scanchar
    @  mov     r1, sp          @ Save stack pointer to r1, you must create space
    @  bl      scanf           @ Scan user's answer
    @  ldr     r1, =yes        @ Put address of 'y' in r1
    @  ldrb    r1, [r1]        @ Load the actual character 'y' into r1
    @  ldrb    r0, [sp]        @ Put the user's value in r0
    @  cmp     r0, r1          @ Compare user's answer to char 'y'
    @  b       loop            @ branch to appropriate location
    @ this only works for character scans. You'll need a different
    @ format specifier for scanf for an integer ("%d"), and you'll
    @ need to use the ldr instruction instead of ldrb to load an int.

startstring:
    .word string1
startstring2: 
    .word string2
startstring3:
    .word string4
startstring4:
    .word string3
startstring5:
    .word string5
startstring6:
    .word string6
yes:
    .byte   'y'
no:
    .byte   'n'

adding: 
    .byte   '+'
subtracting:
    .byte   '-'
multiplying:
    .byte   '*'
scanchar:
    .asciz  " %c"
scanint:
    .asciz  " %d"
string1:
    .asciz  "Enter Number 1: "
string2:
    .asciz  "Enter Number 2: "
string3:
    .asciz  "Result is: %d\n"
string4:
    .asciz  "Enter Operation: "
string5:
    .asciz  "Again? "
string6:
    .asciz  "Invalid                 Operation                 Entered. "
