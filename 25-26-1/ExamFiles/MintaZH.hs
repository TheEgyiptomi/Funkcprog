module MintaZH where

import Data.Char

doubleTriple :: [a] -> [a]
doubleTriple [a] = [a, a, a]
doubleTriple [a, b] = [a, a, b, b]
doubleTriple x = x

lengthOfShorter :: [a] -> [b] -> Integer
lengthOfShorter [] _ = 0
lengthOfShorter _ [] = 0
lengthOfShorter (x:xs) (y:ys) = 1 + lengthOfShorter xs ys

compressLetters :: String -> String
compressLetters [] = []
compressLetters (x : xs@(y : ys))
  | isLower x && x == y = toUpper x : compressLetters ys
  | otherwise = x : compressLetters xs
compressLetters x = x
