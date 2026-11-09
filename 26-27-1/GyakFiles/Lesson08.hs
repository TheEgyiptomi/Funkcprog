module Lesson08 where

import Data.Maybe

data Complex = Complex Double Double

-- Példányosítsuk értelemszerűen a következő osztályokat Complex-re: Eq, Show, Num, Fractional.
-- Eq: Az egyenlőségvizsgálat értelemszerű, két komplex csak akkor egyenlő, ha két szám valós része, illetve a két szám képzetes része megegyezik.

instance Eq (Complex) where
  (Complex a b) == (Complex c d) = a == c && b == d

{-
Show: Jelenítsük meg a komplex számokat úgy, ahogy matematikában is szokás írni azokat, alapértelmezett formában a + bi.
      Ez azt jelenti, hogy az alábbiak szerint járjunk el egyes speciális esetekben:
      -- Ha b == 1, akkor az 1-est ne írjuk ki, pl 2 + i legyen 2 + 1i helyett kiírva.
      -- Ha b == 0, akkor csak a valós rész legyen kiírva.
      -- Ha b < 0, akkor a - bi formában legyen kiírva.
      -- Következetesen járjunk el b == -1 esetén is.
-}

instance Show Complex where
  show (Complex a 1) = show a ++ " + i"
  show (Complex a 0) = show a
  show (Complex a b)
    | b == -1 = show a ++ " - i"
    | b < 0 = show a ++ " - " ++ show (abs b) ++ "i"
    | otherwise = show a ++ " + " ++ show b ++ "i"

{-
Num: Mivel a komplex számok... hát... számok, ezért meg kell mondani, hogy ezen számok hogy viselkednek az alapműveletekkel.
     -- Nézzük meg :i-vel, hogy miket kell definiálni.
     -- Összeadás, kivonás, szorzás remélhetőleg értelemszerű.
     -- abszolútérték: komplexek esetén a két dimenziós számot reprezentáló vektor hosszát jelenti. Használjuk a Pitagorasz-tételt a számoláshoz.
     -- signum: Előjel függvény. Komplexek esetén az "adott irányú" egységvektort jelenti, tehát nincs más dolgunk, mint az eredeti számot elosztani a szám abszolútértékével.
                (Megj.: Ezt nem tudjuk közvetlen megtenni, de részenként már tudunk osztani, hiszen a komplex szám két Double-lel van reprezentálva.)
     -- fromInteger: Ez az a függvény, aminek a segítségével egy leírt számliterál be tud állni tetszőleges típusú szám helyére,
                     pl. ahogy 2 lehet Int, lehet Double, lehet Float; különböző típusok esetén ez a függvény alakítja át az Integer-t a megfelelőre.
                     Megj.: Mivel Integer-t, tehát egész számot alakítunk át, ezért az eredményben mindig mennyi lesz a képzetes rész?
-}

instance Num Complex where
  (Complex a b) + (Complex c d) = Complex (a + c) (b + d)
  (Complex a b) * (Complex c d) = Complex (a * c - b * d) (a * d + b * c)
  (Complex a b) - (Complex c d) = Complex (a - c) (b - d)
  negate (Complex a b) = Complex (negate a) (negate b)
  abs (Complex a b) = Complex (sqrt (a^2 + b^2)) 0
  fromInteger int = Complex (fromInteger int) 0
  signum (Complex 0 0) = 0
  signum d@(Complex a b) = let (Complex hossz _) = abs d in Complex (a / hossz) (b / hossz)

{-
Fractional: Komplex számokat osztani is lehet. :i-vel nézzük meg, hogy miket kell definiálni egy Fractional-ben:
            -- (/) vagy recip: osztás vagy reciprok, mindkettő remélhetőleg értelemszerű.
            -- fromRational: Ahogy a számok Integer-ről vannak átalakítva; a törtek Rational-ről vannak átalakítva.
                             A Rational egy még eddig nem látott típus, lényegében a racionális számokat kódolja el, definíció szerint két egész szám hányadosa.
                             A Rational típus a Data.Ratio modulban található meg.
                             :bro Data.Ratio-val meg lehet nézni, hogy a modulban milyen függvények találhatók.
                             Ez a függvény a tizedesponttal felírt számokat alakítja a megfelelő típusúra (Double-re, Float-ra, stb.)
-}

