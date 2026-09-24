module Lesson05 where

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
-- Mik lesznek a következő range-eknek az értékei?
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
add1 = undefined

-- Definiáld a rep függvényt, amely egy adott elemszámú azonos elemekből álló listát készít.
rep :: Integer -> a -> [a]
rep = undefined
-- Az eredeti függvénye a replicate, azonban az historical reasons miatt csak Int-tel működik, nem jó ötlet használni.

-- Definiáld az onlyUpper függvényt, amely egy szövegből csak a nagybetűket tartja meg.
-- Segítség: ÚJ DOLOG kell! Az isUpper függvény egy karakterről megállapítja, hogy nagybetű-e. Ez a függvény azonban a Data.Char nevű modulban található.
-- Importálni csomagokat az "import <csomag>" módon lehet a MODULDEKLARÁCIÓ UTÁN KÖZVETLEN
-- -- Ezen modulban a "module Lesson03 where" után kell rakni az első függvénydefiníció előtt.
onlyUpper :: String -> [Char]
onlyUpper = undefined

-- Nehezebb: Definiáld a concat' függvényt, amely egy listák listáját összefűzi egybe.
concat' :: [[a]] -> [a]
concat' = undefined

{-
A listagenerátorban tudunk ugyanúgy mintailleszteni a <- bal oldalán.
Csak azon elemeket fogja megtartani, amelyekre teljesül az illesztés, a többit eldobja.
-}

-- Definiáld az onlyAs függvényt, amely egy szöveg szavai közül az "a" szavakat tartja meg!
-- Segítség: Ha feltételezzük, hogy a függvények nevei angolul értelmesek, akkor mi lehet azon függvény neve, amely egy szöveget a SZAVAIra felbontja?
onlyAs :: String -> [String]
onlyAs = undefined

-- Definiáld a firstIsA függvényt, amely megtartja az összes olyan String-et a listából, amelyek az 'a' karakterrel kezdődnek.
firstIsA :: [String] -> [String]
firstIsA = undefined

-- Definiáld az initials függvényt, amely egy név kezdőbetűit adja vissza.
initials :: String -> String
initials = undefined

-- SZÉP KÓD: Indexelés Haskell-ben sok más nyelvvel ellentétben nem azonnali, hanem lineáris idejű,
--           tehát ha pl. egy lista 10. eleme kell, akkor mind a 10 elemen végig kell menni.
--           Ebből következően listagenerátorban az indexeket SOHA SE generáljuk, mert négyzetes viselkedést kapunk,
--           tehát a 10. elemet 100 lépésben kapjuk meg 10 helyett, ez 90-nel több, mint kéne.

-- SZÉP KÓD: Ahogy a korábbiakban látható volt, a függvények elnevezései a camelCase stílust követik,
--           amely azt jelenti, hogy ha egy függvény több szóból állnak, akkor a szavak határánál
--           a következő szót nagybetűvel kezdjük.

-- snake_case, hyphen-case használata nem szokványos ebben a nyelvben.

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
take' :: undefined
take' = undefined
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
drop' :: undefined
drop' = undefined
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
splitAt' :: undefined
splitAt' = undefined
-- Az eredeti függvény a genericSplitAt.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

-- Definiáld az insertAt függvényt, amely egy adott pozícióra beszúr egy elemet egy listába.
-- Ha az index negatív, akkor kezeljük úgy, mintha 0 lenne.
-- Ha az index nagyobb, mint ahány elemű a lista, akkor az utolsó helyre szúrjuk be az elemet.
-- insertAt (-2) 'a' "lma" == "alma"
-- insertAt 0 'a' "lma" == "alma"
-- insertAt 2 'b' "lma" == "lmba"
-- insertAt 10 'b' "lma" == "lmab"
insertAt :: undefined
insertAt = undefined
-- Megj.: Nincs insertAt függvény a Data.List-ben, ezért nincs is aposztróffal ellátva a neve.

-- Definiáld a replicate' függvényt, amely adott darabszámú azonos elemet generál.
-- Ha a szám negatív, azt kezeljük úgy, mintha 0 lenne.
-- Mi lesz a függvény legáltalánosabb típusa?
replicate' :: undefined
replicate' = undefined
-- Az eredeti függvény a genericReplicate.
-- A ' nélküli nevű függvény csak Int-ekkel működik!

--------------------------------------------------------------------------
-- Lokális definíciók (where és let ... in)
--------------------------------------------------------------------------

