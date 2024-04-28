#!/usr/bin/env python3

import svg as svg
import sys
from tycat import read_instance, tycat


def main() :
    for fichier in sys.argv[1:]:
        polygones = read_instance(fichier)
        tycat(*polygones)        


if __name__ == "__main__":
    main()
