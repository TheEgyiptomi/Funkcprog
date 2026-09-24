module KonziFiles.Konzi260113 where

import Data.Char
import Data.List
import Data.Maybe

haltOnAltitude :: Num a => [Maybe a] -> a
haltOnAltitude [] = 120
haltOnAltitude (Nothing:xs) = 120
haltOnAltitude ((Just n) : xs) = n + haltOnAltitude xs

commonPrefix :: String -> String -> Maybe String
commonPrefix xs ys
  | null (cPH xs ys) = Nothing
  | otherwise = Just (cPH xs ys)
  where
    cPH [] _ = ""
    cPH _ [] = ""
    cPH (x:xs) (y:ys)
      | x == y = x : cPH xs ys
      | otherwise = ""

data SpaceSector = EmptySpace | ResourceDeposit Integer | PirateOutpost Int deriving (Show, Eq)

collectResources :: Int -> [SpaceSector] -> Integer
collectResources _ [] = 0
collectResources n ((PirateOutpost x):xs)
  | x > n = 0
  | otherwise = collectResources n xs
collectResources n ((ResourceDeposit v):xs) = v + collectResources n xs
collectResources n (_:xs) = collectResources n xs

type Apple = (Bool, Int)
type Tree = [Apple]
type Garden = [Tree]

ryuksApples :: Garden -> Int
ryuksApples [] = 0
ryuksApples (t:ts) = treeHelper t + ryuksApples ts
  where
    treeHelper :: Tree -> Int
    treeHelper [] = 0
    treeHelper ((b, i):as)
      | b && i <= 3 = 1 + treeHelper as
      | otherwise = treeHelper as

isReservable :: Int -> String -> Bool
isReservable n ss = iRH n ss
  where
    iRH 0 _ = True
    iRH _ [] = False
    iRH m ('o':xs) = iRH n xs
    iRH m ('x':xs) = iRH (m-1) xs

isReservable' :: Int -> String -> Bool
isReservable' 0 _ = True
isReservable' _ [] = False
isReservable' n ls@(x:xs) = isPrefixOf (replicate n 'x') ls && isReservable' n xs
--isReservable' n ls@(x:xs)
  -- | isPrefixOf (replicate n 'x') ls = True
  -- | otherwise = isReservable n xs

largestFunVal :: Ord b => (a -> b) -> [a] -> (Int, b)
largestFunVal f xs = lFVH f (zip [1..] xs)
  where
    lFVH f [(i, x)] = (i, f x)
    lFVH f ((i, x):xs)
      | mV < f x = (i, f x)
      | otherwise = (mI, mV)
      where
        (mI, mV) = lFVH f xs

largestFunVal' :: Ord b => (a -> b) -> [a] -> Maybe b
largestFunVal' _ [] = Nothing
largestFunVal' f [x] = Just (f x)
largestFunVal' f (x:xs)
  | fromJust (largestFunVal' f xs) < f x = Just (f x)
  | otherwise = largestFunVal' f xs

{-
largestFunVal f [x] = f x
largestFunValue f (x:xs)
   | largestFunVal f xs < f x = f x
   | otherwise = largsetFunValue f xs
-}
