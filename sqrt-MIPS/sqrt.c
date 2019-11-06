#include <stdio.h>

double encontra_inteiros(double x)
{
  double i, i2 = 1;
  for (i = 2; i2 < x; i++)
  {
    i2 = i * i;
  }
  i -= 2;
  return i;
}

void calc_raiz(double a1, double x, int i, int e)
{
  double a2, b1;
  b1 = x / a1;
  a2 = (a1 + b1) / 2.0;
  if (i > 100)
  {
    printf("Nao foi possivel calcular sqrt(%.0lf).\n", x);
  }
  else if (calc_erro(b1, e, x))
  {
    imprime_saida(b1, i, x);
  }
  else
  {
    i++;
    calc_raiz(a2, x, i, e);
  }
}

int calc_erro(double b1, int e, double x)
{
  b1 = b1 * b1;
  double erro, erromax;
  erro = x - b1;
  if (erro < 0)
    erro = erro * (-1);
  erromax = 1.0 / pow(10, e);
  if (erro < erromax)
    return 1;
  else
  {
    return 0;
  }
}

void imprime_saida(double resp, int i, double x)
{
  printf("A raiz quadrada de %.0lf eh %.15lf, calculada em %d iteracoes.\n", x, resp, i);
}

int main()
{
  double a;
  int x, e;
  scanf("%d", &x);
  scanf("%d", &e);
  if (x <= 1 || e <= 0)
  {
    printf("Entradas invalidas.\n");
  }
  else
  {
    a = encontra_inteiros(x);
    calc_raiz(a, (double)x, 1, e);
  }
  return 0;
}