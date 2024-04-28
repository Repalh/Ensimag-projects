/*
uint32_t x, y;

uint32_t mult_egypt(void)
{
    uint32_t res = 0;
    while (y != 0) {
        if (y % 2 == 1) {
            res = res + x;
        }
        x = x << 1 ;
        y = y >> 1;
    }
    return res;
}
*/
    .text
    .globl mult_egypt
/* Attention, res est une variable locale que l'on mettra dans t0 */
/* DEBUT DU CONTEXTE
Fonction :
    mult_egypt : feuille
Contexte :
    res : registre t0
    y : mémoire     #alloué par mult_egypt.c
    x : mémoire     #alloué par mult_egypt.c
FIN DU CONTEXTE */
mult_egypt:
mult_egypt_fin_prologue:
    /* uint32_t res = 0 */
    li t0, 0
    lw t1, x
    lw t2, y
    li t3, 0
    li t4, 1
while: 
/* if y == 0 saut fin*/
    beq  t2, t3, fin
    andi t5, t2, 1
    beq t5, t4, if
op:
    sll t1, t1, t4
    sra t2, t2, t4
    sw t1, x, t5
    sw t2, y, t5
    j   while
if: 
    add t0, t0, t1
    j  op

fin:
    mv a0, t0
mult_egypt_debut_epilogue:
    ret
