/*
bool abr_est_present(uint32_t val, struct noeud_t *abr)
{
   if (abr == NULL) {
       return false;
   } else if (val == abr->val) {
       return true;
   } else if (val < abr->val) {
       return abr_est_present(val, abr->fg);
   } else {
       return abr_est_present(val, abr->fd);
   }
}
*/

    .text
    .globl abr_est_present
/* DEBUT DU CONTEXTE
Fonction :
    abr_est_present : non feuille
Contexte :
    ra : pile *(sp+8)
    val : registre a0; pile *(sp+4)
    abr : registre a1; pile *(sp+0)
FIN DU CONTEXTE */
abr_est_present:
    addi sp, sp, -3*4
    sw ra, 8(sp)
    sw a0, 4(sp)
    sw a1, 0(sp)
abr_est_present_fin_prologue:
    beqz a1, null
    lw t0, 0(a1)
    beq t0, a0, true
    blt a0, t0, gauche # if a0 < t0 then gauche
    lw a1, 8(a1)
    jal abr_est_present  # jump to abr_est_present and save position to ra
    j abr_est_present_debut_epilogue
null:
    li a0, 0
    j abr_est_present_debut_epilogue
true:
    li a0, 1
    j abr_est_present_debut_epilogue
gauche:
    lw a1, 4(a1) # 
    jal abr_est_present
abr_est_present_debut_epilogue:
    lw ra, 8(sp)
    addi sp, sp, 3*4
    ret
