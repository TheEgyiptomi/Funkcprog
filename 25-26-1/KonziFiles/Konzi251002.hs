module Konzi1 where


f :: String -> Char
f (_:c: _) = c
f _ = 'a'

{-
a :: String
{c | c ∈ a ∧ is Upper c }
-}


k :: Int -> Int
k = undefined

--data Bool = True | False
data T = F

k' :: (Num a) => a -> a -> a
k' x y = 2 * x + y

f1 :: (a,b,c,d) -> ((a,b), (c,d))
f1 = undefined
