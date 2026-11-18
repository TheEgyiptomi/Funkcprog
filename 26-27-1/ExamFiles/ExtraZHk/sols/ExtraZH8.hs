module ExtraZH8 where

haveAtLeastTwoAndThreeElems :: ([a], [b]) -> Bool
haveAtLeastTwoAndThreeElems ((_:_:_),(_:_:_:_)) = True
haveAtLeastTwoAndThreeElems ((_:_:_:_),(_:_:_)) = True
haveAtLeastTwoAndThreeElems _ = False

sumProduct :: Num a => [a] -> [a] -> a
sumProduct [] _ = 0
sumProduct _ [] = 0
sumProduct (x:xs) (y:ys) = x * y + sumProduct xs ys

dropEveryNth :: Int -> [a] -> [a]
dropEveryNth _ [] = []
dropEveryNth n xs = take (n - 1) xs ++ dropEveryNth n (drop n xs)

