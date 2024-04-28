#!/bin/bash
QEMU="${RVDIR:=/matieres/3MMCEP/riscv}/bin/qemu-system-riscv32"
QEMU_OPTS="-machine cep -nographic -bios none"
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Compute the function name foo from the target nivX__foo
exostarget=$(awk 'match($0,/BADGES_TARGET\s*=\s*(.*)/,a){print a[1]}' Makefile)
exos=""
for value in $exostarget; do
    exos+="${value#*"__"} "
done

# Build the context parser
COMMON=$(cd $(dirname $0); pwd)
make -s -C ${COMMON}/parser/

exosok=""
for exo in $exos
do
  if [ -e test/$exo.sortie ]
  then
    echo -e "${PURPLE}=====  Analyse de $exo  =====${NC}"
# if ! grep 'D[EÉ]BUT DU CONTEXTE' fct_${exo}.s > /dev/null 2>&1 ; then
#   echo 'Pas de balise "DEBUT DU CONTEXTE", impossible de vérifier votre contexte'
#   exit 1
# fi
    # Vérification du contexte
    make $exo.ctxt
    if ! ${COMMON}/parser/contexte < $exo.ctxt > /dev/null; then
      echo -e "${RED}Problème dans le contexte.${NC}"
      exit 1
    fi
    echo "Vérification de la syntaxe du contexte : OK"
    rm $exo.ctxt
    # Vérification des étiquettes
    make -s $exo.stxetd
    if [ -s $exo.stxetd ]; then
      echo -e "${RED}Problème de syntaxe: les étiquettes ne sont pas préservées.${NC}";
      rm *.stxetd
      exit 1
    fi
    echo "Vérification des étiquettes : OK"
    rm "$exo.stxetd"
    # Compilation du programme
    make $exo
    if [ -f $exo ]
    then
      echo "La génération du binaire a bien réussi."
    else
      echo "La génération du binaire $exo a échoué."
      echo -e "${RED}Revoir la syntaxe de fct_${exo}.s${NC}\n"
      exit 1
    fi
    # Exécution du programme et comparaison de la sortie
    timeout --foreground 10 $QEMU $QEMU_OPTS -kernel $exo > $exo.sortie
    if cmp --silent $exo.sortie test/$exo.sortie
    then
      echo "La sortie de $exo est bien identique à test/$exo.sortie."
      rm "$exo.sortie"
    else
      echo "La sortie de $exo n'est pas celle décrite dans test/$exo.sortie."
      rm "$exo.sortie"
      echo -e "${RED}Revoir test/${exo}.sortie et fct_${exo}.s${NC}\n"
      exit 1
    fi
    exosok="${exosok} ${exo}"
  fi
done
echo -e "${GREEN}C'est tout bon vous pouvez ajouter vos fichiers test/EXO.sortie et fct_EXO.s avec les EXO(s) : ${exosok} ${NC}\n"
exit 0
