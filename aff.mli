(** Affichage. *)

(** Afficher une fenêtre. *)
val draw : string -> Geo.surface list -> unit
(** Le premier argument est le titre de la fenêtre. *)
(** Le second argument est la liste des surfaces à afficher. *)
(** Les deux axes de la zone d'affichage sont dans [0.0 .. 1.0]. *)
