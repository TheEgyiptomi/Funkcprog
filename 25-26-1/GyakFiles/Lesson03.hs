module Lesson03 where

fib :: Integer -> Integer
fib 1 = 1
fib 2 = 1
fib n = fib (n - 2) + fib (n - 1)


------------------------------------------------------------------


-- Definiáld az isOrigo függvényt, amely meghatározza egy 3 dimenziós Descartes-féle koordináta-rendszerben ábrázolt pontról, hogy az az origó-e.
isOrigo :: (Integer,Integer,Integer) -> Bool
isOrigo (0,0,0) = True
isOrigo _ = False

-- Definiáld az x0 függvényt, amely azt csinálja, hogy ha egy rendezett pár első komponense 0, akkor a másodikhoz hozzáad 1-et,
-- egyébként pedig kivon 1-et a második komponensből.

x0 :: (Integer,Integer) -> (Integer,Integer)
x0 (0, n) = (0, n+1)
x0 (x, n) = (x, n-1)

-- SZÉP KÓD: Amikor tehetjük, mindig használjunk mintaillesztést. Sokkal szebb és olvashatóbb. Ez később még inkább igaz lesz, amikor több eszközünk lesz.
--           (Karakterek és számok mintaillesztése macerás, ott nem igazán elvárt azon értékek mintaillesztése. Bármi más viszont jól illeszthető.)

{-
Korábban lehetett látni, hogy ezen típusokban ugyanúgy szerepelnek "a"-k és "b"-k:
(,) :: a -> b -> (a,b)
fst :: (a,b) -> a
snd :: (a,b) -> b

Ezek típusváltozók; arról lehet felismerni, hogy kisbetűvel van írva, nem naggyal.

Ez a típus így azt jelenti, hogy MINDEN "a" tetszőleges típusra és MINDEN "b" tetszőleges típusra működik a függvény.
Azonos kisbetű azonos típust jelöl. Különböző kisbetű nem feltétlenül jelent különböző típust egy ilyen függvény használatakor.
Pl.
f :: (Integer,Integer) -> Integer
f x = fst x
teljesen hibátlanul működik.

Ha *definiálunk* ilyen függvényt, akkor egy "a" típus teljesen más, mint egy "b" típus.
g :: (a,b) -> a
g (x,y) = y -- Fordítási hiba: Couldn't match expected type ‘a’ with actual type ‘b’

A típus azt mondja, hogy MINDEN ‘a,b’-re működnie kell a függvénynek.
Ha az első komponens egy karakter, a második komponens egy Bool, akkor eredményként karakter kéne, de mi Bool-t adnánk vissza,
nyilvánvalóan nem helyes működés.

-------

Ha belegondolunk, akkor pl. az fst függvény tetszőleges rendezett párral működik:

Mi lesz az alábbiak eredménye?
fst (1.2, True)
fst ('a',2)
fst (True,False)
fst (False,'g')

Megjegyzés: Természetesen a (,) és snd is tetszőleges típushelyes értékekkel működnek.

Megfigyelhető, hogy az fst függvény működése semmilyen módon nem függ attól, hogy milyen típusokat tartalmazó rendezett párt adunk át.
Ezt szokás parametrikus polimorfizmusnak nevezni.

Definíció:
-- Parametrikusan polimorf függvény: Olyan függvény, amely működése független a bemeneti paraméterek típusától.
⟶  Megállapítása a gyakorlatban: A függvény típusában nincs megkötés!

Láttuk az óra elején a konvertáló függvényeket:
fromIntegral :: (Integral a, Num b) => a -> b
realToFrac :: (Real a, Fractional b) => a -> b

Ezek nem működnek mindegyik típussal, illetve különböző típusok esetén mást kell csinálnia a függvénynek.
Pl. fromIntegral-lal lehet Integer-ről Integer-re alakítani, ekkor a függvénynek semmilyen teendője nincs.
    De lehet Integer-ről Double-re is alakítani, ekkor viszont a függvénynek át kell alakítania az egész számot egy lebegőpontos számra, meg kell változtatnia a reprezentációt.
Ezt a viselkedést szokás ad-hoc polimorfizmusnak nevezni.

Definíció:
-- Ad-hoc polimorf függvény: Olyan függvény, amely működése függ a bemeneti paraméterek típusától.
⟶  Megállapítása a gyakorlatban: A függvény típusában van megkötés!

Még több példa:
(+) :: Num a => a -> a -> a
Két Integer-t teljesen másképp kell összeadni, mint két Double-t. (Ez elsőre nem feltétlenül szembetűnő, numerikus módszerek órán fog kiderülni igazán, hogy így van.)

(==) :: Eq a => a -> a -> Bool
Két Integer-t másképp kell összehasonlítani, mint két Bool-t vagy két rendezett párt.

-- HELYES KÓD: Amikor polimorf függvényeket definiálunk, akkor figyeljünk arra, hogy a típus a lehető legáltalánosabb legyen.

               Paraméterek esetén olyan legyen a típus/típusmegkötés, amilyennel mi szeretnénk, hogy a függvény működjön.
               (pl. faktoriálisnak nincs értelme Num-nak lennie, törtszámokra nem igazán tud működni a függvény, jobb, ha a megkötés Integral, mert csak egész számokkal működik.)

               Eredmény esetén MINDIG a legáltalánosabb legyen az eredmény, ne kössük meg a felhasználó kezét teljesen feleslegesen!
               (pl. egy Fibonacci-sorozat soha nem fog törtszámot eredményül adni, ennek ellenére az eredmény Num legyen, a kiszámítása során mást úgyse használunk ki;
               továbbá lehet, hogy a felhasználó később Double-ként szeretné azt az értéket felhasználni.)
-}

-- Hány különböző féleképpen definiálható az alábbi függvény undefined nélkül? (Különböző viselkedések száma az érdekes)
id' :: Integer -> Integer
id' = undefined

-- Hány különböző féleképpen definiálható az alábbi függvény undefined nélkül?
-- Különböző típusú értékeket nem lehet mintailleszteni egy függvényben!
id'' :: a -> a
-- id'' 'a' = 'b'      |
-- id'' 0 = 1          |-> ILYET NEM LEHET!
-- id'' "asd" = "alma" |
id'' = undefined

-- Kicsit ellentmondásos lehet, de a tanulság az, hogy minél általánosabb egy függvény típusa, annál egyértelműbb definiálni (ha lehet).
