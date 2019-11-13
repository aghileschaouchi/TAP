(********* Exercice  1  *********)
(*lancer ocaml : ocaml graphics.cma *)
type 'a set = Set of ('a -> bool)

let set_empty = Set (fun x -> false);;
let set_all = Set (fun x -> true);;
let singleton x = Set (fun y -> x = y);; (*prend x et teste si  sth = x *)
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
 Graphics.open_graph " 200x200";;
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

set_draw set_empty;;
set_draw set_all;;    
  
let distance (Point2D(x1,y1)) (Point2D(x2,y2)) =
  sqrt((x1-.x2)**2. +. (y1-.y2)**2.);;

(* 2.1 *)
(* un disque est représenté par un centre et un rayon tel que c'est l'ensemble des point ayant une distance inférieure ou égale au rayon à partir du centre. *)  
let disk center r =
  Set( fun p -> (distance p center) <= r);;

(* pour tester *)
let dsk = disk (Point2D(100.,100.)) 40.;;
set_draw dsk;;
  
(*2.2*)
(* les demi-plans : vertical et horizontal sont représentés respectivement par les points dont l'abscisse ou l'ordonné sont inférieurs à une droite donnée.  *)
let halfplane_horiz dy =
  Set(fun (Point2D(x,y)) -> y <= dy) ;;

let halfplane_vert dx =
  Set(fun (Point2D(x,y)) -> x <= dx) ;;

set_draw (halfplane_vert 100.);;
set_draw (halfplane_horiz 100.);;

(* demi-cercle: un cercle et un demi-plan *)  
let half_circle = dsk *| (halfplane_vert 100.);;
set_draw (half_circle);;

  
(* 2.3 *)  
let translate deltax deltay =
  fun (Point2D (x, y)) -> Point2D (x +. deltax, y +. deltay);;
let scale a b =
  fun (Point2D(x, y)) -> Point2D (x *. a, y *. b);;
let rotate theta =
  let costheta = cos theta and sintheta = sin theta in
    fun (Point2D (x, y)) ->
      Point2D (x *. costheta -. y *. sintheta,
               y *. costheta +. x *. sintheta);;


(* 2.3 *)
(* Les trois fonctions appliquent les fonctions translate, scale, rotate à chaque point des ensembles passés. *)
let set_scale a b (Set s) =
  Set(fun p -> s(scale (1./.a) (1./.b) p));;

let set_translate x y (Set s) =
  Set(fun p -> s(translate x y p) ));;

let set_rotate theta (Set s) =
  Set(fun p -> s(rotate theta p) );;

(* pour tester *)  
set_draw (set_scale 0.5 0.5 dsk);;
set_draw (set_translate 50. 50. (dsk));;
set_draw (set_rotate 5. (dsk));;

let ( % ) f g x = f (g x);;   (* generic composition *)
  
(*tranlation relative*)
let set_translate_rel (Set s) theta (Point2D(cx,cy)) =
  set_translate cx cy(set_rotate theta(set_translate(-.cx)(-.cy)(Set s)));;
  
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
      in List.fold_left ( +-|| ) set_all (all_rot 0);;

(*
  Pour la fonction wheel, la différence entre les deux fonctions est que:
      la fonction (+-|) fait appel à *| , +| et un autre *| pour calculer le xor tout en évaluant le type de s1 et s2 (induction), contrairement à la fonction (+-||) qui utilise 'xor' sur deux paramètres de type Set. Ce qui fait la différence de rapidité du calcul. 
*)

let ellipse = set_scale 0.8 1.5 (disk (Point2D (100., 40.)) 30.) ;;  
set_draw (wheel ellipse (Point2D (100., 100.)) 12);;
  
(********* Exercice  3  *********)

type 'a frozen_flow =
| End of 'a
| Step of (unit -> 'a frozen_flow);;

let ppcm x y =
  let rec ppcm_rec x y mul =
    if (y > x) then (ppcm_rec y x mul) else (* Ensures x >= y *)
    if (x = 0) then 0 else                  (* Ensures both are positive *)
      let r = (x mod y) in
        if (r = 0) then (mul/y) else ppcm_rec y r mul
  in ppcm_rec x y (x*y);;
  
(* 3.1 *)
(* si le calcul est congelé (Step) on applique f *)
let thaw frflow =
  match frflow with
  |End e -> End e
  |Step f -> f();;

  
(* 3.2 *)
(* A chaque appel récursif, on remplace le code par un Step qui congèle l'état courant des variables. A chaque condition d'arrêt, on préfixe le code par un End pour matcher la structure frozen_flow. *)
 let ppcm_flow x y =
  let rec ppcm_rec_flow x y mul =
    if (y > x) then ((Step (fun()->ppcm_rec_flow y x mul))) else (* Ensures x >= y *)
    if (x = 0) then (End 0) else                  (* Ensures both are positive *)
      let r = (x mod y) in
        if (r = 0) then (End (mul/y)) else (Step (fun() -> ppcm_rec_flow y r mul))
  in (Step(fun()-> ppcm_rec_flow x y (x*y)));;  

(* 3.3 *)   
type ('key,'data) frozen_data_flow =
| End of 'data
| Step of (unit -> (('key*'data) list) * ('key,'data) frozen_data_flow);;

(* pour adapter le code au nouveau type, on  injecte une variable en tant que clé,valeur pour désigner une étape de congélation. On prend en considération que End prend la valeur du couple. *)
  
let ppcm_flow_3 x y =
  let rec ppcm_rec_flow_3 x y mul =
    if (y > x) then ((Step (fun()->([("x",x)] , ppcm_rec_flow_3 y x mul)))) else (* Ensures x >= y *)
    if (x = 0) then (End 0) else                  (* Ensures both are positive *)
      let r = (x mod y) in
        if (r = 0) then (End (mul/y)) else (Step (fun() -> ([("y",y)] ,ppcm_rec_flow_3 y r mul)))
  in (Step(fun()-> ([("x*y",x*y)] ,ppcm_rec_flow_3 x y (x*y))));;
  
let thaw_2 frflow =
  match frflow with
  |End e -> []
  |Step f -> fst (f());;

let thaw_3 frflow =
  match frflow with
  |End e -> End e
  |Step f -> snd(f());;
  
let res = ppcm_flow_3 40 50;;
 thaw_2  res;;
let step1= thaw_3 res;;
 thaw_2 step1;;
let step2 = (thaw_3 (step1));;
 thaw_2 step2;;
    


