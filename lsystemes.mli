(*Signature du module lsystems*)

open Tortue
open Geo

(* DEFINITIONS DES TYPES *)
type longueur = float
type angle = float

(* SYNTAXE PERMETTANT D'EXCLURE LES MOTIFS NON CONFORMES (MAL CROCHETÉS) *)  
type motif = P of motif
	   | M of motif
	   | C of motif
	   | S of motif * motif
	   | F


(* TYPE AXIOME *)	       
type axiome = motif

(* MEMBRE DROIT D'UNE REGLE *)  
type membre_droit = motif

(* RETOURNER LA LISTE DE SEGMENTS ET L'ETAT FINAL DE LA TORTUE A PARTIE D'UN MOTIF, D'UN ETAT DE TORTUE INITIAL ET DES PARAMETRE longueur et angle *)   
val motif_config : longueur -> angle -> motif -> etat_tortue -> config * etat_tortue

(* RETOURNER LA PLANTE D'AXIOME axiome DONT LA REGLE F->membre_droit A ETE APPLIQUÉ n FOIS *)  
val regle : axiome -> membre_droit -> int ->  motif

(* GENERER UNE LISTE ALEATOIRE DE CARACTERE DE LONGUEUR n NE CONTENANT QUE DES CARACTERES DANS CET ENSEMBLE : {F, -, +, [, ]} *) 
val genere_char : int -> char list

(* GENERER UNE LISTE ALEATOIRE DE MOTIF DE LONGUEUR n *)   
val genere_motif : int -> membre_droit 

(* RETOURNER LE NOMBRE DE PAIRS DE CROCHETS ET DE ROTATIONS D'UN MOTIF *) 
val control : membre_droit -> int * int

(* GENERER UN MOTIF A L'AIDE DE LA FONCTION genere_motif TANT QUE LE MOTIF OBTENU N'A PAS AU MOINS 3 PAIRS DE CROCHETS ET 2 ROTATIONS *) 
val genere_control : int -> membre_droit

(* ANALYSEUR SYNTAXIQUE : TRADUIT UN FLOT DE CHARACTÈRE EN MOTIF *)  
val traduction : char Stream.t -> membre_droit

(* LES SYMBOLS + ET - DU MOTIF DONNE EN PARAMETRE ONT UNE PROBABILITE DE MUTER DE p ENTRE 0 ET 1 *)   
val muter : membre_droit -> float -> membre_droit

