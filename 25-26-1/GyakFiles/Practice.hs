module Practice where

data Practice a b = T1 a | T2 b | T3 a b | T4 deriving (Show, Eq)

task1 ::  [Practice Integer Int] -> Int -> Integer
task1 xs i = foldr pH 0 xs
    where
        pH (T1 x) rekurzio = x + rekurzio
        pH (T2 x) rekurzio = negate rekurzio
        pH (T3 x y) rekurzio 
            | y < i = (negate x) + rekurzio
            | otherwise = x + rekurzio 
        pH T4 rekurzio = rekurzio