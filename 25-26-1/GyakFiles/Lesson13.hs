module Lesson13 where

-- Sok függvény (magasabb rendűek is) hasznos a parciális applikálással, vegyük például az alábbiakat.

-- Definiáld az id' függvényt, amely a paraméterét csak visszaadja eredményül.
id' :: a -> a
id' a = a

-- Definiáld a const' függvényt, amely egy két paraméteres függvény első paraméterét adja vissza eredményül mindig.
const' :: a -> b -> a
const' x y = x 

-- Hogy lehet definiálni azt a függvényt, amely egy két paraméteres függvény második paraméterét adja vissza úgy, hogy
-- CSAK a const-ot és az id-t használjuk?
-- Megj.: A triviális definíció az lenne, hogy: const2 _ x = x; ezt hogy lehet megadni csak const-tal és id-vel?
const2 :: a -> b -> b
const2 x y = (const' id') x y
--      const' b -> a -> a
--         id a -> a
--               A

-- Definiáld a flip' függvényt, amely egy két paraméteres függvényt paramétereit felcseréli!
flip' :: (a -> b -> c) -> b -> a -> c
flip' f b a = f a b

-- Add meg a const2' függvényt, most a flip felhasználásával!
const2' :: undefined
const2' = undefined

-- Definiáld a curry' függvényt, amely egy rendezett párt váró függvény paraméterét szétbontja két önálló paraméterre.
curry' :: ((a, b) -> c) -> a -> b -> c
curry' f a b = f (a, b)

-- Definiáld az uncurry' függvényt, amely egy két paraméteres függvényt átalakít egy rendezett párt váró függvénnyé!
uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' f (a, b) = f a b 

