# ExtraZH #4

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

## Egy szám környezete (1 pont)

Definiáljuk a `neighbourhood` függvényt, amely két egész számot, `X`-et és `R`-et kap, és visszaadja az `X` középpontú, `R` sugarú környezetet!

Az eredmény az `X-R`-től `X+R`-ig tartó számsor, mindkét végponttal együtt.

`R` negatív is lehet; ilyenkor a számsor csökkenő sorrendű.

```hs
neighbourhood :: Integral a => a -> a -> [a]
```

Tesztesetek:
```hs
neighbourhood 0 0 == [0]
neighbourhood 0 1 == [-1,0,1]
neighbourhood 0 (-1) == [1,0,-1]
neighbourhood 0 2 == [-2,-1,0,1,2]
neighbourhood 0 (-2) == [2,1,0,-1,-2]
neighbourhood 1 0 == [1]
neighbourhood 1 1 == [0,1,2]
neighbourhood 1 (-1) == [2,1,0]
neighbourhood 1 2 == [-1,0,1,2,3]
neighbourhood 1 (-2) == [3,2,1,0,-1]
neighbourhood 6 7 == [-1..13]
neighbourhood 6 (-7) == [13,12..(-1)]
```

## Minden második összefűzése (2 pont)

Definiáljuk a `concatEverySecond` függvényt, amely egy listák listájából a második, negyedik és további páros sorszámú listákat fűzi össze!

```hs
concatEverySecond :: [[a]] -> [a]
```

Tesztesetek:
```hs
concatEverySecond [] == []
concatEverySecond [[1,2]] == []
concatEverySecond [[1,2],[3,4]] == [3,4]
concatEverySecond [[1,2],[3,4],[5,6]] == [3,4]
concatEverySecond [[1,2],[3,4],[5,6],[7,8]] == [3,4,7,8]
concatEverySecond ["1","2","3","4","5","6"] == "246"
concatEverySecond ["foo","Hello, ","bar","World!","foo"] == "Hello, World!"
```

## Elem törlése (3 pont)

Definiáljuk a `deleteElem` függvényt, amely egy elem összes előfordulását törli egy listából!

```hs
deleteElem :: Eq a => a -> [a] -> [a]
```

Tesztesetek:
```hs
deleteElem 1 [] == []
deleteElem 1 [1] == []
deleteElem 1 [2] == [2]
deleteElem 1 [1..10] == [2..10]
deleteElem 42 [50,46..30] == [50,46] ++ [38,34,30]
deleteElem 67 [58,16,67,59,69,67,42] == [58,16,59,69,42]
deleteElem 'a' "almafa" == "lmf"
deleteElem 'l' "Hello world!" == "Heo word!"
deleteElem False [False,True,True,True,False,False,False,True] == [True,True,True,True]
```
