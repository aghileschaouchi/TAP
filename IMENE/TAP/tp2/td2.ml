let x=2;;

  (********* Exercice  1  *********)
 
let pi = 3.1415;;
let rot_gen pi (x,y,ang) =    (* ici, pi est lié avec une val = 3.1415 *)
  let newx = x*.cos(ang*.pi) +. y*.sin(ang*.pi) in
  let newy = x*.sin(ang*.pi) -. y*.cos(ang*.pi) in (newx,newy);;
let rot = (rot_gen pi);;
let pi = "troispointquatorze";; (* changement de valeur de pi *)
  rot (1.,0.,1.);;

(*traduction du code en C en OCaml. Différence avec le code en C:
  
*)
  let i=0;;
  let f j  =
    let i = i+ j in i;; (* la valeur utilisée est celle de i=0 définie en haut. on a 'enfermé' dans 
                         le code de f la valeur de i. i ne va plus changer pour f. ce n'est pas une affectation, c'est une constante qui ne change pas au cours du temps. par contre en C i est en écriture et en lecture. on parle de fermeture FORTE et fermeture FAIBLE: en C on a un ReadWrite sur la valeur. en OCaml, c'est un ReadOnly sur la référence. *)
    f 1;;
    f 2;;
    let i=421;;
    f 2;;
