(* RENDU DU TD1
   de Imen Hentati
et de Marc-Alexandre Espiaut *)

(* Exercice 1 *)
(* Pour lancer OCaml, on lance Emacs, on ouvre le fichier .ml puis on démarre l'interpréteur avec
la commande C x + C e. 
   La partie d'en haut est pour le code ML, celle d'en bas est pour la boucle d'interaction  *)

(* Exercice 2 *)

(* Exercice 3 *)
(* Q1: Exemples:
         5-2;; retourne 3
         2/5;; retourne 0, car l'opérateur / ne retourne pas de float *)
(* Q2: pour les flottants, il faut rajouter le caractère '.' et que les valeurs soient des flottants pour que le calcul soit correct. 
       Exemples: 2.0 /. 5.0;; retourne 0.4 *)
(* Q3 *)
(* 3.i *)
let x=true;;
x;;
(* 3.ii *)
(* On assigne la fonction sqrt à la variable x. Ici, la variable x avait déjà une valeur de type booléen, et a été rédéfinie comme une fonction.

Évaluer une fonction permet d'obtenir le type d'entrée attendu et de sortie de la fonction.
Exemple:
sqrt;; retournera "float -> float = <fun>"*)
let x = sqrt;;
x;;
    
(* 3.iii *)
(* Dans cet exercice, on définie la foncion f(x) = 2 * x + 3. Nous avons ici deux façons différentes de définir la même fonction. Soit en utilisant "let f = fun x -> …", pour créer une fonction anonyme ; soit en utilisant "let f x = …" avec x la variable d'entrée. *)
(* On peut appeller la fonction créée de deux manières différentes. Avec ou sans des parenthèses "f(7);;" ou "f 7;;" *)
let f = fun x -> 2 * x + 3;;
    f(7);;
    f 10;;
let f x  = 2 * x + 3;;
    f(7);;
    f 10;;
        
(* 3.iv *)
(* Comme nous utilisons la fonction cos qui retourne un flottant, la totalité des opérateurs et des variables doivent être adaptés en conséquent. *)
let ff x = 3. *. (cos x ** 2.) +. 1.;;
    ff(7.);;
    ff 10.;;

(* 3.v *)
let abs x = if (x < 0) then -x
              else x ;;

(* exercice 4 : manipuler des fonctions *)
(* 4.1 *)
(* La fonction make_even prend en paramètre une fonction qu'elle appelera ensuite dans son calcul. Comme nous l'avons vu pour l'exercice 3.iii, nous pouvons définir la fonction de deux façons. On peut tester make_even sur la fonction f qu'on a déjà défini: "make_even f;;" *)
let make_even f x = (f(x) + f(-x)) / 2;; 
let make_even f = fun x -> (f(x) + f(-x)) / 2;; (* autre notation *)

(* 4.2 *)
(* Pour la fonction deriv, on laisse la valeur d'epsilon à définir lors de l'appel de la fonction.
   Les valeurs sont ici en flottant, car unee partie du calcul est obtenue avec une division. 
   Ne pas utiliser de nombre à vigule reviens donc à obtenir une estimation. *)
let deriv eps f  = fun x -> (f(x +. eps) -. f(x -. eps)) /. 2. *. eps;;
let deriv1 = (deriv 1.);;
let deriv2 = (deriv 2.);;

(* make_even:(int -> int) -> int -> int = <fun> 
   deriv : float -> (float -> float) -> float -> float = <fun>
*)
  
(* 4.3 
  Pour réussir à faire la composition, il est nécessaire de redéfinir make_even ou bien deriv avec des opérations sur les flottants ou sur les entiers. Sinon les types étant incompatibles, les calculs ne se font pas.
 *)
let deriv eps f  = fun x -> (f(x + eps) - f(x - eps)) / 2 * eps;;
let deriv1 = (deriv 1);;

(* 
   Pour réussir à faire la composition: d'abord on fait la partie paire d'une fonction f, sur laquelle on applique ensuite la dérivée, puis on extrait la partie paire du résultat.
*) 

let compose make_even deriv1 make_even f = make_even(deriv1(make_even f));;

(* exercice 5  *)
(* 5.1 *)
let rec fact n = if(n==0) then  1
                         else
                           n* fact(n-1);;

fact 7;;

(*5.2 *)
let rec newton x f n =
           if(n==0) then  x
           else           
             let un  = newton x f n-.1. in
             un -. f(un) /. deriv1 f(un);;


(* 5.3 *)
(* La fonction approx_pi n'est plus applicable pour une valeur supérieure à 262062 ; après quoi, l'appel retourne le message "Stack overflow during evaluation (looping recursion?)." ce qui signifie que le nombre d'appel récursif est trop important et fait déborder la pile. *)

(* 5.4 *)
(* Le code en C fourni dans les sources est une fonction récursive terminale, contrairement à la fonction approx_pi qui n'est que récursive. Cela signifie que, dans le cas d'une fonction récursive terminale, une partie du calcul est déjà réalisée avant de faire un appel récursif, tandis que pour une fonction récursive, le calcul à effectuer doit attendre le retour de l'appel récursif à la fonction.

Cette différence permet donc de résoudre le problème rencontré précédement, à condition seulement de compiler le code avec l'option -O2 de gcc qui active plusieurs optimisations, dont -foptimize-sibling-calls *)
  
(* Approx ----- *)
let approx_pi n = 
  let rec approx_pi_rec n =
    if (n = 0) then 0
    else let a = approx_pi_rec (n-1) in
         let u = Random.float 1. and v = Random.float 1. in
         if (u*.u+.v*.v<=1.) then (a+4)
         else a in (approx_pi_rec n,n);;
            
           
(* Exercice 6  *)
(* La fonction de tri prends deux nouveaux arguments en entrée : fcomp - la fonction de comparaison (ici on utlisera la fonction 'compare'), et revflag - le booléen pour activer ou désactiver le tri décroissant.

Pour l'utilisation de la fonction de comparaion, la condition if des fonctions récursives 'rev_merge' et 'rev_merge_rev' est modifiée pour évaluer le résultat de la fonction 'fcomp' passée en argument de 'stable_sort'.

Pour trier en ordre croissant ou décroissant, l'argument 'revflag' est évalué à la fin de la fonction 'stable_sort' avant l'appel à 'sort' ou 'rev_sort'.*)
  
let rec chop k l =
  if k = 0 then l else begin
    match l with
    | x::t -> chop (k-1) t
    | _ -> assert false
  end
;;

let stable_sort l fcomp revflag =
  let rec rev_merge l1 l2 accu =
    match l1, l2 with
    | [], l2 -> List.rev_append l2 accu
    | l1, [] -> List.rev_append l1 accu
    | h1::t1, h2::t2 ->
       let compres = fcomp h1 h2 in
       if compres <= 0
       then rev_merge t1 l2 (h1::accu)
       else rev_merge l1 t2 (h2::accu)
  in
  let rec rev_merge_rev l1 l2 accu =
    match l1, l2 with
    | [], l2 -> List.rev_append l2 accu
    | l1, [] -> List.rev_append l1 accu
    | h1::t1, h2::t2 ->
       let compres = fcomp h1 h2 in
        if compres > 0
        then rev_merge_rev t1 l2 (h1::accu)
        else rev_merge_rev l1 t2 (h2::accu)
  in
  let rec sort n l =
    match n, l with
    | 2, x1 :: x2 :: _ ->
       if x1 <= x2 then [x1; x2] else [x2; x1]
    | 3, x1 :: x2 :: x3 :: _ ->
       if x1 <= x2 then begin
         if x2 <= x3 then [x1; x2; x3]
         else if x1 <= x3 then [x1; x3; x2]
         else [x3; x1; x2]
       end else begin
         if x1 <= x3 then [x2; x1; x3]
         else if x2 <= x3 then [x2; x3; x1]
         else [x3; x2; x1]
       end
    | n, l ->
       let n1 = n asr 1 in
       let n2 = n - n1 in
       let l2 = chop n1 l in
       let s1 = rev_sort n1 l in
       let s2 = rev_sort n2 l2 in
       rev_merge_rev s1 s2 []
  and rev_sort n l =
    match n, l with
    | 2, x1 :: x2 :: _ ->
       if x1 > x2 then [x1; x2] else [x2; x1]
    | 3, x1 :: x2 :: x3 :: _ ->
       if x1 > x2 then begin
         if x2 > x3 then [x1; x2; x3]
         else if x1 > x3 then [x1; x3; x2]
         else [x3; x1; x2]
       end else begin
         if x1 > x3 then [x2; x1; x3]
         else if x2 > x3 then [x2; x3; x1]
         else [x3; x2; x1]
       end
    | n, l ->
       let n1 = n asr 1 in
       let n2 = n - n1 in
       let l2 = chop n1 l in
       let s1 = sort n1 l in
       let s2 = sort n2 l2 in
       rev_merge s1 s2 []
  in
  let len = List.length l in
  if len < 2 then l else
    if revflag == true then sort len l
    else rev_sort len l
;;

stable_sort [4;2;5;3] compare true;;
stable_sort [4;2;5;3] compare false;;
stable_sort ["mauve";"bleu";"blanc";"carmin"] compare true;;
stable_sort ["mauve";"bleu";"blanc";"carmin"] compare false;;
