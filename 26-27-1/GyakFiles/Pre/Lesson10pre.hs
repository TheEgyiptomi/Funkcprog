module Lesson10 where

-- Definiáld a map'' függvényt listagenerátorral!

------------------------------
-- Milyen más függvényeket lehet még így általánosítani?
-- Nézzünk ezekre is példát.

-- Definiáld a moreThan2 függvényt rekurzívan, amely egy számokat tartalmazó listából megtartja a 2-nél nagyobbakat.
moreThan2 :: undefined
moreThan2 = undefined

-- Definiáld az onlyLower függvényt rekurzívan, amely egy szövegből csak a kisbetűket tartja meg.
onlyLower :: undefined
onlyLower = undefined

-- Itt is lehetne még sok példafeladatot felírni, de az előzőek alapján remélhetőleg érthető, hogy mi a cél.

-- Definiáld a filter' függvényt, amely adott tulajdonsággal rendelkező elemeket tart meg a listából.
filter' :: undefined
filter' = undefined

-- Definiáld a filter'' függvényt listagenerátorral.
filter'' :: undefined
filter'' = undefined

-- Definiáld a mapFilter függvényt rekurzívan és listagenerátorral. Csak azon elemekre alkalmazzuk a map-ot, amelyek a szűrés után megmaradtak.
-- Melyiket kényelmesebb definiálni?
mapFilter :: undefined
mapFilter = undefined

mapFilter' :: undefined
mapFilter' = undefined

-- Definiáld a zipWith' függvényt, amely egy adott művelet alapján teszi össze az elemeket párhuzamosan haladva két listán.
-- A függvény a rövidebb lista hosszáig működik. Amelyikben több elem van, azokat eldobjuk.
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' = undefined
-- Hogy kapjuk vissza az eredeti zip függvényt ezzel a függvénnyel?

-- Definiáld az indexedZipWith függvényt, amely ugyanazt csinálja, mint a zipWith, csak a függvényparaméter paramétereként átvesszük az adott két elem indexét is.
indexedZipWith :: Integral i => (i -> a -> b -> c) -> [a] -> [b] -> [c]
indexedZipWith = undefined

-- Definiáld a ($$) függvényt, amely egy függvényt alkalmaz egy értékre.
infixr 0 $$
($$) :: (a -> b) -> a -> b
f $$ a = undefined
-- Az eredeti függvény a ($).

{-
Azt már az év elején megbeszéltük, hogy a prefixen használt függvények kötési erőssége a legerősebb.
Ez a mondat ebben a formában nem teljesen igaz.
Korábban láthattuk, hogy teljesen nyugodtan zárójelezhetek balra egy kifejezést, az nem változtat semmin, pl.
mod 3 2 == (mod 3) 2
Ami valójában itt kiderül, hogy maga a függvényalkalmazás művelete egy legerősebben balra kötő operátor.
Mivel funkcionális programozásban a leggyakoribb művelet a függvényalkalmazás, ezért ez egy láthatatlan operátor, így a lehető legkevesebb karaktert igényli (0 db-ot egészen pontosan).
Azzal, hogy ez az operátor jobbra köt leggyengébben, de ugyanúgy a függvényalkalmazást csinálja, ennek van egy következménye,
még pedig az, hogy a jobbra zárójelezett kifejezésekről elhagyhatom a zárójelet, ha helyette használom a ($)-t.

Példa:
Előző órán volt az add függvény, amely az alábbi módon lett definiálva.

add :: Num a => Maybe a -> Maybe a -> Maybe a
add (Just x) (Just y) = Just (x + y)
add _        _        = Nothing

Látjuk, hogy a Just-os ágon az eredménykifejezés jobbra van zárójelezve. Ez azt jelenti, hogy a zárójelet elhagyhatom (ha kiteszem a ($)-t) azon a ponton,
ahonnan a kifejezés jobbra van zárójelezve, tehát:

add :: Num a => Maybe a -> Maybe a -> Maybe a
add (Just x) (Just y) = Just $ x + y
add _        _        = Nothing

És pontosan ugyanúgy működik.

A másik haszna ennek az operátornak, hogy tudok hivatkozni magára a függvényalkalmazás operátorára (0 karakterrel nehéz bármire is hivatkozni, nincs neve),
így lehet olyan kifejezéseket definiálni, amik például egy adott értéket adnak át egy-egy függvénynek, mint például az alábbi feladatban.
-}

-- Definiáld az app2ToFunctions függvényt magasabb rendű függvényeket használva rekurzió nélkül, amely alkalmazza a 2-es értéket egy függvényeket tartalmazó lista minden függvényén.
app2ToFunctions :: Num a => [a -> b] -> [b]
app2ToFunctions = undefined

-- Definiáld a span' függvényt, amely kettébont egy listát ott, ahol egy adott tulajdonság már nem teljesül.
-- span' even [2,4,6,1,2,3,4] == ([2,4,6],[1,2,3,4])
-- span' (> 0) [5,4,3,2,1,0,-1,-2,-3] == ([5,4,3,2,1],[0,-1,-2,-3])
-- span' (< 0) [1,2,3,4] == ([],[1,2,3,4])
-- span' (> 0) [1,2,3,4] == ([1,2,3,4],[])
span' :: undefined
span' = undefined

