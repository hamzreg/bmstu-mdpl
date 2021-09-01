#ifndef DOT_PRODUCT_VECTORS_H
#define DOT_PRODUCT_VECTORS_H

#include <stdio.h>
#include <time.h>

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_RESET   "\x1b[0m"

#define COUNT_FACTORS 4

typedef struct 
{
    float factors[COUNT_FACTORS];
} vector_t;

void test_scalar_product(size_t count);

#endif
