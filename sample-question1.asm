    .data
_msg:      .asciiz "factorial = "
_newline:  .asciiz "\n"
    .align 4
    .text
    #
    #  function factorial
    #
    .globl factorial
factorial:
    addi $sp,$sp,-4 # allocate 4 bytes in M[sp] for value
    sw $a0,0($sp)   # value = arg
    addi $a0,$a0,-1
LOOP:
    slti $8,$a0,1
    beq $8,$0,L1
    j L2
L1:
    lw $8,0($sp) # read M[$sp] to $8
    mult $8,$a0
    mflo $8
    sw $8,0($sp) # store (value*arg) to M[$sp]
    addi $a0,$a0,-1
    j LOOP
L2:
    lw   $v0,0($sp)
    addi $sp,$sp,4
    jr $31
    #
    #  function main
    #
    .globl main
main:
    # allocate stack frame M[$sp] for local variable "value"
    # allocate stack frame M[$sp+4] for saving/restoring $31
    addi $sp,$sp,-8
    sw   $31,4($sp)
    li   $a0,4
    jal  factorial    # return value in $v0 register
    sw   $v0,0($sp)   # value = factorial(4)
    li   $v0,4
    la   $a0,_msg
    syscall           # print "factorial = "

    li   $v0,1
    lw   $a0,0($sp)
    syscall           # print value

    li   $v0,4
    la   $a0,_newline
    syscall           # print "\n"

    lw   $31,4($sp)
    addi $sp,$sp,8
    jr $31
