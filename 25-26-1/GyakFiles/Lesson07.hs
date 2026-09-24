module Lesson07 where

-- Definiáld a nub' függvényt, amely egy lista ismétlődő elemeit törli megtartva csak az elsőket.
-- nub' [1,2,1,3,5,3,2,2,3,3,1,1,2,4,4] == [1,2,3,5,4]
-- nub' [2,1,2,2] == [2,1]
-- nub' [1,2,2,2] == [1,2]

filter' :: Eq a => a -> [a] -> [a]
filter' e xs = [x | x <- xs, x /= e]

nub' :: Eq a => [a] -> [a]
nub' [] = []
nub' (x:xs) = x : nub' (filter' x xs)

----------------
-- Számozás
----------------

{-
Sűrűn találkozni olyannal, hogy a "valahányadik elemmel" kell valamit csinálni.
Esetleg olyannal, hogy "minden párosadik elemmel" vagy hasonló.
Ugyan egyszerű esetek átfogalmazhatók csak mintaillesztésre (pl. minden párosadik elem esetén csak kettesével kell lépkedni a listán),
bonyolultabb esetek esetleg "trükközést" igényelhetnek. Trükközés helyett egy általános módszer megszámozni az egyes szavakat, majd
az adott feladatnak megfelelően fel lehet használni a számokat, számozott szavakat.
-}

-- Feladat:
-- Számozzuk meg egy szövegnek az egyes szavait 1-től kezdve. Az eredmény legyen egy rendezett párokból álló lista, az első komponens a szó száma, a második maga a szó.
numberWords :: Integral i => String -> [(String, i)]
--numberWords [] = []
numberWords ls = numWordsHelper (words ls) 1

numWordsHelper :: Integral i => [String] -> i -> [(String, i)]
numWordsHelper [] _ = []
numWordsHelper (w : ws) i = (w, i) : numWordsHelper ws (i + 1)


---------------------------------------
-- Elágazások
---------------------------------------

h :: Int -> [Int]
h x = hH (x > 0) x

hH :: Bool -> Int -> [Int] 
hH True x = [x]
hH _ _ = []

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
-- f [2,4,6,11] == ?
-- f [2,4,6,-8] == ?
-- f [2,4,6,8] == ?
-- f [1,2,4,6,11] == ?
-- f [1,2,3,4] == ?
-- f [-3,-2,9] == ?
-- f [0,11] == ?
-- f [0,11,15,-2] == ?
-- f [2] == ?
-- f [0] == ?

-- Ezen f függvény parciális vagy totális?

-- Feladatok:
-- Definiáld a take' függvényt, amely adott darabszámú elemet megtart egy lista elejéről.
-- Ha több elemet kéne megtartani, mint amennyi van, akkor tartsuk meg az összeset.
-- Ha a szám negatív, kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
take' :: Integral i => i -> [a] -> [a]
take' _ [] = []
take' n (x:xs) 
  | n <= 0 = []
  | otherwise = x : take' (n-1) xs
{-
take' n (x:xs) | n <= 0 = []
take' n (x:xs) | otherwise = x : take' (n-1) xs
-}
-- Az eredeti függvény a genericTake.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

{-
SZÉP KÓD: Ha egy mintaillesztésen belül csak egy feltétel van, egy ág van,
          akkor azt egy sorba szokás írni a mintával. Ellenkező esetben új sorban szokás kezdeni az elágazást.
          Új sorban kezdeni azonban sosem probléma, létezik az a stílus is.
-}

-- Definiáld a drop' függvényt, amely adott darabszámú elemet eldob egy lista elejéről.
-- Ha több elemet kéne eldobni, mint amennyi van, akkor dobjuk el az összeset.
-- Ha a szám negatív, kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
drop' :: Integral i => i -> [a] -> [a]
drop' _ [] = []
drop' n ys@(_:xs)
  | n <= 0 = ys
  | otherwise = drop' (n-1) xs


-- Ilyet ne!!
{-
longerThan n xs = n < 0 
-}

-- Az eredeti függvény a genericDrop.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

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
splitAt' :: Integral i => i -> [a] -> ([a], [a])
splitAt' _ [] = ([], []) 
splitAt' n ys@(x:xs)
 | n <= 0 = ([], ys)
 | otherwise = (x : fst (splitAt' (n - 1) xs) , snd (splitAt' (n-1) xs))

-- Az eredeti függvény a genericSplitAt.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

-- Definiáld az insertAt függvényt, amely egy adott pozícióra beszúr egy elemet egy listába.
-- Ha az index negatív, akkor kezeljük úgy, mintha 0 lenne.
-- Ha az index nagyobb, mint ahány elemű a lista, akkor az utolsó helyre szúrjuk be az elemet.
-- insertAt (-2) 'a' "lma" == "alma"
-- insertAt 0 'a' "lma" == "alma"
-- insertAt 2 'b' "lma" == "lmba"
-- insertAt 10 'b' "lma" == "lmab"
insertAt :: Integral i => i -> a -> [a] -> [a]
insertAt _ a [] = [a]
insertAt n a (x:xs)
  | n <= 0 = a : x : xs
  | otherwise = x : insertAt (n - 1) a xs
-- Megj.: Nincs insertAt függvény a Data.List-ben, ezért nincs is aposztróffal ellátva a neve.

-- Definiáld a replicate' függvényt, amely adott darabszámú azonos elemet generál.
-- Ha a szám negatív, azt kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
replicate' :: Integral i => i -> a -> [a]
replicate' n x 
  | n <= 0 = []
  | otherwise = x : replicate' (n-1) x
-- Az eredeti függvény a genericReplicate.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

