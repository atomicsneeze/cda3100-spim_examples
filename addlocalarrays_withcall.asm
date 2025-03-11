    .data
_msg:      .asciiz "type int value: "
_newline:  .asciiz "\n"
    .align 4
    .text
    .globl main
main:
    # allocate stack frame for
    # 1. local variable arrays[] with 10 elements
    # 2. save original return address from the caller to main
    #
    # M[$sp+0]  .. M[$sp+36] is form arrays[0]..arrays[9]
    # M[$sp+40] is to save and restore $31 (return address)

    addi $sp,$sp,-44
    sw $ra,40($sp) # M[$sp]=R[31] # save return addresss

    add $a0,$sp,$0    # prepare the 1st argument for addlocalarray
    li  $a1,10        # prepare the 2nd argument for addlocalarray
    jal addlocalarray # call addlocalarray(&arrays[0],10)

    lw $ra,40($sp)    # restore return address R[31]=M[$sp]
    addi $sp,$sp,44
    jr $ra

    .globl addlocalarray

addlocalarray:
    #
    # M[$sp] is the 4 bytes memeory for local variable "i" and
    # M[sp+4] is the 4 bytes memory for the local variable "temp"
    # R[$a0] is the first argument, address of &(arrays[0])
    # R[$a1] is the second argument, the length of the arrays
    #
    addi $sp,$sp,-32

    # $8 = $a0, $8 has the base address of arrays[]
    add  $8,$a0,$0
    # $9 = $a1  $9 has the number of elements of arrays[]
    add  $9,$a1,$0

    # M[$sp] is the 4 bytes memeory for local variable "i" and
    sw $0,0($sp)     # i = 0
L0:
    lw $10,0($sp)
    slt $11,$10,$9
    bne $11,$0,L1     # if (i < size) goto L1
    j L2             # goto L2
L1:
    # print "Type int value: "
    li $2,4
    la $a0,_msg
    syscall

    # read 4 bytes int value from keyboard
    li $v0,5
    syscall

    sw $v0,4($sp)  # temp = int value read from keyboard

    # arrays[i] = temp
    lw $10,0($sp)  # load the value of i to R[10]
    sll $11,$10,2
    add $11,$8,$11 # calcuate the address of arrays[i]
    lw $12,4($sp)  # load the value of temp to R[10]
    sw $12,0($11)  # arrays[i] = temp

    lw $10,0($sp)
    addi $10,$10,1
    sw $10,0($sp)  # i++
    j L0           # goto L0
L2:
    # iterate over local arrays[] and print the value in each line
    sw $0,0($sp)
L00:
    lw $10,0($sp)
    slt $11,$10,$9
    bne $11,$0,L10     # if (i < size) goto L10
    j L20
L10:
    lw $10,0($sp)
    sll $10,$10,2
    add $11,$8,$10  # compute the address of arrays[i]
    lw $4,0($11)    # $a0 = arrays[i]
    li $2,1
    syscall

    # print "\n"
    li $2,4
    la $a0,_newline
    syscall

    lw $10,0($sp)
    addi $10,$10,1
    sw $10,0($sp)  # i++
    j L00
L20:
    addi $sp,$sp,32
    jr $31
