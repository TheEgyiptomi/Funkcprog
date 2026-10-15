module Lesson06 where

-- Definiáld az intersperse' függvényt, amely egy adott elemet beszúr minden elem közé.
-- intersperse' 0 [1,2,3] == [1,0,2,0,3]
-- intersperse' 'a' [] == []
-- intersperse' 'a' "b" == "b"
-- intersperse' 'a' "bb" == "bab"
-- intersperse' True [False,False,False,True] == [False,True,False,True,False,True,True]

-- Segítség: a where vagy let-in itt arra fog kelleni, hogy jól tudjuk az elemet beszúrni az elemek közé.
--           Ez azt jelenti, hogy fel kell ismerni, hogy a függvény működése két állapotból áll.
--           (Vagy egy lépésből átmegyünk a másikba és a végéig rekurzív; vagy az elején rekurzív, kivéve a legutolsó lépést.)
intersperse' :: a -> [a] -> [a]
intersperse' _ [] = []
intersperse' _ [x] =  [x]
intersperse' a (x:y:ys) = x : a : intersperse' a (y:ys)

-- Definiáld a showList' függvényt, amely egy listát szépen megjelenít; lényegében ahogy ki kéne írnia a ghci-be.
-- showList' [1,2,3] == "[1,2,3]"
-- showList' [] == "[]"
-- showList' [True] == "[True]"

