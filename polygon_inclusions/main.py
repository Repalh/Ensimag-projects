#!/usr/bin/env python3
"""
fichier principal pour la detection des inclusions.
ce fichier est utilise pour les tests automatiques.
attention donc lors des modifications.
"""
import sys
from tycat import read_instance

def common_area(quad1, quad2):
    """
    Test si le quadrant 2 est dans la region du quadrant 1
    Return un booléen
    """
    return quad1.min_coordinates[0] <= quad2.min_coordinates[0] and quad1.max_coordinates[0] >= quad2.max_coordinates[0] and \
    quad1.min_coordinates[1] <= quad2.min_coordinates[1] and quad1.max_coordinates[1] >= quad2.max_coordinates[1]

def trouve_inclusions(polygones):
    """
    renvoie le vecteur des inclusions
    la ieme case contient l'indice du polygone
    contenant le ieme polygone (-1 si aucun).
    (voir le sujet pour plus d'info)
    """
    sorted_poly = sorted([(abs(polygones[i].area()), i) for i in range(len(polygones))], reverse=True) #Trie les polygones par ordre décroissant des aires 
    quadrant_list = [poly.bounding_quadrant() for poly in polygones]
    vect = [-1 for _ in range(len(polygones))]

    for idx in range(1, len(sorted_poly)):
        stop = idx
        i=1
        while i < len(polygones):
            if sorted_poly[idx-i][0] != sorted_poly[idx][0]:
                idx_inclusion = sorted_poly[idx-i][1]     # on recupère l'indice, de la liste polygones, du polygone qui contient, potentiellement, directement le polygone testé
                break
            i += 1
        idx_inclusion = sorted_poly[idx-1][1]
        while stop > 0:
            if sorted_poly[idx-i][0] == sorted_poly[idx][0]:
                break
            if common_area(quadrant_list[idx_inclusion], quadrant_list[sorted_poly[idx][1]]):
                if est_inclu(polygones[idx_inclusion].points, polygones[sorted_poly[idx][1]].points[1].coordinates):   #On test si un des points du polygone testé appartient au polygone d'aire plus grande
                    vect[sorted_poly[idx][1]] = idx_inclusion   #si c'est le cas, on met dans le vecteur l'indice du polygone qui le contient directement
                    break     #Et on sort de la boucle
            idx_inclusion = sorted_poly[stop-2][1]  #sinon on change l'indice du polygone à tester pour tester au autre polygone d'aire plus grande
            stop -= 1

    return vect

def est_inclu(polygone, point):
    inclus = False  #Variable que l'on retourne qui nous dis si le point est dans le polygone ou non
    i = 0      #On initialise un indice qui va parcourir chaque point du polygone
    j = len(polygone) - 1  #Et une 2e qui parcourera le point juste avant dans le sens horraire
    while i < len(polygone):   #On boucle jusqu'à avoir testé tous les points
        if (((polygone[i].coordinates[1] > point[1]) or (polygone[j].coordinates[1] > point[1])) and \
            ((polygone[i].coordinates[0] >= point[0]) != (polygone[j].coordinates[0] >= point[0]))): 
            coef_dir = (polygone[j].coordinates[1] - polygone[i].coordinates[1]) / (polygone[j].coordinates[0] - polygone[i].coordinates[0])
            y = coef_dir * (point[0] - polygone[i].coordinates[0]) + polygone[i].coordinates[1]
            if y >= point[1]:
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


if __name__ == "__main__":
    main()
