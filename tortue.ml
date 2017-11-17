open Geo

type config = surface list
type longueur = float
type angle = float
type etat_tortue = point * angle

(*AVANCER LA TORTUE*)
let (avancer : etat_tortue -> longueur -> etat_tortue) = 
  fun (p, o) -> fun d -> 
			 {x = p.x +. cos(o) *. d; y = p.y +. sin(o) *. d}, o

(*FAIRE TOURNER LA TORTUE*)
let (tourner : etat_tortue -> angle -> etat_tortue) = 
  fun (p, o1) -> fun o2 ->
		 (p, o1 +. o2)

(*AJOUTER LE SEGMENT CORRESPONDANT AU DEPLACEMENT DE LA TORTUE DANS LA CONFIGURATION*)
let (calcul_config : config -> etat_tortue -> etat_tortue -> config) = 
  fun c -> fun (p1, o1) -> fun (p2, o2) -> Line(p1, p2) :: c
