(*COMMENTAIRES*)
(*COMMENTAIRES*)(*COMMENTAIRES*)(*COMMENTAIRES*)(*COMMENTAIRES*)

  (*1*)
let x = true;;
  (*2*)
let x = sqrt;;
  (*3*)
let f x = 2. *. x +. 3.;;
  (*4*)
let g x = 3. *. (cos x) ** 2. +. 1.;; 
  (*5 à appeler avec abs (-2)*)
let abs x = if (x < 0) then (-x) else (x);;
  (*Exercice 4*)
  (*1*)
let make_even f x = (f (x) + f (-x)) / 2;;
let make_even f = fun x -> (f (x) + f (-x)) / 2;;
  (*2*)
let deriv eps f x = (f (x +. eps) -. f (x -. eps)) /. (2. *. eps);;
let deriv1 = (deriv 0.0000001);;
  (*3*)
let composed f = make_even(deriv 1 (make_even f));;
  (*La composition*)
let compose f g = fun -> f ( g (x));;
let composed = compose (make_even compose( deriv (1) make_even f));;
  (*Derivée*)
let rec fact n = if (n == 0) then 1 else (n * fact (n-1));;
  (*Newton*)
(*let un n = newton (n) in let newton f x = if (x == 0) then x else (un - f (un) / (deriv 1 f (un)));; *)
let rec newton f n x = (let un = newton (f (n-1) x) in if (x == 0) then x else (un - f (un) / deriv 1 f (un)));;
