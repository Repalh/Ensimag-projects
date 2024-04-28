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

def trouve_point(poly):
    """
    Renvoie le point du polygone le plus proche d'une bordure,
    et la direction dans laquelle evaluer la droite.
    """
    max = [poly[0].distance_to(Point([poly[0].coordinates[0], 10])), 0]
    for i in range(len(poly)):
        if poly[i].distance_to(Point([poly[i].coordinates[0], 10])) > max[0]:
            max = [poly[i].distance_to(Point([poly[i].coordinates[0], 10])), i]
    return poly[i]

def trouve_inclusions(polygones):
    """
    renvoie le vecteur des inclusions
    la ieme case contient l'indice du polygone
    contenant le ieme polygone (-1 si aucun).
    (voir le sujet pour plus d'info)
    """
    sorted_poly = sorted([[abs(polygones[i].area()),i] for i in range(len(polygones))], reverse=True)   #Trie par ordre décroissant des aires des polygones
    vect = [-1 for i in range(len(polygones))]                                                          #crée le vecteur de réponse 
    for i in range(1,len(sorted_poly)):                      #test l'inclusion polygone par polygone 
        idx_poly_contenant = sorted_poly[i][1]
        point = polygones[idx_poly_contenant].points[1]
        xp = point.coordinates[0] 
        yp = point.coordinates[1]
        for j in range(i):                              #test si le polygone poly est dans contenue dans les polygones plus grand que lui 
            idx_big_poly = sorted_poly[j][1]
            incr = 0                                                #initialisation du compteur de passage 
            big_poly = polygones[idx_big_poly].points  
            for k, big_point in enumerate(big_poly):
                x1 = big_poly[k-1].coordinates[0]
                y1 = big_poly[k-1].coordinates[1]
                x2 = big_poly[k].coordinates[0]
                y2 = big_poly[k].coordinates[1]
                if (x1<xp<x2 and (y1>yp or y2>yp)) or (x1>xp>x2 and (y1>yp or y2>yp)) :
                    incr +=1
            if incr % 2 == 1 :
                vect[j] = idx_big_poly
    return vect


def main():
    """
    charge chaque fichier .poly donne
    trouve les inclusions
    affiche l'arbre en format texte
    """
    fichier = "e2.poly"
    polygones = read_instance(fichier)
    inclusions = trouve_inclusions(polygones)
    print(inclusions)


if __name__ == "__main__":
    main()