let triplet x y z =
  y;;
(* *)
let addone (x) = 
  x+1;;
  
let curry f =
     fun x y -> f (x, y) ;;
  
let uncurry f =
  fun (y ,x) -> f y x ;;

(* 1.3 *)
let inverse f x=
    fun g -> f g x;;

 (*1.4*)
let rec iterate f x n =
  if n=0 then
    x
  else
    iterate f (f x) (n-1) ;;

(*exercice 2*)
  (*2.1*)
let lmap = [(1,2)];;

  
(*2.2*)
open List;;
let rec length list =
  if list = [] then
    0
  else
    1 + length(List.tl list);;


(*Insertion dans une map list*) 
let insertlist lmap k v =
  (k,v) :: lmap;;
(*Juste une test*)
let insertlistM lmap k v =
   let lmap = (k,v) :: lmap in lmap;;

(*Suppression de tous les éléments d'une liste avec comme clé key*)
let myList = [(1,"test1");(2,"test2");(3,"test3")]
let myList2 = [(4,"test1");(5,"test2");(6,"test3")
              ]                 
let rec list_remove key list =
  match list with
    |[] -> []
    |hd::tl ->
    begin
      if (fst (List.hd list)) = key then
        list_remove key (List.tl list)
      else
        (List.hd list)::(list_remove key (List.tl list)) 
    end
;;
  
(*2.3*)
let rec list_map f list =
  match list with
  |[] -> []
  |hd::tl ->
     begin
       f (List.hd list)::(list_map f (List.tl list))
     end
;;


(*2.4*)
let rec myConcat l1 l2 =
  if l1 = [] then
    l2
  else if l2 = [] then
    l1
  else if l1 = [] && l2 = [] then
    []
  else
    begin
      (List.hd l2)::(myConcat l1 (List.tl l2))
    end
;;


  