-- Definiáld a takeWhile' függvényt, amely egy lista elejéről addig tartja meg az elemeket, amíg egy adott tulajdonság folyamatosan teljesül.
takeWhile' :: undefined
takeWhile' = undefined

-- Definiáld a dropWhile' függvényt, amely egy lista elejéről addig dobálja el az elemeket, amíg egy adott tulajdonság folyamatosan teljesül.
dropWhile' :: undefined
dropWhile' = undefined

-- Definiáld a find' függvényt, amely visszaadja az első adott tulajdonságú elemet egy listából, ha létezik olyan.
find' :: undefined
find' = undefined
-- Az eredeti függvény a Data.List-ben található.

-- Definiáld az findIndex' függvényt, amely visszaadja az első adott tulajdonságú elem indexét egy listából, ha létezik olyan.
-- Megj.: Ugyan fel lehet használni az előző függvényt erre, de nem célszerű.
findIndex' :: undefined
findIndex' = undefined
-- Megj.: Az eredeti függvény a Data.List-ben van, de csak Int-et ad vissza tetszőleges szám helyett, így a használata nem javallott.

-- Új ötlet, további általánosítások:

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
any' :: undefined
any' = undefined
-- Megjegyzés: Hogy lehetne az elem-et megírni az any-vel? (Remélhetőleg egyértelműen látszódik, hogy erősen hasonlítanak egymásra.)

elemViaAny :: undefined
elemViaAny = undefined

-- Definiáld az all' függvényt, amely ellenőrzi, hogy egy adott tulajdonság az összes listaelemre teljesül-e.
all' :: undefined
all' = undefined

-- Definiáld az or' függvényt, amely egy listányi Bool-t összevagyol.
or' :: undefined
or' = undefined

-- Definiáld az and' függvényt, amely egy listányi Bool-t összeésel.
and' :: undefined
and' = undefined

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

-- Létezik olyan fajta hajtogatás is, amely az egyes részeredményeket is visszaadja eredményként.
-- Ezt magyarul pásztázásnak hívjuk (bár az angol neve (scanning) sokkal értelmesebb).

-- Definiáljuk a jobbról való pásztázást!
-- scanr'' (:) [] "pásztáznivaló" == ["pásztáznivaló", "ásztáznivaló", "sztáznivaló", "ztáznivaló", "táznivaló", "áznivaló", "znivaló", "nivaló", "ivaló", "való", "aló", "ló", "ó", []]
-- scanr'' (+) 0 [1..10] == [55, 54, 52, 49, 45, 40, 34, 27, 19, 10, 0]

scanr'' :: undefined
scanr'' = undefined
-- Az eredeti függvény a scanr.
-- A scanr NEM MŰKÖDIK végtelen listával!

-- A scanr-ből hogyan kaphatjuk vissza a foldr műveletét?
-- Válasz:

-- Definiáljuk a balról való pásztázást!
-- scanl'' (\acc x -> x : acc) [] "pásztáznivaló" == [[], "p", "áp", "sáp", "zsáp", "tzsáp", "átzsáp", "zátzsáp", "nzátzsáp", "inzátzsáp", "vinzátzsáp", "avinzátzsáp", "lavinzátzsáp", "ólavinzátzsáp"]
-- scanl'' (+) 0 [1..10] == [0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55]
scanl'' :: undefined
scanl'' = undefined
-- Az eredeti függvény a scanl, de létezik scanl' is, amely a mohó változata a scanr-nek.
-- Meglepő módon a scanl működik végtelen listával!
-- A mohó változat is!

-- A scanl-ből hogyan kaphatjuk vissza a foldl műveletét?
-- Válasz:

-- A scan-eknek is létezik az 1-es változata, tehát scanr1 és scanl1.
-- Amire az 1-es változatoknál vigyázni kell, hogy nem lehet különböző típusú a bemeneti lista és az eredménylista,
-- hiszen a kezdőérték a bemeneti lista első eleme.

-- Mire használható a scan?
-- Definiáld a lucas függvényt, amely a Lucas-sorozatot reprezentálja végtelen listaként.
-- Az első elem legyen a 2, a második az 1, a többi elem a két előző összege.
lucas :: [Integer]
lucas = undefined

-- Definiáld az increasingMaximums függvényt, amely egy olyan részlistát ad vissza, amely az első elemtől kezdve az elemeket növekvő sorrendben tartalmazza.
-- increasingMaximums [] == []
-- increasingMaximums [1] == [1]
-- increasingMaximums [1,2] == [1,2]
-- increasingMaximums [1,0] == [1]
-- increasingMaximums [2,1,3] == [2,3]
-- increasingMaximums [2,0,1] == [2]
-- increasingMaximums [1,3,2,1,8,7,0] == [1,3,8]
increasingMaximums :: undefined
increasingMaximums = undefined

-- GONDOLKODÓS FELADAT:
-- Definiáld a foldl-et foldr-rel!
foldlViaFoldr :: ugyanazATípusaMintAFoldlnek
foldlViaFoldr = undefined
