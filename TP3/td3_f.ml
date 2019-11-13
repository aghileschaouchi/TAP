(* TD3: Programmation fonctionnelle et générique *)
(* Exercice 1: Curryfication et généricité *)

(* 1.1 *)
let triplet (x ,y ,z) = y;;

(* 1.2 *)
(* forme currfiée: *)  
let curry f =
     fun x y -> f (x, y) ;;

(* forme décurryfiée: *)  
let uncurry f =
  fun (x ,y) -> f x y ;;

(* 1.3 *)
let inverse f x y=
    f y x;;
(* l'intérêt d'une telle fonction est de pouvoir bloquer le premier argument en cas de besoin. C'est-à-dire que si, par exemple, on veut appeler la fonction seulement avec le deuxième argument, dans le cas normal on ne peut pas le faire puisque c'est obligatoire de passer le premier argument. En inversant l'ordre des arguments on peut donc utiliser la fonction avec l'argument initialement bloqué parce qu'il passe en second lieu.*)
  
(* 1.4 *)
(* La fonction iterate est appelée de manière récursive. Nous avons deux manières de procéder:
- appliquer f n fois et appliquer x au dernier appel à f
- appliquer f(x) au lieu de x à chaque itération <= solution que nous avons choisi. 
Il est à noter que 'iterate' ne peut être appliquée que sur les fonctions qui ont un seul argument.
*)  
let rec iterate f x n =
  if n=0 then
    x
  else
    iterate f (f x) (n-1) ;;

(* Exercice 2: Listes d'associations génériques *)
(* 2.1: En OCaml, le type de données générique associé à une telle liste est: "(int * int) list" *)
let lmap = [(1,2)];;

  
(* Fonction qui compte la taille d'une liste *)
open List;;
let rec length list =
  if list = [] then
    0
  else
    1 + length(List.tl list);;
  
(* 2.2: Nous avons utilisé la récursivité, on s'arréte si notre liste est vide, sinon on parcours la liste en regardant si le couple en tête de liste à comme clé "key", si c'est le cas on fait appel a la fonction avec comme paramêtres "key" et "List.tl list" qui est le tail de la liste, si ce n'est pas le cas, on insert la tête de liste à l'appel récursive de la fonction *)  
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
  
(* 2.3: La condition d'arret est la liste vide, on applique la fonction en paramètre au couple en tête de liste et en l'insert à l'appel de la fonction récusive avec comme paramêtres "f" et "List.tl list" *)
let rec list_map f list =
  match list with
  |[] -> []
  |hd::tl ->
     begin
       f (List.hd list)::(list_map f (List.tl list))
     end
;;


(* 2.4: Si l1 est une liste vide, alors le résultat est l2, si l2 est vide, alors on retourne l1, si les deux liste sont vides, le résultat est une liste vide, sinon on extrait la tête de liste de l2 et on l'insert dans l'appel récursive de la fonction avec comme paramêtres l1 et le tail de l2*)
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

(* Exercice 3: Objets-enregistrements *)

(* Un nombre complexe s'écrit sous la forme: z = a + ib
On représente le type complexe par 2 variables:
a: partie réelle
b: partie imaginaire
Les fonctions add et mul sont représentés en OCaml comme des champs du type défini (complex).
OCaml permet de passer des 'fonctions' aux "types" en tant qu'attributs.
On peut créer un nouvel objet de type 'complex' et accéder aux variables ainsi qu'aux fonctions en utilisant le nom de l'objet suivi d'un '.' et du nom du champ. 
*)

(* 1.1 *)
type complex = {
  a   : float; 
  b   : float;
  add : complex -> complex;
  mul : complex -> complex
  };;  

(* 1.2 *)
(* La fonction 'add' prend en paramètre 2 nombres complexes. Elle retournes un nombre complexe. Pour accéder aux  champs a et b, on utilise le '.' 
Nous implémentons un constructeur pour 'complex' en déclarant une fonction récursive qui prend en arguments la partie imaginaire et la partie réelle d'un nombre complexe. Le constructeur affecte les valeurs de a et b dans celle des attributs de 'complex'. Dedans il y a aussi l'implémentation des fonctions add et mul en utilisant les fonctions anonymes. Par exemple pour la fonction add, l'addition est calculée de façon récursive depuis le constructeur en faisant appel à elle-même pour accéder au deuxième complex fournit en paramètre.
*)
  
let rec complexConstructor a b ={
    a = a;
    b = b;
    add = (fun tmp -> complexConstructor (a +. tmp.a) (b +. tmp.b));
    mul = (fun tmp -> complexConstructor (a *. tmp.a -. b *. tmp.b) (a *. tmp.b +. tmp.a *. b));                                                         
  };; 

(* Pour tester: On crée deux complex avec le constructeur. On peut ensuite effectuer la somme ou la multiplication *)
let z1 = complexConstructor 2. 3.;;
let z2 = complexConstructor 45. 10.;;
z1.add z2;;
z1.mul z2;;    
