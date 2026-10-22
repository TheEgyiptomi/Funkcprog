module Lesson08 where

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

{-
Fractional: Komplex számokat osztani is lehet. :i-vel nézzük meg, hogy miket kell definiálni egy Fractional-ben:
            -- (/) vagy recip: osztás vagy reciprok, mindkettő remélhetőleg értelemszerű.
            -- fromRational: Ahogy a számok Integer-ről vannak átalakítva; a törtek Rational-ről vannak átalakítva.
                             A Rational egy még eddig nem látott típus, lényegében a racionális számokat kódolja el, definíció szerint két egész szám hányadosa.
                             A Rational típus a Data.Ratio modulban található meg.
                             :bro Data.Ratio-val meg lehet nézni, hogy a modulban milyen függvények találhatók.
                             Ez a függvény a tizedesponttal felírt számokat alakítja a megfelelő típusúra (Double-re, Float-ra, stb.)
-}


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



-- Definiáld a safeHead''-t most Char-ra.



-- Definiáld a safeHead'''-t Bool-ra.



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



-- Megjegyzés, "definíció": Ahogy az (érték)konstruktor egy bizonyos típusú értéket képes létrehozni, úgy a típuskonstruktor egy típust hoz létre.
-- Év elején volt róla szó, hogy a Haskell egy statikusan típusos nyelv. Ez azt jelenti, hogy mindennek van fordítási időben típusa. Még a Maybe'-nek is, meg az összes többi típusnak is.
-- Nézzük meg, hogy mi a Maybe' típusa! (Mivel ez típus, a :t nem működik, helyette vagy :i-t vagy :k-t kell használni.)
-- Tudunk-e Maybe' típusú értéket definiálni?
-- Tehát:
-- m :: Maybe'
-- m = ...
-- Van-e értelmes definíciója m-nek? (akár végtelen rekurzió, akár undefined)

-- Definiáld a safeHead függvényt úgy, hogy minden típusra működjön helyesen!
safeHead :: undefined
safeHead = undefined

-- Definiáld a safeDiv függvényt, amely a 0-val való osztást kiszűri, tehát ha a második paramétere 0, akkor az eredmény legyen Nothing,
-- egyébként osszuk el az elsőt a másodikkal.
safeDiv :: undefined
safeDiv = undefined

-- Definiáld az add függvényt, amely két lehetségesen hibás értéket összead. Ha valamelyik érték Nothing, az eredmény legyen Nothing.
add :: undefined
add = undefined

-- Definiáld a doubleHead függvényt, amely egy listák listájának veszi az első listájának első elemét, ha az létezik.
doubleHead :: undefined
doubleHead = undefined

-- Mi lesz a probléma akkor, ha az eredmény Nothing?
-- Válasz:

-- Definiáld a divHead függvényt, amely egy listának az első elemét elosztja egy második paraméterül kapott egész számmal.
divHead :: undefined
divHead = undefined

-- A probléma itt is ugyanaz lesz, mint az előbb. Mit tudunk, ha az eredmény Nothing?

-- Definiáld a lookup' függvényt, amely egy adott kulcsú értéket megkeres egy listában. A lista rendezett párokból áll, amelyeknek az első komponensét tekintjük
-- a kulcsnak, a másodikat pedig az értéknek. Előfordulhat, hogy nincs a listában a kulcs, ekkor Nothing legyen az eredmény.
lookup' :: undefined
lookup' = undefined

-- Definiáld az elemIndex' függvényt, amely visszaadja az első adott elem indexét egy listából, ha létezik olyan.
-- A típusa legyen minél általánosabb.
elemIndex' :: undefined
elemIndex' = undefined
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
doubleHeadErrorOr :: undefined
doubleHeadErrorOr = undefined

-- Mint ahogy látható, a String-be lényegében azt írunk, amit szeretnénk, ami nem feltétlenül túl segítőkész, főleg ha viccesek és lusták vagyunk,
-- és azt adjuk vissza hibaként, hogy "találd ki!".
-- Egy kicsit kultúráltabban is lehet hibát kezelni, ahogy a nagyvilágban is történik.
-- Egy új típust lehet definiálni, amely a lehetséges hibákat reprezentálja.
-- Ez a módszer leginkább akkor érdekes, ha több hibaforrás lehetséges, mint pl. a doubleHead-ben, divHead-ben, meg majd a háziban.

-- Definiáld az Error saját típust! A konstruktorai olyanok legyenek, hogy a doubleHead függvény két hibáját tudja jelezni.



-- Definiáld a doubleHeadError függvényt!
doubleHeadError :: undefined
doubleHeadError = undefined

-- Definiálj egy másik hibát jelző típust, amely a divHead műveletet kezeli.



-- Definiáld a divHead függvényt ezzel az új hibát jelző típussal!
divHeadError :: undefined
divHeadError = undefined

-- Mi lesz a probléma ezzel a módszerrel?
-- Válasz:

-- Természetesen ez is megoldható, de ezen eszközök megint csak túlmutatnak a tárgy keretein.
-- Konzultáción szintén tudunk róla beszélgetni.

---------------------------------------------------------------------------------------------------------

-- Feladatok:
-- Definiáld az add1OrNot függvényt, amely vagy egy számhoz hozzáad egyet vagy egy Bool-t negál.
add1OrNot :: Num a => Either a Bool -> Either a Bool
add1OrNot = undefined

-- "Bizonyítsuk", hogy az Either típus asszociatív!
-- (Tehát ha van két Either típus egymásba ágyazva, akkor nem számít, hogy hogyan vannak egymásba ágyazva.)
eitherAssoc :: (a `Either` b) `Either` c -> a `Either` (b `Either` c)
eitherAssoc = undefined

-- Megj.: A tényleges bizonyításhoz a másik irányban is meg kéne adni, de elhiszem, hogy ezen a ponton az menne mindenkinek.

---------------------------------
-- Rekurzív (Induktív) típusok
---------------------------------

{-
Nem csak függvények lehetnek rekurzívak, hanem maguknak a típusoknak a felépítése is lehet rekurzív, pontosabban induktív.
Vegyük példaként a listát. Hogy lehet végtelen listánk? Úgy, hogy a típusában valahol végtelen rekurziót lehet csinálni.

Próbáljuk meg definiálni mi magunk a lista adatszerkezetet. Szükség van két konstruktorra; egy, ami az üres listát reprezentálja, meg egy, ami a legalább egy eleműt.
Ezeket általában Nil-nek és Cons-nak szokás nevezni. A Cons konstruktor infixen használva kössön 5-ös erősséggel jobbra.
-}

data List a

-- Definiáld az add1 függvényt, amely a lista minden eleméhez hozzáad egyet.

-- Példányosítsd a List típust Show-ra, Eq-ra.



-- A lista ezen a ponton unalmas, pontosan ugyanazt tudja, mint az eredeti lista, amit eddig használtunk.
-- Definiáljunk eggyel érdekesebbet: bináris fákat.
-- A bináris fa olyan fa, amely minden csomópontban és levélben tartalmaz adatot, továbbá minden csomópontnak pontosan két gyereke van.
-- Reprezentáció szempontból nézzük az alábbi példát.
{-
        4
       / \
      /   \
     3     2
    / \   / \
   1   0 3   7
  / \       / \
10  20     5   9
-}

-- Definiáljuk a BinTree típust, ami egy ilyen fát tud reprezentálni.
-- Két konstruktora kell legyen, Leaf és Node.
-- Kérjük meg a fordítót, hogy példányosítsa nekünk a Show osztályra a típusunkat.

data BinTree a

-- Adjuk meg a fenti példában látható fát lineáris jelöléssel (tehát Leaf-ek és Node-ok függvényében)!
t :: Num a => BinTree a
t = undefined

-- Definiáld az add1Tree függvényt, amely egy bináris fa minden eleméhez hozzáad egyet.

-- Definiáld a sumTree függvényt, amely egy bináris fának az elemeit összeadja.

-- Példányosítsd az Eq osztályt a bináris fára.
