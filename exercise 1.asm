.data
    num1: .word 0
    num2: .word 0
    num3: .word 0
    result: .word 0
    message: .asciiz "El número mayor es: "

.text
.globl main

main:
    # Leer el primer número
    li $v0, 5
    syscall
    sw $v0, num1

    # Leer el segundo número
    li $v0, 5
    syscall
    sw $v0, num2

    # Leer el tercer número
    li $v0, 5
    syscall
    sw $v0, num3

    # Cargar el primer número en $t0
    lw $t0, num1

    # Comparar con el segundo número
    lw $t1, num2
    bgt $t0, $t1, num1_is_larger
    move $t0, $t1

num1_is_larger:
    # Comparar con el tercer número
    lw $t1, num3
    bgt $t0, $t1, display_result
    move $t0, $t1

display_result:
    # Imprimir el mensaje
    la $a0, message
    li $v0, 4
    syscall

    # Imprimir el número mayor
    move $a0, $t0
    li $v0, 1
    syscall

    # Terminar el programa
    li $v0, 10
    syscall
