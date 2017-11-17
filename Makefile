# ENVIRONMENT
INCLUDES=-I +lablGL
LABLGLCMAS=lablgl.cma lablglut.cma unix.cma

# BUILD RULES
all: main

tortue.cmi: tortue.mli
	ocamlc -c tortue.mli
tortue.cmo: tortue.ml tortue.cmi
	ocamlc -c tortue.ml

pile.cmi: pile.mli geo.mli tortue.mli
	ocamlc -c pile.mli
pile.cmo: pile.ml pile.cmi geo.cmi tortue.cmi
	ocamlc -c pile.ml

graphique.cmi: geo.cmi tortue.cmi graphique.mli 
	ocamlc -c graphique.mli 
graphique.cmo: graphique.ml graphique.cmi geo.cmi tortue.cmi
	ocamlc -c graphique.ml


lsystemes.cmi: lsystemes.mli tortue.cmi pile.cmi
	ocamlc -c lsystemes.mli
lsystemes.cmo: lsystemes.ml lsystemes.cmi tortue.cmi geo.cmi pile.cmi
	ocamlc -pp "camlp4o" -c lsystemes.ml




main: main.cmo graphique.cmo aff.cmo geo.cmo lsystemes.cmo  tortue.cmo pile.cmo
	ocamlc $(INCLUDES) $(LABLGLCMAS) graphique.cmo pile.cmo geo.cmo aff.cmo tortue.cmo lsystemes.cmo main.cmo -o main

main.cmo: main.ml graphique.cmo aff.cmo geo.cmo tortue.cmo lsystemes.cmo pile.cmo
	ocamlc -c main.ml

geo.cmi: geo.mli
	ocamlc -c geo.mli
geo.cmo: geo.ml geo.cmi
	ocamlc -c geo.ml

aff.cmi: aff.mli geo.cmi
	ocamlc -c aff.mli
aff.cmo: aff.cmi geo.cmo
	ocamlc $(INCLUDES) -c aff.ml

clean:
	rm -f *.cmi *.cmo *~
