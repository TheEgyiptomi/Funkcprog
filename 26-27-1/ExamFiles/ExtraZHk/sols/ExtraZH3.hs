module ExtraZH3 where

max3 :: Ord a => (a, a, a) -> a
max3 (a, b, c)
    | a >= b && a >= c = a
    | b >= a && b >= c = b
    | c >= a && c >= b = c

areTriosEqual :: Eq a => [a] -> Bool
areTriosEqual (a:b:c:xs) = a == b && b == c && areTriosEqual xs
areTriosEqual _ = True

indexOf :: (Eq a, Num b) => a -> [a] -> b
indexOf x (y:ys)
    | x == y = 0
    | otherwise = 1 + indexOf x ys
