.data
fibResult:  .word   0         # Resultado de Fibonacci
newline:    .asciiz "\n"
prompt:     .asciiz "Ingrese el número de dígitos en la serie de Fibonacci: "

.text
.globl main

main:
    # Solicitar al usuario el número de dígitos
    li $v0, 4                # Código de servicio 4: Imprimir cadena
    la $a0, prompt
    syscall

    # Leer la entrada del usuario
    li $v0, 5                # Código de servicio 5: Leer entero
    syscall
    move $t3, $v0            # Almacenar la entrada en $t3 (fibInput)

    # Validar que el número de dígitos sea mayor a cero
    bgtz $t3, fibonacci_loop  # Si es mayor a cero, continuar
    li $v0, 10               # Código de servicio 10: Salir
    syscall

fibonacci_loop:
    # Inicializar registros
    li $t0, 0                # Inicializar i (contador)
    li $t1, 1                # Inicializar fib0
    li $t2, 1                # Inicializar fib1

fibonacci_loop_body:
    # Calcular el siguiente número de Fibonacci: fib(i) = fib(i-1) + fib(i-2)
    add $t4, $t1, $t2        # $t4 = fib(i-1) + fib(i-2)

    # Mostrar el resultado por consola
    move $a0, $t1            # Argumento 1: fib(i-1)
    li $v0, 1                # Código de servicio 1: Imprimir entero
    syscall

    # Imprimir un espacio en blanco para separar los números
    li $v0, 4                # Código de servicio 4: Imprimir cadena
    la $a0, newline
    syscall

    # Actualizar registros para la siguiente iteración
    move $t1, $t2            # fib(i-1) = fib(i-2)
    move $t2, $t4            # fib(i-2) = fib(i)

    # Incrementar el contador i
    addi $t0, $t0, 1

    # Comprobar si hemos alcanzado el número de dígitos deseado
    beq $t0, $t3, exit       # Si i == fibInput, salir del bucle

    # Saltar de nuevo al inicio del bucle
    j fibonacci_loop_body

exit:
    # Terminar el programa
    li $v0, 10               # Código de servicio 10: Salir
    syscall

