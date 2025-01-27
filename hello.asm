    .data
_msg:
    .asciiz "Hello! This is CDA 3100!\n"
    .text
    .globl main
main:
    #print out a message
    li $2,4
    la $a0,_msg
    syscall

    # exit program
    jr $ra

