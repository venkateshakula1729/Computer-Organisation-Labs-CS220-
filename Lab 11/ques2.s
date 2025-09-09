# n : $s0
# i : $s1
# curr  pointer : $s2

        .text
        .globl  main

main:   li $v0, 5       # scanf("%d", n) 
        syscall
        move $s0, $v0   # put num = n in $s0
        addi $sp, $sp, -60
        move $s2, $sp
        xor $s1, $0, $0
        blez $s0, EXIT

START:  li $v0, 6       # scanf("%f", a[i]) 
        syscall
        swc1 $f0, 0($s2)
        addi $s2, $s2, 4
        addi $s1, $s1, 1
        slt $t0, $s1, $s0
        bne $t0, $0, START                                                               

EXIT:   move $s2, $sp
        mfc1 $0, $f12
        xor $s1, $0, $0
        blez $s0, EXIT2

START2: li $v0, 6       # scanf("%f", b[i]) 
        syscall  
        lwc1 $f1, 0($s2)
        mul.s $f2, $f0, $f1
        add.s $f12, $f12, $f2
        addi $s2, $s2, 4
        addi $s1, $s1, 1
        slt $t0, $s1, $s0
        bne $t0, $0, START2

EXIT2:  li $v0, 2
        syscall
        jr $ra