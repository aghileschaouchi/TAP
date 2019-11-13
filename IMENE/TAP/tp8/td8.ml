(********* Exercice  1  *********)
 
let f = lazy (failwith "Marchera pas");;
Lazy.force f;;

(*** 1.1 ***)
let lazy_int = lazy(1);;
let lazy_list = lazy ([1;2;3]);;
let x = lazy(1/0);;
  
Lazy.force  x;;

(*** 1.2 ***)
let lazy_print = lazy(print_string("ABC"));;

(* On retrouve un affichage de "ABC" lors de la décongélation de lazy_print.
   L'effet de bord se produit au moment du force dont le type de retour est un 'unit' (void) 
*)

Lazy.force lazy_print;;


(*** 1.3 ***)
(* L'affichage de "ABC" se fait uniquement au premier appel de force qui évalue le contenu.
 Il n'y a pas d'affichage au deuxieme force du print parce que ce dernier renvoie un 'unit' donc on ne peut pas évaluer le force deux fois (parce que ce n'est pas un lazy).

 La congélation utilisée dans le TD précédent représente une valeur paresseuse comme une fonction qui force l'exécution à chaque appel (mais toujours la meme fonction) donc elle retournera toujours un affichage de "ABC". 
 La différence entre les deux est que ici, une fois la valeur paresseuse évaluée, le calcul n'est plus refait et le résultat est stocké en mémoire. 
*)

Lazy.force lazy_print;;
Lazy.force lazy_print;; (* evalué a unit *)
  
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

(*** 2.1 ***)
let int_stm = StmCons(lazy((1),
                  StmCons(lazy((1/0),
                     StmEmpty))));;

(*** 2.2 ***)

let stm_head st =
  match st with
  | StmEmpty -> failwith("No head")
  | StmCons(lazy (u,_))-> u;; (*match directement ce qu'il y a a l'interieur. stmcons(lazy u,_) = Lazy.force x in u ;;*)

let stm_tail st =
  match st with
  | StmEmpty -> failwith("No tail")
  | StmCons(lazy (_,u)) -> u;;
  

stm_head int_stm;;
stm_tail int_stm;;

(* Si on regarde la tete de la queue, l'exception de division par zero est levée.*)
stm_head (stm_tail int_stm);;

(*** 2.3 ***)
let rec list_to_stream l =
  match l with
  |[] -> StmEmpty
  |(x::xs) -> StmCons(lazy(x,list_to_stream xs));;

let rec stm_peek n s = (*tester des flots qui sont grands *)
  if(n=0) then [] else
   match s with
   | StmEmpty -> []
   | StmCons(lazy(u,v)) -> u::(stm_peek (n-1) v);; 
  
let l = [1;2;3];;
let st_list = list_to_stream l;;
stm_peek 30 st_list;;

(*** 2.4 ***)
let rec fun_to_stream_bounded f n =
  let rec build k = (*construit le flot de k à n *)
    if(k>n) then StmEmpty
    else
      StmCons(lazy(f(k),build (k+1) )) in build 1;;
  

stm_peek 30 (fun_to_stream_bounded (fun x -> x+1) 20);;

(*** 2.5 ***)
(* C'est un modele d'objets infini. Un systeme qui permet la construction des valeurs 'à la demande'. 
  Si on évalue n valeurs, on crée simplement une liste de longueur n avec un lazy qui peut continuer à construire plus tard.
  Exemple: paginer des resultats: une liste avec toutes les valeurs et il est possible de récupérer des pages quand on le demande, sinon on n'évalue pas le reste. 
*)
let rec fun_to_stream_unbounded f = 
  let rec build k =
    StmCons(lazy(f(k),build(k+1))) in build 1;;

stm_peek 30 (fun_to_stream_unbounded (fun x -> x+1));;

(*** 2.6 ***)
let rec stm_map f fl =
  match fl with
  |StmEmpty -> StmEmpty
  |StmCons(lazy(u,v)) -> StmCons(lazy(f u, stm_map f v));; 

stm_head (stm_map (fun x -> x+1) int_stm);; (* exception: division par zero *) 

(*** 2.7 ***)
let rec stm_compose f fl1 fl2 =
  match (fl1, fl2) with
  |(StmEmpty,StmEmpty) -> StmEmpty
  |(StmCons(lazy(u1,v1)), StmCons(lazy(u2,v2))) ->
           StmCons(lazy(((f u1 u2), (stm_compose f v1 v2))))
  | _ -> failwith "impossible de composer";; (*sans cette condition, le matching n'est pas exhaustif pour le compilateur *)

  
(*** 2.8 ***)
let rec stm_concat fl1 fl2 =
  match fl1 with
  |StmEmpty -> fl2
  |StmCons(lazy(u,v)) -> StmCons(lazy(u, stm_concat v fl2));; 
