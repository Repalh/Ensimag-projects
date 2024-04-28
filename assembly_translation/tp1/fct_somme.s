/*
uint32_t somme(void)
{
    uint32_t i;
    uint32_t res = 0;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
    return res;
}
*/
    .text
    .globl somme
/* DEBUT DU CONTEXTE
Fonction :
    somme : feuille
Contexte :
    i : registre t0
    res : registre t1
FIN DU CONTEXTE */
somme:
somme_fin_prologue:
    /* uint32_t i = 1;*/
    li t0, 1
    /* uint32_t res = 0;*/
    li t1, 0 
    /* uint8_t t2 = 10; */
    li t2, 10
    /*uint8_t t3 = 1; */
    li t3, 1
    /* for (i=1; i <=10; i++) { */
for:
    /* saut a la fin si i > 10 */
    bgt t0, t2, fin
    /* res = res + 1; */
    add t1, t1, t0
    /* i++ */
    add t0, t0, t3
    j   for
    /* } */
fin:
    /* return res */
    mv a0, t1
somme_debut_epilogue:
    ret
