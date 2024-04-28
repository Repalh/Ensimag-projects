#!/usr/bin/env python3
"""
fichier principal pour la detection des inclusions.
ce fichier est utilise pour les tests automatiques.
attention donc lors des modifications.
"""
import sys
from tycat import read_instance

def trouve_inclusions(polygones):
    """
    renvoie le vecteur des inclusions
    la ieme case contient l'indice du polygone
    contenant le ieme polygone (-1 si aucun).
    (voir le sujet pour plus d'info)
    """
    sorted_poly = sorted([[abs(polygones[i].area()), i] for i in range(len(polygones))], reverse=True) #Trie les polygones par ordre décroissant des aires 
    vect = [-1 for _ in range(len(polygones))]  #On initialise le vecteur à retourner

    for idx in range(1, len(sorted_poly)):    #On boucle sur les polygones possiblement inclus
        stop = idx     #On crée une variable pour mettre une condition sur la boucle
        i = 1
        while i < len(polygones):
            if sorted_poly[idx-i][0] != sorted_poly[idx][0]:
                idx_inclusion = sorted_poly[idx-i][1]     # on recupère l'indice, de la liste polygones, du polygone qui contient, potentiellement, directement le polygone testé
                break
            i += 1
        while stop > 0:      #On test sur tous les polygones d'aires plus grande
            if sorted_poly[idx-i][0] == sorted_poly[idx][0]:
                break
            if est_inclu(polygones[idx_inclusion].points, polygones[sorted_poly[idx][1]].points[1].coordinates):   #On test si un des points du polygone testé appartient au polygone d'aire plus grande
                vect[sorted_poly[idx][1]] = idx_inclusion   #si c'est le cas, on met dans le vecteur l'indice du polygone qui le contient directement
                break     #Et on sort de la boucle
            idx_inclusion = sorted_poly[stop-2][1]  #sinon on change l'indice du polygone à tester pour tester au autre polygone d'aire plus grande
            stop -= 1   #On décremente notre compteur

    return vect

def est_inclu(polygone, point):
    inclus = False  #Variable que l'on retourne qui nous dis si le point est dans le polygone ou non
    i = 0      #On initialise un indice qui va parcourir chaque point du polygone
    j = len(polygone) - 1  #Et une 2e qui parcourera le point juste avant dans le sens horraire
    while i < len(polygone):   #On boucle jusqu'à avoir testé tous les points
        if (((polygone[i].coordinates[1] > point[1]) or (polygone[j].coordinates[1] > point[1])) and ((polygone[i].coordinates[0] >= point[0]) != (polygone[j].coordinates[0] >= point[0]))): #test de malade mental
            coef_dir = (polygone[j].coordinates[1] - polygone[i].coordinates[1]) / (polygone[j].coordinates[0] - polygone[i].coordinates[0])
            y = coef_dir * (point[0] - polygone[i].coordinates[0]) + polygone[i].coordinates[1]
            if y >= point[1]:  #Autre test pour compléter le test de malade mental d'avant
                inclus = not inclus  #On a croisé une ligne donc on inverse la valeur de la varible d'appartenance
        j = i  #on incremente nos variables qui parcourent les points 
        i = i + 1
    return inclus


def main():
    """
    charge chaque fichier .poly donne
    trouve les inclusions
    affiche l'arbre en format texte
    """
    for fichier in sys.argv[1:]:
        polygones = read_instance(fichier)
        inclusions = trouve_inclusions(polygones)
        print(inclusions)
    """
    polygones = read_instance("e2.poly")
    inclusions = trouve_inclusions(polygones)
    print(inclusions)"""


if __name__ == "__main__":
    main()
