open Geo
open Tortue

(* MODULE DE CREATION DE FICHIER SVG *)

let (entete_fichier : out_channel -> int -> int -> unit) = fun c w h ->
  output_string c "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<svg  xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"" ;
  output_string c (string_of_int w) ;
  output_string c "\" height=\"" ;
  output_string c (string_of_int h) ;
  output_string c "\" stroke=\"black\">\n" ; ;;



let (fin_fichier : out_channel -> unit) = fun c ->
  output_string c "</svg>\n"; ;;


let (segment : out_channel -> surface -> unit) = fun c s ->
  match s with
    Line(p1, p2) ->
      output_string c "<path d= \"M " ;
      output_string c (string_of_float (p1.x)) ;
      output_string c "," ;
      output_string c (string_of_float (p1.y)) ;
      output_string c " " ;
      output_string c (string_of_float (p2.x)) ;
      output_string c "," ;
      output_string c (string_of_float (p2.y)) ;
      output_string c "\"/> \n" ;
  | _ -> failwith "erreur segment" ;;

 
let rec (segment_liste : out_channel -> config -> unit) = fun chan conf ->
  match conf with
    [] -> ()
  | seg :: reste -> (segment chan seg); (segment_liste chan reste); ;;
