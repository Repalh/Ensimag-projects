/*
void tri_nain(int32_t tab[], uint32_t taille)
{
    uint32_t i = 0;
    while(i < taille - 1) {
        if (tab[i] > tab[i+1]) {
            int32_t tmp = tab[i];
            tab[i] = tab[i+1];
            tab[i + 1] = tmp;
            if (i > 0) {
                i = i - 1;
            }
        } else {
            i = i + 1;
        }
    }
}
*/

    .text
/*  void tri_nain(int32_t tab[], uint32_t taille) */
    .globl tri_nain
/* DEBUT DU CONTEXTE
Fonction :
    tri_nain : feuille
Contexte :
    tab : registre a0
    taille : registre a1
    i : registre t0
    tmp : registre t1
FIN DU CONTEXTE */
tri_nain:
tri_nain_fin_prologue:
    li t0, 0 #i=0
while:
    addi t2, a1, -1
    bge t0, t2, tri_nain_debut_epilogue # if t0 < t2 then tri_nain_debut_epilogue
if:
    /* tab[i] */
    slli t4, t0, 2  #on décalle pck unint32
    add a2, a0, t4  
    lw t2, 0(a2)    #t2 <= tab[i]

    /* tab[i+1] */
    addi t5, t0, 1
    slli t4, t5, 2
    add a3, a0, t4
    lw t3, 0(a3)   #t3 <= tab[i+1]

    /* if */
    ble t2, t3, else # if t2 <= t3 then else

        lw t1, 0(a2) #tmp = tab[i]
        lw t3, 0(a3)
        sw t3, 0(a2) #tab[i]=tab[i+1]
        sw t1, 0(a3) #tab[I+1]=tmp

    bgt t0, zero, if2 # if t0 > zero then else

    j while

if2:
    addi t0, t0, -1
    j while

else:
    addi t0, t0, 1
    j while
    
tri_nain_debut_epilogue:
    ret
