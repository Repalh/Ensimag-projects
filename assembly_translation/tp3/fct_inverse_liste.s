/*
void inverse_liste(struct cellule_t **l)
{
   struct cellule_t *res, *suiv;
   res = NULL;
   while (*l != NULL) {
       suiv = (*l)->suiv;
       (*l)->suiv = res;
       res = *l;
       *l = suiv;
   }
   *l = res;
}
*/
    .text
    .globl inverse_liste
/* void inverse_liste(struct cellule_t **l) */
/* DEBUT DU CONTEXTE
Fonction :
    inverse_liste : feuille
Contexte :
    l : registre a0
    res : registre t0
    suiv : registre t1
FIN DU CONTEXTE */
inverse_liste:
inverse_liste_fin_prologue:
    li t0, 0  # t0 = NULL
while:
    lw t2, 0(a0) 
    beq t2, zero, end_while
    lw t1, 4(t2)  #suiv = (*l)->suiv

    sw t0, 4(t2)  #(*l)->suiv = res

    lw t0, 0(a0)  #res = *l

    sw t1, 0(a0)  #*l = suiv

    j while

end_while:
    sw t0, 0(a0)
inverse_liste_debut_epilogue:
    ret
