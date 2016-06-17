/* See COPYRIGHT for copyright information. */

#include <inc/mmu.h>
#include <inc/memlayout.h>
#include <inc/trap.h>



###################################################################
# exceptions/interrupts
###################################################################

/* TRAPHANDLER defines a globally-visible function for handling a trap.
 * It pushes a trap number onto the stack, then jumps to _alltraps.
 * Use TRAPHANDLER for traps where the CPU automatically pushes an error code.
 *
 * You shouldn't call a TRAPHANDLER function from C, but you may
 * need to _declare_ one in C (for instance, to get a function pointer
 * during IDT setup).  You can declare the function with
 *   void NAME();
 * where NAME is the argument passed to TRAPHANDLER.
 */
#define TRAPHANDLER(name, num)						\
	.globl name;		/* define global symbol for 'name' */	\
	.type name, @function;	/* symbol type is function */		\
	.align 2;		/* align function definition */		\
	name:			/* function starts here */		\
	pushl $(num);							\
	jmp _alltraps

/* Use TRAPHANDLER_NOEC for traps where the CPU doesn't push an error code.
 * It pushes a 0 in place of the error code, so the trap frame has the same
 * format in either case.
 */
#define TRAPHANDLER_NOEC(name, num)					\
	.globl name;							\
	.type name, @function;						\
	.align 2;							\
	name:								\
	pushl $0;							\
	pushl $(num);							\
	jmp _alltraps

.text

/*
 * Lab 3: Your code here for generating entry points for the different traps.
 */
#define ARRAY_TRAPHANDLER(name, num)   \
.data;  \
    .long name;  \
.text;  \
    TRAPHANDLER(name, num)

#define ARRAY_TRAPHANDLER_NOEC(name, num)   \
.data;   \
    .long name; \
.text;   \
    TRAPHANDLER_NOEC(name, num)

.text
    .global _alltraps
.data
    .global vectors
vectors:
    ARRAY_TRAPHANDLER_NOEC(vector0, 0)
    ARRAY_TRAPHANDLER_NOEC(vector1, 1)
    ARRAY_TRAPHANDLER_NOEC(vector2, 2)
    ARRAY_TRAPHANDLER_NOEC(vector3, 3)
    ARRAY_TRAPHANDLER_NOEC(vector4, 4)
    ARRAY_TRAPHANDLER_NOEC(vector5, 5)
    ARRAY_TRAPHANDLER_NOEC(vector6, 6)
    ARRAY_TRAPHANDLER_NOEC(vector7, 7)
    ARRAY_TRAPHANDLER(vector8, 8)
    ARRAY_TRAPHANDLER_NOEC(vector9, 9)
    ARRAY_TRAPHANDLER(vector10, 10)
    ARRAY_TRAPHANDLER(vector11, 11)
    ARRAY_TRAPHANDLER(vector12, 12)
    ARRAY_TRAPHANDLER(vector13, 13)
    ARRAY_TRAPHANDLER(vector14, 14)
    ARRAY_TRAPHANDLER_NOEC(vector15, 15)
    ARRAY_TRAPHANDLER_NOEC(vector16, 16)
    ARRAY_TRAPHANDLER(vector17, 17)
    ARRAY_TRAPHANDLER_NOEC(vector18, 18)
    ARRAY_TRAPHANDLER_NOEC(vector19, 19)
    ARRAY_TRAPHANDLER_NOEC(vector20, 20)
    ARRAY_TRAPHANDLER_NOEC(vector21, 21)
    ARRAY_TRAPHANDLER_NOEC(vector22, 22)
    ARRAY_TRAPHANDLER_NOEC(vector23, 23)
    ARRAY_TRAPHANDLER_NOEC(vector24, 24)
    ARRAY_TRAPHANDLER_NOEC(vector25, 25)
    ARRAY_TRAPHANDLER_NOEC(vector26, 26)
    ARRAY_TRAPHANDLER_NOEC(vector27, 27)
    ARRAY_TRAPHANDLER_NOEC(vector28, 28)
    ARRAY_TRAPHANDLER_NOEC(vector29, 29)
    ARRAY_TRAPHANDLER_NOEC(vector30, 30)
    ARRAY_TRAPHANDLER_NOEC(vector31, 31)
    ARRAY_TRAPHANDLER_NOEC(vector48, 48)

/*
 * Lab 3: Your code here for _alltraps
 */

.text
    .global _alltraps

_alltraps:
    pushl %ds
    pushl %es
    pushal
    movw $GD_KD, %ax
    movw %ax, %ds
    movw %ax, %es
    pushl %esp
    call trap

