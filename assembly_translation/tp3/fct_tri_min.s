/*
void tri_min(int32_t tab[], uint32_t taille)
{
    uint32_t i, j, ix_min;
    int32_t tmp;
    for (i = 0; i < taille - 1; i++) {
        for (ix_min = i, j = i + 1; j < taille; j++) {
            if (tab[j] < tab[ix_min]) {
                ix_min = j;
            }
        }
        tmp = tab[i];
        tab[i] = tab[ix_min];
        tab[ix_min] = tmp;
    }
}
*/
    .text
    .globl tri_min
/* void tri_min(int32_t tab[], uint32_t taille) */
/* DEBUT DU CONTEXTE
Fonction :
    tri_min : feuille
Contexte :
    tab : registre a0
    taille : registre a1
    i : registre t0
    j : registre t1
    ix_min : registre t2
    tmp : registre t3
FIN DU CONTEXTE */
tri_min:
tri_min_fin_prologue:
    li t0, 0 #t0 = 0
    addi t4, a1, -1
for:
    bge t0, t4, end  #if t0 >= t4 then end
    mv t2, t0   #ix_min = i
    addi t1, t0, 1  # j = i + 1

for_imbr:
    bge t1, a1, end_for # if t1 >= a1 then end_for
    slli t6, t1, 2
    add t6, a0, t6  # t6 = tab[j]
    lw t5, 0(t6)  #t5 = tab[j]
    slli t6, t2, 2
    add t6, a0, t6  #t6 = tab[idx_min]
    lw a3, 0(t6)  #a3 = tab[idx_min]
    bgt a3, t5, if
    
else:
    addi t1, t1, 1 #j++
    j for_imbr

end_for:
    slli t6, t0, 2
    add t6, a0, t6
    lw t3, 0(t6)
    slli a3, t2, 2
    add a3, a0, a3
    lw a4, 0(a3)
    sw a4, 0(t6)
    sw t3, 0(a3)
    addi t0, t0, 1 #i++e
    j for
if:
    mv t2, t1
    j else  
end:  
tri_min_debut_epilogue:
    ret

