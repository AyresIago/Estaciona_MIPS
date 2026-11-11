.data
msg_resultado: .asciiz "Indice da vaga do carro (0 a 7, ou -1 se nao achar): "
placa: .word 101, 202, 303, 0, 0, 0, 0, 0

.text
.globl main

main:
    la $a0, msg_resultado
    li $v0, 4
    syscall

    li $a0, 303         # Vamos testar procurando pelo carro de código 303
    jal achaCarro

    move $a0, $v0
    li $v0, 1
    syscall

    li $a0, 10
    li $v0, 11
    syscall

    li $v0, 10
    syscall

achaCarro:
    li $t0, 0
    li $t1, 8
    la $t2, placa

achaCarro_loop:
    bge $t0, $t1, achaCarro_nao_encontrado

    sll $t3, $t0, 2
    add $t3, $t2, $t3
    lw $t4, 0($t3)

    beq $t4, $a0, achaCarro_achou

    addiu $t0, $t0, 1
    j achaCarro_loop

achaCarro_nao_encontrado:
    li $v0, -1
    jr $ra

achaCarro_achou:
    move $v0, $t0
    jr $ra