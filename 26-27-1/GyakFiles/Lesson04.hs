module Lesson04 where

-- FONTOS! Mivel Haskell-ben természetes dolog a végtelen lista, a feladatokat úgy kell megoldani, hogy azok végtelen listára is menjenek, ez az alapértelmezett elvárás.
--         A feladatban jelölve lesz, ha a listáról feltehető, hogy véges.

----------------------------------
-- Rekurzió
----------------------------------

{-
Bevezetés (from λ)
-}

-- Definiáljuk azt a rekurzív függvényt, amely egy paraméterül kapott nemnegatív egész értékig előállítja a számok összegét.

sumTo :: Integer -> Integer
sumTo 0 = 0
sumTo x = x + sumTo (x-1)

-- Definiáld a szorzás műveletét rekurzívan csupán az összeadás és a különbségképzés segítségével. Feltehetjük, hogy paraméterek nemnegatív egész értékek.

multiply :: Integer -> Integer -> Integer
multiply _ 0 = 0
multiply x y = x + multiply x (y - 1)

-- multiply 2 3 = 2 + multiply 2 (3 - 1)
-- multiply 2 3 = 2 + (2 + multiply 2 (2 - 1))
-- multiply 2 3 = 2 + (2 + (2 + multiply 2 (1 - 1)))
-- multiply 2 3 = 2 + (2 + (2 + 0))
-- multiply 2 3 = 2 + (2 + 2)
-- multiply 2 3 = 2 + 4
-- multiply 2 3 = 6
-- multiply x 0 = 0
-- multiply x y = x + multiply x (y-1)


--  Definiáljuk azt a rekurzív függvényt, amely a paraméterül kapott nemnegatív egész értékig megadja a számok négyzeteinek összegét. Azaz, az n ^ 2, (n - 1) ^ 2, …, 1 számok összegét. A számot megszorozhatjuk önmagával, de használhatjuk a hatványozás műveletét is (^).

sumSquaresTo :: Integer -> Integer
sumSquaresTo 0 = 0
sumSquaresTo x = x ^ 2 + sumSquaresTo (x - 1) 

-- Definiáljuk azt a rekurzív függvényt, ami egy n egész számnak megadja az i nemnegatív egész kitevős hatványát. A függvény első paramétere a hatványozandó szám, a második pedig a kitevő.
powerN :: Integer -> Integer -> Integer
powerN _ 0 = 1
powerN n i = n * powerN n (i - 1)

{-
Funkcionális programozásban nincsenek ciklusok, nincs for, nincs while, nincs foreach és más ezekhez hasonló konstrukció.
Az egyetlen egy dolog, amivel egy struktúrán (pl. listán) végig tudunk menni az nem más, mint a rekurzió.

Lássunk erre egy példát!
Hogyan tudjuk definiálni a korábbi add1 függvényt rekurzióval?
-}
add1' :: Num a => [a] -> [a]
-- Először végig kell gondolni, hogy mi lesz a függvény alapesete.
-- Jelen esetben ha nincs több elemünk, akkor egész egyértelmű, hogy mit kell csinálni. Ha nincs elem, akkor nincs elem.
add1' [] = []
-- Ez után szükséges végig gondolni, hogy mit kell akkor tenni, ha van elemem.
-- Minden elemhez hozzá kell adnom 1-et.
-- Ez azt jelenti, hogy először a lista eleméhez hozzáadok 1-et, majd utána a többihez is.
add1' (x:xs) = x + 1 : add1' xs
--             ^^^^^^^^^^^^^^^^
--             A listát, mint eredményt
--             fel kell építeni újra.

-- (:) előtt: hozzáadtunk az első elemhez egyet.
-- (:) után: A lista minden eleméhez hozzá kell adni egyet. Melyik függvény az, amelyik ezt tudja? Pont az, amelyiket éppen írjuk.

