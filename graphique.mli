open Geo
open Tortue

(*SIGNATURE DU MODULE GRAPHIQUE*)

(* ECRIRE L'EN-TETE DU FICHIER SVG *)
val entete_fichier : out_channel -> int -> int -> unit

(* ECRIRE LA FIN DU FICHIER SVG *)  
val fin_fichier : out_channel -> unit

(* AJOUTER UN SEGMENT AU FICHIER SVG *)  
val segment : out_channel -> surface -> unit

(* AJOUTER UNE LISTE DE SEGMENT AU FICHIER SVG *)  
val segment_liste : out_channel -> config -> unit  
