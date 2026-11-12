module Lesson09 where

import Data.Char

-- Definiáld az Error saját típust! A konstruktorai olyanok legyenek, hogy a doubleHead függvény két hibáját tudja jelezni.

data DoubleHeadError = EmptyList | EmptyFirstList deriving (Show)

-- Definiáld a doubleHeadError függvényt!
doubleHeadError :: [[a]] -> Either a DoubleHeadError
doubleHeadError [] = Right EmptyList
doubleHeadError ([]:_) = Right EmptyFirstList
doubleHeadError ((x : _) : _) = Left x

-- Definiálj egy másik hibát jelző típust, amely a divHead műveletet kezeli.

data DivHeadError = DivByZero | EmptyList'

-- Definiáld a divHead függvényt ezzel az új hibát jelző típussal!
divHeadError :: Integral a => a -> [a] -> Either a DivHeadError
divHeadError 0 _ = Right DivByZero
divHeadError _ [] = Right EmptyList'
divHeadError n (x:_) = Left (n `div` x)

-- Mi lesz a probléma ezzel a módszerrel?
-- Válasz:

-- Természetesen ez is megoldható, de ezen eszközök megint csak túlmutatnak a tárgy keretein.
-- Konzultáción szintén tudunk róla beszélgetni.

---------------------------------------------------------------------------------------------------------

-- Feladatok:
-- Definiáld az add1OrNot függvényt, amely vagy egy számhoz hozzáad egyet vagy egy Bool-t negál.
add1OrNot :: Num a => Either a Bool -> Either a Bool
add1OrNot = undefined

-- "Bizonyítsuk", hogy az Either típus asszociatív!
-- (Tehát ha van két Either típus egymásba ágyazva, akkor nem számít, hogy hogyan vannak egymásba ágyazva.)
eitherAssoc :: (a `Either` b) `Either` c -> a `Either` (b `Either` c)
eitherAssoc = undefined

-- Megj.: A tényleges bizonyításhoz a másik irányban is meg kéne adni, de elhiszem, hogy ezen a ponton az menne mindenkinek.

---------------------------------
-- Rekurzív (Induktív) típusok
---------------------------------

{-
Nem csak függvények lehetnek rekurzívak, hanem maguknak a típusoknak a felépítése is lehet rekurzív, pontosabban induktív.
Vegyük példaként a listát. Hogy lehet végtelen listánk? Úgy, hogy a típusában valahol végtelen rekurziót lehet csinálni.

Próbáljuk meg definiálni mi magunk a lista adatszerkezetet. Szükség van két konstruktorra; egy, ami az üres listát reprezentálja, meg egy, ami a legalább egy eleműt.
Ezeket általában Nil-nek és Cons-nak szokás nevezni. A Cons konstruktor infixen használva kössön 5-ös erősséggel jobbra.
-}

data List a = Nil | Cons a (List a)
--        Nil :: List a  ;  Cons :: a -> List a -> List a
--         [] :: [a]     ;   (:) :: a -> [a]     -> [a]
infixr 5 `Cons` 

-- Definiáld az add1 függvényt, amely a lista minden eleméhez hozzáad egyet.

add1 :: Num a => List a -> List a
--      Num a =>   [a]  ->   [a]
add1 Nil = Nil
add1 (Cons x xs) = Cons (x + 1) (add1 xs)
--   (x `Cons` xs) = x + 1 `Cons` add 1
-- add1 (x : xs) =   x + 1    :   add1 xs

-- Példányosítsd a List típust Show-ra, Eq-ra.

instance (Eq a) => Eq (List a) where
  Nil == Nil = True
  x `Cons` xs == y `Cons` ys = x == y && xs == ys
  --            Eq a => a -> a -> Bool && Eq a => List a -> List a -> Bool 
  _ == _ = False

instance (Show a) => Show (List a) where
  show ls = show (toBuilinList ls)
    where
      toBuilinList :: List a -> [a]
      toBuilinList Nil = []
      toBuilinList (x `Cons` xs) = x : toBuilinList xs

-- A lista ezen a ponton unalmas, pontosan ugyanazt tudja, mint az eredeti lista, amit eddig használtunk.
-- Definiáljunk eggyel érdekesebbet: bináris fákat.
-- A bináris fa olyan fa, amely minden csomópontban és levélben tartalmaz adatot, továbbá minden csomópontnak pontosan két gyereke van.
-- Reprezentáció szempontból nézzük az alábbi példát.
{-
        4
       / \
      /   \
     3     2
    / \   / \
   1   0 3   7
  / \       / \
10  20     5   9
-}

-- Definiáljuk a BinTree típust, ami egy ilyen fát tud reprezentálni.
-- Két konstruktora kell legyen, Leaf és Node.
-- Kérjük meg a fordítót, hogy példányosítsa nekünk a Show osztályra a típusunkat.
--                             bal részfa     jobb részfa
data BinTree a = Leaf a | Node (BinTree a) a (BinTree a) deriving Show
--  Leaf :: a -> BinTree a ; Node :: (BinTree a) -> a -> (BinTree a) -> BinTree a

