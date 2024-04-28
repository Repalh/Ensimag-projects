/*
bool palin(const char *ch)
{
    uint32_t inf, sup;
    inf = 0;
    sup = strlen(ch) - 1;
    while (inf < sup && ch[inf] == ch[sup]) {
        inf++;
        sup--;
    }
    return inf >= sup;
}
*/
    .text
    .globl palin
	.type palin, @function
    /* bool palin(char *ch) */
/* DEBUT DU CONTEXTE
Fonction :
    palin : non feuille
Contexte :
    ra   : pile *(sp+12)
    ch : registre a0; pile *(sp+8)
    inf  : pile *(sp+4)
    sup  : pile *(sp+0)
FIN DU CONTEXTE */
palin:
    addi sp, sp, -4*4
    sw ra, 12(sp)
palin_fin_prologue:
    li t0, 0
    sw t0, 0(sp)
    sw t0, 4(sp)
    sw a0, 8(sp)
    jal strlen
    lw t1, 0(sp)
    addi a0, a0, -1
    mv t1, a0
    lw a0, 8(sp)
    lw t0, 4(sp)
while:
    bge t0, t1, end_while # if t0 >= t1 then else

    add t2, a0, t0
    add t3, a0, t1
    lb t4, 0(t3)
    lb t5, 0(t2)

    bne t4, t5, end_while
    addi t0, t0, 1
    addi t1, t1, -1
    j while
    
end_while:
    bge t0, t1, end
    mv a0, x0
    j palin_debut_epilogue
end:
    li t0, 1
    mv a0, t0
palin_debut_epilogue:
    lw ra, 12(sp)
    addi sp, sp, 4*4
    ret
	.size palin, . - palin
