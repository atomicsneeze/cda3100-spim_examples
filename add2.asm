    .data
_a:       .space 4
_b:       .space 4
_c:       .space 4
_msg:     .asciiz "sum of two integer values = "
_newline: .asciiz "\n"
    .text
    .globl main
main:
    # read one integer value from keyboard into _a
    li $v0,5
    syscall
    la $8,_a
    sw $v0,0($8)
    # read another integer value from keyboard into _b
    li $v0,5
    syscall
    la $8,_b
    sw $v0,0($8)

    # load M[_a] to R[9]
    la $8,_a
    lw $9,0($8)
    # load M[_b] to R[10]
    la $8,_b
    lw $10,0($8)

    # add R[11], R[9],R[10]
    add $11,$9,$10

    # store R[???], M[_c]
    la $8,_c
    sw $11,0($8)

    # set $v0 = 4 (R[2]=4)
    # set $a0 = _msg
    # syscall
    li $2,4
    la $a0,_msg
    syscall

    # load M[_c] to R[4] $a0
    # set $v0 = 1
    # syscall
    la $8,_c
    lw $a0,0($8)
    li $2,1
    syscall

    li $2,4
    la $a0,_newline
    syscall

    # exit program
    jr $ra
