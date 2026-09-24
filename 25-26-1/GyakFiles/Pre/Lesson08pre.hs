module Lesson08 where

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
{-g
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

-- Definiáljuk újra az előző órán látott spliAt' fv-t let-in segítségével.
splitAt' :: undefined
splitAt' = undefined

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

-- Feladatok:
-- Definiáld a tails' függvényt, előállítja egy lista összes lehetséges végződését!
-- tails' [1,2,3] == [[1,2,3],[2,3],[3],[]]
-- tails' "abcd" == ["abcd","bcd","cd","d",""]
tails' :: undefined
tails' = undefined
-- A függvény a Data.List modulban található!

--------------------------------------------
-- Érdekesebb rekurziók
--------------------------------------------

-- Definiáld az inits' függvényt, amely előállítja egy lista összes prefixét!
-- inits' [1,2,3] == [[],[1],[1,2],[1,2,3]]
-- inits' "ab" == ["","a","ab"]
-- inits' [5,10,9,1,0] == [[],[5],[5,10],[5,10,9],[5,10,9,1],[5,10,9,1,0]]
inits' :: undefined
inits' = undefined
-- A függvény a Data.List modulban található!

-- Definiáld a quickSort függvényt, amely a quick sort műveletét végzi el, azon módszerrel rendezi a lista elemeit.
-- A quick sort úgy rendezi az elemeket, hogy először választunk egy összehasonlítási pontot, értéket (angolul "pivot"),
-- és az összes elemet ezen elemhez képest rendezzük. Az attól kisebbek balra, az attól nagyobb vagy egyenlők pedig jobbra lesznek; magát a pivot-ot pedig a két rész közé helyezzük.
-- Az így keletkezett két részt természetesen ugyanúgy rendezni kell az azonos algoritmussal.
-- A "pivot" az első elem legyen, láncolt lista esetén az a legegyszerűbb választás.
-- A listáról feltehető, hogy véges.
quickSort :: undefined
quickSort = undefined

-- Definiáld a mergeSort függvényt, amely egy lista elemeit rendezi az összefésüléses rendezés algoritmusát használva.
-- Az összefésüléses rendezés úgy működik, hogy a kezdeti listát két részre bontjuk, majd mindkét részlistán ugyanezt az algoritmust használjuk
-- addig, amíg az alapesetig el nem érünk, tehát amiről egyértelműen el tudjuk dönteni, hogy rendezett.
-- Ez után elkezdjük visszaépíteni a legkisebb egyértelműen rendezett darabokból a rendezett listát összefésüléssel.
-- Ezen a ponton tudjuk, hogy az összes részlista, amit kapunk az rendezett, tehát az összefésülés során feltehetjük, hogy a részlisták már rendezettek.
-- Két rendezett listát úgy fésülünk össze, hogy összehasonlítjuk az első két elemet, megnézzük, hogy melyik a kisebb,
-- azt tesszük az eredménylista elejére, majd azon a listán lépünk a rekurzióban, ahol a kisebb elem volt, a másik listát meghagyjuk, ahogy volt.
-- Ha ezt eljátszuk, akkor a végén egy rendezett listát kell kapnunk.

-- Segítség: A where/let-in kelleni fog, hogy az összefésülés műveletét definiáljuk, hiszen olyan műveletet definiálunk, ami csak bizonyos előfeltétellel működik helyesen.
-- Segítség: A lista felezéséhez lassú használni a genericLength-et, az keresztülmegy az egész listán, csak hogy egy számot megkapjunk, majd szétválasztani ott még egyszer ugyanannyi munka.
--           Érdemes definiálni egy segédfüggvényt, amely a listát megfelezi. Az ötlet annyi, hogy legyen két másolatunk az eredeti listáról, az egyiken egyesével lépkedünk, a másikon kettesével.
--           Ha az egyiknek elérünk a végéig (amelyiken kettesével lépkedtünk, akkor a másikban pont a lista másik fele van.
-- A listáról feltehető, hogy véges.
mergeSort :: undefined
mergeSort = undefined

-- Állítsuk elő egy lista elemeinek az ismétlés nélküli kombinációit! (A lista elemeit tekintsük különbözőknek.)
-- combinations (-1) "abcd" == []
-- combinations 0 "abcd" == [[]]
-- combinations 1 "abcd" == ["a","b","c","d"]
-- combinations 2 "abcd" == ["ab", "ac", "ad", "bc", "bd", "cd"]
-- combinations 3 "abcd" == ["abc","abd","acd","bcd"]
-- combinations 4 "abcd" == ["abcd"]
-- combinations 5 "abcd" == []
-- combinations 2 [1,1,2,2] == [[1,1],[1,2],[1,2],[1,2],[1,2],[2,2]]
combinations :: undefined
combinations = undefined

-- Definiáld a deletions függvényt, amely egy elemet töröl egy listából az összes lehetséges módon!
-- deletions [1,2,3] == [[2,3],[1,3],[1,2]]
-- deletions "alma" == ["lma","ama","ala","alm"]
deletions :: undefined
deletions = undefined

-- Definiáld az insertions függvényt, amely beszúr egy elemet egy listába az összes lehetséges módon!
-- insertions 1 [] == [[1]]
-- insertions 0 [1,2,3] == [[0,1,2,3],[1,0,2,3],[1,2,0,3],[1,2,3,0]]
-- insertions 'a' "sdfg" == ["asdfg","sadfg","sdafg","sdfag","sdfga"]
insertions :: undefined
insertions = undefined

-- Definiáld a permutations függvényt, amely megadja egy lista összes permutációját!
-- Az egyszerűbb megoldás érdekében feltehető a listáról, hogy véges. (Megoldható úgy is, hogy végtelen listával is működjön, de az exponenciálisan nehezebb.)
permutations' :: undefined
permutations' = undefined
-- A függvény a Data.List modulban található!
