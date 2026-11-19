module Lesson10 where

import Data.Char

-- Definiáld a map'' függvényt listagenerátorral!

map'' :: (a -> b) -> [a] -> [b]
map'' f xs = [ f a | a <- xs]
--              b    a    [a]    
--           {n | n \in N, n < 10}
------------------------------
-- Milyen más függvényeket lehet még így általánosítani?
-- Nézzünk ezekre is példát.

-- Definiáld a moreThan2 függvényt rekurzívan, amely egy számokat tartalmazó listából megtartja a 2-nél nagyobbakat.
moreThan2 :: (Num a, Ord a) => [a] -> [a]
moreThan2 [] = []
moreThan2 (x:xs)
  | x > 2 = x : moreThan2 xs 
  | otherwise = moreThan2 xs

-- Definiáld az onlyLower függvényt rekurzívan, amely egy szövegből csak a kisbetűket tartja meg.
onlyLower :: String -> String
onlyLower "" = ""
onlyLower (c:cs)
  | isLower c = c : onlyLower cs
  | otherwise = onlyLower cs

-- általánois feltétel: a -> Bool alakú

-- Itt is lehetne még sok példafeladatot felírni, de az előzőek alapján remélhetőleg érthető, hogy mi a cél.

-- Definiáld a filter' függvényt, amely adott tulajdonsággal rendelkező elemeket tart meg a listából.
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
  | f x = x : filter' f xs
  | otherwise = filter' f xs

-- Definiáld a filter'' függvényt listagenerátorral.
filter'' :: (a -> Bool) -> [a] -> [a]
filter'' f xs = [x | x <- xs, f x ]
--               a   a    [a]

-- Definiáld a mapFilter függvényt rekurzívan és listagenerátorral. Csak azon elemekre alkalmazzuk a map-ot, amelyek a szűrés után megmaradtak.
-- Melyiket kényelmesebb definiálni?
mapFilter :: (a -> b) -> (a -> Bool) -> [a] -> [b]
mapFilter _ _ [] = []
mapFilter f p (x:xs)
  | p x = f x : mapFilter f p xs
  | otherwise = mapFilter f p xs
-- mapFilter f p xs = map f (filter p xs)
mapFilter' :: (a -> b) -> (a -> Bool) -> [a] -> [b]
mapFilter' f p xs = [ f x | x <- xs, p x]
--             [a]     b    a   [a]

-- Definiáld a zipWith' függvényt, amely egy adott művelet alapján teszi össze az elemeket párhuzamosan haladva két listán.
-- A függvény a rövidebb lista hosszáig működik. Amelyikben több elem van, azokat eldobjuk.
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys
--          a [a]  b [b] 
-- Hogy kapjuk vissza az eredeti zip függvényt ezzel a függvénnyel?

-- Definiáld az indexedZipWith függvényt, amely ugyanazt csinálja, mint a zipWith, csak a függvényparaméter paramétereként átvesszük az adott két elem indexét is.
indexedZipWith :: Integral i => (i -> a -> b -> c) -> [a] -> [b] -> [c]
indexedZipWith f xs ys = iZWHelper f 0 xs ys
  where
    iZWHelper :: Integral i => (i -> a -> b -> c) -> i -> [a] -> [b] -> [c]
    iZWHelper _ _ [] _ = []
    iZWHelper _ _ _ [] = []
    iZWHelper f index (x:xs) (y:ys) = f index x y : iZWHelper f (index + 1) xs ys

-- Definiáld a ($$) függvényt, amely egy függvényt alkalmaz egy értékre.
infixr 0 $$
($$) :: (a -> b) -> a -> b
f $$ a = f a
-- Az eredeti függvény a ($).

