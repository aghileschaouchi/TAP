(********* Exercice  1  *********)

type 'a set = Set of ('a -> bool)

let set_empty = Set (fun x -> false);;
let set_all = Set (fun x -> true);;
let singleton x = Set (fun y -> x = y);;
let set_mem (Set s) x = s x;;
let set_add (Set s) x = Set (fun y -> s y || y = x);;
let set_del (Set s) x = Set (fun y -> y != x && s y);;

(* Elementary operators *)
let out (Set s) = Set (fun y -> not (s y));;
let ( +| ) (Set s1) (Set s2) = Set (fun y -> s1 y || s2 y);;
let ( *| ) (Set s1) (Set s2) = Set (fun y -> s1 y && s2 y);;

(* Symmetric difference - Two manners *)
let ( +-| ) s1 s2 = (s1 *| (out s2)) +| ((out s1) *| s2);;

let xor x y = not (x=y);;

let ( +-||) (Set s1) (Set s2) = Set (fun y -> xor (s1 y) (s2 y));;

  (********* Exercice  2  *********)

type point2D = Point2D of float * float;;

let set_draw_wh width height s =
  let im = Array.make_matrix height width Graphics.black in
    for j = 0 to height - 1 do
      for i = 0 to width - 1 do
        if set_mem s (Point2D (float i, float j)) then
          im.(height - 1 - j).(i) <- Graphics.white
      done
    done;
    Graphics.draw_image (Graphics.make_image im) 0 0;;

let set_draw = set_draw_wh 200 200;;

let distance (Point2D(x1,y1)) (Point2D(x2,y2)) =
  sqrt((x1-.x2)**2. +. (y1-.y2)**2.);;

(* 2.1 Disk *)
let make_disk rayon pc =
  Set (fun p -> (distance pc p <= rayon));;
  
  set_draw (make_disk 100. (Point2D(100.,100.)));;

let translate deltax deltay =
  fun (Point2D (x, y)) -> Point2D (x +. deltax, y +. deltay);;
let scale a b =
  fun (Point2D(x, y)) -> Point2D (x *. a, y *. b);;
let rotate theta =
  let costheta = cos theta and sintheta = sin theta in
    fun (Point2D (x, y)) ->
      Point2D (x *. costheta -. y *. sintheta,
               y *. costheta +. x *. sintheta);;

let ( % ) f g x = f (g x);;   (* generic composition *)
(* Rotation relative to a point *)
let set_rotate_rel (Set s) theta (Point2D (cen_x, cen_y)) =
      Set (s % (translate (cen_x) (cen_y)) %
       (rotate theta) %
       (translate (-.cen_x) (-.cen_y)));;

let wheel s (Point2D (cen_x, cen_y) as p) n =
      let theta = 2. *. 3.1415927 /. (float n) in
      let rec all_rot i =
        if i >= n then [] else
          (set_rotate_rel s (theta *. (float i)) p) :: (all_rot (i+1))
      in List.fold_left ( +-| ) set_all (all_rot 0);;

  (* 2.2 *)
let halfplane_v x  =
  Set (fun (Point2D(u,v)) ->  u <= x);;

  set_draw (halfplane_v 100.);;
  
let halfplane_h  y=
  Set (fun (Point2D(u,v)) -> v <= y);;

  set_draw (halfplane_h 100.);;
  
let semi_disk c r =
  Set (fun (Point2D(x,y)) -> (distance c Point2D(-x,y) <= rayon));;
  
  (disk (P(0.,0.)) 100.) *| (halfplane_h 100.);;

    (*2.3*)
  let set_scale a b (Set s) =
    Set (fun p -> s (scale (1. /. a) (1. /. b) p));;

  let set_rotate_rel (Set s) theta (Point2D(cy,cy));;

    (* wheel *)
    set_translate cx cy(set_rorate theta (set_translate (-.cx) (-.cy) (Set s)));;

    (*  compliation : ocaml graphics.cma ,Graphics.open_graph "";; *)  
      
(********* Exercice  3  *********)
(*
type 'a frozen_flow =
| End of 'a
| Step of (unit -> 'a frozen_flow)
;;
 *)
let ppcm x y =
  let rec ppcm_rec x y mul =
    if (y > x) then (ppcm_rec y x mul) else (* Ensures x >= y *)
    if (x = 0) then 0 else                  (* Ensures both are positive *)
      let r = (x mod y) in
        if (r = 0) then (mul/y) else ppcm_rec y r mul
  in ppcm_rec x y (x*y);;

type ('key,'data) frozen_data_flow =
| End of 'data
| Step of (unit -> (('key*'data) list) * ('key,'data) frozen_data_flow);;

  
let thow f = match f with
| End e -> End e
| Step g -> g();;  
  
let comp = Step (fun() -> Step (fun() -> End 0));;
thow (thow comp);;

  (* 2.2 *)
  let ppcm x y =
  let rec ppcm_rec x y mul =
    if (y > x) then (Step (fun() -> ppcm_rec y x mul)) else (* Ensures x >= y *)
    if (x = 0) then End (0) else                  (* Ensures both are positive *)
      let r = (x mod y) in
        if (r = 0) then (End (mul/y)) else (Step (fun () -> ppcm_rec y r mul))
  in ppcm_rec x y (x*y);;

  (* 2.3 *)

  let thow_2 f = match f with
    |End _ -> []
    |Step g -> fst(g());;

  let thow_3 f = match f with
    |End e -> End e
    |Step g -> snd(g());;

      let ppcm x y =
        let rec ppcm_rec x y mul =
    if (y > x) then (Step (fun() -> ([("x",x);("y",y);("mul",mul)] ,ppcm_rec y x mul))) else (* Ensures x >= y *)
      if (x = 0) then End (0) else                  (* Ensures both are positive *)
      let r = (x mod y) in
      if (r = 0) then (End (mul/y)) else (Step (fun () -> ([("y",y);("r",r);("mul",mul)] ,ppcm_rec y r mul)))
        in ppcm_rec x y (x*y);;
        
      (* Pour tester *)
      let f_ppcm = ppcm 16 32;;
        thow_2 f_ppcm;;
          thow_3 f_ppcm;;
            thow_3 (thow_3(f_ppcm));;
            
