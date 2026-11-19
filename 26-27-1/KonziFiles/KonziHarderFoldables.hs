module KonziHarderFoldables where

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
