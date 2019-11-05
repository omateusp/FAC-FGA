Alunos: Luis Claudio Telles Lima (16/0153204) e Mateus Oliveira (16/0015006)


        Relatório do Trabalho 02
Fundamentos de Arquitetura de Computadores
           Prof. Tiago Alves




* Sistema Operacional


O sistema foi construído no sistema operacional linux gnome;


* Ambiente de desenvolvimento 


Foi utilizado o ambiente MARS para desenvolvimento e Spim para teste;


* Instruções de Uso


1) Descompactar o arquivo.zip e abrir o arquivo mod-exp.asm no ambiente MARS;
2) Pressione F3 ou selecione Run->Assemble na parte superior do tela do MARS;
3) Na parte superior pressionar o botão verde(Run the current program) para rodar o programa;
4) Digitar o valor do primeiro número inteiro e pressionar ENTER; Digitar o valor do segundo número inteiro e pressionar ENTER; Digitar o valor do terceiro número inteiro e pressionar ENTER;
5) Caso algum dos tres numeros seja nao positivo ou maior que 65535 o programa imprimirá "Entradas inválidas.\n"
6) O primeiro lido corresponde a base, o segundo corresponde ao expoente, e o terceiro e o módulo.


* Limitações


Após a validação do intervalo dos número será verificado a primalidade do módulo e, se falso, o programa imprimirá "O modulo nao eh primo" e, se verdadeiro, o programa irá calcular e exponenciação modular com os valores de entrada a apresentar a mensagem especificada no enunciado com os mesmos.

* Exemplos de casos de teste:

Entradas:
5
3
13


Saídas:
A exponencial modular 5 elevado a 3 (mod 13) eh 8.


--------------------------------------------------
Entradas:
5
3
4


Saídas:
O modulo nao eh primo.


--------------------------------------------------
Entradas:
-5
3
11


Saídas:
Entradas invalidas.


--------------------------------------------------
Entradas:
5
0
11


Saídas:
Entradas invalidas.


--------------------------------------------------
Entradas:
5
2
-1


Saídas: 
Entradas invalidas.


--------------------------------------------------
Entradas:
5
3
1
Saídas:
O modulo nao eh primo.

--------------------------------------------------