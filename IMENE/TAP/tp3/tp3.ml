(*exercice 1*)
(* 1.1 *)
let triplet x y z =
  y;;
(* 1.2 *)
  
let curry f =
     fun x y -> f (x, y) ;;
  
let uncurry f =
  fun (y ,x) -> f y x ;;
  
(* 1.3 *)
let inverse f x y=
    f y x;;

 (*1.4*)
let rec iterate f x n =
  if n=0 then
    x
  else
    iterate f (f x) (n-1) ;;

(* addone: fonction avec laquelle on va tester la fonction iterate *)
let addone (x) = 
  x+1;;

 iterate addone 2 3;;
  
 (*exercice 2*)
 open List ;;
  (*2.1*)
let lmap = [(1,2)];;
(* la liste qui prend des couples <K,V> est une liste dont le type est (int * int) list.  *)
  
let rec length list =
  if list = [] then
    0
  else
    1 + length(List.tl list);;
  
let insertlist list k v =
 (k,v):: list ;;

(* on teste l'insertion dans une liste comme suit: *)
let lmap = insertlist lmap 4 5;;

(*2.2*)
let key_is_not n (k,_) = n <> k ;;

  
let list_remove key list =
  List.filter (key_is_not key) list;;
   
    
  (*2.3*)

