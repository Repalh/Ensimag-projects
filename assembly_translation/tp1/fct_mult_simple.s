/*
uint32_t x, y;  // dans la mémoire globale et allouées dans le fichier C
uint32_t res;   // dans la mémoire globale et à allouer en langage d'assemblage

uint32_t mult_simple(void)
{
    res = 0;
    while (y != 0) {
        res = res + x;
        y--;
    }
    return res;
}
*/
    .text
    .globl mult_simple
/* DEBUT DU CONTEXTE
Fonction :
    mult_simple : feuille 
Contexte :
    res : mémoire   #alloué par mult_simple.c
    y : mémoire     #alloué par mult_simple.c
    x : mémoire     #alloué en langage d'assemblage
FIN DU CONTEXTE */
mult_simple:
mult_simple_fin_prologue:
    /* res = 0 */
    li t0, 0
    sw t0, res, t5
    lw t1, x
    lw t2, y
    li t3, 0
    li t4, 1
while:
    beq  t2, t3, fin
    /* res = res + x; */
    lw t0, res
    add t0, t0, t1
    sw t0, res, t5
    /* y-- */
    sub t2, t2, t4
    j  while
fin:
    mv a0, t0
mult_simple_debut_epilogue:
    ret


    .data
    .globl res
res: .word 0
/* uint32_t res; */
