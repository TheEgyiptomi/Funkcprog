module ExtraZH4 where

neighbourhood :: Integral a => a -> a -> [a]
neighbourhood x r
    | r < 0 = [x-r,x-r-1..x+r]
    | otherwise = [x-r..x+r]

concatEverySecond :: [[a]] -> [a]
concatEverySecond (_:x:xs) = x ++ concatEverySecond xs
concatEverySecond _ = []

deleteElem :: Eq a => a -> [a] -> [a]
deleteElem _ [] = []
deleteElem x (y:ys)
    | x == y = deleteElem x ys
    | otherwise = y : deleteElem x ys