-- Definiáld az iterate' függvényt, amely egy végtelen listát állít elő úgy, hogy folyamatosan alkalmaz egy függvényt egy értéken,
-- és az egyes részeredményeket adjuk vissza a listában.
-- take 10 (iterate' (+1) 0) == [0,1,2,3,4,5,6,7,8,9]
-- take 10 (iterate' not True) == [True,False,True,False,True,False,True,False,True,False]
iterate' :: (a -> a) -> a -> [a]
iterate' f a = a : iterate' f (f a)

-- Definiáld a repeat' függvényt az iterate' felhasználásával!
repeat' :: a -> [a]
repeat' a = iterate' id a

{-
A funkcionális programozás erőssége a függvények komponálhatósága, egymás utáni alkalmazása.
Ehhez azonban szükségünk van magára erre a függvényre, amely két függvényt komponál ezzel létrehozva egy új függvényt.
A definíciója ugyanaz, mint matematikában, analízisben.
-}
(∘) :: (b -> c) -> (a -> b) -> a -> c
(∘) f g a = f (g a)
infixr 9 ∘
-- Az eredeti függvény neve (.)a -> a

-- Az alábbi feladatokban használjunk függvénykompozíciót!

-- Definiáld azt a függvényt, amely az [1,11,111,1111,11111,...] végtelen listát állítja elő.
numbersMadeOfOnes :: undefined
numbersMadeOfOnes = undefined

-- Definiáld azt a függvényt, amely a [3,33,333,3333,33333,...] végtelen listát állítja elő.
numbersMadeOfThrees :: undefined
numbersMadeOfThrees = undefined

-- Definiáld azt a függvényt, amely az [1,31,331,3331,33331,...] végtelen listát állítja elő.
numbersMadeOfThreesAndOne :: undefined
numbersMadeOfThreesAndOne = undefined

{-
Mivel Haskellben lehetséges a parciális applikálás, lehetséges, hogy a függvényeinket kompozíciókként adjuk meg a paraméterek felvétele nélkül.
pl.

times2plus1 :: Num a => a -> a
times2plus1 x = 2 * x + 1

helyett tudjuk azt, hogy ez a művelet valójában csak két függvény kompozíciójából áll és tudjuk úgy definiálni, hogy:

times2plus1 = (+1) . (2*)
és a két függvény teljesen ugyanaz.

Először a számot meg kell szorozni kettővel, majd utána hozzá kell adni egyet.
A kompozíció matematikai érdekessége, hogy míg mi természetes módon balról jobbra olvasunk, addig a kompozíciókat jobbról balra kell olvasni
annak tekintetében, hogy mit csinál először és mit csinál utána. (Tehát a kompozíció művelete jobbra köt.)

Amikor nem veszünk fel paramétereket és úgy definiálunk függvényeket, azt szokás pointfree stílusnak nevezni.
-- SZÉP KÓD: Addig, amíg nem kell függvénykompozíciókat hegyén hátán használni, próbáljuk meg definiálni a függvényeket minél kevesebb paraméterfelvétellel.
             Meglepően tisztább és olvashatóbb lesz a kód.
Ezt egy példán keresztül megmutatva:
-}
-- Definiáld az any függvényt háromféleképpen. Az any ellenőrzi, hogy egy adott tulajdonságú elem megtalálható-e egy listában.
-- Segítség: Használd az or és a map függvényt a rövid definíció érdekében. Ne használj rekurziót és elágazást.
--           Az or függvény egy listányi Bool-t összevagyol.

-- Vegyük fel az összes paramétert!
any' :: (a -> Bool) -> [a] -> Bool
any' f xs = or . (map f) $ xs

-- Csak az első paramétert vegyük fel! (Megj.: Olyan nincs, hogy csak a második paramétert vegyük fel.)
any'' :: (a -> Bool) -> [a] -> Bool
any'' f = or . (map f)

-- Egy paramétert se vegyünk fel, pointfree adjuk meg!
any''' :: (a -> Bool) -> [a] -> Bool
any''' = (or .) . map

-- A három definíció közül melyik a legrövidebb, de annyira, hogy a kódjának az értelmezése még intuitív maradjon?
-- Válasz:

-- Feladatok:

-- Definiáljunk egy másik fajta kompozíciót (pipeline), amely megoldja nekünk, hogy balról jobbra olvassunk,
-- tehát lényegében csak cseréljük meg a kompozíció olvasási irányát.
(|>) :: undefined
(|>) = undefined

infixl 9 |>
-- Ez a függvény nem létezik, így aki használni szeretné, annak másolgatnia kell a definícióját.

-- Definiáld a dropSpaces függvényt, amely eldobja csak a szóközöket egy szöveg elejéről.
dropSpaces :: undefined
dropSpaces = undefined

-- Definiáld a trim függvényt, amely eldobja csak a szóközöket egy szöveg elejéről és végéről.
-- Feltehető, hogy a szöveg véges.
trim :: undefined
trim = undefined

-- Definiáld a maximumOfMinimums függvényt! Adott egy listák listája. Keressük meg a legnagyobb elemet a legkisebbek közül.
-- Feltehető, hogy a lista, továbbá egyetlen eleme sem üres lista.
maximumOfMinimums :: undefined
maximumOfMinimums = undefined

-- Definiáld a mapMap függvényt, amely alkalmaz egy függvényt listák listájában levő elemekre!
mapMap :: undefined
mapMap = undefined

-- Adjuk meg egy névnek a kezdőbetűit, azokat szóközökkel elválasztva!
firstLetters :: undefined
firstLetters = undefined

-- Adjuk meg egy név monogramját! A monogram abban különbözik, hogy pont is van a kezdőbetűk után; minden más része ugyanaz, mint az előző feladatnak!
monogram :: undefined
monogram = undefined

-- Definiáld a sublists függvényt, amely visszaadja egy lista minden lehetséges részsorozatát.
-- Részsorozatnak tekintjük a közvetlen egymást követő elemeket az eredeti listában.
-- Pl. "abcd"-nek részsorozata a "bc", de az "acd" nem.
sublists :: undefined
sublists = undefined

-- Definiáld az until' függvényt, amely addig ismétel egy műveletet egy értéken, amíg az eredményre egy adott tulajdonság nem teljesül.
-- Az eredmény az első olyan érték, amire teljesül a feltétel.
-- Definiáljuk rekurzívan és magasabb rendű függvényekkel is!
-- until' (\x -> x `mod` 5 == 0) (+2) 1 == 5
-- until' (\x -> x `mod` 5 == 0) (+9) 5 == 5
-- until' isLower succ 'A' == 'a'
-- until' isLower succ 'B' == 'a'
until' :: undefined
until' = undefined

until'' :: undefined
until'' = undefined

-- Megjegyzés: Problémás az az eset, ha a feltétel soha nem fog teljesülni.
-- pl. until' (const False) (+1) 0
-- Hogyan lehetne azt megoldani?
-- Válasz:

until''' :: undefined
until''' = undefined
