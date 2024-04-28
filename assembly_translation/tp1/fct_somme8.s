/*
uint8_t res8;

uint8_t somme8(void)
{
    uint8_t i;
    res8 = 0;
    for (i = 1; i <= 30; i++) {
        res8 = res8 + i;
    }
    return res8;
}
*/

    .text
    .globl somme8
/* DEBUT DU CONTEXTE
Fonction :
    somme8 : feuille
Contexte :
    res8 : mémoire    #alloué par le langage d'assemblage
    i : registre t0
FIN DU CONTEXTE */
somme8:
somme8_fin_prologue:
    /* uint8_t i = 1; */
    li t0, 1
    /* res8 = 0 */
    li t1, 0
    sb t1, res8, t5
    li t2, 30
    for: 
        bgt t0, t2, fin
        /* res8 += i */
        lbu t1, res8
        add t1, t1, t0
        sb t1, res8, t5
        /* i++ */
        addi t0, t0, 1
        j   for
    fin:
        mv a0, t1
somme8_debut_epilogue:
    ret

    .data
    .globl res8
res8: .byte 0
/* uint8_t res8;
  La variable globale res8 étant définie dans ce fichier, il est nécessaire de
  la définir dans la section .data du programme assembleur.
*/
