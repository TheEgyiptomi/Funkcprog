module Lesson02 where

-----------------------------------
-- Bemelegítés
-----------------------------------

{-
Fájl betöltése:
- ghci-ben :load <fájlnév> vagy :l <fájlnév>
- :reload vagy :r; újratölti a legutoljára betölteni próbált fájlt
-}

-- Alapvető műveletek számokon:
-- (+), (-), (*), ghci-ben kipróbálni
-- Matematikai szabályok érvényesek; hatványozás > szorzás > összeadás; balról-jobbra kiértékelés
   -- Részletesebben, hogy ez ténylegesen honnan állapítható meg, következő órán!

-- VIGYÁZAT! Negatív számok/literálok NEM LÉTEZNEK Haskellben!
-- Valamikor úgy működik, ahogy gondoljuk
negativeOne :: Integer
negativeOne = -1

-- De nem mindig!
-- oops :: Integer
-- oops = 3 + -4
-- Zárójelben a -4, mint matekban szokás, már helyesen működik.
negativeOne' :: Integer
negativeOne' = 3 + (-4)

----------------------------
-- Bool
----------------------------

-- Két értéke van: True és False (igaz és hamis értéket reprezentál)
   --              ^^^^    ^^^^^
   --              NAGYBETŰVEL kell írni az elsőt!

true :: Bool
true = True

false :: Bool
false = undefined

----------------------------------------
-- Mintaillesztés
----------------------------------------

{-
A mintaillesztés a funkcionális programozás egyik leghasznosabb, leghasználtabb és leggyakoribb eszköze.

A mintaillesztés lényegében úgy néz ki, hogy amikor a függvényt definiáljuk, akkor a paraméter helyére konkrét értéket írunk és utána definiáljuk,
hogy mi legyen a függvény eredménye.

Vegyük az alábbi példát:

not :: Bool -> Bool

A függvény egy Bool (igaz-hamis) értéket szeretne negálni. Tehát igazra hamisat, hamisra pedig igazat kéne visszaadnia.
Hogyan definiáljuk? Lényegében a kód pontosan ugyanúgy fog kinézni, ahogy az előző mondatban lévő leírás.
-}

not' :: Bool -> Bool
--not' _ = undefined
not' True = False
not' False = True

{-
FONTOS! A minta illeszkedésének ellenőrzése FENTRŐL LEFELÉ sorrendben történik.
Mik minősülnek mintának? Lényegében 3 kategóriáról tudunk beszélni mintaként:
-- Konkrét értékek: Ilyen pl. True, False, 0, 1, 2, 'a', 'B', stb.
-- Változók: x, y, z, stb. Egy változó a TÍPUSNAK MEGFELELŐ BÁRMILYEN értékére illeszkedik. Egy adott változó az illesztéskor csak egyszer szerepelhet!
-- Joker: _ , amely azt jelenti, hogy "tudom, hogy ott van egy paraméterem, de annak az értékét nem szeretném használni". Egy függvénydefinícióban több _ is használható az = bal oldalán.

Egy kicsit pontosítsuk azt, hogy mire mintaillesztünk.

A Bool nem egy beépített, beégetett típus a nyelvben (nagyon kevés típus van, ami beégetett), hanem saját általunk definiálható típus, amely az alábbi módon néz ki Haskell-ben:

data Bool = False | True

A saját típusokról fogunk még beszélni részletesebben a 7. óra környékén. Jelen pillanatban elég annyi, hogy a Bool a típus neve,
majd az egyenlőségjel után a típusnak a KONSTRUKTORai szerepelnek, amelyek Bool esetén a False és a True.
A konstruktor egy olyan függvény, amely az adott típus értékét reprezentálja/építi fel.

Mintailleszteni ezekre és csak ezekre lehet Haskell-ben!
(Eltekintve a ténytől, hogy a számok és karakterek mintaillesztése egy csöppet másképp működik a háttérben, de az nem igazán lesz érdekes a tárgy keretében.
Akit jobban érdekel, természetesen utána tud nézni vagy konzultáción lehet róla beszélgetni.)

SZÉP KÓD: Ha tehetjük, akkor mindig illesszünk mintát az összes lehetséges módon egy adott paraméteren, így a kódsorok, az illesztések sorrendje nem fog számítani.
Pl.
Fenti not' függvény:

not' False = True      vs.     not' True  = False
not' True  = False             not' False = True

Ezen két esetben teljesen mindegy, hogy hogyan van a függvény definiálva, ugyanúgy fog viselkedni.

Ezzel szemben:

not' False = True      vs.     not' _     = False
not' _     = False             not' False = True

Hogy viselkedik a bal oldali függvény és hogyan viselkedik a jobb oldali?

A különbség abból adódik, hogy átfedés van az ágak között. Sűrű hibák forrása pedig abból születik, hogy nincsenek az átfedő esetek figyelembe véve.
A _ mintára illeszkedik a True és a False is, míg a False-ra csak a False.
Ha előbb van az a minta, ami több mindenre illeszkedik (általánosabb), akkor a függvény nem úgy fog viselkedni, mint ahogy elsőre gondoljuk.
-}

