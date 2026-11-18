# ExtraZH #8

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

## Két lista: az egyik legalább 2, a másik legalább 3 elemű (1 pont)

Definiáljuk a `haveAtLeastTwoAndThreeElems` függvényt, amely eldönti, hogy egy rendezett párban szereplő listák közül az egyik legalább 2, a másik pedig legalább 3 elemű-e!

A listák sorrendje nem számít; az alábbi esetek egyaránt teljesítik a feltételt:
- az első lista legalább 2, a második legalább 3 elemű;
- az első lista legalább 3, a második legalább 2 elemű.

```hs
haveAtLeastTwoAndThreeElems :: ([a], [b]) -> Bool
```

Tesztesetek:
```hs
haveAtLeastTwoAndThreeElems ([], []) == False
haveAtLeastTwoAndThreeElems ([], [1]) == False
haveAtLeastTwoAndThreeElems ([1], []) == False
haveAtLeastTwoAndThreeElems ([], [1,2]) == False
haveAtLeastTwoAndThreeElems ([1], [1]) == False
haveAtLeastTwoAndThreeElems ([1,2], []) == False
haveAtLeastTwoAndThreeElems ([], [1,2,3]) == False
haveAtLeastTwoAndThreeElems ([1], [1,2]) == False
haveAtLeastTwoAndThreeElems ([1,2], [1]) == False
haveAtLeastTwoAndThreeElems ([1,2,3], []) == False
haveAtLeastTwoAndThreeElems ([], [1,2,3,4,5]) == False
haveAtLeastTwoAndThreeElems ([1], [1,2,3,4]) == False
haveAtLeastTwoAndThreeElems ([1,2], [1,2,3]) == True
haveAtLeastTwoAndThreeElems ([1,2,3], [1,2]) == True
haveAtLeastTwoAndThreeElems ([1,2,3,4], [1]) == False
haveAtLeastTwoAndThreeElems ([1,2,3,4,5], []) == False
haveAtLeastTwoAndThreeElems ([], [1,2,3,4,5,6]) == False
haveAtLeastTwoAndThreeElems ([1], [1,2,3,4,5]) == False
haveAtLeastTwoAndThreeElems ([1,2], [1,2,3,4]) == True
haveAtLeastTwoAndThreeElems ([1,2,3], [1,2,3]) == True
haveAtLeastTwoAndThreeElems ([1,2,3,4], [1,2]) == True
haveAtLeastTwoAndThreeElems ([1,2,3,4,5], [1]) == False
haveAtLeastTwoAndThreeElems ([1,2,3,4,5,6], []) == False
haveAtLeastTwoAndThreeElems ("", "") == False
haveAtLeastTwoAndThreeElems ("", "bar") == False
haveAtLeastTwoAndThreeElems ("foo", "") == False
haveAtLeastTwoAndThreeElems ("foo", "bar") == True
haveAtLeastTwoAndThreeElems ([1..], []) == False
haveAtLeastTwoAndThreeElems ([1..], [1]) == False
haveAtLeastTwoAndThreeElems ([1..], [1,2]) == True
haveAtLeastTwoAndThreeElems ([], [1..]) == False
haveAtLeastTwoAndThreeElems ([1], [1..]) == False
haveAtLeastTwoAndThreeElems ([1,2], [1..]) == True
haveAtLeastTwoAndThreeElems ([1..], [1..]) == True
```

## Szorzatösszeg (2 pont)

Definiáljuk a `sumProduct` függvényt, amely összeszorozza a két lista azonos indexű elemeit, majd összeadja a szorzatokat. Ha a listák hossza eltér, a többletelemeket figyelmen kívül hagyja.

```hs
sumProduct :: Num a => [a] -> [a] -> a
```

Tesztesetek:
```hs
sumProduct [] [] == 0
sumProduct [1] [] == 0
sumProduct [] [1] == 0
sumProduct [1] [1] == 1
sumProduct [1,2] [1] == 1
sumProduct [1] [1,2] == 1
sumProduct [1,2] [1,2] == 5
sumProduct [1,2] [2,1] == 4
sumProduct [1..5] [5,4..1] == 35
sumProduct [9,6,7] [4,2,0] == 48
sumProduct [9,6,7] [4,1,1] == 49
```

## Minden `N`-edik elem elhagyása (3 pont)

Definiáljuk a `dropEveryNth` függvényt, amely elhagyja a lista minden `N`-edik elemét (`N` > 0)!

```hs
dropEveryNth :: Int -> [a] -> [a]
```

Tesztesetek:
```hs
dropEveryNth 1 [] == []
dropEveryNth 1 [1] == []
dropEveryNth 1 [1..10] == []
dropEveryNth 1 "hello" == ""
dropEveryNth 2 [] == []
dropEveryNth 2 [1] == [1]
dropEveryNth 2 [1..10] == [1,3..9]
dropEveryNth 2 "hello" == "hlo"
dropEveryNth 3 [] == []
dropEveryNth 3 [1] == [1]
dropEveryNth 3 [1..10] == [1,2,4,5,7,8,10]
dropEveryNth 3 "hello" == "helo"
take 10 (dropEveryNth 2 [1..]) == [1,3..19]
take 10 (dropEveryNth 19 ['X','X'..]) == replicate 10 'X'
```
