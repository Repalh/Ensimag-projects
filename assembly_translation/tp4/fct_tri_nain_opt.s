/*
void tri_nain_opt   (int32_t tab[], uint32_t taille)
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
    .globl tri_nain_opt
/* Version du tri optimisée sans respecter la contrainte de la traduction
 * systématique pour les accès mémoire (et le calcul de leurs adresses)
   Complétez le contexte ci-dessous en indiquant les registres qui contiendront
   des variables temporaires.  */
/* DEBUT DU CONTEXTE
Fonction :
    tri_nain_opt : feuille
Contexte :
    tab : registre a0
    taille : registre a1
    i : registre t0
    tmp : registre t1
    &tab[i]  : registre a2
    tab[i]   : registre t2; mémoire
    tab[i+1] : registre t3; mémoire
FIN DU CONTEXTE */
tri_nain_opt:
tri_nain_opt_fin_prologue:
    li t0, 0 #i=0
while:
    addi t2, a1, -1
    bge t0, t2, tri_nain_opt_debut_epilogue # if t0 < t2 then tri_nain_debut_epilogue
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

        mv t1, t2 #tmp = tab[i]
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
tri_nain_opt_debut_epilogue:
    ret
