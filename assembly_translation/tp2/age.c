#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

uint32_t age(uint32_t);

int main(void)
{
   uint16_t annee = 1982;
   printf("En l'an 2000, vous aviez donc %" PRIu32 " ans !\n", age(annee));
   return 0;
}
