#include "general.h"
#include "64_bit_operations.h"

void sum_64_bit(double first, double second)
{
    double amount;

    for (size_t i = 0; i < REPEATS; ++i)
        amount = first + second;
}

void prod_64_bit(double first, double second)
{
    double prod;

    for (size_t i = 0; i < REPEATS; ++i)
        prod = first * second;
}


void sum_64_bit_asm(double first, double second)
{
    double amount;

    for (size_t i = 0; i < REPEATS; ++i)
        asm("fld %1\n"
            "fld %2\n"
            "faddp\n"
            "fstp %0\n"
            : "=m"(amount)
            : "m"(first), "m"(second));
}

void prod_64_bit_asm(double first, double second)
{
    double prod;

    for (size_t i = 0; i < REPEATS; ++i)
        asm("fld %1\n"
            "fld %2\n"
            "fmulp\n"
            "fstp %0\n"
            : "=m"(prod)
            : "m"(first), "m"(second));
}

void result_64_bit()
{
    printf("%zu bites\n", sizeof(double) * CHAR_BIT);

    double first = 5e20, second = 6e30;

    clock_t start = clock();
    sum_64_bit(first, second);
    clock_t end = clock();

    printf("time sum =  %-15.3g\n", (double)(end - start) / CLOCKS_PER_SEC / REPEATS);

    start = clock();
    sum_64_bit_asm(first, second);
    end = clock();

    printf("time sum asm =  %-15.3g\n", (double)(end - start) / CLOCKS_PER_SEC / REPEATS);


    start = clock();
    prod_64_bit(first, second);
    end = clock();

    printf("time prod =  %-15.3g\n", (double)(end - start) / CLOCKS_PER_SEC / REPEATS);

    start = clock();
    prod_64_bit_asm(first, second);
    end = clock();

    printf("time prod asm =  %-15.3g\n\n", (double)(end - start) / CLOCKS_PER_SEC / REPEATS);
}
