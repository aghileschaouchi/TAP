 
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
  (==) = eq_sign
 
filter pred []     = []
filter pred (x:xs) =
  if (pred x) then x : (filter pred xs) else filter pred xs

insert x []        = [x]
insert x (y:ys)    =
  if (x == y) then (y:ys)
  else y : (insert x ys)
 
data Complex = C (Int,Int) deriving Show
-- isZero c = (c == C(0,0))
