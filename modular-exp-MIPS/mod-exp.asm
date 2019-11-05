main:
		li $v0, 5          #call to read int
		syscall              	
		move $t0, $v0      #move int to $t0(base)

		li $v0, 5          #call to read int
		syscall
		move $t1, $v0      #move int to $t1(expoente)
 
		li $v0, 5          #call to read int
		syscall
		move $t2, $v0      #move int to $t2(mod)
		
		ble $t0, $zero, imprime_erro1
		ble $t1, $zero, imprime_erro1
		ble $t2, $zero, imprime_erro1
		
		bgt $t0, 65535, imprime_erro1
		bgt $t1, 65535, imprime_erro1
		bgt $t2, 65535, imprime_erro1	
		
		blt $t2, 2, imprime_erro2   #if (n < 2) -> nao eh primo
		
		beq $t2, 2, exponenciacaoModular     # if(n==2) -> eh_primo
		
		rem $s0, $t2, 2         # if(n%2==0) -> nao eh_primo 
		beq $s0, 0, imprime_erro2

		li $t4, 3
		
		breakLoop:
			blt $t2, 255, verifyIsPrime
			j verifyIsPrime2
		
		verifyIsPrime:
			beq $t4, $t2, exponenciacaoModular
			
			rem $t8, $t2, $t4
			beq $t8, 0, imprime_erro2
			
			addi $t4, $t4, 2
			j verifyIsPrime	

		verifyIsPrime2:
			beq $t4, 255, exponenciacaoModular
			
			rem $t8, $t2, $t4
			beq $t8, 0, imprime_erro2
			
			addi $t4, $t4, 2
			j verifyIsPrime	
											
	imprime_erro1:
		la $a0, erro1
		li $v0, 4
		syscall
		
		li $v0, 10
		syscall
	
	imprime_erro2:
		la $a0, erro2	
		li $v0, 4
		syscall
		
		li $v0, 10
		syscall
		
	exponenciacaoModular:
		add $t5, $t0, $zero	
		add $t6, $t1, $zero
		add $t7, $t2, $zero
						
		li $t3, 1          #resposta($t3) = 1
		
		rem $t0, $t0, $t2  #base = base % mod;
			
		while:
			ble $t1, 0, finish   #if(expoente<=0) termina
			
			add $t9, $zero, $t1
			and $t9, 1           #if (expoente e impar) 
			beq $t9, 1, impar
			
			j continua	
			
		impar:
			mul $t3, $t3, $t0    #resposta = resposta * base % mod;
			rem $t3, $t3, $t2
					
		continua:
			srl $t1, $t1, 1      #expoente >>= 1;(divisao inteira por dois)
			
			mul $t0, $t0, $t0    #base = base * base % mod;
			rem $t0, $t0, $t2
			
			j while

		finish:
			la $a0, res1
			li $v0, 4
			syscall
			
			move $a0, $t5
			li $v0, 1
			syscall

			la $a0, res2
			li $v0, 4
			syscall
			
			move $a0, $t6
			li $v0, 1
			syscall
			
			la $a0, res3
			li $v0, 4
			syscall

			move $a0, $t7
			li $v0, 1
			syscall

			la $a0, res4
			li $v0, 4
			syscall
			
			move $a0, $t3
			li $v0, 1
			syscall

			la $a0, res5
			li $v0, 4
			syscall			
			
			li $v0, 10
			syscall

.data 
	erro1: .asciiz "Entradas invalidas.\n"
	erro2: .asciiz "O modulo nao eh primo.\n"
	res1: .asciiz "A exponencial modular "
	res2: .asciiz " elevado a "
	res3: .asciiz " (mod "
	res4: .asciiz ") eh "
	res5: .asciiz ".\n" 
