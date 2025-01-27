    .data
_a:  .space 4
_b:  .space 4
_c:  .space 4
_msg1:    .asciiz "sum of two integer values = "
_newline: .asciiz "\n"

    .text
    .globl main
main:
    # read integer into a
    # read integer into b
    li $v0,5
    syscall
    la $t8,_a
    sw $v0,0($t8)
    li $v0,5
    syscall
    la $t8,_b
    sw $v0,0($t8)

    la $t8,_a
    lw $t0,0($t8)
    la $t8,_b
    lw $t1,0($t8)
    add $t0,$t0,$t1

    la $t8,_c
    sw $t0,0($t8)

    # prompt "sum of two integer values =
    li $v0,4
    la $a0,_msg1
    syscall

    li $v0,1
    la $t8,_c
    lw $a0,0($t8)
    syscall

    # print newline
    li $v0,4
    la $a0,_newline
    syscall

    jr $ra
