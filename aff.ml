(* Pour compiler aff.ml : taper
   ocamlc -I +lablGL -c aff.ml
*)

let vertex {Geo.x=x; Geo.y=y} =
  GlDraw.vertex ~x ~y ()

let translate r =
  GlMat.translate ~x:r.Geo.x ~y:r.Geo.y ()

let scale s =
  GlMat.scale ~x:s ~y:s ()

let protect f g =
  try
    f();
    g()
  with e ->
    g();
    raise e

let mat f =
  GlMat.push();
  protect f GlMat.pop

let render prim f =
  GlDraw.begins prim;
  protect f GlDraw.ends

let circle x = Geo.point (sin x) (cos x)

let gl_memoize =
  let dl = ref None in
  fun f -> match !dl with
  | Some dl -> GlList.call dl
  | None ->
      let dl' = GlList.create `compile in
      f ();
      GlList.ends ();
      dl := Some dl'

let display_surface = function
  | Geo.Circle (c, r) ->
      GlMat.push();
      mat (fun () ->
        translate c;
        scale r;
        let n = 360 in
        GlDraw.begins `line_loop;
        for i=0 to n-1 do
          vertex (circle (2. *. Geo.pi *. float i /. float n))
        done;
        GlDraw.ends ())
  | Geo.Line (v1, v2) ->
      GlDraw.begins `lines;
      List.iter vertex [v1; v2];
      GlDraw.ends ()
  | Geo.Polygon (pts) ->
      GlDraw.begins `polygon;
      List.iter vertex pts;
      GlDraw.ends ()

let display surf_list =
  GlClear.clear [ `color; `depth ];
  Gl.enable `depth_test;
  GlFunc.depth_func `lequal;
  GlMat.mode `projection;
  GlMat.load_identity ();
  GlMat.ortho ~x:(0., 1.) ~y:(0., 1.) ~z:(0., 1.);
  GlMat.mode `modelview;
  GlMat.load_identity ();
  GlDraw.color (1., 1., 1.) ~alpha:1.;
  gl_memoize (fun () -> List.iter display_surface surf_list);
  Gl.finish ();
  Unix.sleep 0;
  Glut.swapBuffers ()

let idle () =
  Unix.sleep 1

let handle_key (key:int) =
  if key=27 then exit 0

let create_window (width:int) (height:int) (title:string) =
  ignore (Glut.init Sys.argv);
  Glut.initDisplayMode ~alpha:true ~double_buffer:true ~depth:true ();
  Glut.initWindowSize ~w:width ~h:height;
  ignore (Glut.createWindow ~title:title);
  GlClear.color (0., 0., 0.) ~alpha:0.;
  Gl.enable `blend;
  List.iter Gl.enable [`line_smooth; `polygon_smooth];
  List.iter (fun x -> GlMisc.hint x `nicest) [`line_smooth; `polygon_smooth];
  GlDraw.line_width 4.;
  GlFunc.blend_func ~src:`src_alpha ~dst:`one

let set_cb display idle (key_event:int->unit) =
  Glut.displayFunc ~cb:display;
  let idle_glut () = idle (); Glut.postRedisplay () in
  Glut.idleFunc ~cb:(Some idle_glut);
  Glut.keyboardFunc ~cb:(fun ~key ~x ~y -> key_event key)

let draw window_title surf_list =
  create_window 480 480 window_title;
  set_cb (fun () -> display surf_list) idle handle_key;
  Glut.mainLoop ()
