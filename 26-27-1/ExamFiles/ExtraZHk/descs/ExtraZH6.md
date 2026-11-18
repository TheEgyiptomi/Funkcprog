# ExtraZH #6

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

## Megegyező előjelű koordináták (1 pont)

Definiáljuk a `sameSignCoordinates` függvényt, amely egy koordinátapárról eldönti, hogy mindkét koordináta nulla-e, vagy a két koordináta előjele azonos-e!

```hs
sameSignCoordinates :: (Num a, Ord a) => (a, a) -> Bool
```

Tesztesetek:
```hs
sameSignCoordinates (0, 0) == True
sameSignCoordinates (0, 1) == False
sameSignCoordinates (0, -1) == False
sameSignCoordinates (1, 0) == False
sameSignCoordinates (1, 1) == True
sameSignCoordinates (1, -1) == False
sameSignCoordinates (-1, 0) == False
sameSignCoordinates (-1, 1) == False
sameSignCoordinates (-1, -1) == True
sameSignCoordinates (1, 2) == True
sameSignCoordinates (1, -2) == False
sameSignCoordinates (-1, 2) == False
sameSignCoordinates (-1, -2) == True
sameSignCoordinates (1, 0.5) == True
sameSignCoordinates (1, -0.5) == False
sameSignCoordinates (-1, 0.5) == False
sameSignCoordinates (-1, -0.5) == True
sameSignCoordinates (1, 0.0001) == True
sameSignCoordinates (1, -0.0001) == False
sameSignCoordinates (-1, 0.0001) == False
sameSignCoordinates (-1, -0.0001) == True
```

## Ugyanolyan szomszédos elemek (2 pont)

Definiáljuk a `sameNeighbours` függvényt, amely eldönti, hogy van-e a listában két azonos szomszédos elem!

Feltehetjük, hogy ha a listában nincs két azonos szomszédos elem, akkor a lista véges.

```hs
sameNeighbours :: Eq a => [a] -> Bool
```

Tesztesetek:
```hs
sameNeighbours [] == False
sameNeighbours [1] == False
sameNeighbours [False] == False
sameNeighbours "a" == False
sameNeighbours [1,2] == False
sameNeighbours [1,1] == True
sameNeighbours [1,2,2,1] == True
sameNeighbours [True,False,True] == False
sameNeighbours [True,True,True] == True
sameNeighbours "helo!" == False
sameNeighbours "hello!" == True
```

## `N` csoportos összegzés (3 pont)

Definiáljuk a `sumGroupsOfN` függvényt, amely `N` elemű (`N` >= 1) csoportokra osztja a listát, majd visszaadja az egyes csoportok elemeinek összegét!

Az utolsó csoportban `N`-nél kevesebb elem is lehet.

```hs
sumGroupsOfN :: Num a => Int -> [a] -> [a]
```

Tesztesetek:
```hs
sumGroupsOfN 1 [] == []
sumGroupsOfN 1 [1] == [1]
sumGroupsOfN 1 [1,2] == [1,2]
sumGroupsOfN 1 [1,2,3] == [1,2,3]
sumGroupsOfN 1 [1,2,3,4] == [1,2,3,4]
sumGroupsOfN 1 [1,2,3,4,5] == [1,2,3,4,5]
sumGroupsOfN 1 [1,2,3,4,5,6] == [1,2,3,4,5,6]
sumGroupsOfN 1 [1..10] == [1..10]
sumGroupsOfN 2 [] == []
sumGroupsOfN 2 [1] == [1]
sumGroupsOfN 2 [1,2] == [3]
sumGroupsOfN 2 [1,2,3] == [3,3]
sumGroupsOfN 2 [1,2,3,4] == [3,7]
sumGroupsOfN 2 [1,2,3,4,5] == [3,7,5]
sumGroupsOfN 2 [1,2,3,4,5,6] == [3,7,11]
sumGroupsOfN 2 [1..10] == [3,7,11,15,19]
sumGroupsOfN 3 [] == []
sumGroupsOfN 3 [1] == [1]
sumGroupsOfN 3 [1,2] == [3]
sumGroupsOfN 3 [1,2,3] == [6]
sumGroupsOfN 3 [1,2,3,4] == [6,4]
sumGroupsOfN 3 [1,2,3,4,5] == [6,9]
sumGroupsOfN 3 [1,2,3,4,5,6] == [6,15]
sumGroupsOfN 3 [1..10] == [6,15,24,10]
take 10 (sumGroupsOfN 3 [1..]) == [6,15..87]
```
