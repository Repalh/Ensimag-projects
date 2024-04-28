/*
void abr_vers_tab(struct noeud_t *abr)
{
    struct noeud_t *fd;
    if (abr != NULL) {
        abr_vers_tab(abr->fg);
        *ptr = abr->val;
        ptr++;
        fd = abr->fd;
        free(abr);
        abr_vers_tab(fd);
    }
}
*/

    .text
    .globl abr_vers_tab
/* DEBUT DU CONTEXTE
Fonction :
    abr_vers_tab : non feuille
Contexte :
    ra : pile *(sp+8)
    abr : registre a0; pile *(sp+4)
    fd : pile *(sp+0)
    ptr : mémoire
FIN DU CONTEXTE */
abr_vers_tab:
    addi sp, sp, -3*4; # sp = sp + -4*4
    sw ra, 8(sp)
    sw a0, 4(sp)
abr_vers_tab_fin_prologue:
if:
    beqz a0, abr_vers_tab_debut_epilogue
    lw a0, 4(a0)
    jal abr_vers_tab
    lw a0, 4(sp)
    lw t0, 0(a0) #t0 <- abr->val
    lw t1, ptr   #t1 <- ptr
    sw t0, 0(t1) #*ptr <- t0
    lw t0, ptr   #t0 <- ptr
    addi t0, t0, 4 #t0++
    sw t0, ptr, t5 #ptr = t0 
    lw t1, 8(a0)  #t1 = abr->fd
    sw t1, 0(sp)
    jal free
    lw t1, 0(sp)
    mv a0, t1
    jal abr_vers_tab
abr_vers_tab_debut_epilogue:
    lw ra, 8(sp)
    addi sp, sp, 3*4
    ret

    .data
    .globl ptr
ptr: .word 0

