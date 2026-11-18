module ExtraZH6 where

sameSignCoordinates :: (Num a, Ord a) => (a, a) -> Bool
sameSignCoordinates (x, y) = signum x == signum y

sameNeighbours :: Eq a => [a] -> Bool
sameNeighbours (x:y:xs) = x == y || sameNeighbours (y:xs)
sameNeighbours _ = False

sumGroupsOfN :: Num a => Int -> [a] -> [a]
sumGroupsOfN _ [] = []
sumGroupsOfN n xs = sum (take n xs) : sumGroupsOfN n (drop n xs)
