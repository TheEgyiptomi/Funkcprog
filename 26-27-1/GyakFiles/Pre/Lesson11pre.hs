module Lesson11 where

-- Emlékezzünk vissza az alábbi korábban definiált függvényekre:
-- sum, product, elem, (++), concat, any
{-
sum []     = 0
sum (x:xs) = x + sum xs

product []     = 1
product (x:xs) = x * product xs

elem _ []     = False
elem e (x:xs) = e == x || elem e xs

[]     ++ ys = ys
(x:xs) ++ ys = x : xs ++ ys
-}

-- Definiáld az any' függvényt, amely ellenőrzi, hogy létezik-e egy elem egy listában, amelyre egy adott tulajdonság teljesül.
any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (x:xs) = f x || any' f xs 
-- Megjegyzés: Hogy lehetne az elem-et megírni az any-vel? (Remélhetőleg egyértelműen látszódik, hogy erősen hasonlítanak egymásra.)

-- elem e xs = any' (== e) xs

elemViaAny :: Eq a => a -> [a] -> Bool
elemViaAny e xs = any' (== e) xs

-- Definiáld az all' függvényt, amely ellenőrzi, hogy egy adott tulajdonság az összes listaelemre teljesül-e.
all' :: (a -> Bool) -> [a] -> Bool
all' _ [] = True
all' = f (x:xs) = f x && all' f xs

-- Definiáld az or' függvényt, amely egy listányi Bool-t összevagyol.
or' :: [Bool] -> Bool
or' xs = any' id xs

-- Definiáld az and' függvényt, amely egy listányi Bool-t összeésel.
and' :: undefined
and' xs = all' id xs

-- Mindegyik függvény definíciója gyakorlatilag ugyanúgy néz ki.
-- Valami az üres listára, meg valami a legalább egy elemre. A rekurzió mindegyikben mindig az egy elemmel kevesebb maradék lista.
-- Hogyan lehetne általánosítani ezt az ötletet?
-- Megj.: Emlékezzünk vissza rá, hogy ilyen fajta rekurzió esetén merre zárójeleződött az eredménykifejezés!

-- Próbáljuk meg lépésenként általánosítani.
-- Amikor hiányzik valami, akkor vegyük hozzá a típushoz, meg a definícióhoz.
generalisedIdeaR :: undefined
generalisedIdeaR = undefined

-- Ezt a függvényt hívják foldr-nek!
-- Létezik a foldr' függvény is, amely a foldr-nek a mohó változata és amely a Data.Foldable modulban található.
-- A foldr' NEM MŰKÖDIK végtelen listával!

-- Természetesen nem csak ilyen fajta rekurziónk volt.
-- Emlékezzünk vissza a reverse-re.
{-
reverse = reverseAcc [] where
  reverseAcc acc []     = acc
  reverseAcc acc (x:xs) = reverseAcc (x:acc) xs

Az ötlet használható sum-mal is:
sum' = sumAcc 0 where
  sumAcc acc []     = acc
  sumAcc acc (x:xs) = sumAcc (acc + x) xs

Emlékezzünk, hogy ilyenkor az eredménykifejezés merre van zárójelezve!
Látszik a hasonlóság a függvények között?

Általánosítsuk ennek az ötletét is!
-}
generalisedIdeaL :: undefined
generalisedIdeaL = undefined

-- Ezt a függvényt hívják foldl-nek.
-- Létezik a foldl' függvény is, amely a foldl-nek a mohó változata és amely a Data.Foldable modulban található.
-- foldl helyett a foldl'-t érdemes használni!
-- pl. foldr  (+) 0 [1..100000000] futásidejű hibát okoz, mert túl nagy a kiértékeletlen kifejezés a lustaság miatt.
--     foldl  (+) 0 [1..100000000] szintén.
--     foldl' (+) 0 [1..100000000] viszont kiszámítható lesz, mert az akkumulált paramétert mohón kezeli, kiértékeli,
--                                 nem gyűjtögeti a kiértékeletlen kifejezéseket.

-- Ha megnézzük mindkét fold-ot, akkor lényegében mindkettő listát dolgoz fel.
-- Ha úgy tetszik, akkor ez a lista destruktora (más szavakkal iterátora, rekurzora, eleiminátora; mindegyik (kb) ugyanazt jelenti ebben a világban),
-- mert a függvény feldolgozza a lista összes elemét, szintaktikailag megkülönbözteti az összes listát egymástól.

-- A végtelen listás szabályok ugyanúgy érvényesek foldr és foldl-re is,
-- tehát a foldr tud működni végtelen listán, mert előbb használjuk a műveletet, mint a rekurziót,
-- a foldl nem tud működni végtelen listán, mert akkumulál, gyűjtöget.

-- Definiáljuk újra a fenti függvényeket foldr-et vagy foldl-et használva.

