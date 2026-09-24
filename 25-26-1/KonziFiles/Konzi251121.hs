module Konzi3 where

data List a where -- Nil | Cons a (List a)
  Nil :: List a
  Cons :: a -> List a -> List a

infixr 5 `Cons`

{-
[1,2,3,4,5] = (1 : 2 : 4 : 5 : [])

Nil ~ []
`Cons` ~ (:)
-}

sum' :: (Num a) => List a -> a
sum' Nil = 0
sum' (Cons a as) = a + sum' as

instance (Show a) => Show (List a) where
  show Nil = "[]"
  show (a `Cons` as) = show a ++ " : " ++ show as

instance Eq a => Eq (List a) where
  Nil == Nil = True
  (Cons a as) == (Cons b bs) = a == b && as == bs
  _ == _ = False

-- Feladatok:
-- Definiáld a tails' függvényt, előállítja egy lista összes lehetséges végződését!
-- tails' [1,2,3] == [[1,2,3],[2,3],[3],[]]
-- tails' "abcd" == ["abcd","bcd","cd","d",""]
tails' :: [a] -> [[a]]
tails' [] = [[]]
tails' ls@(_ : xs) = ls : tails' xs
-- A függvény a Data.List modulban található!

-- Definiáld a quickSort függvényt, amely a quick sort műveletét végzi el, azon módszerrel rendezi a lista elemeit.
-- A quick sort úgy rendezi az elemeket, hogy először választunk egy összehasonlítási pontot, értéket (angolul "pivot"),
-- és az összes elemet ezen elemhez képest rendezzük. Az attól kisebbek balra, az attól nagyobb vagy egyenlők pedig jobbra lesznek; magát a pivot-ot pedig a két rész közé helyezzük.
-- Az így keletkezett két részt természetesen ugyanúgy rendezni kell az azonos algoritmussal.
-- A "pivot" az első elem legyen, láncolt lista esetén az a legegyszerűbb választás.
-- A listáról feltehető, hogy véges.
quickSort :: Ord a => [a] -> [a]
quickSort [] = []
quickSort as@(x : xs) = quickSort (filter (< x) xs) ++ quickSort (filter (>= x) as)

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
mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort ls = let (as , bs) = halver ls in merge (mergeSort as, mergeSort bs)
  where
    halver :: Ord a => [a] -> ([a], [a])
    halver [] = ([], [])
    halver [x] = ([], [x])
    halver (x : y : xs) = let (el, er) = halver xs in (x : el, y : er)

    merge :: Ord a => ([a], [a]) -> [a]
    --merge ([], []) = []
    merge ([], ls) = ls
    merge (ls, []) = ls
    merge (x : xs, y : ys)
      | x <= y = x : merge (xs, y:ys)
      | otherwise = y : merge (x : xs, ys)


halver :: Ord a => [a] -> ([a], [a])
halver [] = ([], [])
halver [x] = ([], [x])
halver (x : y : xs) = let (el, er) = halver xs in (x : el, y : er)

dhalver xs [] = ([], xs)
dhalver xs [_] = ([], xs)
dhalver (x:xs) (_:_:ys) = let (as, bs) = dhalver xs ys in (x:as, bs)
