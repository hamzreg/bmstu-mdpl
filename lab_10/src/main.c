#include <stdio.h>

#include "dot_product_vectors.h"

#define OK 0
#define TIME_REPEATS 1000000

int main(void)
{
    test_scalar_product(TIME_REPEATS);

    return OK;
}

