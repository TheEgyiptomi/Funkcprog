# ExtraZH #5

## Előzetes tudnivalók

Használható segédanyagok:
- [Haskell-könyvtárak dokumentációja](http://lambda.inf.elte.hu/haskell/doc/libraries/),
- [Hoogle](http://lambda.inf.elte.hu/haskell/hoogle/),
- [a tárgy honlapja](http://lambda.inf.elte.hu/Index.xml),
- [Haskell-szintaxis-összefoglaló](http://lambda.inf.elte.hu/CheatSheet.xml).

**Egyéb segédeszköz nem használható!**

Kérdéseiteket és észrevételeiteket a felügyelő oktatóknak jelezzétek, **ne** a diáktársaitoknak!

**FONTOS!**
- A függvényeket a leírásban megadott típusnak megfelelően kell definiálni.
- **Csak a teljesen jó megoldásért jár pont.**
- A hiányos vagy hibás részeket kommentben tüntessétek fel a feltöltött megoldásban.
- A teszteseteket körültekintően írjuk meg, de nem feltétlenül fedik le a függvény teljes működését. Ezért beadás előtt próbáljátok ki a megoldásotokat további esetekkel is!

A *Visual Studio Code Haskell Syntax Highlighting* bővítmény megtalálható a csatolt fájlok között.

Telepítés menete:

1. Nyissátok meg a bal oldali Bővítmények panelt a négy kis négyzet ikonjára kattintva, vagy használjátok a `Ctrl + Shift + X` billentyűparancsot.
2. Kattintsatok a megnyíló panel jobb felső sarkában lévő `...` gombra.
3. Válasszátok az `Install from VSIX...` lehetőséget, majd keressétek meg és válasszátok ki a letöltött fájlt.

## Legalább három, legfeljebb hat elemű listák (1 pont)

Definiáljuk a `haveAtLeastThreeAndMostSixElems` függvényt, amely eldönti, hogy egy lista legalább 3, de legfeljebb 6 elemű-e!

```hs
haveAtLeastThreeAndMostSixElems :: [a] -> Bool
```

Tesztesetek:
```hs
haveAtLeastThreeAndMostSixElems [] == False
haveAtLeastThreeAndMostSixElems [1] == False
haveAtLeastThreeAndMostSixElems [1,2] == False
haveAtLeastThreeAndMostSixElems [1,2,3] == True
haveAtLeastThreeAndMostSixElems [1,2,3,4] == True
haveAtLeastThreeAndMostSixElems [1,2,3,4,5] == True
haveAtLeastThreeAndMostSixElems [1,2,3,4,5,6] == True
haveAtLeastThreeAndMostSixElems [1,2,3,4,5,6,7] == False
haveAtLeastThreeAndMostSixElems [1,2,3,4,5,6,7,8] == False
haveAtLeastThreeAndMostSixElems [1..100] == False
haveAtLeastThreeAndMostSixElems [1..] == False
haveAtLeastThreeAndMostSixElems "" == False
haveAtLeastThreeAndMostSixElems "a" == False
haveAtLeastThreeAndMostSixElems "ab" == False
haveAtLeastThreeAndMostSixElems "abc" == True
haveAtLeastThreeAndMostSixElems "abcd" == True
haveAtLeastThreeAndMostSixElems "abcde" == True
haveAtLeastThreeAndMostSixElems "abcdef" == True
haveAtLeastThreeAndMostSixElems "abcdefg" == False
haveAtLeastThreeAndMostSixElems "abcdefgh" == False
haveAtLeastThreeAndMostSixElems ['a'..'z'] == False
haveAtLeastThreeAndMostSixElems ['a'..] == False
```

## Fura fésülés (2 pont)

Definiáljuk a `weirdInterleave` függvényt, amely a következő minta szerint fésüli össze két lista elemeit: vesz 1 elemet az első listából, majd 2 elemet a másodikból, és ezt ismétli.

Ha az egyik listából elfogynak az elemek, fűzzük hozzá a másik lista fennmaradó elemeit. Ha a második listából már csak egy elem maradt, fűzzük be azt, majd az első lista összes fennmaradó elemét.

```hs
weirdInterleave :: [a] -> [a] -> [a]
```

Tesztesetek:
```hs
weirdInterleave [] [] == []
weirdInterleave [1] [] == [1]
weirdInterleave [] [2] == [2]
weirdInterleave [1] [2] == [1,2]
weirdInterleave [1] [2,3] == [1,2,3]
weirdInterleave [1,4] [2,3] == [1,2,3,4]
weirdInterleave [1,4] [2,3,5] == [1,2,3,4,5]
weirdInterleave [1,4] [2,3,5,6] == [1..6]
weirdInterleave "HlWl" "elo ord!" == "Hello World!"
take 10 (weirdInterleave [1,1..] [2,2..]) == [1,2,2,1,2,2,1,2,2,1]
take 10 (weirdInterleave ['0','0'..] ['A'..]) == "0AB0CD0EF0"
```

## Listák metszete (3 pont)

Definiáljuk az `intersection` függvényt, amely megadja két lista metszetét!

A megoldásban ne használjuk a `Data.List` modul `intersect` függvényét.

Feltehetjük, hogy mindkét lista véges, és hogy egy lista minden eleme csak egyszer szerepel benne.

```hs
intersection :: Eq a => [a] -> [a] -> [a]
```

A tesztek a `Data.List.sort` függvénnyel rendezik az eredményt, mert annak sorrendje nincs megkötve:
```hs
intersection [] [] == []
intersection [1,2,3] [] == []
intersection [] [1,2,3] == []
Data.List.sort (intersection [1,2,3] [1,2,3]) == [1,2,3]
Data.List.sort (intersection [1,2,3] [1,2,3,4]) == [1,2,3]
Data.List.sort (intersection [1,3] [1,2,3]) == [1,3]
Data.List.sort (intersection [1,2,3] [3,2,1]) == [1,2,3]
Data.List.sort (intersection [1..10] [1..10]) == [1..10]
Data.List.sort (intersection [1..10] [10,9..1]) == [1..10]
Data.List.sort (intersection [1..20] [15..25]) == [15..20]
Data.List.sort (intersection [1..20] [25,24..15]) == [15..20]
```
