/*
uint32_t fact(uint32_t n)
{
    if (n <= 1) {
        return 1;
    } else {
        return n * fact(n - 1);
    }
}
*/

    .text
    .globl fact
    /* uint32_t fact(uint32_t n) */
/* DEBUT DU CONTEXTE
Fonction :
    fact : non feuille
Contexte :
    ra : pile *(sp+4)
    n  : registre a0; pile *(sp+0)
FIN DU CONTEXTE */
fact:
    addi sp, sp, -2*4
    sw ra, 4(sp)
    sw a0, 0(sp)
fact_fin_prologue:
    li t0, 1 # t0 = 1 
    bgt a0, t0, else
    j fact_debut_epilogue
else:
    addi a0, a0, -1; # a0 = a0 + -1
    jal fact
    lw t1, 0(sp)
    mul a0, a0, t1; # a0 = a0 * t0
fact_debut_epilogue:
    lw ra, 4(sp)
    addi sp, sp, 8; # sp = sp + 8
    ret
