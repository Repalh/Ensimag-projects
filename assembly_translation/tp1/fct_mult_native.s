/*
uint32_t x, y;

uint32_t mult_native(void)
{
    return x*y;
}
*/
    .text
    .globl mult_native
/* DEBUT DU CONTEXTE
Fonction :
    mult_native : feuille
Contexte :
    y : mémoire     #alloué par mult_native.c
    x : mémoire     #alloué par mult_native.c
FIN DU CONTEXTE */
mult_native:
mult_native_fin_prologue:
    lw t0, x
    lw t1, y
    li t2, 0
    mul t2, t1, t0
    mv a0, t2
mult_native_debut_epilogue:
    ret
