module Lesson04 where

---------------------------------------
-- Listák
---------------------------------------

-- Mai új típus az egyirányú láncolt lista (erről bővebben algoritmusok és adatszerkezetek órán).

{-
data [a] = [] | a : [a]
infixr 5 :

Két konstruktora van:
-- [] :: [a], üres lista
-- (:) :: a -> [a] -> [a], legalább egy elemű lista, a (:) hozzátesz egy elemet a lista elejére.

-- Tehát Haskellben a lista pl. így néz ki:   1 : 2 : 3 : []
-- Szerencsére a Haskell fejlesztők nagyon rendesek és a fenti lista felírható [1,2,3] formában is.
-- 1 : 2 : 3 : [] == [1,2,3]

Csak azonos típusú elemek szerepelhetnek egy listában:
pl. [1,'a',True] nem típushelyes, fordító is szólni fog érte.

Definíció:
-- Homogén adatszerkezet: Az adatszerkezetben csak azonos típusú elemek lehetnek. (pl. lista)
-- Heterogén adatszerkezet: Az adatszerkezetben lehetnek különböző típusú elemek is. (pl. rendezett n-esek)
-}

{-
Eddig nem sok szó esett a String-ekről. A String-ek különböző programozási nyelvekben valamilyen szöveget ábrázolnak.
A szövegek pedig karakterekből állnak. Haskell-ben a String valójában nem más, mint karakterek listája.
Tehát ha azt írom típusba, hogy String vagy azt, hogy [Char], mindkettő teljesen ugyanaz és szabadon felcserélhető.
Típusegyenlőség jelölése a hullámjellel történik, pl. String ~ [Char]
Haskellben a következő módon lehet ezt megadni:
type String = [Char]
Típusszinonimákról még későbbi órákon lesz szó.
-}

-- Feladat:
-- Definiáld a null' függvényt MINTAILLESZTÉSSEL, amely egy listáról ellenőrzi, hogy üres-e.
null' :: [a] -> Bool
null' [] = True
null' _ = False

-- Definiáld a notNull függvényt MINTAILLESZTÉSSEL, amely egy listáról ellenőrzi, hogy nem üres-e.
notNull :: [a] -> Bool
-- ((c : []) == [c]) -> (a : b : []) == [a,b]
notNull (_ : _) = True
notNull _ = False

-- Definiáld a head' függvényt MINTAILLESZTÉSSEL, amely egy listának veszi az első elemét.
-- Mi lesz a típusa?
head' :: [a] -> a
head' (x : _) = x

-- Definiáld a tail' függvényt MINTAILLESZTÉSSEL, amely egy listának eldobja az első elemét.
tail' :: [a] -> [a]
tail' (_ : xs) = xs

-- Észrevehetjük, hogy a head' és a tail' üres lista esetén csúnyán viselkednek, futási hibát okoznak.
-- Az ilyen függvényeket szokás parciális függvényeknek nevezni.

{-
Definíció:
-- Parciális függvény: Olyan függvény, amely nem működik a bemeneti típus összes lehetséges értékével.
                       (Valamilyen értékre végtelenségig számol vagy futási hibát vált ki.)
                                           ^^^^^^^^^^^^^^^^^^^^
                                           ez később érthető lesz.
pl. head, tail (és még lesz egy pár.)

-- Totális függvény: Olyan függvény, amely a bemeneti típus összes lehetséges értékével működik.
   pl. null, id, (&&), (||), stb.

SZÉP KÓD: A parciális függvények használatát kerüljük el!! Túl egyszerű nem odafigyelni valamilyen esetre és azonnal elrontjuk a teljes programot!
          Használjunk helyette mintaillesztést és kezeljünk le minden esetet! Hagyjuk, hogy a fordító segítsen minket ezzel.
          (Ehhez természetesen olyan típusok is kellenek, így erre még nem minden esetben van lehetőségünk.)
-}

-- Definiáld azt a függvényt, amely egy legalább három elemű lista második elemét elhagyja, minden más esetben az eredeti listát adja vissza!
remove2nd :: [a] -> [a]
remove2nd (x : _ : (y : ys)) = x : y :ys
remove2nd a = a


-- As pattern @ : A mintaillesztés egyes részeinek tudunk nevet adni például az alábbi formában:
alma :: [a] -> [a]
alma (_:_:ys@(_:_:xs)) = ys

-- Az "alma" függvényben mit tudunk ys-ről? Legalább hány elemű?
-- Legalább hány elemű lista esetén nem lesz probléma az "alma" függvény meghívása?

-- Előnye, hogy ha már van egy kész érték, akkor szegény számítógépnek nem kell szétszednie az összes részt, majd utána újra összetenni az eredményben.
-- Hanem csak felhasználja a már kész listát.

-- Definiáld újra a fenti függvényt a @ elnevezést használva.
remove2nd' :: [a] -> [a]
--          a   a legalább két elemű lista
--          |   |       || 
--          v   v    vvvvvvvv
remove2nd' (x : _ : xs@(_ : _)) = x : xs
remove2nd' a = a