{-
Lássunk egy példát a működésre, hogy lépésenként mi történik:
add1' [1,5,9,0] ≡⟨ legalább egy elemű listám van, (x:xs) illeszkedik, x = 1, xs = [5,9,0] ⟩
1 + 1 : add1' [5,9,0] ≡⟨ legalább egy elemű listám van, (x:xs) illeszkedik, x = 5, xs = [9,0] ⟩
1 + 1 : (5 + 1 : add1' [9,0]) ≡⟨ legalább egy elemű listám van, (x:xs) illeszkedik, x = 9, xs = [0] ⟩
1 + 1 : (5 + 1 : (9 + 1 : add1' [0])) ≡⟨ legalább egy elemű listám van, (x:xs) illeszkedik, x = 0, xs = [] ⟩
1 + 1 : (5 + 1 : (9 + 1 : (0 + 1 : add1' []))) ≡⟨ üres a lista, [] ágon lévő eredmény kell ⟩
1 + 1 : (5 + 1 : (9 + 1 : (0 + 1 : []))) ≡
2 : (5 + 1 : (9 + 1 : (0 + 1 : []))) ≡
2 : (6 : (9 + 1 : (0 + 1 : []))) ≡
2 : (6 : (10 : (0 + 1 : []))) ≡
2 : (6 : (10 : (1 : []))) ≝ [2,6,10,1]
-}

{-
Definíció:
-- Rekurzív függvény: Olyan függvény, amely önmaga definiálásához saját magát használja fel.
-}

{-
Még egy példa, matematikában elcsépelt példa a rekurzióra: faktoriális
Pozitív egész számok szorzata n-ig
n! = n * (n - 1) * ... * 2 * 1
         ^^^^^^^^^^^^^^^^^^^^^
         Vegyük észre, hogy ez valójában (n - 1)!
-}

fact :: Integer -> Integer
-- Mi az alapeset? 0! = 1
fact 0 = 1
-- Nem 0 esetben a faktorálist rekurzívan számoljuk ki.
fact n = n * fact (n - 1)

-- Mi a probléma a fenti definícióval ebben a formában?

{-
Működés egy példán:
fact 5 ≡⟨ nem 0 ⟩
5 * fact (5 - 1) ≡
5 * fact 4 ≡⟨ nem 0 ⟩
5 * (4 * fact (4 - 1)) ≡
5 * (4 * fact 3) ≡⟨ nem 0 ⟩
5 * (4 * (3 * fact (3 - 1))) ≡
5 * (4 * (3 * fact 2)) ≡⟨ nem 0 ⟩
5 * (4 * (3 * (2 * fact (2 - 1)))) ≡
5 * (4 * (3 * (2 * fact 1))) ≡⟨ nem 0 ⟩
5 * (4 * (3 * (2 * (1 * fact (1 - 1))))) ≡
5 * (4 * (3 * (2 * (1 * fact 0)))) ≡⟨ most már 0 ⟩
5 * (4 * (3 * (2 * (1 * 1)))) ≡
5 * (4 * (3 * (2 * 1))) ≡
5 * (4 * (3 * 2)) ≡
5 * (4 * 6) ≡
5 * 24 ≡
120
-}

-- Feladatok:

-- Definiáld a sum' függvényt, amely összegzi egy számokat tartalmazó lista elemeit.
-- A listáról feltehető, hogy véges.
-- Mi lesz a legáltalánosabb típusa?
sum' :: Num a => [a] -> a 
sum' [] = 0
sum' (x : xs) = x + sum' xs
--    a   [a]
--        [] :: [a]

-- Definiáld a product' függvényt, amely összeszorozza egy számokat tartalmazó lista elemeit.
-- A listáról feltehető, hogy véges.
-- Mi lesz a legáltalánosabb típusa?
product' :: Num a => [a] -> a 
product' [] = 1
product' (x : xs) = x * product' xs
-- product (x : []) = x
--           [x]

-- Definiáld az elem' függvényt, amely megállapítja, hogy egy elem benne van-e egy listában.
-- A függvénynek működnie kell végtelen listán, de csak akkor, ha a keresett elem benne van a listában. (Mert csak akkor van értelme.)
-- Mi lesz a legáltalánosabb típusa?
elem' :: Eq a => [a] -> a -> Bool
elem' [] _ = False
elem' (x : xs) e = x == e || elem' xs e

-- SZÉP KÓD: Ha az eredmény egy Bool típusú érték, akkor felesleges bármilyen jellegű elágazást használni. A logikai műveletek elegek.

-- Definiáld a genericLength' függvényt, amely megadja, hogy egy lista hány elemű.
-- A listáról feltehető, hogy véges.
-- Mi lesz a lehető legáltalánosabb típusa?
genericLength' :: [a] -> Integer
genericLength' [] = 0
genericLength' (x : xs) = 1 + genericLength' xs 
-- Az eredeti függvény a Data.List modulban érhető el.

-- HELYES KÓD: Nem érdemes a sima length függvényt használni, mert az csak Int-et ad vissza, amelyről megtanultuk,
--             véges méretű, értékei -2⁶³ ─ 2⁶³-1 között vannak.

-- Példa feladat, ahol el tudja rontani a rossz függvény használata a megoldást:
-- Definiáljuk egy másik módon a faktoriális függvényt:
-- Segítség: a faktoriális csak 1-től n-ig a szorzata a számoknak. Hogy tudunk 1-től n-ig számokat generálni?
--           Melyik függvényt tudjuk felhasználni utána?
factorial :: Integral a => a -> a
factorial n = product' [1..n]

-- Definiáld a replicateFact függvényt, amely egy adott lista elemszámának faktoriálisaszor ismétel meg egy adott elemet.
-- replicateFact [1,2] 'a' == "aa" -- 2! = 2
-- replicateFact [] 'a' == "a"  -- 0! = 1
-- replicateFact "abc" 'b' == "bbbbbb" -- 3! = 6
-- replicateFact "abcd" 'c' == "cccccccccccccccccccccccc" -- 4! = 24
-- Csak meglévő függvényekkel definiáljuk rekurzió nélkül, de rosszul.
-- Használjuk a replicate, factorial, length függvényeket!
replicateFact :: [a] -> b -> [b]
replicateFact i e = replicate (factorial (length i)) e
-- length :: [a] -> Int

replicate' :: Integral b => b -> a -> [a]
replicate' 0 _ = []
replicate' n x = x : replicate' (n - 1) x

-- Próbáljuk ki:
-- replicateFact [1..21] 'a'
-- Mi lesz az eredmény?
-- A 21! egy nulla vagy attól kisebb szám?

-- A probléma ott van, hogy az Int korlátos, a length pedig csak Int-et ad vissza. Mivel 21! > 2⁶³-1,
-- ezért túlcsordulás történik, ami azt jelenti, hogy negatív lesz az eredmény.
-- Ezt ki is lehet próbálni: (maxBound :: Int) + 1 eredménye egy negatív szám lesz. (maxBound :: Int) == 2⁶³-1

-- Próbáljuk meg jobban definiálni, mi van akkor, ha átalakítjuk az Int-et Integer-ré az ismert fromIntegral függvénnyel?
-- A replicate függvényt cseréljük le a fenti rep függvényre, ugyanazt csinálja, csak az Integer-rel működik.
replicateFact' :: [a] -> b -> [b]
replicateFact' i e = replicate (factorial (fromIntegral (length i))) e

-- Próbáljuk ki:
-- replicateFact [1..21] 'a'
-- Mi lesz az eredmény?
-- Ha sok 'a', akkor már közelebb járunk a jó megoldáshoz*, de nem lesz úgy jó soha.
-- Ha még mindig üres lista, akkor a factorial függvényen kívülre került a fromIntegral, és továbbra is látni,
-- hogy nem igazán segít az átalakítás.
-- Maga a számolás ténye Int-ként történik meg és az az, ami elrontja az egészet.

-- *Ha van sok 'a', akkor egy 2⁶³ elemű listával lehet elrontani a length függvényt, hiszen túlcsordulás miatt a length eredménye egy negatív szám lesz.
--  Ennek az eredményét ne várjuk meg, mert valahol több ezer év lesz, mire visszaadja az üres listát arra.

{-
Tanulság: NE HASZNÁLJUNK olyan függvényeket, amik közvetlen csak Int-tel dolgoznak.
          Használjuk ezeknek megfelelő generic párjait:

Int-es fgv    │    length     │    replicate     │    take     │    drop     │     (!!)     │    splitAt      ⟵ Ezek használatát kerüljük
──────────────┼───────────────┼──────────────────┼─────────────┼─────────────┼──────────────┼───────────────
generic párja │ genericLength │ genericReplicate │ genericTake │ genericDrop │ genericIndex │ genericSplitAt  ⟵ Ezeket használjuk helyettük

Az összes ilyen függvény a Data.List modulban található!
-}

-- Feladatok:
-- Definiáld a (+++) függvényt, amely két listát összefűz!
(+++) :: [a] -> [a] -> [a]
[] +++ ys = ys
xs +++ [] = xs
(x:xs) +++ ys = x : xs +++ ys 
--              x : (xs +++ ys )
infixr 5 +++
-- Megj.: Az eredeti függvény neve (++).

-- Definiáld ismert concat' függvényt rekurzívan!
concat' :: [[a]] -> [a]
concat' [] = []
concat' (x : xs) = x ++ concat' xs
--      [a] [[a]]

-- Definiáld a slowReverse függvényt, amely egy lista elemeinek sorrendjét megfordítja egy naív módon.
-- A listáról feltehető, hogy véges.
slowReverse :: [a] -> [a]
slowReverse [] = []
slowReverse (x : xs) = slowReverse xs ++ (x : [])
--                                         [x]

{-
Nem mindegyik rekurzió alapesete ugyanaz.
Nem mindig az üres lista az alapeset.
Nem mindig van alapeset. (Legsűrűbb esetben van.)
A rekurzió lépése lehet sokkal érdekesebb is annál, mint hogy egy listaelemet elhagyunk.
Nyilván nem csak listán lehet rekurziót használni, de a félévben azzal fogunk a legtöbbet foglalkozni.
-}

-- Feladatok:
-- Definiáld a repeat' függvényt, amely egy adott elemet a végtelenségig ismétel.
repeat' :: a -> [a]
repeat' a = a : repeat' a 

-- Definiáld a last' függvényt, amely visszaadja egy lista utolsó elemét.
-- A listáról feltehető, hogy véges.
last' :: [a] -> a
last' [a] = a
last' (a : as) = last' as

-- Definiáld az init' függvényt, amely kitörli egy lista utolsó elemét; az elejét tartja meg.
init' :: [a] -> [a]
init' [a] = []
init' (a : as) = a : init' as
