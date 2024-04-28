CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -g
LDFLAGS=
EXEC=brainfuck

all: $(EXEC)
	@echo
	@echo "Pour exécuter le compilateur brainfuck taper \033[0;33m'./brainfuck <fichier brainfuck>'\033[0m"
	@echo "Pour supprimer les fichiers générés lors de la compilation essayer \033[0;33m'make clean'\033[0m"
	@echo "Pour réaliser des test sur le compilateur brainfuck taper \033[0;33m'make test'\033[0m"
	@echo

brainfuck: brainfuck_main.o brainfuck_helper.o
	@$(CC) -o $@ $^ $(LDFLAGS)

brainfuck_main.o: brainfuck_main.c brainfuck_helper.h
	@$(CC) -o $@ -c $< $(CFLAGS)

test: all
	./verif.sh

clean:
	@rm -f *.o
	@rm -f $(EXEC)
	@echo "Tout est propre !"

.PHONY: clean