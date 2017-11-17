open Tortue
open Geo

type pile = etat_tortue list
  
let pile_vide = []

let (est_pile_vide : pile -> bool) = fun pile ->
  (pile = [])
  
let (empile : pile -> etat_tortue -> pile) = fun pile etat ->
  etat :: pile 

let rec (depile : pile -> pile * etat_tortue) = fun pile ->
  ((match pile with
    [] -> failwith "Pile vide"
  | [a] -> pile_vide
  | a :: b -> let (s, e) = (depile b) in  a :: s)
     ,
    (match pile with
      [] -> failwith "Pile vide"
    | [a] -> a
    | a :: b -> let (s, e) = (depile b) in e))

     
(*assert(empile [3; 4; 6] 7 = [7; 3; 4; 6])
  assert(depile [3; 4; 6]= ([3; 4], 6))*)
