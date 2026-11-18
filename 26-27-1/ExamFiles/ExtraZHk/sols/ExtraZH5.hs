module ExtraZH5 where

haveAtLeastThreeAndMostSixElems :: [a] -> Bool
haveAtLeastThreeAndMostSixElems [_,_,_] = True
haveAtLeastThreeAndMostSixElems [_,_,_,_] = True
haveAtLeastThreeAndMostSixElems [_,_,_,_,_] = True
haveAtLeastThreeAndMostSixElems [_,_,_,_,_,_] = True
haveAtLeastThreeAndMostSixElems _ = False

weirdInterleave :: [a] -> [a] -> [a]
weirdInterleave [] ys = ys
weirdInterleave (x:xs) [] = x : xs
weirdInterleave (x:xs) [y] = x : y : xs
weirdInterleave (x:xs) (y1:y2:ys) = x : y1 : y2 : weirdInterleave xs ys

intersection :: Eq a => [a] -> [a] -> [a]
intersection [] _ = []
intersection _ [] = []
intersection (x:xs) ys
    | x `elem` ys = x : intersection xs ys
    | otherwise = intersection xs ys
