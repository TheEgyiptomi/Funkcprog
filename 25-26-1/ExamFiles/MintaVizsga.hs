import Data.List

points :: Integral a => [(String, a, a)] -> [(String, a)]
points ls = [ (n, a)| (n, t, f) <- ls, let a = 100 - (t `div` 2) - f, a > 0]

type Apple = (Bool, Int)
type Tree = [Apple]
type Garden = [Tree]

ryuksApples :: Garden -> Int
ryuksApples ls = sum [ 1 | l <- ls, (True, x) <- l, x <= 3]

barbie :: [String] -> String
barbie [] = "farmer"
barbie [x]
  | x == "rozsaszin" = x
  | otherwise = "farmer"
barbie ("rozsaszin":xs) = "rozsaszin"
barbie (x:y:xs)
  | y /= "fekete" = y
  | otherwise     = barbie xs

doesContain :: String -> String -> Bool
doesContain [] _  = True
doesContain _  [] = False
doesContain (e:es) (x:xs)
  | e == x    = doesContain es xs
  | otherwise = doesContain (e:es) xs

firstValid :: [a -> Bool] -> a -> Maybe Int
firstValid fs e
  | null res = Nothing
  | otherwise = Just $ head res
  where
    res = [ i | (i,f) <- zip [0..] fs, f e]

combineListsIf :: (a -> b -> Bool) -> (a -> b -> c) -> [a] -> [b] -> [c]
combineListsIf p f (x:xs) (y:ys)
  | p x y = f x y : combineListsIf p f xs ys
  | otherwise = combineListsIf p f xs ys
combineListsIf _ _ _ _ = []

data Line = Tram Integer [String] | Bus Integer [String] deriving (Eq, Show)

whichBusStop :: String -> [Line] -> [Integer]
whichBusStop stop [] = []
whichBusStop stop (Bus i stops : xs)
  | stop `elem` stops = i : whichBusStop stop xs
  | otherwise         = whichBusStop stop xs
whichBusStop stop (Tram i stops : xs) = whichBusStop stop xs

isReservable :: Int -> String -> Bool
isReservable 0 _  = True
isReservable n [] = False
isReservable n str = seats `isPrefixOf` xs || isReservable n (dropWhile (== 'o') rest)
  where
     seats = replicate n 'x'
     (xs, rest) = span (== 'x') str
{-
isReservable :: Int -> String -> Bool
isReservable 0 _  = True
isReservable n [] = False 
isReservable n ('o':str) = isReservable n str
isReservable n str@(s:ss)
  | hasN n str = True
  | otherwise  = isReservable n (dropWhile (== 'x') ss)
  where
    hasN 0 _ = True
    hasN i ('x':xs) = hasN (i-1) xs
    hasN _ ('o':xs) = False
-}

