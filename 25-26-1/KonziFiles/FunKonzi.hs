{-# LANGUAGE DataKinds, GADTs, TypeOperators, TypeFamilies #-}
module Fun where

import Data.Kind
import GHC.Internal.TypeLits (ErrorMessage)

infixr 5 :::
type HList :: [Type] -> Type
data HList xs where
  HNil :: HList '[]
  (:::) :: x -> HList xs -> HList (x:xs)

head' :: HList (x:xs) -> x
head' (x ::: xs) = x

-- head' [] funky fordítási hiba ← totális lesz a head, hiszen típusban megkötöttük, hogy legalább van egy eleme listának

data Nat where
  Zero :: Nat
  Suc :: Nat -> Nat

type (!!) :: [Type] -> Nat -> Type
type family (!!) xs i where
  (x : xs) !! Zero = x
  (x : xs) !! (Suc n) = xs !! n
  
{-
                      Nem lehet → át kéne törni a határt 
                      ||||||||
                      vvvvvvvv  
(!!!) :: HList xs -> (i :: Nat) -> xs !! i
(x : xs) !!! i
  | i <= 0 = x
  | otherwise = xs !!! (i - 1)
-}

-- Solution: singleton Nat ~ SNat
type SNat :: Nat -> Type
data SNat n where
  SZero :: SNat Zero
  SSuc :: SNat n -> SNat (Suc n)
  


(!!!) :: HList xs -> SNat i -> xs !! i
(x ::: xs) !!! SZero = x
(x ::: xs) !!! (SSuc n) = xs !!! n