instance Fractional Complex where
  fromRational rat = Complex (fromRational rat) 0
  (Complex a b) / (Complex c d) = Complex (acbd / cd) (bcad / cd)
    where
      cd = c^2 + d^2 -- osztó
      acbd = a * c + b * d -- valós rész
      bcad = b * c - a * d -- complex rész


------------------------------------------
-- Paraméteres konstruktorok
------------------------------------------

{-
Ahogy a rendezett pároknak, meg ahogy a listáknak is vannak olyan konstruktoraik, amik paramétereket várnak (pl. (,) és (:)),
úgy mi is tudunk ilyeneket definiálni.
-}

-- Definiáld a Fruit típust, amelynek legyen három konstruktora: Grape, Apple, Pear.
-- Ez után definiáld a FruitBatch típust, amelynek egy konstruktora van: FruitBatch, és ennek a konstruktornak két paramétere van, egy Fruit és egy Integer.
-- Lényegében ez írja le, hogy melyik gyümölcsből hány darabom van.
-- A konstruktoroknak szóközzel elválasztva kell átadni a paramétereit, a paraméterek az értékek típusai kell legyenek a konstruktornál.
-- Megjegyzés: Ki fog derülni a következő feladatból, hogy így azért nem az igazi ez a típus; meg lehet ezt oldani jobban is.



-- Kérdezzük meg ghci-től, hogy mi lesz a FruitBatch konstruktor típusa!

-- Definiáld a sumFruits függvényt, amely megszámolja egy listányi FruitBatch-ben, hogy hány darab gyümölcsünk van.
-- Nem válogatjuk külön a gyümölcsöket, csak a gyümölcsök száma az érdekes összesen.
sumFruits :: undefined
sumFruits = undefined

-- Definiáld az sumDifferentFruits függvényt, amely összeadja egy listányi FruitBatch-ben, hogy a különböző gyümölcsökből hány darabunk van.
-- Ez előtt tegyük egy kicsit beszédesebbé a típust. Definiálj 3 típusszinonimát Integer-re: NumberOfApples', NumberOfGrapes', NumberOfPears'

