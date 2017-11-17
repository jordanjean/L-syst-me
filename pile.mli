open Tortue

(* DEFINITIONS ELEMENTAIRES *)
type pile = etat_tortue list
val pile_vide : pile

(* RETOURNE VRAI SI LA PILE EST VIDE, FAUX SINON *)
val est_pile_vide : pile -> bool

(* EMPILER ET DEPILER UN ETAT TORTUE SUIVANT LA CONVENTION FIRST-IN FIRST-OUT *)

(* RETOURNE UNE PILE AVEC L'ETAT DONNÉ EMPILÉ *)   
val empile : pile -> etat_tortue -> pile

(* RETOURNE UN COUPLE FORMÉ DE LA PILE DEPILÉ D'UN ETAT ET DE CET ETAT DEPILÉ *)
val depile : pile -> pile * etat_tortue