{-
Előfordulhat, hogy egy kifejezés többször is megjelenik. Ekkor érdemes azt kiemelni egy külön lokális definícióba,
így az a kifejezés csak egyszer lesz kiszámolva és azt fel lehet használni.

Vegyük az alábbi erőltetett példát.
-}

pl :: Integer -> Integer -> Bool
pl x y = even (x + y) && (x + y) `mod` 3 == 0

{-
Látni, hogy az x + y kétszer is megjelenik.
(Most tekintsünk el attól, hogy ki lehet matekozni, hogy ez a 6-tal osztható összeget vizsgálja.)
Az x + y kifejezést így a számítógép kétszer számolja ki teljesen feleslegesen,
hiszen a nyelv tiszta, az összeadás egy tiszta művelet, "x + y"-t akárhányszor ki lehet számolni, az eredmény mindig ugyanaz lesz.
Emeljük ki, hogy csak egyszer számolja ki és helyette az eredményt használja fel kétszer.
Ezt az alábbi módon lehet megtenni.
-}

---------------- where
pl1 :: Integer -> Integer -> Bool
pl1 x y = even z && z `mod` 3 == 0
  where
    z = x + y
{-
A where egy lokális scope-ot hoz létre, amelyben definiálhatunk függvényeket, konstansokat.
Ebben a blokkban definiáljuk a "z" változót, ami az "x + y"-t jelöli. A példában is látni, hogy a where blokkban a felvett paraméterek látszódnak és használhatók.

Amire vigyázni kell a where-ben, hogy a where blokk MINTAILLESZTÉSENKÉNT működik.
Például az alábbi kód helytelen:

pl2 :: Integer -> Integer
pl2 0 = x      -- Variable not in scope: x
pl2 n = x + n
  where
    x = n + 2

Továbbá figyelni kell rá, hogy a where blokkot bentebb kell kezdeni, nem szabad az első oszlopban.
Haskell-ben játszik az ún. margószabály, ez azt jelenti, hogy a kódblokkokat a kód elhelyezése határozza meg, nem valami más jel (általában '{', '}').
Épp ezért figyelni kell rá, hogy az azonos blokkba tartozó kódok azonos oszlopban kezdődjenek.
Még egy FONTOS dolog, hogy a kódok elhelyezését SZIGORÚAN SZÓKÖZZEL oldjuk meg, kifejezetten nem ajánlott a tabulátor használata, mert a legsűrűbb esetben érthetetlen hibát okoz.
-}

---------------- let ... in
-- Hasonlóképpen működik, mint a where blokk, ugyanúgy lehet függvényeket, konstansokat benne definiálni.

pl3 :: Integer -> Integer -> Bool
pl3 x y = let z = x + y      in even z && z `mod` 3 == 0
{-        ^^^^^^^^^^^^^      ^^
     Létrehozzuk           | Az "in" utáni részen használható
     a lokális definíciót, | a "z" változó is. (Ami eddig is
     most éppen z a neve a | használható volt, az utána is
     változónak.           | használható marad.)

A let ... in forma egy egész kifejezésként működik és akár egymásba is ágyazhatók.
A where-hez képesti különbség az, hogy mivel kifejezésként működik, ez egyértelműen meghatározza, hogy mi a lokális scope,
abból nem szabadul ki semmi sehova.
-}

pl4 :: Integer -> Integer
pl4 x = (let z = x + 1 in z + z) + (let y = 3 in y + x)
{-                                 ^^^^^^^^^^^^^^^^^^^^
                                   Itt nem használható a "z" változó,
                                   fordítási hibát kapnánk: "Variable not in scope: z"
-}

-- Mind a where-ben, mint a let ... in-ben lehet mintailleszteni, melyet az alábbi példa szemléltet.
pl5 :: (Integer,Integer) -> Integer
pl5 x = y + z
  where
    (y,z) = x

pl5' :: (Integer,Integer) -> Integer
pl5' x = let (y,z) = x in y + z

-- Feladatok:
-- Definiáljuk újra a numberWords függvényt egy általánosabb típussal.
-- Segítség: A where/let-in arra kell, hogy egy lokális függvényt definiáljunk (lehetne publikus is ez a függvény).
--           Lényegében repeat jellegű dolgot kell művelni a segédfüggvényben, de mivel megszámozni szeretnénk a szavakat,
--           a számokat valahogy növelni is kell.
numberWords' :: undefined
numberWords' = undefined