-- sumDifferentFruits :: [FruitBatch] -> (NumberOfApples',NumberOfGrapes',NumberOfPears')
sumDifferentFruits = undefined

-- A függvény írása közben esetleg tapasztalható, hogy senki nem állít meg abban, hogy az almát hozzáadjam a körtékhez.

-- Ennek egy megoldása ugyan egyszerű, de körülményes.
-- Definiáld a NumberOfApples, NumberOfGrapes, NumberOfPears típusokat, mindhárom típusnak legyen egy konstruktora a típussal azonos névvel, azoknak egy Integer paramétere.

-- SZÉP KÓD: Ha egy típusnak pontosan egy konstruktora van, akkor az a legsűrűbb esetben jó, ha azonos nevű a típussal.
--           Ez nem probléma, hogy a konstruktor azonos nevű a típussal, hiszen a típus és az értékkonstruktorok két külön névtérben élnek.




-- A fenti három típus legyen a Num osztály példánya és a műveletek működjenek pontosan ugyanúgy, mint az Integer-en.




-- Definiáljuk újra a sumDifferentFruits' függvényt a helyes típussal. (Most már nehezebben lesz lehetséges összeadni az almákat a körtékkel, természetesen még mindig lehet.)
-- sumDifferentFruits' :: [FruitBatch] -> (NumberOfApples,NumberOfGrapes,NumberOfPears)
sumDifferentFruits' = undefined

-- Mi történne, ha a Fruit típushoz hozzávennénk a barackokat (Peach) is? Mit kéne csinálni?
-- És ha mondjuk még cseresznyéket is hozzávennénk?

-- A fenti kérdésekre adott remélhetőleg helyes válaszból kiderül, hogy túl körülményes így kezelni ezt.
-- Ennek a megoldása érdekes, nem nehéz, de túlmutat a tárgy keretein; konzultáció közben lehet erről is beszélgetni.


-----------------------------
-- Paraméteres típusok
-----------------------------

-- Motiváció:
{-
Emlékezzünk vissza, hogy léteznek a parciális függvények: head, tail, div, mod, stb.
Továbbá emlékezzünk arra is, hogy a parciális függvények nem működnek minden lehetséges bemeneti értékkel, melynek a következménye, hogy
olyan csúnya értékek átadásakor a program menthetetlenül elszáll (tiszta világban nincs try, nincs catch, nincs semmi, mert a kivétel elkapása nem egy tiszta dolog).

Ezért az ötlet az volna, hogy próbáljuk meg valahogy az előbb említett függvényeket totálissá tenni.
Szerencsére vannak saját típusaink, azokat valahogy megpróbálhatjuk használni.
-}

-- Definiáld a safeHead' függvényt, amely ha van legalább egy elemünk a listában, akkor visszaadja azt, üres lista esetén pedig "semmit" ad vissza.
-- Segítség: Természetesen ezt a "semmit" valahogy reprezentálni kell. Az év elején megbeszéltük, hogy olyan nincs, hogy egy függvény csak csinál valamit,
--           de nincs eredménye. Definiáljunk pl. egy típust, ami Int-et tárol magában és definiáljuk úgy a safeHead'-et.
data NullableInt = JustInt Int | NothingInt deriving (Show, Eq)

safeHead' :: [Int] -> NullableInt
safeHead' [] = NothingInt
safeHead' (x:_) = JustInt x

-- Definiáld a safeHead''-t most Char-ra.

data NullableChar = JustChar Char | NothingChar deriving (Show, Eq)

safeHead'' :: [Char] -> NullableChar
safeHead'' [] = NothingChar
safeHead'' (x:_) = JustChar x

-- Definiáld a safeHead'''-t Bool-ra.

data NullableBool = JustBool Bool | NothingBool deriving (Show, Eq)

safeHead''' :: [Bool] -> NullableBool
safeHead''' [] = NothingBool
safeHead''' (x:_) = JustBool x


{-
Mi a probléma?
Emlékezzünk vissza a head függvény típusára. head :: [a] -> a
Tetszőleges értékekkel működik, lehet az String, Char, Integer, Float, Bool, másik lista, rendezett pár, stb.
Mindegyikre nem tudunk ezzel a módszerrel típust generálni, hiszen ezekből végtelen van.
Szerencsére meg tudjuk mi is oldani egy típusban, hogy tetszőleges típusokkal működjön.

Ehhez csak annyit kell tenni, hogy a típusnak egy típusváltozót fel kell venni paraméterül.
-}

-- Definiáld a Maybe' típuskonstruktort, amelynek legyen egy típusparamétere.
-- Legyen továbbá két konstruktora, egy Nothing' és egy Just', amelynek a paramétere legyen a felvett típusváltozó.

data Maybe' a = Just' a | Nothing' deriving (Show, Eq)
--          |         |
--           ---------

-- Megjegyzés, "definíció": Ahogy az (érték)konstruktor egy bizonyos típusú értéket képes létrehozni, úgy a típuskonstruktor egy típust hoz létre.
-- Év elején volt róla szó, hogy a Haskell egy statikusan típusos nyelv. Ez azt jelenti, hogy mindennek van fordítási időben típusa. Még a Maybe'-nek is, meg az összes többi típusnak is.
-- Nézzük meg, hogy mi a Maybe' típusa! (Mivel ez típus, a :t nem működik, helyette vagy :i-t vagy :k-t kell használni.)
-- Tudunk-e Maybe' típusú értéket definiálni?
-- Tehát:
-- m :: Maybe'
-- m = ...
-- Van-e értelmes definíciója m-nek? (akár végtelen rekurzió, akár undefined)

-- Definiáld a safeHead függvényt úgy, hogy minden típusra működjön helyesen!
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

-- Definiáld a safeDiv függvényt, amely a 0-val való osztást kiszűri, tehát ha a második paramétere 0, akkor az eredmény legyen Nothing,
-- egyébként osszuk el az elsőt a másodikkal.
safeDiv :: Integral a => a -> a -> Maybe a
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y) 

-- Definiáld az add függvényt, amely két lehetségesen hibás értéket összead. Ha valamelyik érték Nothing, az eredmény legyen Nothing.
add :: Num a => Maybe a -> Maybe a -> Maybe a
add Nothing _ = Nothing
add _ Nothing = Nothing
add (Just x) (Just y) = Just (x + y)

-- Definiáld a doubleHead függvényt, amely egy listák listájának veszi az első listájának első elemét, ha az létezik.
doubleHead :: [[q]] -> Maybe q
doubleHead [] = Nothing
doubleHead ([]:_) = Nothing
--         [q] 
doubleHead ((x : _) : _) = Just x
--           q  [q] [[q]]
-- Mi lesz a probléma akkor, ha az eredmény Nothing?
-- Válasz:

