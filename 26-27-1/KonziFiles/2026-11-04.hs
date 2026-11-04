module MintaZH where

import Data.Char

doubleTriple :: [a] -> [a]
--doubleTriple [] = []
doubleTriple [x] = [x,x,x]
doubleTriple [x,y] = [x,x,y,y]
doubleTriple x = x
-- x : []

lengthOfShorter :: [a] -> [b] -> Integer
lengthOfShorter [] _ = 0
lengthOfShorter _ [] = 0
lengthOfShorter (_:xs) (_:ys) = 1 + lengthOfShorter xs ys

compressLetters :: String -> String
compressLetters "" = "" -- <=> [] = []
compressLetters [x] = [x]
compressLetters (x:y:xs)
    | isLower x && x == y = toUpper x : compressLetters xs
    | otherwise = x : compressLetters (y:xs)