-- Definiáld az intersperse' függvényt, amely egy adott elemet beszúr minden elem közé.
-- intersperse' 0 [1,2,3] == [1,0,2,0,3]
-- intersperse' 'a' [] == []
-- intersperse' 'a' "b" == "b"
-- intersperse' 'a' "bb" == "bab"
-- intersperse' True [False,False,False,True] == [False,True,False,True,False,True,True]

-- Segítség: a where vagy let-in itt arra fog kelleni, hogy jól tudjuk az elemet beszúrni az elemek közé.
--           Ez azt jelenti, hogy fel kell ismerni, hogy a függvény működése két állapotból áll.
--           (Vagy egy lépésből átmegyünk a másikba és a végéig rekurzív; vagy az elején rekurzív, kivéve a legutolsó lépést.)
intersperse' :: undefined
intersperse' = undefined

-- Definiáld a showList' függvényt, amely egy listát szépen megjelenít; lényegében ahogy ki kéne írnia a ghci-be.
-- showList' [1,2,3] == "[1,2,3]"
-- showList' [] == "[]"
-- showList' [True] == "[True]"

-- Segítség: A where/let-in itt arra kell, hogy két alapesetet különböztessünk meg, lényegében hasonló az intersperse-hez.
showList' :: undefined
showList' = undefined

-- Definiáld az unzip' függvényt, amely egy párok listáját szétszed listák párjává úgy,
-- hogy a rendezett párok első fele az eredmény pár első listája lesz, a rendezett párok második fele
-- az eredmény pár második listája lesz.
-- unzip' [(0,'0'),(1,'1'),(2,'2')] == ([0,1,2],"012")
-- unzip' [] == ([],[])
-- unzip' [(3,0),(4,1),(0,2),(9,9),(8,10)] == ([3,4,0,9,8],[0,1,2,9,10])

-- Segítség: Most a where/let-in mintaillesztésre fog kelleni.
unzip' :: undefined
unzip' = undefined

---------------------------------------
-- Gyűjtögető rekurzió
---------------------------------------

-- Definiáld a reverse' függvényt, amely megfordítja egy lista elemeinek sorrendjét.
-- A listáról feltehető, hogy véges.
-- Segítség: A where/let-in arra kell, hogy egy olyan segédfüggvényt definiáljunk, ami egy paraméterben akkumulálja, gyűjtögeti az elemeket, a részeredményt tartalmazza.
reverse' :: undefined
reverse' = undefined

{-
Észrevételek:
-- Végtelen listára NEM MŰKÖDIK!!!
-- 4 különböző fajta rekurzió lehetséges így.
-- A végeredmény kifejezés zárójelezése attól függ, hogy hol van a rekurzió vagy épp milyen fajta rekurziónk van.
   pl.
   sum [] = 0
   sum (x:xs) = x + sum xs

   sum [1,2,3] =
   1 + sum [2,3] =
   1 + (2 + sum [3]) =
   1 + (2 + (3 + sum [])) =
   1 + (2 + (3 + 0))
   -----------------------------------------
   sum [] = 0
   sum (x:xs) = sum xs + x

   sum [1,2,3] =
   sum [2,3] + 1 =
   (sum [3] + 2) + 1 =
   ((sum [] + 3) + 2) + 1 =
   ((0 + 3) + 2) + 1
   -----------------------------------------
   sum xs = sumAcc 0 xs where
    sumAcc acc [] = acc
    sumAcc acc (x:xs) = sumAcc (acc + x) xs

   sum [1,2,3] = sumAcc 0 [1,2,3] =
   sumAcc (0 + 1) [2,3] =
   sumAcc ((0 + 1) + 2) [3] =
   sumAcc (((0 + 1) + 2) + 3) [] =
   ((0 + 1) + 2) + 3
   -----------------------------------------
   sum xs = sumAcc 0 xs where
    sumAcc acc [] = acc
    sumAcc acc (x:xs) = sumAcc (x + acc) xs

   sum [1,2,3] = sumAcc 0 [1,2,3] =
   sumAcc (1 + 0) [2,3] =
   sumAcc (2 + (1 + 0)) [3] =
   sumAcc (3 + (2 + (1 + 0))) [] =
   3 + (2 + (1 + 0))

Ha olyan a függvény, hogy a paraméterek típusai különböznek, akkor ezen 4 fajta rekurzióból 2 használható értelmesen.
-}
