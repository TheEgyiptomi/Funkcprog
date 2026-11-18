module ExtraZH1 where

areSameParity :: Integral a => (a, a, a) -> Bool
areSameParity (a, b, c) = even a && even b && even c || odd a && odd b && odd c

selectElems :: [a] -> [Bool] -> [a]
selectElems [] _ = []
selectElems _ [] = []
selectElems (x:xs) (True:ys) = x : selectElems xs ys
selectElems (_:xs) (_:ys) = selectElems xs ys

congruentElems :: Integral i => i -> i -> [i] -> [i]
congruentElems _ _ [] = []
congruentElems m x (y:ys)
    | x `mod` m == y `mod` m = y : congruentElems m x ys
    | otherwise = congruentElems m x ys
