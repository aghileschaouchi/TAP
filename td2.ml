let i = 0;;
let f j = let i = i + j in i;; (* On a enfermé la valeur de i dans la fonction*)
  (*En caml on a enfermé la valeur de i dans la fonction*)
  (*En C en enférme la réf de i dans la fonction*)
  (*RO sur la réference*)
  (*RW sur la valeur*)
  
f (1);; (*Renvoi 1*)
f (2);; (*Renvoi 2*)
let i = 421;;
f (2);; (*Renvoi 2*)
