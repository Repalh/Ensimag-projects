#!/usr/bin/env python3
"""
fichier principal pour la detection des inclusions.
ce fichier est utilise pour les tests automatiques.
attention donc lors des modifications.
"""
import sys
from tycat import read_instance
from geo.point import Point
from geo.segment import Segment

def trouve_inclusions(polygones):
    """
    renvoie le vecteur des inclusions
    la ieme case contient l'indice du polygone
    contenant le ieme polygone (-1 si aucun).
    (voir le sujet pour plus d'info)
    """
    quadrant_list = [poly.bounding_quadrant() for poly in polygones]
    vect = [-1 for _ in range(len(polygones))]
    for i, quad in enumerate(quadrant_list):
        for j, quad_inc in enumerate(quadrant_list[i:]):
            if quad.intersect(quad_inc):
                if est_inclu(polygones[i].points, polygones[j].points[1].coordinates):   #On test si un des points du polygone testé appartient au polygone d'aire plus grande
                    vect[j] = i
                elif est_inclu(polygones[j].points, polygones[i].points[1].coordinates):   #On test si un des points du polygone testé appartient au polygone d'aire plus grande
                    vect[i] = j
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
    polygones = read_instance("test.poly")
    inclusions = trouve_inclusions(polygones)
    print(inclusions)"""


if __name__ == "__main__":
    main()
