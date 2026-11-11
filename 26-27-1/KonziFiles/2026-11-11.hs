module Konzi3 where

import Data.Maybe

-- case of
-- Either a b

f :: Either Bool String -> Maybe String
f (Left bool) = Nothing
f (Right str) = Just str

f x = case g x of
  Left str -> Just str
  _ -> Nothing
  where
    g :: Either Bool String -> Either String Bool
    g = undefined

data Line = Tram Integer [String] | Bus Integer [String] deriving (Eq, Show)

whichBusStop :: String -> [Line] -> [Integer]
whichBusStop street [] = []
whichBusStop street (Tram num stops : lines)
  | street `elem` stops = num : whichBusStop street lines
  --         ∈ 
  | otherwise = whichBusStop street lines
whichBusStop street (Bus num stops : lines)
  | isInList street stops = num : whichBusStop street lines
  | otherwise = whichBusStop street lines
  where
    --isInList :: String -> [String] -> Bool
    isInList _ [] = False
    isInList street (stop : stops) = street == stop || isInList street stops
