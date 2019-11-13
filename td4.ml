(* TD4: Techniques de programmation fonctionnelle *)
(* Exercice 1 *)
(* 1.2 *)

let rec sum l = match l with
  | []    -> 0
  | x::xs -> x + (sum xs);;

let rec length l = match l with 
  | []    -> 0
  | _::xs -> 1 + (length xs);;

let maximum l = 
  let rec max_rec l m = match l with 
    | []    -> m
    | x::xs -> max_rec xs (max m x)
  in max_rec l (List.hd l);;

let sum_fold l = List.fold_left (fun sum x -> sum + x) 0 l;;
let l = [1;2;3];;
  
let length_fold l = List.fold_left (fun sum x -> 1 + sum) 0 l;;
  
let maximum_fold l = List.fold_left (fun m x -> max m x) 0 l;;

  let lBool = [true;false;false];;
let list_or l = List.fold_left (fun acc x -> acc || x) false l;;
