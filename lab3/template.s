    .syntax unified

    @ Template file for Lab 3
    @ Team member names here

    .arch armv7
    .fpu vfp 

    @ --------------------------------
    .global main
main:
    @ driver function main lives here, modify this for your other functions


    @ You'll need to scan characters for the operation and to determine
    @ if the program should repeat.
    @ To scan a character, and compare it to another, do the following
      ldr     r0, =scanchar
      mov     r1, sp          @ Save stack pointer to r1, you must create space
      bl      scanf           @ Scan user's answer
      ldr     r1, =yes        @ Put address of 'y' in r1
      ldrb    r1, [r1]        @ Load the actual character 'y' into r1
      ldrb    r0, [sp]        @ Put the user's value in r0
      cmp     r0, r1          @ Compare user's answer to char 'y'
      b       loop            @ branch to appropriate location
    @ this only works for character scans. You'll need a different
    @ format specifier for scanf for an integer ("%d"), and you'll
    @ need to use the ldr instruction instead of ldrb to load an int.
yes:
    .byte   'y'
scanchar:
    .asciz  " %c"
