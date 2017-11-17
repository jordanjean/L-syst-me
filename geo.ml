(** Valeur approchée de Pi. *)
let (pi : float) = 4. *. atan 1. ;;

(** Point ou vecteur. *)
type point = { x : float; y : float; } ;;

(** Surface. *)
type surface =
  | Circle of point * float (** Cercle : centre et rayon *)
  | Line of point * point   (** Segment : deux extremites *)
  | Polygon of point list   (** Polygone plein : listes des sommets *) ;;

(** Constructeur de point. *)
let (point : float -> float -> point) = fun a -> fun b -> {x = a; y = b} ;;

(** Translation. *)
let (( +| ) : point -> point -> point) = fun u -> fun v -> {x = u.x +. v.x; y = u.y +. v.y} ;;
assert({x = 2.; y=3.} +| {x =1.; y= 2.} = {x = 3.; y= 5.}) ;;

(** Translation inverse. *)
let (( -| ) : point -> point -> point) = fun u -> fun v -> {x = u.x -. v.x; y = u.y -. v.y} ;; 

(** Inverse. *)
let ( ( ~| ) : point -> point) = fun u -> {x = -.u.x; y = -.u.y} ;; 

(** Homothétie. *)
let (( *| ) : float -> point -> point) = fun r -> fun u -> {x = r*.u.x; y = r*.u.y} ;; 

let (milieu : point -> point -> point) = fun u -> fun v-> {x = (u.x +. v.x)/.2.; y = (u.y +. v.y)/.2.} ;;

assert(milieu (point 2. 4.) (point 6. 10.) = point 4. 7.) ;;

(** Vecteur normal d'un vecteur. *)
let (normal : point -> point) = fun u -> {x = -.u.y; y = -.u.x} ;;

(** Produit scalaire de deux vecteurs. *)
let (dot : point -> point -> float) = fun u -> fun v -> u.x*.v.x +. u.y*.v.y ;;

(** Carré scalaire d'un vecteur. *)
let (sqdot : point -> float) = fun u -> (u.x*.u.x)+.(u.y*.u.y) ;;

(** Norme d'un vecteur. *)
let (length : point -> float) = fun u -> sqrt (u.x*.u.x +. u.y*.u.y) ;;

(** Vecteur unitaire d'un vecteur. *)
let (unitise : point -> point) = fun v -> 1./.(length v) *| v ;;

(* Distance entre deux points. *)
let (distance : point -> point -> float) = fun u -> fun v -> sqrt ((u.x-.v.x)*.(u.x-.v.x) +. (u.y-.v.y)*.(u.y-.v.y)) ;;

(* Ajoute un angle à un vecteur. *)
let (rotate : point -> float -> point) = fun u -> fun a -> {x = (u.x*.(cos a)) -. (u.y*.(sin a)); y = u.x*.(sin a) +. u.y*.(cos a)} ;;



