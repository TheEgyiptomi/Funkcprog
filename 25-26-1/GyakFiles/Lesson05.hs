module Lesson05 where

import Data.Char

----------------------------------------
-- Lista .. kifejezések (range)
----------------------------------------

-- [1..10] == [1,2,3,4,5,6,7,8,9,10], +1-esével lépked a megadott értékig (inklúzív)
-- [1,3..10] == [1,3,5,7,9], a második és első elem közti különbséggel lépked a megadott értékig. (Ebben a példában ez most +2.)
-- [1..] : 1-től +1-esével lépkedve végtelen lista
-- [2,4..] : 2-től +2-esével lépkedve végtelen lista

-- Nézzük meg, mi történik, ha [10..1]-et próbáljuk kiértékelni. Mi lesz az eredmény?
-- Hogyan tudjuk megoldani, hogy "elvárt" eredményt kapjuk?

-- Megjegyzés: Törtekkel nem igazán érdemes ezt használni, mert nagyon mókás eredményt tudnak produkálni.
-- Pl. [0,0.5..2.75] == [0.0,0.5,1.0,1.5,2.0,2.5,3.0]
--                                               ^^^ ez már a range-en kívül van.

-- Ez működik minden olyan típussal, aminek van Enum példánya, pl. Bool, Char is megy.
-- ['a'..'e'] == "abcde"

-- Ellenőrző/Gondolkodós kérdések:
-- Mik lesznek a következő range-eknek az értékei?t
-- E: [(-3)..2] == ?
-- E: [5,10..30] == ?
-- E: [0..(-2)] == ?
-- E: ['b','e'..'p'] == ?

-- G: [0,0..] == ?
-- G: ([1..] :: [Int]) == ?
-- G: [False..] == ?


-- FONTOS! Mivel Haskell-ben természetes dolog a végtelen lista, a feladatokat úgy kell megoldani, hogy azok végtelen listára is menjenek, ez az alapértelmezett elvárás.
--         A feladatban jelölve lesz, ha a listáról feltehető, hogy véges.

----------------------------------------
-- Listagenerátor (List comprehension)
----------------------------------------

-- Lényegében a matematikából ismert halmazkifejezést szeretné utánozni.
-- {x^2 | x ∈ {0,1,2,3,4,5} } == {0,1,4,9,16,25}
-- Ezt Haskell-re egészen egyszerű átfordítani.
squares :: [Integer]
squares = [x^2 | x <- [0..5]]
--         ^^^   ^^^^^^^^^^^
-- Mit csinálunk | Végig megyünk a <- jobb oldalán lévő listán
-- az értékkel   | minden egyes értéken egyenként sorban.
-- egyenként     |

-- Mi a helyzet, ha csak bizonyos elemek kellenek?
-- {x | x ∈ {0,1,2,3}, x páros}
-- Az átfordítás szintén hasonló.
evens :: Integral a => [a] -> [a]
evens xs = [x | x <- xs, even x]
-- A generátorokat, feltételeket egymástól vesszővel választjuk el.
-- Feltételek között a vesszővel való elválasztás logikai ést jelent,
-- tehát minden egyes feltételnek meg kell felelnie egy értéknek, hogy benne legyen az eredményben.
-- Pl. 10-nél kisebb nemnegatív párosok kellenek:
smallEvens :: Integral a => [a]
smallEvens = [x | x <- [0..20], even x, x < 10]
-- Ez természetesen úgy is megoldható, hogy [0,2..8], a bemutatás kedvéért lett megadva a fenti módon.

-- Arra azonban figyelni kell, hogy egy változó csak a generátor után látható a | jobb oldalán
-- pl. az alábbi nem helyes:
-- [x | even x, x <- xs] -- Not in scope 'x`

{-
Természetesen több feltétel és több generátor is megadható, ugyanúgy vesszővel elválasztva.
Nézzük meg, hogy mi lesz az eredménye a [(x,y) | x <- ['a'..'c'], y <- [False,True]] kifejezésnek.

A generátorok mindig balról jobbra sorrendben lépkednek, ez az előző kifejezésből is látszódik.
[(x,y) | x <- ['a'..'c'], y <- [False,True]] == [('a',False),('a',True),('b',False),('b',True),('c',False),('c',True)]
-}

-- Feladatok:

-- Definiáld az add1 függvényt, amely egy lista minden számához hozzáad 1-et.
add1 :: Num a => [a] -> [a]
add1 ls = [l + 1 | l <- ls]

-- Definiáld a rep függvényt, amely egy adott elemszámú azonos elemekből álló listát készít.
rep :: Integer -> a -> [a]
rep n y = [y | _ <- [1..n]] 
-- Az eredeti függvénye a replicate, azonban az historical reasons miatt csak Int-tel működik, nem jó ötlet használni.

-- Definiáld az onlyUpper függvényt, amely egy szövegből csak a nagybetűket tartja meg.
-- Segítség: ÚJ DOLOG kell! Az isUpper függvény egy karakterről megállapítja, hogy nagybetű-e. Ez a függvény azonban a Data.Char nevű modulban található.
-- Importálni csomagokat az "import <csomag>" módon lehet a MODULDEKLARÁCIÓ UTÁN KÖZVETLEN
-- -- Ezen modulban a "module Lesson03 where" után kell rakni az első függvénydefiníció előtt.
onlyUpper :: String -> [Char]
onlyUpper ls = [x | x <- ls, isUpper x]

-- Nehezebb: Definiáld a concat' függvényt, amely egy listák listáját összefűzi egybe.
concat' :: [[a]] -> [a]
concat' lss = [l | ls <- lss, l <- ls]

{-
A listagenerátorban tudunk ugyanúgy mintailleszteni a <- bal oldalán.
Csak azon elemeket fogja megtartani, amelyekre teljesül az illesztés, a többit eldobja.
-}

-- Definiáld az onlyAs függvényt, amely egy szöveg szavai közül az "a" szavakat tartja meg!
-- Segítség: Ha feltételezzük, hogy a függvények nevei angolul értelmesek, akkor mi lehet azon függvény neve, amely egy szöveget a SZAVAIra felbontja?
onlyAs :: String -> [String]
onlyAs ls = [z | z <- words ls, z == "a"]

-- Definiáld a firstIsA függvényt, amely megtartja az összes olyan String-et a listából, amelyek az 'a' karakterrel kezdődnek.
firstIsA :: [String] -> [String]
firstIsA ls = [s | s@('a':_) <- ls]
--firstIsA ls = [s | s <- ls, head s == 'a']

-- Definiáld az initials függvényt, amely egy név kezdőbetűit adja vissza.
initials :: String -> String
initials ls = [n | (n:_) <- words ls] 

-- SZÉP KÓD: Indexelés Haskell-ben sok más nyelvvel ellentétben nem azonnali, hanem lineáris idejű,
--           tehát ha pl. egy lista 10. eleme kell, akkor mind a 10 elemen végig kell menni.
--           Ebből következően listagenerátorban az indexeket SOHA SE generáljuk, mert négyzetes viselkedést kapunk,
--           tehát a 10. elemet 100 lépésben kapjuk meg 10 helyett, ez 90-nel több, mint kéne.

-- SZÉP KÓD: Ahogy a korábbiakban látható volt, a függvények elnevezései a camelCase stílust követik,
--           amely azt jelenti, hogy ha egy függvény több szóból állnak, akkor a szavak határánál
--           a következő szót nagybetűvel kezdjük.

-- snake_case, hyphen-case használata nem szokványos ebben a nyelvben.
