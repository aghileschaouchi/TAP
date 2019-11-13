(* Data driven programming *)

type value = 
  | Int of int 
  | Float of float;;
  
(* Pattern matching *)
  
let string_of_value x =
 match x with 
  | Int i   -> string_of_int i;
  | Float f -> string_of_float f;;
  
  
  (* On ajoute la dernière ligne pour  que ça marche *)
let rec sum_of_values a b = match (a,b) with 
  | (Int i,Int j)     -> Int(i+j)
  | (Int i,Float f)   -> Float((float i)+.f)
  | (Float f,Float g) -> Float (f+.g)
  | (Float f, Int i) -> Float(f +. float(i));;
  
(* Pour tester *)
  sum_of_values (Int 1) (Int 2);;
                           
(* Exercice 1 *)
type weight =
  | Kilo of float
  | Livre of float
  | Carat of float;;

let element_to_kilo x =
  match x with
  | Livre x -> x *. (1. /. 2.205)
  | Carat x -> x *. (1. /. 5000.)
  | Kilo x -> x;;

  (* Pour appliquer *)
  element_to_kilo (Livre 5.);;
(* Il faut en effet gérer tous les cas du type weight dans la fonction element_to_kilo, même Kilo *)

    (* Exercice 1.4 *)
  type coin =
    | One 
    | Seven  
    | Thirteen;;
    (* Fonction gloutonne *)
(* Exhaustivitée : traiter tous les cas *)
  let rec coin_to_list n =
    match n with
    | k when n >= 13 -> Thirteen::coin_to_list (k-13)
    | k when n >= 7 -> Seven::coin_to_list (k-7)
    | k when n >= 1 -> One::coin_to_list (k-1)
    | _ -> [];;

  (* Exercice 2 *)
    
  (* BinNode(racine,filsgauche,filsdroit) *)
    
type 'a bintree = 
| BinEmpty
| BinNode of 'a * 'a bintree * 'a bintree

(* 2.1 : On test avec une fonction, une profondeur, un element de depart *)
           
let rec bintree_build f h x = 
  if (h <= 0)
  then BinEmpty
  else let (x1,x2) = f(x) in 
       BinNode (x,
                (bintree_build f (h-1) x1),
                (bintree_build f (h-1) x2));;
 (* 2.2 *)
let rec bintree_map f bintree =
  match bintree with
  | BinEmpty -> BinEmpty
  | BinNode (a,b,c) ->
     BinNode(f a, bintree_map f b, bintree_map f c)
             
;;

(* 2.3 *)
  (* A tester avec fold_left
     fold_left bintree_insert
       BinEmpty
       [1;2;3;4;5];;

 *)
let rec bintree_insert x bintree =
  match bintree with
  | BinEmpty -> BinNode(val,BinEmpty,BinEmpty)
  | BinNode(a,tl,tr) ->
     if x < a
       BinNode(a , bintree_insert tr n, tl)      
     else if x > a
       BinNode( a, bintree_insert tl n, tr);;
               
   (* 2.5 bintree_fold *)
             let rec bintree_fold f a t =
               match t with
               | BinEmpty -> a
               | BinNode (n, tl, tr) -> f n (bintree_fold f a tl) (bintree_fold f a tr);;
               
   (* 2.6 *)
   type 'a tree =
   | TreeEmpty
   | TreeNode of 'a * (('a tree) list)
   (* Fonction associée *)
   let rec tree_build f h x sizeList =
     if (h <= 0) then TreeEmpty
     else let (x1,x2) = f(x) in 
          TreeNode (x,
            (bintree_build f (h-1) x1),
            (bintree_build f (h-1) x2));;
     TreeNode (x,
               (tree_build f (h-1) x1),
               (tree_build f)
     
   (* il faut transformer la liste des fils en nouvelle liste de fils. Avec map.*)            
   let rec tree_map f t =
     match t with
     | TreeEmpty -> TreeEmpty
     | TreeNode(t, list) -> TreeNode(f t, List.map tree_map list);;
              
