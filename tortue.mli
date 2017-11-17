(*SIGNATURE DU MODULE TORTUE*)

open Geo

(* LISTE DE SEGMENTS *)
type config = surface list
  
type angle = float
type longueur = float

(* POSITION DE LA TORTUE ET ORIENTATION EN RADIAN *)  
type etat_tortue = point * angle

(* FAIRE AVANCER LA TORTUE DE l *)  
val avancer : etat_tortue -> longueur -> etat_tortue

(* FAIRE TOURNER LA TORTUE DE angle (radian) *)  
val tourner : etat_tortue -> angle -> etat_tortue

(* CALCULER LA NOUVELLE CONFIGURATION DE L'AFFICAGE EN FONCTION D'UN DEPLACEMENT DE LA TORTUE *)  
val calcul_config : config -> etat_tortue -> etat_tortue -> config
