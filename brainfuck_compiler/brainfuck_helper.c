#include <assert.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include "brainfuck_helper.h"

void ldc_insere_fin(struct ldc **l, char *addr) {
    // Cas d'une liste vide
    if(*l == NULL) {
        (*l) = malloc(sizeof(struct ldc));
        (*l)->addr = addr;
        (*l)->prec = *l;
        (*l)->suiv = *l;
        return;
    }

    // Création nouvelle queue
    struct ldc *c = malloc(sizeof(struct ldc));
    c->addr = addr;
    c->prec = (*l)->prec;
    c->suiv = (*l);

    // Création de la nouvelle queue
    if((*l)->prec != *l) {
        (*l)->prec->suiv = c;
    } else {
        (*l)->suiv = c;
    }
    (*l)->prec = c;
}


char* get_input_prog(char* input_filename){

    FILE* fichier = fopen(input_filename, "r"); //On ouvre le fichier en lecture seulement

    if (fichier == NULL){           //On vérifie que le fichier a bien été ouvert
        printf("Impossible d'ouvrir le fichier %s", input_filename);  //Message d'erreur si le fichier a été mal ouvert
        return 0;
    }

    fseek(fichier, 0, SEEK_END);    //Positionne un pointeur à la fin du fichier
    uint32_t pos = ftell(fichier);  //Stocke dans pos le nombre de caractères parcouru pour arriver à la fin du fichier
    fseek(fichier, 0, SEEK_SET);    //Repositionne le pointeur au début du fichier
    
    char *tableau = calloc(pos+1, sizeof(char));  //Crée un tableau 
    tableau[pos] = '\0';   //Caractère de fin du tableau
    fread(tableau, pos, 1, fichier); //Met dans chaque case du tableau le caractère pointé par le pointeur de fichier et avance au suivant
        
    fclose(fichier);     //On referme le fichier
    
    return tableau;
}

void free_input_prog(char* input_prog){
    free(input_prog);
}

struct ldc* build_loops(char* input_prog){
    struct ldc* ptr = NULL; //Initialisation d'une liste doublement chainée
    uint32_t i = 0;
    while (input_prog[i] != '\0') {  //Tant qu'on a pas fini de parcourir le tableau d'instruction
        if (input_prog[i] == '[' || input_prog[i] == ']'){  //Si on croise un crochet
            ldc_insere_fin(&(ptr), &(input_prog[i]));   //On stocke son addresse dans la ldc 
        }
        i++;
    }
    return ptr;
}

void free_loops(struct ldc* loops){
    /* Si la ldc est pas vide */
    if (loops != NULL){
        struct ldc *curr_elmt = loops->suiv;
        while (curr_elmt != loops){
            struct ldc* delete_elmt = curr_elmt;  //On crée un pointeur sur curr_elmt
            curr_elmt = curr_elmt->suiv;          //On met dans curr_elmt la case suivante 
            free(delete_elmt);                    //On free la case que pointe delete_elmt
        }
        free(loops);     //On free la case pointe par loops
    }
}

void execute_instruction(char** ipp, uint8_t** dpp, struct ldc* loops){
    /* On regarde quelle instruction on doit executer */
    switch (**ipp)
    {
    case '+':
        (**dpp)++;  //On incrémente la valeur stockée mémoire de 1
        break;
    case '-':
        (**dpp)--;  //On décrémente la valeur stockée mémoire de 1
        break;
    case '<':
        (*dpp)--;   //On passe à la case mémoire suivante
        break;
    case '>':
        (*dpp)++;   //On revient à la case mémoire précédente
        break;
    case '[':
        if (**dpp == 0){  //On regarde si le compteur est à 0
            struct ldc* curr_loop = loops;
            /* On trouve dans la ldc le '[' */
            while (curr_loop->addr != *ipp){
                curr_loop = curr_loop->suiv;
            }
            /* 
            On va chercher le ']' associé au '[' sur lequel on travaille
            Technique : On incremente un compteur si on croise '[' et on le décrémente si l'on croise ']'
            Dès que le compteur est à 0 ce que nous avons touvé le bon crochet.
             */
            uint16_t compteur = 1;
            while (compteur != 0){
                curr_loop = curr_loop->suiv;
                if (*(curr_loop->addr) == '['){
                    compteur++;
                }else if (*(curr_loop->addr) == ']'){
                    compteur--;
                }
            }
            *ipp = curr_loop->addr;  //On saute à la fin de la boucle
        }
        break;
    case ']':
        if (**dpp != 0){  //On vérifie que le compteur de la boucle est différent de 0, sinon on passe simplement à l'instruction suivante
            struct ldc* curr_loops = loops;
            /*On réalise exactement le même code que dans le cas de '[' mais en inversant '[' et ']'*/
            while (curr_loops->addr != *ipp){
                curr_loops = curr_loops->suiv;
            }
            uint16_t compteur = 1;
            while (compteur != 0){
                curr_loops = curr_loops->prec;
                if (*(curr_loops->addr) == '['){
                    compteur--;
                }else if (*(curr_loops->addr) == ']'){
                    compteur++;
                }
            }
            *ipp = curr_loops->addr;
        }
        break;
    case '.':
        printf("%c", **dpp);  //On affiche le caractère stocké dans la case mémoire pointée, encodé en ASCII
        break;
    case ',':
        **dpp = getchar();    //On stocke dans la case mémoire pointée le caractère passé par l'utilisateur
        break;
    default:
        break;
    }
    (*ipp)++;   //On passe simplement à l'instruction suivante
}