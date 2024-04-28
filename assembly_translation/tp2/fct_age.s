/*
uint32_t age(uint32_t annee_naissance)
{
    uint32_t age;
    age = 2000 - annee_naissance;
    return age;
}
*/

    .text
    .globl age
    /* uint32_t age(uint32_t annee_naissance) */
/* DEBUT DU CONTEXTE
  Fonction :
    age : feuille
  Contexte : # contexte imposé
    annee_naissance  : registre a0
    age              : pile *(sp+0)  # de type uint32_t
FIN DU CONTEXTE */
age:
age_fin_prologue:
  li t0, 2000      # t0 = 2000
  sub a0, t0, a0   # a0 = t0 - a0

age_debut_epilogue:
  ret

