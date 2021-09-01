#include "dot_product_vectors.h"

void scalar_product_c(float *result, const vector_t *a, const vector_t *b)
{
    *result = a->factors[0] * b->factors[0] +
              a->factors[1] * b->factors[1] +
              a->factors[2] * b->factors[2] +
              a->factors[3] * b->factors[3];
}

void scalar_product_asm(float *result, const vector_t *a, const vector_t *b)
{
    __asm__(".intel_syntax noprefix\n\t"
            "movaps xmm0, %1\n\t"
            "movaps xmm1, %2\n\t"
            "mulps xmm0, xmm1\n\t"
            "movhlps xmm1, xmm0\n\t"
            "addps xmm0, xmm1\n\t"
            "movaps xmm1, xmm0\n\t"
            "shufps xmm0, xmm0, 1\n\t"
            "addps xmm0, xmm1\n\t"
            "movss %0, xmm0\n\t"
            :"=m"(*result)
            :"m"(a->factors), "m"(b->factors)
            :"xmm0", "xmm1");
}

void test_scalar_product(size_t count)
{
    float result = 0;

    vector_t a[3] = {10, 10, 10};
    vector_t b[3] = {5, 5, 5};

    clock_t start = clock();
    printf(ANSI_COLOR_CYAN "\nC SCALAR PRODUCT\n" ANSI_COLOR_RESET);

    for (size_t i = 0; i < count; ++i)
    {
        scalar_product_c(&result, a, b);
    }
    clock_t end = clock() - start;
    
    printf("Result time = " ANSI_COLOR_GREEN "%.3g s\n" ANSI_COLOR_RESET, ((double) (end)) / CLOCKS_PER_SEC / (double) count);
    printf("Result = " ANSI_COLOR_GREEN "%.3lf\n" ANSI_COLOR_RESET, result);


    printf(ANSI_COLOR_CYAN "\nASM SCALAR PRODUCT\n" ANSI_COLOR_RESET);

    float asm_result = 0;

    start = clock();

    for (size_t i = 0; i < count; ++i) 
    {
        scalar_product_asm(&asm_result, a, b);
    }
    end = clock() - start;

    printf("Result time = " ANSI_COLOR_GREEN "%.3g s\n" ANSI_COLOR_RESET, ((double) (end)) / CLOCKS_PER_SEC / (double) count);
    printf("Result = " ANSI_COLOR_GREEN "%.3lf\n" ANSI_COLOR_RESET, asm_result);
}
