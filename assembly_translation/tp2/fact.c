#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

uint32_t fact(uint32_t);

int main()
{
   uint32_t n = 7;
   printf("Fact(%" PRIu32 ") = %" PRIu32 "\n", n, fact(n));
   return 0;
}
