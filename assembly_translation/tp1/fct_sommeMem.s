/*
uint32_t res;

uint32_t sommeMem(void)
{
    uint32_t i;
    res = 0;
    for (i = 1; i <= 10; i++) {
        res = res + i;
    }
    return res;
}
*/

    .text
    .globl sommeMem
/* DEBUT DU CONTEXTE
Fonction :
    sommeMem : feuille
Contexte :
    i : registre t0
    res : mémoire
FIN DU CONTEXTE */
sommeMem:
sommeMem_fin_prologue:
    /* uint32_t i = 1; */
    li t0, 1
    li t5, 10
    /* res = 0 */
    li t1, 0
    sw t1, res, t4
    /* for (i = 1; i <= 10; i++) { */
for:
    /* saut a la fin si i > 10 */
    bgt t0, t5, fin
    /* res = res + i */
    lw t1, res
    add t1, t1, t0 
    sw t1, res, t4
    /* i++ */
    addi t0, t0, 1
    j   for
    /* } */
fin:
    /* return res */
    mv a0, t1
sommeMem_debut_epilogue:
    ret

    .data
    .globl res
res: .word 0
/* uint32_t res;
  La variable globale res étant définie dans ce fichier, il est nécessaire de
  la définir dans la section .data du programme assembleur.
*/
