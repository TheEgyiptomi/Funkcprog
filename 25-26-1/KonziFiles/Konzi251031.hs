module Konzi2 where

deleteDuplicateSpaces :: String -> String
deleteDuplicateSpaces [] = []
deleteDuplicateSpaces ls = init (concat [ s ++ " " | s <- words ls])

myEnumFromThenTo n m k 
 | (m-n) >= 0 = mEFTTHN n (m-n) k
 | otherwise = mEFTTHCS n (m-n) k

mEFTTHN :: Integer -> Integer -> Integer -> [Integer]
mEFTTHN n d k
 | n <= k = n : mEFTTHN (n+d) d k
 | otherwise = []

mEFTTHCS :: Integer -> Integer -> Integer -> [Integer]
mEFTTHCS n d k
 | n >= k = n : mEFTTHCS (n+d) d k
 | otherwise = []
