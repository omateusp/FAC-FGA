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

int calc_erro(double res, double e, double x)
{
  res = res * res;
  double erro, erromax;
  erro = x - res;

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

void calc_raiz(double a1, double b1, double x, int i, double e)
{
  double a2, b2;
  printf("a1= %lf b1= %lf\n", a1, b1);

  a2 = (a1 + b1) / 2;
  printf("a2 = %lf\n", a2);

  b2 = x / a2;
  printf("b2 = %lf\n", b2);
  if (i > 100)
  {
    printf("Nao foi possivel calcular sqrt(%.0lf).\n", x);
  }
  else if (calc_erro(b2, e, x))
  {
    imprime_saida(b2, i, x);
  }
  else
  {
    i++;
    calc_raiz(a2, b2, x, i, e);
  }
}

int main()
{
  double a, b;
  double x, e;
  scanf("%lf", &x);
  scanf("%lf", &e);

  if (x <= 1 || e <= 0)
  {
    printf("Entradas invalidas.\n");
  }
  else
  {
    a = encontra_inteiros(x);
    b = x / a;
    printf("a= %lf, b= %lf\n", a, b);
    calc_raiz((double)a, b, x, 1, e);
  }
  return 0;
}