-- Gyakorlás, ötletelés:
-- Definiáld az (&&&) függvényt mintaillesztéssel, amely a logikai és műveletét végzi el két Bool értéken!

(&&&) :: Bool -> Bool -> Bool
True &&& True = True
--_ &&& _ = False
  
{-
-}

-- Definiáld a (|||) függvényt mintaillesztéssel, amely a logikai vagy műveletét végzi el két Bool értéken!

(|||) :: Bool -> Bool -> Bool
(|||) False False = False
_ ||| _ = True

{-
Ezen fenti függvényeket sokféleképpen lehet definiálni.
Nézzük meg, hogy mi történik, ha kiértékeljük az alábbiakat ebben a sorrendben:
-- 1 `div` 0
-- 1 `div` 0 == 0
-- 1 `div` 0 == 0 && 1 == 0

Tippelés: Mi fog történni az alábbi esetben?
-- 1 == 0 && 1 `div` 0 == 0

Nézzük meg, hogy a fent definiált függvényekkel mi fog történni!
Definiáljuk az egyik logikai műveletet az "összes értelmes" lehetséges módon és azokkal is nézzük meg, hogy mi történik!
-}

{-
A fentiekből megállapítható, hogy valamikor kivételt kapunk, valamikor nem. Ha jobban odafigyelünk, akkor kideríthető egyértelműen, hogy mely esetekben kapunk kivételt és mikor nem.
Észrevehetjük, hogy ha nem muszáj, akkor Haskell nem értékel ki feleslegesen kifejezéseket. Ezt a kiértékelési stratégiát hívjuk LUSTA kiértékelésnek.

Mohó kiértékelés: Olyan kiértékelési módszer, amely során egy kifejezés minden része kiértékelésre kerül az eredmény kiszámítása előtt.
-- Pl.
-- Legyen f a b = 2 * a + b; g y = y + 2
-- f (g 3) (g 2) levezetése a következő lesz mohó módszerrel:
   f (g 3) (g 2)
 → f (3 + 2) (g 2)
 → f 5 (g 2)
 → f 5 (2 + 2)
 → f 5 4
 → 2 * 5 + 4 → 10 + 4 → 14

Lusta kiértékelés: Olyan kiértékelési módszer, amely során egy kifejezés csak akkor értékelődik ki, ha muszáj.
-- Pl.
-- Legyen f a b = 2 * a + b; g y = y + 2
-- f (g 3) (g 2) levezetése a következő lesz lusta módszerrel:
   f (g 3) (g 2)
 → 2 * g 3 + g 2
 → 2 * (3 + 2) + g 2
 → 2 * 5 + g 2
 → 10 + g 2
 → 10 + (2 + 2)
 → 10 + 4
 → 14

-- Az alábbi példában előjön a lustaság szerepe; ha az alábbi kifejezést mohón értékeljük ki:
   1 == 0 && (3 == 3 && 1 `div` 0 == 1)
 → False && (3 == 3 && 1 `div` 0 == 1)
 → False && (True && 1 `div` 0 == 1)
 → ...               ^^^^^^^^^^^^^^ 0-val való osztás kivétel.

-- Ha azonban lustán értékeljük ki:
   1 == 0 && (3 == 3 && 1 `div` 0 == 1)
 → False && (3 == 3 && 1 `div` 0 == 1)
 → False
A lustaság miatt a kifejezés maradék részére rá se kell nézni, az (&&) definíciója miatt ha tudjuk, hogy az első paraméter False, akkor az eredmény is az mindenképpen.
-}

