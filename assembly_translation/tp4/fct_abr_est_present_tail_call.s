/*
bool abr_est_present_tail_call(uint32_t val, struct noeud_t *abr)
{
   if (abr == NULL) {
       return false;
   } else if (val == abr->val) {
       return true;
   } else if (val < abr->val) {
       return abr_est_present_tail_call(val, abr->fg);
   } else {
       return abr_est_present_tail_call(val, abr->fd);
   }
}
*/
    .text
    .globl abr_est_present_tail_call
/* DEBUT DU CONTEXTE
Fonction :
    abr_est_present_tail_call : feuille
Contexte :
    val : registre a0
    abr : registre a1
FIN DU CONTEXTE */
abr_est_present_tail_call:
abr_est_present_tail_call_fin_prologue:
    beqz a1, null
    lw t0, 0(a1)
    beq t0, a0, true
    blt a0, t0, gauche # if a0 < t0 then gauche
    lw a1, 8(a1)
    j abr_est_present_tail_call  # jump to abr_est_present and save position to ra
    j abr_est_present_tail_call_debut_epilogue
null:
    li a0, 0
    j abr_est_present_tail_call_debut_epilogue
true:
    li a0, 1
    j abr_est_present_tail_call_debut_epilogue
gauche:
    lw a1, 4(a1) # 
    j abr_est_present_tail_call
abr_est_present_tail_call_debut_epilogue:
    ret