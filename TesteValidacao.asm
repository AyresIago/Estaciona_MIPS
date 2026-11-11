.data
s_titulo: .asciiz "=== TESTE LERINT ===\n"
msg_teste: .asciiz "Digite um valor entre 1 e 100: "
msg_invalida: .asciiz "Entrada invalida. Digite um numero.\n"
msg_fora_faixa: .asciiz "Valor fora da faixa.\n"
msg_resultado: .asciiz "Voce digitou: "
buf: .space 16

.text
.globl main

main:
    la $a0, s_titulo
    li $v0, 4
    syscall

    la $a0, msg_teste
    li $a1, 1
    li $a2, 100
    jal lerInt

    move $s0, $v0

    la $a0, msg_resultado
    li $v0, 4
    syscall

    move $a0, $s0
    li $v0, 1
    syscall

    li $a0, 10
    li $v0, 11
    syscall

    li $v0, 10
    syscall

lerInt:
    addiu $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    move $s0, $a0
    move $s1, $a1
    move $s2, $a2

lerInt_inicio:
    move $a0, $s0
    li $v0, 4
    syscall

    la $a0, buf
    li $a1, 16
    li $v0, 8
    syscall

    lb $t0, 0($a0)
    beqz $t0, lerInt_eof
    li $t1, 10
    beq $t0, $t1, lerInt_eof

    li $v0, 0
    move $t1, $a0

lerInt_loop_char:
    lb $t0, 0($t1)
    beqz $t0, lerInt_valida_faixa
    li $t2, 10
    beq $t0, $t2, lerInt_valida_faixa

    blt $t0, 48, lerInt_erro_invalido
    bgt $t0, 57, lerInt_erro_invalido

    mul $v0, $v0, 10
    subi $t0, $t0, 48
    add $v0, $v0, $t0

    addiu $t1, $t1, 1
    j lerInt_loop_char

lerInt_erro_invalido:
    la $a0, msg_invalida
    li $v0, 4
    syscall
    j lerInt_inicio

lerInt_valida_faixa:
    blt $v0, $s1, lerInt_erro_faixa
    bgt $v0, $s2, lerInt_erro_faixa
    j lerInt_fim

lerInt_erro_faixa:
    la $a0, msg_fora_faixa
    li $v0, 4
    syscall
    j lerInt_inicio

lerInt_eof:
    li $v0, -1

lerInt_fim:
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    addiu $sp, $sp, 16
    jr $ra