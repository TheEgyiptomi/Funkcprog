# ExtraZH #2

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

## Collatz-függvény (1 pont)

Definiáljuk a `collatzFn` függvényt, amely a páros számokat elfelezi, a páratlanokat pedig megszorozza 3-mal, majd hozzáad 1-et!

```hs
collatzFn :: Integral a => a -> a
```

Tesztesetek:
```hs
collatzFn 0 == 0
collatzFn 1 == 4
collatzFn 2 == 1
collatzFn 3 == 10
collatzFn 4 == 2
collatzFn 5 == 16
collatzFn 6 == 3
collatzFn 7 == 22
collatzFn 8 == 4
collatzFn 9 == 28
collatzFn 10 == 5
collatzFn 67 == 202
collatzFn 420 == 210
```

## Szomszédok összegzése (2 pont)

Definiáljuk a `sumNeighbours` függvényt, amely kiszámítja a listában egymás mellett álló elempárok összegét!

```hs
sumNeighbours :: Num a => [a] -> [a]
```

Tesztesetek:
```hs
sumNeighbours [] == []
sumNeighbours [1] == []
sumNeighbours [1,2] == [3]
sumNeighbours [1,2,3] == [3,5]
sumNeighbours [1,2,3,4] == [3,5,7]
sumNeighbours [1,2,3,4,5] == [3,5,7,9]
sumNeighbours [1,2,3,4,5,6] == [3,5,7,9,11]
sumNeighbours [1,1,1,1] == [2,2,2]
sumNeighbours [1,0,1,0,1] == [1,1,1,1]
take 10 (sumNeighbours [1..]) == [3,5..21]
```

## Intervallumbeli elemek (3 pont)

Definiáljuk az `elemsInRange` függvényt, amely kiválasztja a listából azokat az elemeket, amelyek a két végponttal megadott zárt intervallumba esnek!

Ha az intervallum vége kisebb a kezdeténél, cseréljük fel a két végpontot.

```hs
elemsInRange :: Ord a => (a, a) -> [a] -> [a]
```

Tesztesetek:
```hs
elemsInRange (0, 0) [] == []
elemsInRange (0, 1) [] == []
elemsInRange (1, 0) [] == []
elemsInRange (0, 1) [0] == [0]
elemsInRange (1, 0) [0] == [0]
elemsInRange (0, 0) [0,1,-1,0] == [0,0]
elemsInRange (3, 7) [1,4,6,0,8,5,9,3,7,2] == [4,6,5,3,7]
elemsInRange (7, 3) [1,4,6,0,8,5,9,3,7,2] == [4,6,5,3,7]
elemsInRange (5, 10) [0..20] == [5..10]
elemsInRange (10, 5) [0..20] == [5..10]
elemsInRange ('e', 'v') ['a'..'z'] == ['e'..'v']
elemsInRange ('v', 'e') ['a'..'z'] == ['e'..'v']
```