-- Adjuk meg a fenti példában látható fát lineáris jelöléssel (tehát Leaf-ek és Node-ok függvényében)!
t :: Num a => BinTree a
t = Node (Node (Node (Leaf 10) 1 (Leaf 20)) 3 (Leaf 0)) 4 (Node (Leaf 3) 2 (Node (Leaf 5) 7 (Leaf 9)))

-- Definiáld az add1Tree függvényt, amely egy bináris fa minden eleméhez hozzáad egyet.
add1Tree :: Num a => BinTree a -> BinTree a
add1Tree (Leaf x) = Leaf (x + 1)
add1Tree (Node tl x tr) = Node (add1Tree tl) (x + 1) (add1Tree tr)
--        BinTree a
-- Definiáld a sumTree függvényt, amely egy bináris fának az elemeit összeadja.

-- Példányosítsd az Eq osztályt a bináris fára.

instance (Eq a) => Eq (BinTree a) where
  Leaf x == Leaf y = x == y
  Node tla a tra == Node tlb b trb = a == b && tla == tlb && tra == trb
  _ == _ = False

-----------------------------------------------------
-- Magasabb rendű függvények (Higher order functions)
-----------------------------------------------------

-- Motivációként csináld meg az alábbi feladatokat:
-- Definiáld az add2 függvényt, amely egy lista minden eleméhez hozzáad 2-t.
add2 :: Num a => [a] -> [a]
add2 [] = []
add2 (x : xs) = x + 2 : add2 xs

-- Definiáld a mul2 függvényt, amely egy lista minden elemét megszorozza 2-vel.
mul2 :: Num a => [a] -> [a]
mul2 [] = []
mul2 (x : xs) = x * 2 : add2 xs

-- Definiáld a toUpperAll függvényt, amely egy szöveg minden karakterét nagybetűsíti.
toUpperAll :: String -> String
toUpperAll "" = []
toUpperAll (c : cs) = toUpper c : toUpperAll cs

-- Definiáld a negateAll függvényt, amely egy Bool-ok listájának minden elemét negálja.
negateAll :: [Bool] -> [Bool]
negateAll [] = []
negateAll (b : bs) = not b : negateAll bs


-- Legyen adott egy h függvényt:
h :: Num a => Bool -> a
h True = 1
h False = 0

-- Definiáld a hAll függvényt, amely egy Bool-ok listáját átalakítja számok listájává.



-- Aki esetleg unja már, mi lenne jó, ha mit tudnánk ezek helyett csinálni?
-- Aki még nem unja, van még ∞+1 ilyen feladat.

-- Általánosítsuk az ötletet!
-- Mi lesz a típusa? Hogyan fog a típusban meglátszódni, hogy mi kell nekünk?
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x : xs) = f x : map' f xs
-- f :: a -> b 

-- Definíció:
-- Magasabb rendű függvény: Olyan függvény, amely függvényt vár paraméterül.
-- Megj.: ...vagy függvényt ad eredményül, ezt is hozzá szokták tenni,
--        de ebben a nyelvben az teljesen felesleges, mert akkor minden függvény magasabb rendűnek számítana.

