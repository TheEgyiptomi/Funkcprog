module Lesson03 where

-- UGYANAZ A BLOKK, MINT AZ ELŐZŐ ÓRA VÉGÉN:
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

g :: (a,b) -> a
g (x,y) = x

-- Hány különböző féleképpen definiálható az alábbi függvény undefined nélkül? (Különböző viselkedések száma az érdekes)

id' :: Integer -> Integer
id' 0 = 1
id' 1 = 1
id' x = x

-- Hány különböző féleképpen definiálható az alábbi függvény undefined nélkül?
-- Különböző típusú értékeket nem lehet mintailleszteni egy függvényben!
id'' :: a -> a
-- id'' 'a' = 'b'      |
-- id'' 0 = 1          |-> ILYET NEM LEHET!
-- id'' "asd" = "alma" |
id'' x = x -- (:: Bool -> Bool)

-- Kicsit ellentmondásos lehet, de a tanulság az, hogy minél általánosabb egy függvény típusa, annál egyértelműbb definiálni (ha lehet).

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
notNull [] = False
notNull _ = True

-- Definiáld a head' függvényt MINTAILLESZTÉSSEL, amely egy listának veszi az első elemét.
-- Mi lesz a típusa?
head' :: [a] -> a
head' (x:xs) = x

-- Definiáld a tail' függvényt MINTAILLESZTÉSSEL, amely egy listának eldobja az első elemét.
tail' :: [a] -> [a]
--tail' [] = []
tail' (x:xs) = xs

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
remove2nd       (x:y:ys@(g:ls)) = x : g : ls -- (___ x : ys)
-- lehet ilyen   1 2 3 []

-- As pattern @ : A mintaillesztés egyes részeinek tudunk nevet adni például az alábbi formában:
alma :: [a] -> [a]
alma (_:_:ys@(_:_:xs)) = ys

-- Az "alma" függvényben mit tudunk ys-ről? Legalább hány elemű?
-- Legalább hány elemű lista esetén nem lesz probléma az "alma" függvény meghívása?

-- Előnye, hogy ha már van egy kész érték, akkor szegény számítógépnek nem kell szétszednie az összes részt, majd utána újra összetenni az eredményben.
-- Hanem csak felhasználja a már kész listát.

-- Definiáld újra a fenti függvényt a @ elnevezést használva.
remove2nd' :: [a] -> [a]
remove2nd' = undefined