-- Mintaillesztés más típuson:

-- Definiáld az isZero függvényt mintaillesztéssel, amely egy számról ellenőrzi, hogy 0-e.
isZero :: Integer -> Bool
isZero 0 = True
isZero _ = False



----------------------------------------------------------------------------
-- Ha marad idő, akkor számok!!


----------------------------
-- Char
----------------------------

-- Karakterliterálokat aposztróffal írunk, azok között egy karakter jelöl egy karaktert.

a :: Char
a = 'a'

-- Nincs igazán érdekes függvény jelenleg Char-hoz.
-- Jelenleg használható példaként a succ, pred, toEnum, fromEnum függvények lehetnek.
-- Ezek a függvények minden felsorolható típuson működnek. Ilyen például az Int, Char, Bool.
-- succ: egy karakter rákövetkezőjét adja vissza. A program elszáll, ha nincs következő.
-- pred: egy karakter megelőzőjét adja vissza. A program elszáll, ha nincs előző.
-- toEnum: karakterkódót (Int) átalakítja karakterré.
-- fromEnum: karaktert átalakítja annak a kódjává.

-- Léteznek más függvények, pl. toUpper, toLower, melyek rendre egy adott karakter nagy, illetve kicsi változatát adják vissza,
-- de ezek más könyvtárakban, modulokban vannak, jelenlegi eszközeinkkel azok még nem használhatók.

-- Definiáld az isAorB függvényt mintaillesztéssel, amely egy karakterről eldönti, hogy az a nagy A vagy a nagy B-e.
isAorB :: Char -> Bool
isAorB 'A' = True
isAorB 'B' = True
isAorB _ = False 

-------------------------------
-- Számok
-------------------------------

{-
one :: Int
one = 1

three :: Integer
three = 3
-}
{-
Az előző órán kiderítettük, hogy "one + three" nem igazán működik, mert nem típushelyes. Hogy lehet mégis összeadni ezen számokat?
Explicit módon át kell alakítani egyik típusú értéket egy másik típusúra.
-- Explicit == Ki kell írni, nincs más módja.

Számok lényegében pontos átalakítására két függvény alkalmas:
-- fromIntegral :: (Integral a, Num b) => a -> b
-- realToFrac :: (Real a, Fractional b) => a -> b

Egyelőre még nem kell nagyon érteni a betűket, a lényeg, hogy a => előtt látni két megjelenő TÍPUSOSZTÁLYT,
amely megköti az egyes értékekről, hogy mik lehetnek.
Majd az óra végén lesz ezekről az "a"-król és "b"-kről szó.

A fromIntegral-ban látni, hogy valami "a" a paraméter és valami "b" az eredmény, az "a"-ról, mint paraméterről azt tudjuk, hogy valamilyen EGÉSZ szám lehet és ennyi.
Tört nem lehet. Míg az eredményről azt tudjuk megállapítani, hogy tetszőleges számmá át tudja alakítani az egész számot.
Az Integral-ba az Int és az Integer típus tartozik bele (meg még egy pár, ami nem fontos, de ez mindig megnézhető a :i-vel).
A Num-ba az Int, Integer, Double, Float is beletartozik (meg még egy pár, szintén :i segít).

A realToFrac esetén hasonló a helyzet, csak "a"-ról most azt tudjuk, hogy valamilyen "valós" (Haskell világában inkább racionálissá alakítható) számról képez,
és az eredmény valamilyen tört lesz.
A Real-be az Int, Integer, Double, Float is beletartozik.
A Fractional-be pedig a Double és a Float tartozik bele.

Vegyük elő megint a one-t és a three-t.
-}

one :: Int
one = 1

three :: Integer
three = 3

-- Hogyan csináljunk 4-et a one és a three felhasználásával? (one + three) kéne, csak az nem típushelyes.
four = undefined
-- Mi lesz a típusa a four-nak?

