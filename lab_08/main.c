#include <stdio.h>
#include <string.h>

#define OK                 0

#define SECOND_LEN         10
#define DST_LEN            100

#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_RESET   "\x1b[0m"


void asm_strcopy(char *dst, char *src, int len);

int asm_strlen(const char* str)
{
    int len = 0;

    const char *copy_str = str;

    __asm__(
        ".intel_syntax noprefix\n"
        "mov al, 0\n"
        "mov rdi, %1\n"
        "mov ecx, -1\n"
        "repne scasb\n"
        "not ecx\n"
        "dec ecx\n"
        "mov %0, ecx\n"
        : "=r" (len)
        : "r" (copy_str)
        : "%ecx", "%rdi", "%al");
    
    return len;
}

void compare_len(int len, int result)
{
    if (len == result)
        printf(ANSI_COLOR_GREEN "PASSED\n" ANSI_COLOR_RESET);
    else
        printf(ANSI_COLOR_RED "FAIL\n" ANSI_COLOR_RESET);
}

void test_asm_strlen(void)
{
    printf(ANSI_COLOR_GREEN "\nSTRLEN\n" ANSI_COLOR_RESET);

    printf("\ntest 1.0\n");
    char first_str[] = "hello, world!";
    printf(ANSI_COLOR_CYAN "DATA: " ANSI_COLOR_RESET "%s\n", first_str);
    printf(ANSI_COLOR_CYAN "LEN: " ANSI_COLOR_RESET "%ld\n", strlen(first_str));
    printf(ANSI_COLOR_CYAN "RESULT: " ANSI_COLOR_RESET "%d\n", asm_strlen(first_str));
    compare_len(strlen(first_str), asm_strlen(first_str));

    printf("\ntest 2.0\n");
    char second_str[SECOND_LEN] = "world";
    printf(ANSI_COLOR_CYAN "DATA: " ANSI_COLOR_RESET "%s\n", second_str);
    printf(ANSI_COLOR_CYAN "LEN: " ANSI_COLOR_RESET "%ld\n", strlen(second_str));
    printf(ANSI_COLOR_CYAN "RESULT: " ANSI_COLOR_RESET "%d\n", asm_strlen(second_str));
    compare_len(strlen(second_str), asm_strlen(second_str));
}

void compare_str(char *first, char *second)
{
    if (!strcmp(first, second))
        printf(ANSI_COLOR_GREEN "PASSED\n" ANSI_COLOR_RESET);
    else
        printf(ANSI_COLOR_RED "FAIL\n" ANSI_COLOR_RESET);
}

void test_asm_strcopy(void)
{
    printf(ANSI_COLOR_GREEN "\nSTRCOPY\n" ANSI_COLOR_RESET);

    char src[] = "helloabcdefghijkl";
    char dst[DST_LEN] = "world, world!";
    int len = 5;

    printf("\ntest 1.0:\n");
    printf(ANSI_COLOR_CYAN "SRC: " ANSI_COLOR_RESET "%s\n", src);
    printf(ANSI_COLOR_CYAN "DST: " ANSI_COLOR_RESET "%s\n", src);
    printf(ANSI_COLOR_CYAN "LEN: " ANSI_COLOR_RESET "%d\n", len);
    asm_strcopy(src, src, len);
    printf(ANSI_COLOR_CYAN "ANSWER: " ANSI_COLOR_RESET "%s\n", src);
    printf(ANSI_COLOR_CYAN "RESULT: " ANSI_COLOR_RESET "%s\n", src);
    compare_str(src, src);
    

    printf("\ntest 2.0:\n");
    printf(ANSI_COLOR_CYAN "SRC: " ANSI_COLOR_RESET "%s\n", src);
    printf(ANSI_COLOR_CYAN "DST: " ANSI_COLOR_RESET "%s\n", dst);
    printf(ANSI_COLOR_CYAN "LEN: " ANSI_COLOR_RESET "%d\n", len);
    asm_strcopy(dst, src, len);
    printf(ANSI_COLOR_CYAN "ANSWER: " ANSI_COLOR_RESET "%s\n", "hello, world!");
    printf(ANSI_COLOR_CYAN "RESULT: " ANSI_COLOR_RESET "%s\n", dst);
    compare_str(dst, "hello, world!");

    printf("\ntest 3.0:\n");
    printf(ANSI_COLOR_CYAN "SRC: " ANSI_COLOR_RESET "%s\n", src);
    printf(ANSI_COLOR_CYAN "DST: " ANSI_COLOR_RESET "%s\n", "abcdefghijkl");
    printf(ANSI_COLOR_CYAN "LEN: " ANSI_COLOR_RESET "%d\n", len);
    asm_strcopy(src, src + 5, len);
    printf(ANSI_COLOR_CYAN "ANSWER: " ANSI_COLOR_RESET "%s\n", "abcdeabcdefghijkl");
    printf(ANSI_COLOR_CYAN "RESULT: " ANSI_COLOR_RESET "%s\n", src);
    compare_str(src, "abcdeabcdefghijkl");

    len = 3;
    printf("\ntest 4.0:\n");
    printf(ANSI_COLOR_CYAN "SRC: " ANSI_COLOR_RESET "%s\n", src);
    printf(ANSI_COLOR_CYAN "DST: " ANSI_COLOR_RESET "%s\n", "fghijkl");
    printf(ANSI_COLOR_CYAN "LEN: " ANSI_COLOR_RESET "%d\n", len);
    asm_strcopy(src + 10, src, len);
    printf(ANSI_COLOR_CYAN "ANSWER: " ANSI_COLOR_RESET "%s\n", "abcdeabcdeabcijkl");
    printf(ANSI_COLOR_CYAN "RESULT: " ANSI_COLOR_RESET "%s\n", src);
    compare_str(src, "abcdeabcdeabcijkl");
}

int main(void)
{
    test_asm_strlen();
    test_asm_strcopy();

    return OK;
}
