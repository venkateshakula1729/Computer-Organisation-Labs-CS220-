# num -> $s0
# k -> $s1

        .text
        .globl  main

fib:    addi $sp, $sp, -12
        sw $ra, 4($sp)
        sw $a0, 0($sp)
        beq $a0, 1, label
        beq $a0, 2, label
        addi $a0, $a0, -2
        jal fib
        sw $v0, 8($sp)
        addi $a0, $a0, 1
        jal fib
        addi $a0, $a0, 1
        lw $t0 8($sp)
        addu $v0, $t0, $v0
        j branch
label:  li $v0, 1   # n == 1 || n == 2
branch: bne $a0, $s1, return
        move $t1, $a0   # put n in $t1
        move $t0, $v0   # put z in $t0
        li $v0, 1
        move $a0, $t0
        syscall
        addi $s1, $s1, 1    # k++
        beq $t1, $s0, jump
        li $v0, 11       # print space
        li $a0, ','
        syscall
jump:   move $a0, $t1
        move $v0, $t0
return: lw $a0, 0($sp)
        lw $ra, 4($sp)
        addi $sp, $sp, 12
        jr $ra

main:   li $v0, 5       # scanf("%d", n) 
        syscall
        move $s0, $v0   # put num = n in $s0
        li $s1, 1       # int k = 1
        addi $sp, $sp, -4
        sw $ra, 0($sp)
        move $a0, $s0
        jal fib
        add $v0, $0, $0
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra