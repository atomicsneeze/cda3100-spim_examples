    .data
_msg:      .asciiz "type int value: "
_newline:  .asciiz "\n"
    .align 4
    .text
    .globl main
main:
    # allocate stack frame for local variable i and temp
    # M[sp] is the 4 bytes memeory for local variable "i" and
    # M[sp+4] is the 4 bytes memory for the local variable "temp"
    # M[sp+8+4*0],M[sp+8+4*1],M[sp+4+4*2] .. M[sp+4+4*9], which are
    # M[sp+8],M[sp+12]..,M[sp+40]
    addi $sp,$sp,-40
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

    # store the value read, which is in R[2] into arrays[i]
    # find the address of arrays[i]
    # load the value from M[temp]'
    # store the value to arrays[i]

    sw $2,4($sp)
    lw $2,4($sp)
    addu $9,$sp,8
    sll $10,$8,2
    add $11,$9,$10 # address of local arrays[i]
    sw $2,0($11)   # arrays[i]=R[2]

    addi $8,$8,1
    sw $8,0($sp)
    j L0
L2:
    # iterate over local arrays[] and print the value in each line
    sw $0,0($sp)
L00:
    lw $8,0($sp)
    slti $9,$8,10
    bne $9,$0,L10
    j L20
L10:
    addu $9,$sp,8
    sll $10,$8,2
    add $11,$9,$10 # address of local arrays[i]
    lw $4,0($11)
    li $2,1
    syscall

    # print "\n"
    li $2,4
    la $a0,_newline
    syscall

    addi $8,$8,1
    sw $8,0($sp)
    j L00
L20:
    jr $31
