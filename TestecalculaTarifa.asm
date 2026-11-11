.data
msg_resultado: .asciiz "Valor da tarifa (R$): "

.text
.globl main

main:
    la $a0, msg_resultado
    li $v0, 4
    syscall

    li $a0, 10     # Testando com XX minutos de permanencia ()
    jal calculaTarifa

    move $a0, $v0
    li $v0, 1
    syscall

    li $a0, 10
    li $v0, 11
    syscall

    li $v0, 10
    syscall

calculaTarifa:
    li $t0, 15
    ble $a0, $t0, tarifa_gratis

    li $t0, 60
    ble $a0, $t0, tarifa_primeira_hora

    subu $t1, $a0, 60
    addi $t1, $t1, 59
    li $t2, 60
    div $t1, $t2
    mflo $t1

    li $t3, 5
    mul $t1, $t1, $t3
    addi $v0, $t1, 10

    li $t4, 50
    bgt $v0, $t4, tarifa_teto
    jr $ra

tarifa_gratis:
    li $v0, 0
    jr $ra

tarifa_primeira_hora:
    li $v0, 10
    jr $ra

tarifa_teto:
    li $v0, 50
    jr $ra