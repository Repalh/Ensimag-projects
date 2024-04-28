/*
uint32_t fact_papl(uint32_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        uint64_t tmp = n*fact_papl(n-1);
        if ((tmp >> 32) > 0)
            erreur_fact(n);
        return (uint32_t)tmp;
    }
}
*/

    .text
    .globl fact_papl
    /* uint32_t fact_papl(uint32_t n) */
/* DEBUT DU CONTEXTE
Fonction :
    fact_papl : non feuille
Contexte :
    ra  : pile *(sp+12)
    n   : registre a0; pile *(sp+8)
    tmp : pile *(sp+0)
FIN DU CONTEXTE */
fact_papl:
    addi sp, sp, -4*4
    sw ra, 12(sp)
    sw a0, 8(sp)
fact_papl_fin_prologue:
    li t0, 1 # t0 = 1 
    bgt a0, t0, else
    mv a0, t0
    j fact_papl_debut_epilogue
else:
    addi a0, a0, -1 # a0 = a0 + -1
    jal fact_papl
    lw t1, 8(sp)    #t1 = a0 (n de avant l'appel)
    mul t2, a0, t1 # t2 = a0 * t1 (low)
    mulhu t3, a0, t1 #t3 = a0 * t1 (high)
    sw t2, 0(sp)
    sw t3, 4(sp)
    bgt t3, zero, if
    lw a0, 0(sp)
    j fact_papl_debut_epilogue
if:
    lw a0, 8(sp)
    jal erreur_fact
fact_papl_debut_epilogue:
    lw ra, 12(sp)
    addi sp, sp, 16; # sp = sp + 16
    ret