{-
Magasabb rendű függvények használata:
Megpróbálhatnánk úgy használni, ahogy eddig tettük, pl.

l = map' f [1,2,3] where
  f x = x + 1

de azért azt elkezdjük látni, hogy:
1. A where-ben/let-in-ben csak ezért egy függvényt definiálni nem igazán karakterhatékony, nem is idiomatikus.
2. Elég sűrűn előfordul, hogy ugyanazt a függvényt kéne többször a where-ben definiálni, az meg csak simán kódduplikáció; az meg egy nyelvben sem szép.

Milyen jó lenne, ha lennének ilyen egyszer használatos függvények, amiket csak odaírok és működik!
Szerencsénk van, ilyenek egy funkcionális nyelvben léteznek, ezeket szokás lambda függvényeknek nevezni.

-- Definíció:
-- Lambda-függvény: Névtelen függvény.

Szintaxisa: (\ <1. paraméter neve> <2. paraméter neve> ... <n. paraméter neve> -> <kifejezés>)
ahol a paraméterek neveire ugyanaz a szabály vonatkozik, mint a sima függvényekben, tehát kisbetűvel kezdődnek.

Ezzel az új eszközzel felvértezve magunkat tudunk egyszer használatos, névtelen függvényeket megadni paraméterül a magasabb rendű függvényeknek.

l = map' (\x -> x + 1) [1,2,3]

Sokkal rövidebb, átláthatóbb, hogy mit szeretnénk kifejezni.

--------------------

Természetesen ezen névtelen függvények használhatók magasabb rendű függvények nélkül is.
pl. (\x -> x + 1) 2, pontosan ugyanúgy működnek, mint a megszokott, névvel rendelkező függvények.
    ^^^^^^^^^^^^^^^ -- Mennyi lesz az eredménye ennek a kifejezésnek?

A lambdákban ugyanúgy lehet mintailleszteni, azonban nem totálisan, csak maximum egy minta van megengedve.
(\True -> False) True == False

-- SZÉP KÓD: Éppen a fenti miatt csak azon értékeket mintaillesszük, amiknek pontosan egy konstruktora van,
             de azt mintaillesszük is (ha csak nem valami nagyon-nagyon triviális dolgot művelünk)! (pl. rendezett n-es)

Mi történik (\False -> True) True esetén?

Két paraméter esetén az alábbi módon néz ki:
(\x y -> 2 * x + 3 * y) 9 10

Mi történik akkor, ha a függvényt bezárójelezzük az első paraméterrel?
((\x y -> 2 * x + 3 * y) 9) 10

Hiba lesz vagy teljesen helyes?
Ha futtatjuk mindkettőt, akkor láthatjuk, hogy mind a kettő ugyanazt az eredményt adta vissza.
Pedig tisztán látható, hogy a második esetben csak egy paramétert adtam át a függvénynek és azt kellett kiértékelnie a zárójelezés miatt.
Ezt Haskell meg is tette, a köztes eredmény egy új függvény lesz, egészen pontosan a (\y -> 2 * 9 + 3 * y) függvény, amelyben az x helyére már be lett helyettesítve
a 9-es érték, és amely függvény már csak egy paramétert vár még. Ezt az úgy nevezett parciális applikálás/függvényalkalmazás teszi lehetővé.

-- Definíció:
-- Parciális applikálás/függvényalkalmazás: A függvénynek átadok legalább egy paramétert, de nem az összeset, így az alkalmazás eredménye egy másik függvény lesz.
-- Totális applikálás/függvényalkalmazás: A függvénynek átadjuk az összes szükséges paraméterét, hogy az eredménye egy konkrét érték legyen, amely nem függvény.

Ez nem egy beépített nyelvi jellemző, hanem matematikai következmény. A típusrendszer mondja meg, hogy pontosan mit csinálhatunk mivel.
Ez azt jelenti, hogy valahol a típusrendszerben meg kéne látszódnia, hogy ezt megtehetjük.
Hol látszódhat? Magának a függvénynek a típusában; azon belül? Mi az a szimbólum a típusban, amivel eddig keveset foglalkoztunk (és nem a =>)?
ghci-ben nézzük meg: :i ->
Mit látunk? A (->) pontosan ugyanolyan típuskonstruktor, mint az Either vagy a Maybe és még sok más. Emellett a nyílnak meg van adva a fixitása is,
amelyből megtudjuk, hogy a (->) infixen használva jobbra köt a lehető leggyengébben.

Ez azt jelenti, hogy ha leírom azt, hogy a -> b -> a vagy azt, hogy a -> (b -> a), ez a két típus teljesen ugyanazt jelenti.
Amely meg azt vonja maga után, hogy pl.
f :: a -> b -> a
f x y = x
és
g :: a -> (b -> a)
g x = \y -> x
teljesen ugyanazok, ahol az f függvényben felvettem mindkét paramétert, a g-ben pedig felvettem egyet és eredményként egy függvényt adok vissza, ahogy a típus leírja.
Továbbá:
h :: (a -> (b -> a))
h = \x -> \y -> x
szintén ugyanaz.

Ezt a folyamatot (f → g → h) szokás curry-zésnek nevezni.
Megjegyzés: Ugyan ez a curry-zés, de a tárgy keretében ha valamilyen számonkérés formájában megkérdezik, hogy "mi a curry-zés lényege?" vagy valami hasonló módon,
            ahol a curry-zésre kérdez rá a kérdés, akkor az a válasz, hogy "Minden függvény egyparaméteres" annak ellenére, hogy ez a curry-zésnek egy következménye.

Hogy tudjuk a parciális applikálást kihasználni?
Vegyük a korábbi példát.

l = map' (\x -> x + 1) [1,2,3]

Ez a felírás még mindig hosszúnak érződik.
Hol lehet rajta még rövidíteni?
A map' függvénynek az a neve, azzal nem lehet csinálni többet.
A lista az meg attól függ, hogy mi mit szeretnénk, azon se lehet igazán rövidíteni.
Akkor csak a lambdában lehet.
Láthatjuk, hogy a (+) első paramétere maga a függvény paramétere; a másik pedig egy 1-es érték.
Tehát lényegében csak egy olyan függvényt kell leírnunk, amelynek az eredménye egy olyan függvény, amely egy számhoz 1-et hozzáad.

Ezt parciális applikálással le tudjuk írni a (+) függvényt használva úgy, hogy (+ 1). (Mivel az összeadás kommutatív, az (1 +) is ugyanezt az eredményt éri el.)
Mi lesz a különbség a (+ 1) és a (+) 1 kifejezések között?

Így összességében a fenti felírást úgy tudjuk tovább rövidíteni, hogy:
l = map' (+ 1) [1,2,3]

Így már sokkal rövidebb, olvashatóbb, érthetőbb, hogy mit csinálunk a listával.
-}