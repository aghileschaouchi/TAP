(* Exercice 1 *)
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

let list = [1;2;5;4;2];;
  
let rec sum_fold l =
  List.fold_left (fun sum x -> sum + x) 0 l ;;
(* au lieu de (fun sum x -> sum + x) ... on peut directement mettre + *)

let rec length_fold l =
  List.fold_left (fun length x -> length + 1) 0 l;;

let rec maximum_fold l =
  List.fold_left max 0 l;;

(* Pour tester *)
sum_fold list;;
length_fold list;;
maximum_fold list;;  

let bool_list = [false;false;true;false];;
let rec list_or l =
  List.fold_left (fun acc x -> acc || x) false l ;;

  list_or bool_list;;

    

