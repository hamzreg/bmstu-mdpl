#include <stdio.h>
#include <math.h>

#include "general.h"

#include "compare_sin.h"
#include "32_bit_operations.h"
#include "64_bit_operations.h"

#define OK 0

int main() 
{
  compare_sin();

  printf("\nADDITION AND MULTIPLICATION\n");

  result_32_bit();

  result_64_bit();

  result_80_bit();

  return OK;
}