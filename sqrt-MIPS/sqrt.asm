.data
  entra_inv: .asciiz "Entradas invalidas.\n"
  imposs_msg: .asciiz "Nao foi possivel calcular sqrt("
  imposs_msg2: .asciiz ").\n"
  numero_01: .double 1.0
  numero_10: .double 10.0
  numero_100: .double 100.0
  res1: .asciiz "A raiz quadrada de "
  res2: .asciiz " eh "
  res3: .asciiz ", calculada em "
  res4: .asciiz " iteracoes.\n"

.text
  main:
    li $v0,7                ##
		syscall                 # scanf("%lf", &x);
    mov.d $f20, $f0         ## $f20 = x

    li $v0,5                ##
		syscall                 # scanf("%d", &e);
    move $s3, $v0           ## $s3 = e

    # li $v0,7                ##
		# syscall                 # scanf("%lf", &e);
    # mov.d $f22, $f0         # $f22 = e

    ldc1 $f10, numero_01    # $f10 = 1.0 = somador

    c.le.d $f20, $f10       ##
    bc1t entradas_invalidas # if (x <= 1 || e <= 0)
    ble $s3, $zero, entradas_invalidas
    # c.lt.d $f22, $f10       #   printf("Entradas invalidas.\n");
    # bc1t entradas_invalidas #

    # ldc1 $f24, numero_00    # $f24 = 0.0
    mov.d $f6, $f10         # $f6 = 1
    mov.d $f4, $f10         # $f4 = 1 = atual
    mov.d $f28, $f10        # $f28 = 1 = n
    add.d $f8, $f4, $f4     # $f8 = 2

    jal encontra_inteiros   # $f24 = encontra_inteiros($f20);

    div.d $f26, $f20, $f24  # b1 = x/a1

    jal decobrir_erro_max   # $f28 = erromax

    jal prep_calc_raiz

    li $v0, 10              ##
    syscall                 # exit program

  entradas_invalidas:
    la $a0, entra_inv
    li $v0, 4
    syscall

    li $v0, 10              ##
    syscall                 # exit program

  encontra_inteiros:        ##  somador = $f10 atual = $f4
    add.d $f10, $f10, $f4   # for (i = 0; somador < x; i++)
    add.d $f4, $f4, $f8     # 
    add.d $f24, $f24, $f6   # $f24 = b++
    c.lt.d $f10, $f20
    bc1t encontra_inteiros
    sub.d $f24, $f24, $f6    # $f24 = a0
    jr $ra

  decobrir_erro_max:
    # $f22 = n
    ldc1 $f28, numero_10
    mov.d $f30, $f28
    addi $t0, $zero, 1
    # cvt.w.d $t1, $f22
  loop:
    addi $t0, $t0, 1
    bgt $t0, $s3, exit_loop
    mul.d $f28, $f28, $f30
    j loop
  exit_loop:
    div.d $f28, $f6, $f28
    jr $ra


  prep_calc_raiz:
    # a1= $f24, b1= $f26
    # a2= $f4, b2= $f10
    # i = $s0
    addi $s0, $zero, 1      # int i = 1,
    addi $s1, $zero, 100    # limit = 100;
    move $s2, $ra           # exit adress
  calc_raiz:
    add.d $f4, $f24, $f26   ##
    div.d $f4, $f4, $f8     # a2 = (a1 + b1) / 2;

    div.d $f10, $f20, $f4   # b2 = x / a2;

    jal calc_erro           # check if erro < erro_max

    mov.d $f24, $f4         # a1 = a2
    mov.d $f26, $f10        # b1 = b2
    addi $s0, $s0, 1        # i++
    bgt $s0, $s1, impossivel_calc # if(i > 100) = exit_erro
    j calc_raiz             # loop

  impossivel_calc:
    la $a0, imposs_msg      ##
    li $v0, 4               # printf("Nao foi possivel calcular sqrt(%.0lf).\n", x);
    syscall

    cvt.w.d $f20, $f20
    mfc1 $t1, $f20
    li $v0, 1
    move $a0, $t1
    syscall

    la $a0, imposs_msg2
    li $v0, 4
    syscall
    jr $s2

  calc_erro:
    mul.d $f16, $f10, $f10  # res = bn^2
    sub.d $f18, $f20, $f16  # erro = x - res

    abs.d $f18, $f18        # módulo do erro

    # erromax = $f28
    c.lt.d $f18, $f28
    bc1t imprime_resposta

    jr $ra
  
  imprime_resposta:
    li $v0, 4
    la $a0, res1
    syscall

    cvt.w.d $f20, $f20
    mfc1 $t1, $f20
    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, res2
    syscall

    li $v0, 3
    mov.d $f12, $f10
    syscall

    li $v0, 4
    la $a0, res3
    syscall

    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, res4
    syscall