(*
#load "dynlink.cma" ;;
#load "camlp4o.cma" ;;
*)

open Tortue
open Geo


(* TYPES *)
type longueur = float
type angle = float
  
type motif = P of motif
	   | M of motif
	   | C of motif
	   | S of motif * motif
	   | F 

type axiome = motif
type membre_droit = motif


(*CREATION D'UNE LISTE DE SEGMENT A PARTIR D'UN MOTIF*)  
let rec (motif_config : longueur -> angle -> motif -> etat_tortue -> (config * etat_tortue)) = fun long ang motif etat ->
  match motif with
    F -> ((calcul_config [] etat (avancer etat long)), (avancer etat long))
  | P(x) -> (motif_config long ang x (tourner etat ang))
  | M(x) -> (motif_config long ang x (tourner etat (-.ang)))
  | C(x) -> let (conf, e) =  motif_config long ang x etat in conf, etat
  | S(x, y) -> let (c1, e1) = motif_config long ang x etat in
	       let (c2, e2) = motif_config long ang y e1 in
	       (c1 @ c2, e2)



     
(*APPLICATION D'UNE REGLE A UN MOTIF*)
let rec (regle : axiome -> membre_droit -> int ->  motif) = fun a m n ->
  let rec (aux : axiome -> membre_droit ->  motif) = fun axio membre ->
    match axio with 
      F -> membre
    | P(x) -> P(aux x membre)
    | M(x) -> M(aux x membre)
    | C(x) -> C(aux x membre)
    | S(x, y) -> S(aux x membre, aux y membre)
  in if n = 0 then a else
      regle (aux a m) m (n-1)


(* GENERATION D'UNE LISTE DE CHARACTERE*)	
let (genere_char : int -> char list) = fun n ->
  let rec (aux : int -> char list -> char list) = fun k l ->
    Random.self_init();
    if k = 0 then l else let alea = (Random.int 4) in 
      match alea with
	0 -> aux (k-1) ('F' :: l)
      | 1 -> aux (k-1) ('-' :: l)
      | 2 -> aux (k-1) ('[' :: l)
      | 3 -> aux (k-1) (']' :: l)
      | _ -> failwith "érreur de génération"
  in aux n []


  
(* GENERATION D'UN MEMBRE DROIT D'UNE REGLE*)
let (genere_motif : int -> membre_droit) = fun n ->
  let rec (aux : int -> membre_droit -> membre_droit) = fun k membre ->
    Random.self_init();
    if k = 0 then membre else let alea = (Random.int 4) in 
      match alea with
	0 -> aux (k-1) (P(membre))
      | 1 -> aux (k-1) (M(membre))
      | 2 -> aux (k-1) (C(membre))
      | 3 -> aux (k-1) (S(membre, F))
      | _ -> failwith "érreur de génération"
  in aux n F

	
(*RETOURNE LE NOMBRE DE PAIRS DE CROCHETS ET LE NOMBRE DE ROTATION D'UN MOTIF*)
let (control : membre_droit -> (int * int)) = fun membre ->
  let rec (aux : membre_droit -> int -> int -> (int * int)) = fun membre crochets rotation ->
    match membre with
      F -> crochets, rotation
    | C(x) -> aux x (crochets + 1) rotation
    | P(x) | M(x) -> aux x crochets (rotation + 1)
    | S(x, y) -> aux x crochets rotation 
  in aux membre 0 0




(* TESTS DE TRADUCTION : OPERATIONELLE 

let flot = Stream.of_list ['F'; '-'; '+'; '['; '-'; '-'; 'F'; ']'; 'F'];;
  Stream.npeek 10 flot;;*)

(*TRADUIRE UNE LISTE DE CHARACTERE EN UN MOTIF*)
let rec (traduction : char Stream.t -> membre_droit) =
  parser
    [<''['; c = traduction ; '']'; p = traduction>] -> S(C(c), p)
  | [<''+'; p = traduction >] -> P(p)
  | [<''-'; p = traduction >] -> M(p)
  | [<''F'; p = traduction >] -> if p = F then F else S(F, p)
  | [< >] -> F
;;
  
(*GENERE UN MOTIF AVEC AU MOINS 3 PAIRS DE CROCHETS ET AU MOINS 2 ROTATIONS*)
let rec (genere_control : int -> membre_droit) = fun n ->
  let alea = (genere_motif n) in
  let (cro, rot) = control alea in
  if cro >= 3 && rot >= 2 then alea else genere_control n




    

(*MUTATION : LES SYMBOLE + ET - ON UNE PROBABILITE p DE S'ECHANGER*)
let rec (muter : membre_droit -> float -> membre_droit) = fun membre p ->
  Random.self_init();
  (match membre with
    F -> F
  | P(x) -> if (Random.float 1.) <= p then M(muter x p) else P(muter x p) 
  | M(x) -> if (Random.float 1.) <= p then P(muter x p) else M(muter x p) 
  | C(x) -> C(muter x p)
  | S(x, y) -> S(muter x p, muter y p))
     