-- Segítség: A where/let-in itt arra kell, hogy két alapesetet különböztessünk meg, lényegében hasonló az intersperse-hez.
showList' :: Show a => [a] -> String
showList' [] = "[]"
showList' ls = '[' : sLH ls
    where
        --sLH :: Show a => [a] -> String
        sLH [x] = show x ++ "]"
        sLH (l:ls) = show l ++ "," ++ sLH ls

-- Definiáld az unzip' függvényt, amely egy párok listáját szétszed listák párjává úgy,
-- hogy a rendezett párok első fele az eredmény pár első listája lesz, a rendezett párok második fele
-- az eredmény pár második listája lesz.
-- unzip' [(0,'0'),(1,'1'),(2,'2')] == ([0,1,2],"012")
-- unzip' [] == ([],[])
-- unzip' [(3,0),(4,1),(0,2),(9,9),(8,10)] == ([3,4,0,9,8],[0,1,2,9,10])

-- Segítség: Most a where/let-in mintaillesztésre fog kelleni.
unzip' :: [(a, b)] -> ([a], [b])
unzip' [] = ([], [])
unzip' ((a, b) : ls) = let (as, bs) = unzip' ls in (a:as, b:bs) 
--      (a,b)  [(a,b)]     ([a], [b]) 
---------------------------------------
-- Elágazások
---------------------------------------

{-
Az elágazás a programozás egyik hasznos eszköze, ha valamitől függ, hogy mit szeretnénk, hogy a kód csináljon.

Haskell-ben az elágazás szintaxisa hasonlít a matematikában használatosra.
Matek:
       { x * 2,     ha x páratlan és x ≥ 10
f(x) = { x * 3 + 1, ha x < 10
       { x * 5,     egyébként
       ^
 Nagy kapcsos szeretne lenni.

Haskell-ben a szintaxis úgy néz ki, hogy a nagy kapcsos zárójelet lecseréljük a 'pipe' (|, AltGr+w) karakterre.
FONTOS! Az ágakat szóközzel bentebb húzva kell kezdeni, itt is játszik a margószabály.
Továbbá a matematikához képesti különbség, hogy először van az elágazás, a feltételek, utána jön csak az egyenlőségjel és hogy mit adjunk vissza eredményként.
Az elágazások feltételei Bool típusú kifejezéseket fogadnak el. Az elágazások vizsgálata szintén fentről lefelé történik, mint ahogy a mintaillesztés is.
Az első olyan ág fog lefutni, ahol a feltétel True-ra értékelődik ki. Ugyanúgy, ahogy a mintaillesztésnél is, ha nincs olyan feltétel, ami True-ra értékelődne ki,
akkor egy Non-exhaustive pattern kivétellel elszáll a program futás időben. A kettő együtt kombinálható, ld. lentebbi feladat (f függvény).

Lássuk az alábbi példát, javítsuk ki a korábban látott faktoriális függvényt legalább annyira, hogy totális függvény legyen.
-}

fact :: Integer -> Integer
fact n
  -- Ha n ≤ 0, akkor az eredmény legyen 1; 0! = 1, a többi negatív szám meg nem izgat minket, most az összes negatívra 1 az eredmény.
  | n <= 0    = 1
  -- Egyébként n! = n * (n - 1)!
  | otherwise = n * fact (n - 1)

{-
Megjelenik a definícióban egy új dolog, az otherwise.
Az otherwise nem kulcsszó; pontosan ugyanolyan függvény, mint a többi.

otherwise :: Bool
otherwise = True
-}

{-
SZÉP KÓD: Néhányan már felfedezhették, hogy Haskell-ben van if-then-else konstrukció. Ezt a tárgy keretein belül SZIGORÚAN TILOS használni.
          Szokjuk meg a rendes elágazást. Ha valaki háziban használja, annak el lesz utasítva a megoldása kérdés nélkül.

SZÉP KÓD: Ugyan az otherwise-ot magát lehetne helyettesíteni a True-val, olvashatóság miatt azonban használjuk az otherwise-ot.

SZÉP KÓD: Elágazás feltételben == True-t és == False-ot SZIGORÚAN TILOS HASZNÁLNI! Eleve egy Bool kifejezés van ott, ha az == True vagy == False kéne.

SZÉP KÓD: Ha egy függvény eredménye Bool típusú érték lenne (pl. elem függvény), akkor elágazást felesleges és TILOS használni! Ott vannak a logikai műveletek,
          tessék azokat használni.
-}

-- Adott az alábbi függvény:
f :: [Integer] -> Integer
f [2,4,6,x]
    | x > 10 = 0
    | x < 0  = 1
f [x,y]
    | x + y > 10 = x * y
    | x - y < 10 = 2
f (x:xs)
    | x > 0 || x < 0 = f xs
f [] = -100
-- GHCi-ben való futtatás nélkül az alábbi kifejezéseknek mi lesz az eredményük?
-- f [2,4,6,11] == 0
-- f [2,4,6,-8] == 1
-- f [2,4,6,8] == 48
-- f [1,2,4,6,11] == 0
-- f [1,2,3,4] == 2
-- f [-3,-2,9] == 2
-- f [0,11] == 0
-- f [0,11,15,-2] == Exception, non exhaustive pattern
-- f [2] == -100
-- f [0] == Exception, non exhaustive pattern

-- Ezen f függvény parciális vagy totális?

-- Feladatok:
-- Definiáld a take' függvényt, amely adott darabszámú elemet megtart egy lista elejéről.
-- Ha több elemet kéne megtartani, mint amennyi van, akkor tartsuk meg az összeset.
-- Ha a szám negatív, kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
take' :: Integral b => b -> [a] -> [a] 
take' n [] = []
take' n (l:ls)
    | n <= 0 = []
    | otherwise = l : take' (n - 1) ls

{-
SZÉP KÓD: Ha egy mintaillesztésen belül csak egy feltétel van, egy ág van,
          akkor azt egy sorba szokás írni a mintával. Ellenkező esetben új sorban szokás kezdeni az elágazást.
          Új sorban kezdeni azonban sosem probléma, létezik az a stílus is.
-}

-- Definiáld a drop' függvényt, amely adott darabszámú elemet eldob egy lista elejéről.
-- Ha több elemet kéne eldobni, mint amennyi van, akkor dobjuk el az összeset.
-- Ha a szám negatív, kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
drop' :: Integral b => b -> [a] -> [a]
drop' n [] = []
drop' n (l:ls) 
    | n <= 0 = l:ls
    | otherwise = drop' (n-1) ls

-- Definiáld a splitAt' függvényt, amely egy adott pozíción kettéválaszt egy listát.
-- Az eredmény egy rendezett pár lesz, az első komponense annyi elemű lista, amennyi a szám volt,
-- a második komponens pedig a fennmaradó lista.
-- Ha a pozíció negatív, akkor a lista előtt akarnánk bontani, tehát előtte üres lista van, utána meg az egész lista.
-- Ha a pozíció nagyobb, mint ahány elemünk van, akkor utána akarnánk bontani, tehát előtte van a teljes lista, utána meg semmi.
-- Mi lesz a függvény legáltalánosabb típusa?
-- splitAt' 0 [1,2,3] == ([],[1,2,3])
-- splitAt' 1 [1,2,3] == ([1],[2,3])
-- splitAt' 2 [1,2,3] == ([1,2],[3])
-- splitAt' 3 [1,2,3] == ([1,2,3],[])
splitAt' :: Integral b => b -> [a] -> ([a], [a])
splitAt' n xs = (take' n xs, drop' n xs) 

-- Definiáld az insertAt függvényt, amely egy adott pozícióra beszúr egy elemet egy listába.
-- Ha az index negatív, akkor kezeljük úgy, mintha 0 lenne.
-- Ha az index nagyobb, mint ahány elemű a lista, akkor az utolsó helyre szúrjuk be az elemet.
-- insertAt (-2) 'a' "lma" == "alma"
-- insertAt 0 'a' "lma" == "alma"
-- insertAt 2 'b' "lma" == "lmba"
-- insertAt 10 'b' "lma" == "lmab"
insertAt :: Integral b => b -> a -> [a] -> [a]
insertAt _ a [] = [a]
insertAt n a (l:ls) 
    | n <= 0 = a : l : ls
    | otherwise = l : insertAt (n - 1) a ls 
insertAt n a ls = let (es, ms) = splitAt' n ls in es ++ a : ms
--                                               [a]   a   [a]
-- Megj.: Nincs insertAt függvény a Data.List-ben, ezért nincs is aposztróffal ellátva a neve.

-- Definiáld a replicate' függvényt, amely adott darabszámú azonos elemet generál.
-- Ha a szám negatív, azt kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
replicate' :: Integral b => b -> a -> [a]
replicate' b a
    | b <= 0 = []
    | otherwise = a : replicate' (b - 1) a
-- Az eredeti függvény a genericReplicate.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

-------------------------
-- Típusszinonimák
-------------------------

{-
Az első, amivel említés szintjén találkoztunk az az, hogy tudjuk, hogy Haskellben a String nem más, mint [Char].

Típusszinonimák szintaxisa az alábbiként néz ki Haskellben:

type <Típusnév> [típusparaméterek...] = <Létező típus>

pl. a String-et, ahogy korábban is láttuk, az alábbi módon lehet definiálni:
type String = [Char]

A típusszinonimák semmiben sem különböznek azon típusoktól, amelyekre a szinonima definiálva lett,
teljesen szabadon felcserélhetőek.
-}

-- Feladatok:
-- Definiáld a Point típusszinonimát, amely jelöljön egy Integer-ekből álló rendezett párt.

type Point = (Integer, Integer)

-- Definiáld a moveX függvényt, amely egy pontot az X-tengely mentén eltol egy adott értékkel.
-- Használjuk az előbb definiált Point típust.
moveX :: Integer -> Point -> Point
moveX xV (x, y) = (x + xV, y)

{-
Mire is jó a típusszinonima, ha teljesen ugyanúgy viselkedik, mint az eredeti típus, amire a szinonimát készítettük?
Nézzük az alábbi példát:
-}
person :: (String,String,String,String,Int)
{-
Mi szeretne lenni az a sok String? Mint programozók, egy-két ötletünk lehet, pl. illető neve, lakcím, telefonszám, ímélcím, stb.
Az Int-ről ki tudjuk találni, hogy az az illető életkora lesz.
Ember legyen a talpán, aki ennyiből megmondja, hogy most melyik String mit jelöl.
A félév elején arról volt szó, hogy Haskellben a típus beszél, nem a változók nevei. A változók itt ráadásul nehezen beszélnének, hiszen egy konstans értéket
reprezentál a típus.

Persze, hogy ha ezen komment alá tekintünk, kiderül, hogy melyik adat mi szeretne lenni.
Nagy általánosságban azonban csak a függvény típusához lesz hozzáférésünk, nem a definícióhoz.
-}
person = ("Én","Alma utca 10","06-20-nemmondommeg","alma@alma.hu",20)

-- Tegyük egy kicsit beszédesebbé a típusát a person-nek, hogy tudjuk, hogy melyik adat mi szeretne lenni!

type Name = String
type Address = String
type Mobile = String
type Email = String
type Age = Int

type Person = (Name, Address, Mobile, Email, Age)

person2 :: (Name, Address, Mobile, Email, Age)
person2 = person

person3 :: Person
person3 = person2

-- SZÉP KÓD: Erre való a típusszinonima, hogy a kódunkat olvashatóbbá, informatívabbá tegyük.
--           Használjuk nyugodtan, semmilyen lassulással nem jár a program szempontjából, viszont sokkal jobb annak,
--           aki olvassa a kódot (persze ha jók és beszédesek a nevek).

{-
Természetesen a veszélye is megvan ennek. Mivel a típusszinonimák szabadon felcserélhetőek, simán el lehet végezni olyan műveleteket rajtuk,
amelyeknek esetleg logikailag semmi közük egymáshoz.
-}
type Age' = Int -- fentebb kéne legyen definiálva
type Euro = Int

eztNemKéne :: Euro -> Age' -> Int
eztNemKéne e a = e + a

-- Semmi hiba nincs a fenti kódban, pedig jó lenne, ha lenne, mert egy eurónak egy életkorhoz sok köze nincs.
-- Hogy mit lehet ezzel csinálni, az a következő órán kiderül.
