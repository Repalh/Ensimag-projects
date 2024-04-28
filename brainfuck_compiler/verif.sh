#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;33m'
PURPLE='\033[0;35m'
NC='\033[0m'
hello='Hello World!'
print3='3'
print666='666'

clear

echo "$hello" >> hello1.txt
echo "$hello" >> hello2.txt
echo "$print3" >> print3.txt
echo "$print666" >> print666.txt

declare -a exs=( "print3" "hello1" "hello2" "print666" )

echo -e "${PURPLE}===========  Début des tests  ===========${NC}"

for exo in ${exs[@]}
do

    time ./brainfuck $exo.bf > $exo.test
    echo

    if cmp $exo.test $exo.txt
    then
        echo -e "Test de ${exo} --------- ${GREEN}la sortie est bonne ${NC}"
    else
        echo -e "Test de ${exo} --------- ${RED}la sortie est fausse ${NC}"
    fi

done

echo
echo -e "${PURPLE}===========  Fin des tests  =============${NC}"
echo

echo -e "Il reste ${BLUE}affiche_1entree.bf${NC} et ${BLUE}tictactoe.bf${NC} à tester"

rm -f *.test
rm -f *.txt
rm -f *.o
