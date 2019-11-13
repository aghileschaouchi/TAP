(********* Exercice  2  *********)

type 'k key         = K of 'k
and ('k, 'a) vertex = 'k key * 'a
and ('k, 'a) graph  = Graph of (('k, 'a) vertex * 'k key list) list;;
 
let g = Graph ([
         ((K 1, "A"), [K 2; K 3]);
         ((K 2, "B"), [K 4; K 5]);
         ((K 3, "C"), [K 6; K 7]);
         ((K 4, "A"), []);
         ((K 5, "C"), []);
         ((K 6, "D"), []);
         ((K 7, "C"), []);
              ])
      
(* 1.1 *)
(* un sommet est une paire <clé,valeur> . La liste des voisins est une liste de clés.
Dans le graphe g, il y a une liste qu'on appelle 'l'.
l est une liste de voisins qu'on va vouloir transformer en une liste (clé, {ensemble de voisins de k} )
Premièrement on récupére la clé (sans la valeur). Pour cela, on fait un map sur le premier élément avec 'fst'. Exemple: ((K 1, "A") => (K 1) )
Ensuite on utilise List.assoc (de manière currifiée) qui prend la clé et donne une key list.
 *)

let rec graph_next g k =
  match g with
  | Graph l -> let asc = List.map (fun (u,v) -> (fst u,v)) l in
               List.assoc k asc;;

graph_next g (K 1);;
graph_next g (K 2);;
    
(* 1.2 *)
(* Le parcours en profondeur visite tous les sommets en passant à chaque fois par tous les voisins de chaque sommet visité.
On fait du pattern matching selon la liste des sommets à visiter 'tovisit' (liste de clés):

   - si pas vide, on agit sur le premier sommet dans la liste qui est 'x':
            on regarde si x a déjà été visité avec la fonction List.mem. Si c'est le cas, les sommets à visiter sont 'xs'. En OCaml, le traitement dans le 'if' renvoie directement un résultat contrairement aux autres langages tels que java.  
            on récupère ses voisins avec la fonction précédente 'graph_next' et on les insère  dans 'tovisit'
            on rajoute x dans la liste des sommets visités 'visited' (si elle y existe déjà, on renvoie la même liste.)
            Maintenant, on obtient les deux nouvelles listes; on appelle de manière récursive depth_traversal avec ces nouvelles listes des visités et des tovisit.
   - On s'arrête quand on a plus rien à visiter.

 On appelle 'List.rev' pour une question d'affichage dans le bon ordre.
*)
let rec depth_traversal g tovisit visited =
  match tovisit with
  | [] -> List.rev visited
  | (x::xs) -> let xneight = graph_next g x in
             let ntovisit = if(List.mem x visited) then xs else (xneight@xs) in
             let nvisited = if(List.mem x visited) then visited else x::visited in
             depth_traversal g ntovisit nvisited;;

(* 1.3 *)
(* Le parcours en largeur visite tous les sommets en parcourant à chaque fois le sommet et ses voisins avant de passer au sommet suivant.
L'algorithme est semblable à celui de depth_traversal. La différence est l'endroit ou on regarde les sommets à visiter. En profondeur, on visite d'abord les voisins, et en largeur c'est l'inverse: on rajoute les sommets à la fin.
*)
let rec breadth_traversal g tovisit visited =
  match tovisit with
  | [] -> List.rev visited
  | (x::xs) -> let xneigh = graph_next g x in
               let ntovisit = if (List.mem x visited) then xs else (xs@xneigh) in
               let nvisited = if (List.mem x visited) then visited else x::visited in
               breadth_traversal g ntovisit nvisited;;

(* Pour tester *)  
depth_traversal g [K 1] [];;

breadth_traversal g [K 1] [];;
  
(* 1.4 *)
(* Le but de cette question est d'éviter la duplication de code dans les deux algorithmes de parcours en profondeur et en largeur.
Avec le type 'strategy', on définit deux stratégies avec le point qui fait la différence entre les deux algorithmes: l'insertion des sommets à visiter.
La fonction générique generic_traversal contient la généralisation avec la stratégie et dit: en fonction des voisins, décider de les rajouter ou pas. *)
type 'a strategy = Strategy of ('a -> 'a list -> 'a list -> 'a list) ;;

let strategy_breadth = Strategy (fun _ xs xneigh -> xneigh@xs);;
let strategy_depth  =  Strategy (fun _ xs xneigh -> xs@xneigh);;

let rec generic_traversal (Strategy s) g tovisit visited =
  match tovisit with
  | [] -> visited
  | (x::xs) -> let xneigh = graph_next g x in
	       let ntovisit = if (List.mem x visited) then xs else (s x xneigh xs) in
	       let nvisited = if (List.mem x visited) then visited else x::visited in
               generic_traversal (Strategy s) g ntovisit nvisited;;


(* Pour tester *)  
generic_traversal strategy_depth g [K 1] [];;

generic_traversal strategy_breadth g [K 1] [];;
  

(********* Exercice  1  *********)
(* une file = une liste d'entrée + une liste de sortie
Pour éjecter un élément de la liste, il faut faire un détournemeent sur la liste de sortie puis faire un pop.
Au lieu de faire du pattern matching à chaque fois, on va directement passer en paramètre des fonctions insert, transfer et pop le constructeur de la file appelé 'Q'. 
*)
  
type 'a queue = Q of 'a list * 'a list;;  
 
(* 2.1 *)
(* L'insertion se fait dans la liste d'entrée. La liste de retour reste telle quelle. *)
let rec q_insert (Q(l1,l2)) x =
  Q(x::l1, l2);;

  
(* 2.2 *)
(* On remplie la liste de sortie l2 par les éléments de l1 à l'envers. *)
let rec q_transfer (Q(l1,l2)) =
  if (l2 == []) then
    Q([], List.rev l1)
  else
    Q(l1,l2) ;;

  
(* 2.3 *)
(* Si pas d'éléments en sortie, on lance une exception définie en OCaml par 'failwith' *)
let rec q_pop (Q(l1,l2)) =
  match l2 with
  | [] -> failwith "Liste vide"
  | x::xs -> Q(l1, xs);;


(* Pour tester *)
let file = List.fold_left q_insert (Q([],[])) [1;2;3;4];;

q_transfer file;;

q_pop (q_transfer file);;
