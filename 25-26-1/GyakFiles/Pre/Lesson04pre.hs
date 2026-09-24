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
null' = undefined

-- Definiáld a notNull függvényt MINTAILLESZTÉSSEL, amely egy listáról ellenőrzi, hogy nem üres-e.
notNull :: [a] -> Bool
notNull = undefined

-- Definiáld a head' függvényt MINTAILLESZTÉSSEL, amely egy listának veszi az első elemét.
-- Mi lesz a típusa?
head' :: undefined
head' = undefined

-- Definiáld a tail' függvényt MINTAILLESZTÉSSEL, amely egy listának eldobja az első elemét.
tail' :: undefined
tail' = undefined

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
remove2nd = undefined

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
