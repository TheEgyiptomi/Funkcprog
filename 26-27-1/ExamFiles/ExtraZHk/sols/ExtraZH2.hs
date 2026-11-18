module ExtraZH2 where

collatzFn :: Integral a => a -> a
collatzFn n
    | even n = n `div` 2
    | otherwise = 3 * n + 1

sumNeighbours :: Num a => [a] -> [a]
sumNeighbours (x:y:xs) = x + y : sumNeighbours (y:xs)
sumNeighbours _ = []

elemsInRange :: Ord a => (a, a) -> [a] -> [a]
elemsInRange (a, b) xs | a > b = elemsInRange (b, a) xs
elemsInRange _ [] = []
elemsInRange (a, b) (x:xs)
    | a <= x && x <= b = x : elemsInRange (a, b) xs
    | otherwise = elemsInRange (a, b) xs