-- Definiáld a divHead függvényt, amely egy listának az első elemét elosztja egy második paraméterül kapott egész számmal.
divHead :: Integral maci => [maci] -> maci -> Maybe maci 
divHead _ 0 = Nothing
divHead [] _ = Nothing
divHead (osztando : _) oszto = Just (osztando `div` oszto)

-- A probléma itt is ugyanaz lesz, mint az előbb. Mit tudunk, ha az eredmény Nothing?

-- Definiáld a lookup' függvényt, amely egy adott kulcsú értéket megkeres egy listában. A lista rendezett párokból áll, amelyeknek az első komponensét tekintjük
-- a kulcsnak, a másodikat pedig az értéknek. Előfordulhat, hogy nincs a listában a kulcs, ekkor Nothing legyen az eredmény.
lookup' :: Eq key => [(key, value)] -> key -> Maybe value
lookup' [] _ = Nothing
lookup' ((key, value) : xs) searchedKey
--       (key, value)
  | key == searchedKey = Just value
  | otherwise = lookup' xs searchedKey

-- Definiáld az elemIndex' függvényt, amely visszaadja az első adott elem indexét egy listából, ha létezik olyan.
-- A típusa legyen minél általánosabb.
elemIndex' :: (Eq a, Integral b) => [a] -> a -> Maybe b
elemIndex' [] _ = Nothing
elemIndex' (actuaElem : xs) searchedElem
 | actuaElem == searchedElem = Just 0
 | otherwise = (Just 1) `add` (elemIndex' xs searchedElem)
-- Integral b => Maybe b '+' Maybe b
elemIndex'' ls searchedElem = lookup' (zip ls [0..]) searchedElem

-- Megj.: Az eredeti függvény a Data.List-ben van, de csak Int-et ad vissza tetszőleges szám helyett, így a használata nem javallott.

-----------------------------------------------------------

-- Legyen adott az alábbi data:
data SelectValue = First | Second

-- Definiáld a select függvényt, amelynek három paramétere van, az első eldönti, hogy a következő kettő közül melyiket adjuk vissza.
-- Mi lesz az eredmény típusa?
--               Ez a kettő maradjon a és b
--                       v    v
select :: SelectValue -> a -> b -> undefined
select = undefined

-- Mi lehet erre a megoldás?
-- Egy új típus kell rá definiálni olyan formában, amely tudja magáról, hogy az értékei között vagy "a" típusú érték vagy "b" típusú érték lehet.
-- Definiáljunk egy ilyen datát; ezt a datát Either-nek szokás nevezni, továbbá két konstruktora van, Left és Right!

data Either' a b = Left' a | Right' b deriving (Eq, Show)

select' :: SelectValue -> a -> b -> Either' a b
select' First a _ = Left' a
select' Second _ b = Right' b 

-- Most már meg tudjuk csinálni a fenti feladatot.
{-
Az előbb definiált Either típusban több információ elfér, mint egy Maybe-ben hibakezelés szempontjából.
Először nézzük a naív módját a hibakezelésnek:
-}
type ErrorOr a = Either String a
{-
A lényeg annyi, hogy ha hibás eredményünk van, akkor egy String-et adunk vissza és abba írhatunk valamilyen szöveget
tájékoztatva a felhasználót a hibáról. Nem túl struktúrált, de kezdetben megfelel.
-}

-- Definiáljuk újra a doubleHead függvényt, csak most az eredménye egy "ErrorOr a" típusú érték legyen
doubleHeadErrorOr :: [[a]] -> ErrorOr a
doubleHeadErrorOr [] = Left "Teljes lista üres"
doubleHeadErrorOr ([] : _) = Left "Első lista üres"
doubleHeadErrorOr ((x : _) : _) = Right x

-- Mint ahogy látható, a String-be lényegében azt írunk, amit szeretnénk, ami nem feltétlenül túl segítőkész, főleg ha viccesek és lusták vagyunk,
-- és azt adjuk vissza hibaként, hogy "találd ki!".
-- Egy kicsit kultúráltabban is lehet hibát kezelni, ahogy a nagyvilágban is történik.
-- Egy új típust lehet definiálni, amely a lehetséges hibákat reprezentálja.
-- Ez a módszer leginkább akkor érdekes, ha több hibaforrás lehetséges, mint pl. a doubleHead-ben, divHead-ben, meg majd a háziban.