{-
Ellenőrző kérdés, az alábbi átalakítások közül melyiket melyik függvény tudja elvégezni?

Int -> Integer
Integer -> Double
Float -> Double
Double -> Double
Double -> Integer
-}

{-
Nem mindegyik fajta átalakítás veszteségmentes (már az előző esetben is probléma van, ha Integer-ről alakítunk Int-re vagy Double-ről Float-ra),
ha törtről alakítunk egészre, akkor a törtrésszel nem tudunk kezdeni semmit, csak elfelejteni lehet. Épp ezért ezeknek muszáj külön függvényt definiálni,
amelyekkel a törtértékeket kerekíteni tudjuk bizonyos módon egészre.

A RealFrac osztályban a Float és a Double van.

floor :: (RealFrac a, Integral b) => a -> b
A floor függvény egy törtszámot a tőle kisebbegyenlő legnagyobb egész számra kerekíti.
pl. floor 2.5 == 2; floor 4 == 4; floor 6.99 == 6
Mennyi lesz floor (-4.89)?

ceiling :: (RealFrac a, Integral b) => a -> b
A ceiling függvény egy törtszámot a tőle nagyobbegyenlő legkisebb egész számra kerekíti.
pl. ceiling 2.5 == 3; ceiling 3 == 3; ceiling 5.001 == 6
Mennyi lesz ceiling (-3.45)?

truncate :: (RealFrac a, Integral b) => a -> b
A truncate függvény egy törtszámnak elhagyja a törtrészét.
pl. truncate 2.5 == 2; truncate (-2.5) == (-2); truncate 2.99 == 2; truncate 2.0001 == 2; truncate (-2.0001) == (-2)
Mennyi lesz truncate 5?

round :: (RealFrac a, Integral b) => a -> b
"Megszokott" kerekítés, nem pontosan a matematikai, hanem az informatikai.
pl. round 0.25 == 0; round 3.4 == 3; round 3.5 == 4; round (-3.9) == (-4)
Mennyi lesz round 2.5?
-}


---------------------------------------
-- Rendezett pár (rendezett n-es)
---------------------------------------

-- Legyen egy új típusunk mára, ez legyen a rendezett pár (tuple, pair).
-- Előnye, hogy ha "több értéket kell visszaadni", akkor ezzel meg lehet tenni.
-- Akár több különböző típusú érték is lehet benne.

{-
A rendezett párok típusa az alábbi módon néz ki

data (a,b) = (a,b)

Konstruktor: (,) :: a -> b -> (a,b)
Párok komponenseinek elérése:
fst :: (a,b) -> a; ez a függvény a pár első komponensét adja vissza
snd :: (a,b) -> b; ez a függvény a pár második komponensét adja vissza

FIGYELEM! Az fst és snd CSAK RENDEZETT PÁROKON működik, rendezett 3-ason, 4-esen, stb. nem! (Ahogy a típusa is mondja.)

Rendezett 3-as típusa:
data (a,b,c) = (a,b,c)

Rendezett 4-es típusa:
data (a,b,c,d) = (a,b,c,d)

A többit ez alapján ki lehet találni.

Mintailleszteni természetesen ugyanúgy a konstruktorra lehet, tehát a pár esetén a (,)-re.
                                                                    a 3-as esetén a (,,)-re.
                                                                    stb.

Pl.
sum2 :: (Integer,Integer) -> Integer
sum2 (x,y) = x + y

sum3 :: (Integer,Integer,Integer) -> Integer
sum3 (x,y,z) = x + y + z
-}

fst' :: (x, y) -> x
fst' (a, _) = a

-- Feladat:

-- Definiáld az incBoth függvényt, amely egy rendezett pár mindkét elemét megnöveli 1-gyel!
-- Definiáld az fst és snd-vel, illetve definiáld mintaillesztéssel is.

incBoth :: (Integer,Double) -> (Integer,Double)
incBoth (i, d) = (i + 1, d + 1)

incBoth' :: (Integer,Double) -> (Integer,Double)
incBoth' t = (fst t + 1, snd t + 1)
