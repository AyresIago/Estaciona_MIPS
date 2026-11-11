.data
msg_resultado: .asciiz "Primeira vaga livre (indice 0 a 7): "
placa: .word 101, 202, 0, 404, 505, 0, 707, 808

.text
.globl main

main:
    la $a0, msg_resultado
    li $v0, 4
    syscall

    jal achaVagaLivre

    move $a0, $v0
    li $v0, 1
    syscall

    li $a0, 10
    li $v0, 11
    syscall

    li $v0, 10
    syscall

achaVagaLivre:
    li $t0, 0
    li $t1, 8
    la $t2, placa

achaVagaLivre_loop:
    bge $t0, $t1, achaVagaLivre_lotado

    sll $t3, $t0, 2      # indice x 4
    add $t3, $t2, $t3   # soma o deslocamento para entender
    lw $t4, 0($t3)      # carrega

    beqz $t4, achaVagaLivre_achou

    addiu $t0, $t0, 1
    j achaVagaLivre_loop

achaVagaLivre_lotado:
    li $v0, -1
    jr $ra

achaVagaLivre_achou:
    move $v0, $t0
    jr $ra