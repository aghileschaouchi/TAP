(* Exercice 1 *) 
type 'k key         = K of 'k
and ('k, 'a) vertex = 'k key * 'a
and ('k, 'a) graph  =
  Graph of (('k, 'a) vertex * 'k key list) list;;
 
let g = Graph ([
         ((K 1, "A"), [K 2; K 3]);
         ((K 2, "B"), [K 4; K 5]);
         ((K 3, "C"), [K 6; K 7]);
         ((K 4, "A"), []);
         ((K 5, "C"), []);
         ((K 6, "D"), []);
         ((K 7, "C"), []);
              ])

       next g (K 3);;

(* 1.1 *)

let first (u,v) = (fst u, v);;

let rec next g k =
  match g with
  | Graph l -> let asc = List.map (fun (u,v) -> (fst u,v)) l
in List.assoc k asc;;

  (* (('k,'a) graph) -> ('k key list) -> ('k key list) -> ('k key list) *)
let rec dfs g tovisit visited = match tovisit with
  | [] -> visited
  | (x::xs) -> dfs g (next g x)::xs (x::visited);;
                                       
let rec depth_traversal g tovisit visited =
  match tovisit with
  | [] -> visited
  | (x::xs) -> let xneigh = next g x in
               let ntovisit = if (List.mem x visited) then xs else (xneigh@xs) in
               let nvisited = if (List.mem x visited) then visited else x::visited in depth_traversal g ntovisit nvisited;;

                                       
let rec breadth_traversal g tovisit visited =
  match tovisit with
  | [] -> visited
  | (x::xs) -> let xneigh = next g x in
               let ntovisit = if (List.mem x visited) then xs else (xs@xneigh) in
               let nvisited = if (List.mem x visited) then visited else x::visited in breadth_traversal g ntovisit nvisited;;

type 'a strategy = Strategy of ('a -> 'a list -> 'a list -> 'a list);;

(* Exercice 2 *)
type 'a queue = Q of 'a list * 'a list;;    
  
let q_insert (Q(insertL, popL)) elem =
  Q (elem::insertL, popL);;
  
let q_transfert (Q(insertL, popL)) = if popL == [] then
                                     Q([], List.rev insertL)
                                   else
                                     Q(insertL, popL);;
  (* Pour tester *)
  
  let my_q = List.fold_left q_insert (Q([],[])) [1;2;3;4];;

    
  let q_pop (Q(insertL, popL)) = match popL with
    | [] -> failwith "error"
    | x::xs -> Q(insertL, xs);;
    
    (* Exercice 3 *)

    
(* Semaine prochaine : terminer ex1 Strategy
Ex3 pas la peine *)

    (*
Error: Unbound value queue
# let my_q = List.fold_left q_insert (Q([],[])) [1;2;3;4];;
val my_q : int queue = Q ([4; 3; 2; 1], [])
# my_q;;
- : int queue = Q ([4; 3; 2; 1], [])
# q_transfert my_q;;
- : int queue = Q ([], [1; 2; 3; 4])
# q_pop my_q;;
Exception: Failure "error".
# q_pop my_q;;
Exception: Failure "error".
# my_q;;
- : int queue = Q ([4; 3; 2; 1], [])
# my_q_r = q_transfert my_q;;
Characters 0-6:
  my_q_r = q_transfert my_q;;
  ^^^^^^
Error: Unbound value my_q_r
Hint: Did you mean my_q?
# let my_q_r = q_transfert my_q;;
val my_q_r : int queue = Q ([], [1; 2; 3; 4])
# q_pop my_q_r;;
- : int queue = Q ([], [2; 3; 4])
*)
