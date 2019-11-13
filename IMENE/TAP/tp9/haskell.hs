-- Type class
-- la classe Eq est équivalente en Java à l'interface Comparable[T] ou T = a
-- en Java : polymorphisme inclusion (poly d'objets)
-- en Haskell: polymorphisme paramétrique parce qu"il est basé sur les paramètres
import Prelude hiding (filter)
 
-- class Eq a where
--   (==) :: a -> a -> Bool
--   (/=) :: a -> a -> Bool
--   (/=) x y = not (x == y) -- Default implementation of (/=)
 
data Sign = Pos | Neg           -- A simple type that is either positive or negative

eq_sign :: Sign -> Sign -> Bool -- Definition of an equality on signs
eq_sign Pos Pos = True
eq_sign Neg Neg = True
eq_sign _   _   = False

instance Eq Sign where          -- The instance of the Eq class
  (==) = eq_sign                -- Définition de l'égalité sur Sign
 
filter pred []     = []       -- filter est de type (t-> bool) -> [t] -> [t]
filter pred (x:xs) =
  if (pred x) then x : (filter pred xs) else filter pred xs

insert x [] = [x]             -- type de insert: Eq t => t -> [t] -> [t]. Eq est dû au (==)
insert x (y:ys) =             --pattern matching en haskell
  if(x == y) then
    (y:ys)
    else
    y:(insert x ys)
  
data Complex = C (Int,Int) deriving Show     -- on peut étendre à postériori
-- isZero c = (c == C(0,0))

