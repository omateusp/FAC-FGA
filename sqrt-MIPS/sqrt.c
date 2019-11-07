#include <stdio.h>
#include <math.h>

void imprime_saida(double resp, int i, double x)
{
  printf("A raiz quadrada de %.0lf eh %.15lf, calculada em %d iteracoes.\n", x, resp, i);
}

double encontra_inteiros(double x)
{
  double i, somador = 1;
  int atual = 1;
  for (i = 0; somador < x; i++)
  {
    somador += atual;
    atual += 2;
  }
  return i - 1;
}

int calc_erro(double res, int e, double x)
{
  res = res * res;
  double erro, erromax;
  erro = x - res;
  if (erro < 0)
    erro = erro * (-1);
  erromax = 1.0 / pow(10, e);
  printf("erromax = %.16lf\n", erromax);
  if (erro < erromax)
    return 1;
  else
  {
    return 0;
  }
}

void calc_raiz(double a1, double x, int i, int e)
{
  printf("i= %d\n", i);
  double a2, b1;
  b1 = x / a1;
  a2 = (a1 + b1) / 2.0;
  printf("a= %lf b= %lf\n", a1, b1);
  if (i > 100)
  {
    printf("Nao foi possivel calcular sqrt(%.0lf).\n", x);
  }
  else if (calc_erro(a2, e, x))
  {
    imprime_saida(a2, i, x);
  }
  else
  {
    i++;
    calc_raiz(a2, x, i, e);
  }
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
    printf("a= %lf\n", a);
    calc_raiz(a, (double)x, 1, e);
  }
  return 0;
}