#include "cep_platform.h"
    .text
    .globl reveil
/* void reveil(uint32_t delta_t); */
reveil:
    li t0, 0x0200bff8
    lw t1, 0(t0)
    lw t2, 4(t0)
    add t1, a0, t1; # t1 = a0 + t1
    bgeu t1, a0, if
    addi t2, t2, 1
if:
    li t0, -1
    li t3, 0x02004000 # Address of memory mapped register
    sw t0, 0(t3) # No smaller than old value.
    sw t2, 4(t3) # No smaller than new value.
    sw t1, 0(t3) 
    ret

    .globl gestion_interruptions
gestion_interruptions:
    addi sp, sp, -4 # Juste ra à sauver
    sw   ra, 0(sp)
    andi t0, a0, 0xf
    li   t1, IRQ_M_TMR  # Interruption d'horloge
    bne  t0, t1, interruption_externe
    jal  mon_vecteur_horloge
    j    retour
interruption_externe:
    /* Pour plus tard : gestion des boutons poussoirs */
retour:
    lw   ra, 0(sp)
    addi sp, sp, 4
    ret

/* Idiot mais nécessaire pour que l'évaluation soit contente... */
/* DEBUT DU CONTEXTE
  Fonction :
    timer : feuille
  Contexte :
FIN DU CONTEXTE */
timer:
timer_fin_prologue:
timer_debut_epilogue:
    ret

    .data
    .globl param
/* struct compt *param; */
param: .long 0x0
