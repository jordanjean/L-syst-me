open Geo
open Tortue
open Lsystemes
open Graphique


(*DEFINITIONS DE MOTIFS*)
  
let (axio1 : axiome) = S(F, M(M(S(F, M(M(F))))))
let (regl1 : membre_droit) = (S(F, P(S(F, M(M(S(F, P(F))))))))
let (regl2 : membre_droit) = S(S(F, C(M(S(S(F, C(P(F))), M(F))))), F)

(*REGLE A MODIFIER EVENTUELLEMENT : *)  
let (regl_ramifications : membre_droit) = S(S(S(S(F, C(P(F))), F), C(M(F))), F);; 



print_string "\nCE PROGRAMME CREE 4 FICHIERS .svg POUR LES OUVRIR UTILISER LA COMMANDE see <fichier.svg> \n" ;;


(*CONSTRUCTION DU FICHIER 1 : PLANTE DU SUJET*)  

let fichier1 = open_out "plante.svg" ;;
print_string "\n1) Création de la plante d'axiome F et de règle F → F[+F]F[-F]F dans le fichier plante.svg :\n" ;
print_string "\nEntrer le nombre d'applications de la règle (valeur inférieure à 5 conseillée) :  \n" ;;

let n1 = read_int() ;;
let (m : motif) = regle F regl_ramifications n1;;

let (conf1, e) = motif_config 10. (pi/.6.) m (point 300. 850., -.pi/.2. )  ;;
  
(entete_fichier fichier1 600 1000) ;
(segment_liste fichier1 conf1) ;
(fin_fichier fichier1) ;;

close_out fichier1;;





(*CONSTRUCTION DE FICHIER 2 : PLANTE DU SUJET AYANT SUBIT UNE MUTATION SELON LE PARAMETRE p FOURNIT PAR L'UTILISATEUR*)

let fichier2 = open_out "plante_mutee.svg" ;;
print_string "\n2) Création de la mutation de cette plante dans le fichier plante_mutee.svg :\n" ;
print_string "\nEntrer la probabilité p entre 0 et 1 de mutation de la plante : " ;;

let p = read_float() ;;

let (mut : motif) = (muter m p);;
let (conf2, e) = motif_config 10. (pi/.6.) mut (point 300. 850., -.pi/.2.) ;;

(entete_fichier fichier2 600 1000) ;
(segment_liste fichier2 conf2) ;
(fin_fichier fichier2) ;;

close_out fichier2;;






(*CONSTRUCTION DU FICHIER 3 : PLANTE DONT UNE REGLE DE MEMBRE DROIT GENERE ALEATOIREMENT A ETE APPLIQUEE*)

let fichier3 = open_out "plante_alea.svg" ;;
print_string "\n3) Création de la plante d'axiome F et de règle F → m avec (m généré aléatoirement) dans le fichier plante_alea.svg :\n" ;
print_string "\nEntrer le nombre d'applications de la règle (valeur inférieure à 5 conseillée) :  \n" ;;

let n3 = read_int();;
let (alea : motif) = regle F (genere_control 20) n3;;
let (conf3, e) = motif_config 10. (pi/.6.) alea (point 300. 850., -.pi/.2.);;

(entete_fichier fichier3 600 1000) ;
(segment_liste fichier3 conf3) ;
(fin_fichier fichier3) ;;

close_out fichier3;;





(*CONSTRUCTION DU FICHIER 4 : PLANTE DU SUJET*)  

let fichier4 = open_out "plante_perso.svg" ;;
print_string "\n4) Création de la plante d'axiome F et de règle F → m, avec m entrée par l'utilisateur dans le fichier plante_perso.svg :\n" ;

print_string "\nEntrer la règle m à appliquer : \n" ;;

let (regle_perso : membre_droit) = traduction (Stream.of_string(read_line())) ;;

print_string "\nEntrer le nombre d'applications de la règle (valeur inférieure à 5 conseillée) :  \n" ;;

let n4 = read_int() ;;

let (m2 : motif) = regle F regle_perso n4;;

let (conf4, e) = motif_config 10. (pi/.6.) m2 (point 300. 850., -.pi/.2. )  ;;

(entete_fichier fichier4 600 1000) ;
(segment_liste fichier4 conf4) ;
(fin_fichier fichier4) ;;

close_out fichier4;;


