(* Un nombre complexe s'écrit sous la forme: z = a + ib
On représente le type complexe par 2 variables:
a: partie réelle
b: partie imaginaire
*)
type complex = {
    a: float;
    b: float } ;;


 let z  = {a=10.; b=20.} ;; (* val c : complex = {a=10; b=20} *)
 let z2 = {a=2.; b=5.} ;;

(* La fonction 'add' prend en paramètre 2 nombres complexes. Elle retournes un nombre complexe. Pour accéder aux  champs a et b, on utilise le '.' *)
 let add z1 z2 =
  {a= z1.a +. z2.a; b= z1.b +. z2.b};;

 add z z2 ;; (* complex: {a=12; b=25} *)

 (* La fonction 'mul' a aussi deux complex en paramètre et retourne le résultat de la multiplication des deux nombres.
la formule est la suivante:  (a+i.b) x (a'+i.b') = (aa'-bb') + i(ab'+ba')
L'accès aux  champs se fait par 'pattern matching'.
 *)
 let mul z1 z2 = match (z1,z2) with
     ({a=a1;b=b1} , {a=a2;b=b2}) -> {a= a1*.a2 -. b1*.b2 ; b= a1*.b2 +. a2*.b1} ;;

   mul z z2;; (* complex: {a=-80; b=90} *)
                         
        

 




  

