(********* Exercice  1  *********)
 
let f = lazy (failwith "Marchera pas");;
Lazy.force f;;
 
(********* Exercice  2  *********)
 
type 'a stm =
| StmEmpty
| StmCons of ('a * 'a stm) lazy_t
 
let rec length_evaluated stm = match stm with
  | StmEmpty   -> 0
  | StmCons(x) -> if not(Lazy.is_val x)
                    then 0
                    else let (_,v) = Lazy.force x in
                         1 + length_evaluated v;;
 
let stm = StmCons (lazy(1, StmCons(lazy (1/0, StmEmpty))));;

  (* head *)

let stm_head stm = match stm with
  | StmEmpty -> failwith "no head"
  | StmCons(x) -> let (u, _) = Lazy.force x in u;;

  let head = stm_head stm;;

    (* tail *)
    
let stm_tail stm = match stm with
  | StmEmpty -> failwith "no tail"
  | StmCons(lazy(_, v)) -> v;;

let tail = stm_head (stm_tail stm);;

  (* n premiers *)
let rec n_first stm n = if n = 0 then [] else match stm with
  | StmEmpty -> []
  | StmCons (lazy(u, v)) -> u::(n_first v (n-1));;

let res list_to_stream l = match l with
  |[] -> StmEmpty
  |x::xs -> StmCons(lazy(x, list_to_stream xs));;

  (* 1.4 *)
let rec fun_to_stream_bounded f n = match n with
  |0 -> [f(0)]
  |x -> f(x)::(fun_to_stream_bounded f (n-1));;

let fun_to_stream_bounded f n = let rec build k =
                                  if (k > n) then StmEmpty
                                  else StmCons (lazy (f(k), build (k+1)))
                                in build 1;;
  
let f_l = fun_to_stream_bounded (fun u -> u+1) 3;;
  n_first f_l 3;;

  let fun_to_stream_unbounded
        f  = let rec build k =
                                     StmCons (lazy (f(k), build (k+1)))
                                     in build 1;;

    (* map et concat *)

    
