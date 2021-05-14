#include "compare_sin.h"

void compare_sin()
{
  printf("\nCOMPARE SIN\n");

  double result = 0.0;

  printf("sin(pi)\n");
  printf("sin(3.14) = %g\n", sin(3.14));
  printf("sin(3.141596) = %g\n", sin(3.141596));

  asm("fldpi\n"
      "fsin\n"
      "fstp %0\n"
      : "=m"(result));
  printf("sin(pi) asm = %g\n\n", result);


  printf("sin(pi / 2)\n");
  printf("sin(3.14 / 2) = %g\n", sin(3.14 / 2));
  printf("sin(3.141596 / 2) = %g\n", sin(3.141596 / 2));

  asm("fldpi\n"
      "fld1\n"
      "fld1\n"
      "faddp\n"
      "fdiv\n"
      "fsin\n"
      "fstp %0\n"
      : "=m"(result));
  printf("sin(pi / 2) asm = %g\n\n", result);
}
