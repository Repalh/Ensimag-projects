#!/usr/bin/env python3

import genere_poly as gen
import time
from tycat import read_instance
from main import trouve_inclusions as T_I_quad
from main_init_aire import trouve_inclusions as T_I_aire
from main_naif import trouve_inclusions_naif as T_I_naif
import matplotlib.pyplot as plt

def main():
    test = int(input("Quel test voulez vous effectuer : \n1 : Génération de polygones aléatoires; \n2 : Génération de polygones imbriqués; \n3 : Génération de polygones qui ne sont pas imbriqués.\nEntrée votre choix (1, 2 ou 3) : "))
    match test:
        case 1:
            file_name = "random_"
            m = 0
            i = [10, 25, 50, 100, 200, 500, 1000]
            x = []
            tps_quad = []
            tps_aire = []
            while m < len(i):
                gen.circular_poly(i[m], 200, file_name)
                x += [i[m]]
                polygones = read_instance(file_name+str(i[m])+".poly")
                temps = 0
                start = time.time()
                _ = T_I_quad(polygones)
                end = time.time()
                temps += end - start
                tps_quad+=[temps]
                temps = 0
                start = time.time()
                _ = T_I_aire(polygones)
                end = time.time()
                temps += end - start
                tps_aire+=[temps]
                m += 1
            plt.xlabel("Nombre de points dans un polygone")
            plt.ylabel("temps en sec")
            plt.title("Temps d'execution en fonction du nombre \nde points dans chaque polygones qui sont imbriqués")
            plt.plot(x, tps_aire, "r+-", label="algo sans quadrant")
            plt.plot(x, tps_quad, 'b*-', label="algo avec quadrant")
            plt.legend()
            plt.grid()
            plt.show()
        case 2:
            file_name = "imbrique_"
            i = [10, 50, 100, 200, 500, 1000, 3000, 5000]
            m = 0
            x = []
            tps_quad = []
            tps_aire = []
            while m < len(i):
                gen.imbrique_poly(i[m], file_name)
                x += [i[m]]
                polygones = read_instance(file_name+str(i[m])+".poly")
                temps = 0
                start = time.time()
                _ = T_I_naif(polygones)
                end = time.time()
                temps += end - start
                tps_quad+=[temps]
                temps = 0
                start = time.time()
                _ = T_I_aire(polygones)
                end = time.time()
                temps += end - start
                tps_aire+=[temps]
                m += 1
            plt.xlabel("Nombre de polygones")
            plt.ylabel("Temps en sec")
            plt.title("Temps d'execution en fonction du nombre \nde polygones imbriqués")
            plt.plot(x, tps_aire, "r+-", label="algo sans quadrant")
            plt.plot(x, tps_quad, 'b*-', label="algo naïf")
            plt.legend()
            plt.grid()
            plt.show()
        case 3:
            file_name = "cote_"
            i = [10, 50, 100, 200, 500, 1000, 3000, 5000]
            m = 0
            x = []
            tps_quad = []
            tps_aire = []
            while m < len(i):
                gen.pas_imbrique_poly(i[m], file_name)
                x += [i[m]]
                polygones = read_instance(file_name+str(i[m])+".poly")
                temps = 0
                start = time.time()
                _ = T_I_quad(polygones)
                end = time.time()
                temps += end - start
                tps_quad+=[temps]
                temps = 0
                start = time.time()
                _ = T_I_aire(polygones)
                end = time.time()
                temps += end - start
                tps_aire+=[temps]
                m += 1
            plt.xlabel("Nombre de polygones")
            plt.ylabel("Temps en sec")
            plt.title("Temps d'execution en fonction du nombre \nde polygones pas imbriqués")
            plt.plot(x, tps_aire, "r+-", label="algo sans quadrant")
            plt.plot(x, tps_quad, 'b*-', label="algo avec quadrant")
            plt.legend()
            plt.grid()
            plt.show()
        case 4:
            file_name = "random_pas_imbr_"
            m = 0
            i = [10, 50, 100, 200, 500, 1000, 3000, 5000, 10000]
            x = []
            tps_quad = []
            tps_aire = []
            while m < len(i):
                gen.circular_poly_pas_imbrique(10, i[m], file_name)
                x += [i[m]]
                polygones = read_instance(file_name+str(i[m])+".poly")
                temps = 0
                start = time.time()
                _ = T_I_quad(polygones)
                end = time.time()
                temps += end - start
                tps_quad+=[temps]
                """temps = 0
                start = time.time()
                _ = T_I_aire(polygones)
                end = time.time()
                temps += end - start
                tps_aire+=[temps]"""
                m += 1
            plt.xlabel("Nombre de polygones")
            plt.ylabel("temps en sec")
            plt.title("Temps d'execution en fonction du nombre \nde polygones pas imbriqués")
            #plt.plot(x, tps_aire, "r+-", label="algo sans quadrant")
            plt.plot(x, tps_quad, 'b*-', label="algo avec quadrant")
            plt.legend()
            plt.grid()
            plt.show()
            
        case _:
            return "Mauvais input"



if __name__ == "__main__":
    main()