sumViaFold :: undefined
sumViaFold = undefined

productViaFold :: undefined
productViaFold = undefined

(+++) :: undefined
(+++) = undefined

concatViaFold :: undefined
concatViaFold = undefined

reverseViaFold :: undefined
reverseViaFold = undefined

elemViaFold :: undefined
elemViaFold = undefined

orViaFold :: undefined
orViaFold = undefined

andViaFold :: undefined
andViaFold = undefined

anyViaFoldr :: undefined
anyViaFoldr = undefined

allViaFold :: undefined
allViaFold = undefined

-- Definiáljuk a foldr1' függvényt, amely ugyanazt csinálja, mint a foldr,
-- csak a kezdőértéke a lista első eleme lesz.
-- Ez természetesen feltételezi, hogy a lista nem üres.
foldr1' :: undefined
foldr1' = undefined

-- Ugyanígy létezik foldl1 is.
foldl1' :: undefined
foldl1' = undefined

-- Ezekkel érdemes definiálni például az alábbi függvényt:
-- Definiáld a maximum' függvényt, amely egy visszaadja egy lista legnagyobb elemét.
-- Feltehető, hogy a lista nem üres és véges.
maximum' :: undefined
maximum' = undefined
-- Megj.: minimum hasonlóan definiálható.


-- Sok függvény (magasabb rendűek is) hasznos a parciális applikálással, vegyük például az alábbiakat.

-- Definiáld az id' függvényt, amely a paraméterét csak visszaadja eredményül.
id' :: undefined
id' = undefined

-- Definiáld a const' függvényt, amely egy két paraméteres függvény első paraméterét adja vissza eredményül mindig.
const' :: undefined
const' = undefined

-- Hogy lehet definiálni azt a függvényt, amely egy két paraméteres függvény második paraméterét adja vissza úgy, hogy
-- CSAK a const-ot és az id-t használjuk?
-- Megj.: A triviális definíció az lenne, hogy: const2 _ x = x; ezt hogy lehet megadni csak const-tal és id-vel?
const2 :: undefined
const2 = undefined

-- Definiáld a flip' függvényt, amely egy két paraméteres függvényt paramétereit felcseréli!
flip' :: undefined
flip' = undefined

-- Add meg a const2' függvényt, most a flip felhasználásával!
const2' :: undefined
const2' = undefined

-- Definiáld a curry' függvényt, amely egy rendezett párt váró függvény paraméterét szétbontja két önálló paraméterre.
curry' :: ((a, b) -> c) -> a -> b -> c
curry' = undefined

-- Definiáld az uncurry' függvényt, amely egy két paraméteres függvényt átalakít egy rendezett párt váró függvénnyé!
uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' = undefined