{-
Azt már az év elején megbeszéltük, hogy a prefixen használt függvények kötési erőssége a legerősebb.
Ez a mondat ebben a formában nem teljesen igaz.
Korábban láthattuk, hogy teljesen nyugodtan zárójelezhetek balra egy kifejezést, az nem változtat semmin, pl.
mod 3 2 == (mod 3) 2
Ami valójában itt kiderül, hogy maga a függvényalkalmazás művelete egy legerősebben balra kötő operátor.
Mivel funkcionális programozásban a leggyakoribb művelet a függvényalkalmazás, ezért ez egy láthatatlan operátor, így a lehető legkevesebb karaktert igényli (0 db-ot egészen pontosan).
Azzal, hogy ez az operátor jobbra köt leggyengébben, de ugyanúgy a függvényalkalmazást csinálja, ennek van egy következménye,
még pedig az, hogy a jobbra zárójelezett kifejezésekről elhagyhatom a zárójelet, ha helyette használom a ($)-t.

Példa:
Előző órán volt az add függvény, amely az alábbi módon lett definiálva.

add :: Num a => Maybe a -> Maybe a -> Maybe a
add (Just x) (Just y) = Just (x + y)
add _        _        = Nothing

Látjuk, hogy a Just-os ágon az eredménykifejezés jobbra van zárójelezve. Ez azt jelenti, hogy a zárójelet elhagyhatom (ha kiteszem a ($)-t) azon a ponton,
ahonnan a kifejezés jobbra van zárójelezve, tehát:

add :: Num a => Maybe a -> Maybe a -> Maybe a
add (Just x) (Just y) = Just $ x + y
add _        _        = Nothing

És pontosan ugyanúgy működik.

A másik haszna ennek az operátornak, hogy tudok hivatkozni magára a függvényalkalmazás operátorára (0 karakterrel nehéz bármire is hivatkozni, nincs neve),
így lehet olyan kifejezéseket definiálni, amik például egy adott értéket adnak át egy-egy függvénynek, mint például az alábbi feladatban.
-}

-- Definiáld az app2ToFunctions függvényt magasabb rendű függvényeket használva rekurzió nélkül, amely alkalmazza a 2-es értéket egy függvényeket tartalmazó lista minden függvényén.
app2ToFunctions :: Num a => [a -> b] -> [b]
app2ToFunctions fs = map ($ 2) fs
--                       (\f -> f 2)
-- Definiáld a span' függvényt, amely kettébont egy listát ott, ahol egy adott tulajdonság már nem teljesül.
-- span' even [2,4,6,1,2,3,4] == ([2,4,6],[1,2,3,4])
-- span' (> 0) [5,4,3,2,1,0,-1,-2,-3] == ([5,4,3,2,1],[0,-1,-2,-3])
-- span' (< 0) [1,2,3,4] == ([],[1,2,3,4])
-- span' (> 0) [1,2,3,4] == ([1,2,3,4],[])
span' :: (a -> Bool) -> [a] -> ([a], [a])
span' _ [] = ([], [])
span' p (x:xs)
  | p x = let (as, bs) = span' p xs in (x:as, bs)
  | otherwise = ([] , x:xs)

-- Definiáld a takeWhile' függvényt, amely egy lista elejéről addig tartja meg az elemeket, amíg egy adott tulajdonság folyamatosan teljesül.
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' f xs = fst $ span f xs

-- Definiáld a dropWhile' függvényt, amely egy lista elejéről addig dobálja el az elemeket, amíg egy adott tulajdonság folyamatosan teljesül.
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' f xs = snd $ span f xs

-- Definiáld a find' függvényt, amely visszaadja az első adott tulajdonságú elemet egy listából, ha létezik olyan.
find' :: (a -> Bool) -> [a] -> a
find' _ [] = error "Sad"
find' p (x:xs) 
  | p x = x
  | otherwise = find' p xs
-- Az eredeti függvény a Data.List-ben található.

-- Definiáld az findIndex' függvényt, amely visszaadja az első adott tulajdonságú elem indexét egy listából, ha létezik olyan.
-- Megj.: Ugyan fel lehet használni az előző függvényt erre, de nem célszerű.
findIndex' :: Integral b => (a -> Bool) -> [a] -> b
findIndex' p (x:xs)
  | p x = 0
  | otherwise = 1 + findIndex' p xs

-- Megj.: Az eredeti függvény a Data.List-ben van, de csak Int-et ad vissza tetszőleges szám helyett, így a használata nem javallott.
