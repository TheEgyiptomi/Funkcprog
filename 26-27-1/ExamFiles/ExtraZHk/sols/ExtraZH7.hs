module ExtraZH7 where

import Data.Char (isLower, isUpper)

sphereVolume :: (Floating a, Ord a) => a -> a
sphereVolume r
    | r < 0 = 0
    | otherwise = 4 / 3 * pi * r ** 3

productOfLengths :: [[a]] -> Int
productOfLengths [] = 1
productOfLengths (xs:xss) = length xs * productOfLengths xss

onlyLowercaseVowelsAndUppercaseNonVowels :: String -> String
onlyLowercaseVowelsAndUppercaseNonVowels "" = ""
onlyLowercaseVowelsAndUppercaseNonVowels (c:cs)
    | isVowel c && isLower c || not (isVowel c) && isUpper c =
        c : onlyLowercaseVowelsAndUppercaseNonVowels cs
    | otherwise = onlyLowercaseVowelsAndUppercaseNonVowels cs
    where isVowel c = c `elem` "aeiouAEIOU"
