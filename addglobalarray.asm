    .data
_arrays:   .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
_msg:      .asciiz "type int value: "
_newline:  .asciiz "\n"
    .align 4
    .text
    ########
    # main #
    ########
    .align 4
    .globl main
main:
    addi $sp,$sp,-4
    sw $ra,0($sp) # M[sp]=0
    jal addglobalarray
    # exit program
    lw $ra,0($sp)
    addi $sp,$sp,4
    jr $ra
    ########
    # main #
    ########
    .align 4
    .globl addglobalarray
addglobalarray:
    # allocate stack frame for local variable i and temp
    # M[sp] is the 4 bytes memeory for local variable "i" and
    # M[sp+4] is the 4 bytes memory for the local variable "temp"
    addi $sp,$sp,-32

    sw $0,0($sp) # M[sp]=0
L0:
    lw $8,0($sp) # R[8]=M[sp]
    slti $9,$8,10
    bne $9,$0,L1
    j L2
L1:
    # print "Type int value: "
    li $2,4
    la $a0,_msg
    syscall

    # read 4 bytes int value from keyboard
    li $v0,5
    syscall

    # store the value read, which is in R[2] into the
    # local variable temp
    # find the address of arrays[i]
    # load the value from M[temp]'
    # store the value to arrays[i]
    sw $2,4($sp)
    lw $2,4($sp)
    la $9,_arrays
    sll $10,$8,2
    add $11,$9,$10 # address of arrays[i]
    sw $2,0($11)   # arrays[i]=R[2]

    addi $8,$8,1
    sw $8,0($sp)
    j L0
L2:
    sw $0,0($sp)   # initialize i = 0
L00:
    lw $8,0($sp)
    slti $9,$8,10
    bne $9,$0,L10
    j L20
L10:
    # temp = arrays[i]
    la $9,_arrays
    sll $10,$8,2
    add $11,$9,$10 # address of arrays[i]
    lw $9,0($11)
    sw $9,4($sp)   # temp = arrays[i]
    # print temp to console
    lw $a0,4($sp)
    li $v0,1
    syscall
    # print newline to console
    la $a0,_newline
    li $v0,4
    syscall
    # i++
    addi $8,$8,1
    sw $8,0($sp)
    j L00
L20:
    # exit program
    addi $sp,$sp,32
    jr $ra