-- Definiáld az iterate' függvényt, amely egy végtelen listát állít elő úgy, hogy folyamatosan alkalmaz egy függvényt egy értéken,
-- és az egyes részeredményeket adjuk vissza a listában.
-- take 10 (iterate' (+1) 0) == [0,1,2,3,4,5,6,7,8,9]
-- take 10 (iterate' not True) == [True,False,True,False,True,False,True,False,True,False]
iterate' :: undefined
iterate' = undefined

-- Definiáld a repeat' függvényt az iterate' felhasználásával!
repeat' :: undefined
repeat' = undefined

{-
A funkcionális programozás erőssége a függvények komponálhatósága, egymás utáni alkalmazása.
Ehhez azonban szükségünk van magára erre a függvényre, amely két függvényt komponál ezzel létrehozva egy új függvényt.
A definíciója ugyanaz, mint matematikában, analízisben.
-}
(∘) :: undefined
(∘) = undefined
infixr 9 ∘
-- Az eredeti függvény neve (.)

-- Az alábbi feladatokban használjunk függvénykompozíciót!

-- Definiáld azt a függvényt, amely az [1,11,111,1111,11111,...] végtelen listát állítja elő.
numbersMadeOfOnes :: undefined
numbersMadeOfOnes = undefined

-- Definiáld azt a függvényt, amely a [3,33,333,3333,33333,...] végtelen listát állítja elő.
numbersMadeOfThrees :: undefined
numbersMadeOfThrees = undefined

-- Definiáld azt a függvényt, amely az [1,31,331,3331,33331,...] végtelen listát állítja elő.
numbersMadeOfThreesAndOne :: undefined
numbersMadeOfThreesAndOne = undefined

{-
Mivel Haskellben lehetséges a parciális applikálás, lehetséges, hogy a függvényeinket kompozíciókként adjuk meg a paraméterek felvétele nélkül.
pl.

times2plus1 :: Num a => a -> a
times2plus1 x = 2 * x + 1

helyett tudjuk azt, hogy ez a művelet valójában csak két függvény kompozíciójából áll és tudjuk úgy definiálni, hogy:

times2plus1 = (+1) . (2*)
és a két függvény teljesen ugyanaz.

Először a számot meg kell szorozni kettővel, majd utána hozzá kell adni egyet.
A kompozíció matematikai érdekessége, hogy míg mi természetes módon balról jobbra olvasunk, addig a kompozíciókat jobbról balra kell olvasni
annak tekintetében, hogy mit csinál először és mit csinál utána. (Tehát a kompozíció művelete jobbra köt.)

Amikor nem veszünk fel paramétereket és úgy definiálunk függvényeket, azt szokás pointfree stílusnak nevezni.
-- SZÉP KÓD: Addig, amíg nem kell függvénykompozíciókat hegyén hátán használni, próbáljuk meg definiálni a függvényeket minél kevesebb paraméterfelvétellel.
             Meglepően tisztább és olvashatóbb lesz a kód.
Ezt egy példán keresztül megmutatva:
-}
-- Definiáld az any függvényt háromféleképpen. Az any ellenőrzi, hogy egy adott tulajdonságú elem megtalálható-e egy listában.
-- Segítség: Használd az or és a map függvényt a rövid definíció érdekében. Ne használj rekurziót és elágazást.
--           Az or függvény egy listányi Bool-t összevagyol.

-- Vegyük fel az összes paramétert!
any' :: (a -> Bool) -> [a] -> Bool
any' = undefined

-- Csak az első paramétert vegyük fel! (Megj.: Olyan nincs, hogy csak a második paramétert vegyük fel.)
any'' :: (a -> Bool) -> [a] -> Bool
any'' = undefined

-- Egy paramétert se vegyünk fel, pointfree adjuk meg!
any''' :: (a -> Bool) -> [a] -> Bool
any''' = undefined

-- A három definíció közül melyik a legrövidebb, de annyira, hogy a kódjának az értelmezése még intuitív maradjon?
-- Válasz:

-- Feladatok:

-- Definiáljunk egy másik fajta kompozíciót (pipeline), amely megoldja nekünk, hogy balról jobbra olvassunk,
-- tehát lényegében csak cseréljük meg a kompozíció olvasási irányát.
(|>) :: undefined
(|>) = undefined

infixl 9 |>
-- Ez a függvény nem létezik, így aki használni szeretné, annak másolgatnia kell a definícióját.

-- Definiáld a dropSpaces függvényt, amely eldobja csak a szóközöket egy szöveg elejéről.
dropSpaces :: undefined
dropSpaces = undefined

-- Definiáld a trim függvényt, amely eldobja csak a szóközöket egy szöveg elejéről és végéről.
-- Feltehető, hogy a szöveg véges.
trim :: undefined
trim = undefined

-- Definiáld a maximumOfMinimums függvényt! Adott egy listák listája. Keressük meg a legnagyobb elemet a legkisebbek közül.
-- Feltehető, hogy a lista, továbbá egyetlen eleme sem üres lista.
maximumOfMinimums :: undefined
maximumOfMinimums = undefined

-- Definiáld a mapMap függvényt, amely alkalmaz egy függvényt listák listájában levő elemekre!
mapMap :: undefined
mapMap = undefined

-- Adjuk meg egy névnek a kezdőbetűit, azokat szóközökkel elválasztva!
firstLetters :: undefined
firstLetters = undefined

-- Adjuk meg egy név monogramját! A monogram abban különbözik, hogy pont is van a kezdőbetűk után; minden más része ugyanaz, mint az előző feladatnak!
monogram :: undefined
monogram = undefined

-- Definiáld a sublists függvényt, amely visszaadja egy lista minden lehetséges részsorozatát.
-- Részsorozatnak tekintjük a közvetlen egymást követő elemeket az eredeti listában.
-- Pl. "abcd"-nek részsorozata a "bc", de az "acd" nem.
sublists :: undefined
sublists = undefined

-- Definiáld az until' függvényt, amely addig ismétel egy műveletet egy értéken, amíg az eredményre egy adott tulajdonság nem teljesül.
-- Az eredmény az első olyan érték, amire teljesül a feltétel.
-- Definiáljuk rekurzívan és magasabb rendű függvényekkel is!
-- until' (\x -> x `mod` 5 == 0) (+2) 1 == 5
-- until' (\x -> x `mod` 5 == 0) (+9) 5 == 5
-- until' isLower succ 'A' == 'a'
-- until' isLower succ 'B' == 'a'
until' :: undefined
until' = undefined

until'' :: undefined
until'' = undefined

-- Megjegyzés: Problémás az az eset, ha a feltétel soha nem fog teljesülni.
-- pl. until' (const False) (+1) 0
-- Hogyan lehetne azt megoldani?
-- Válasz:

until''' :: undefined
until''' = undefined
