# ExtraZH #1

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

## Ugyanolyan paritásúak-e? (1 pont)

Definiáljuk az `areSameParity` függvényt, amely eldönti, hogy egy rendezett hármas mindhárom elemének azonos-e a paritása (azaz mindhárom esetben azonos-e a kettővel való osztás maradéka)!

```hs
areSameParity :: Integral a => (a, a, a) -> Bool
```

Tesztesetek:
```hs
areSameParity (0, 0, 0) == True
areSameParity (1, 0, 0) == False
areSameParity (0, 1, 0) == False
areSameParity (0, 0, 1) == False
areSameParity (1, 1, 1) == True
areSameParity (0, 1, 1) == False
areSameParity (1, 0, 1) == False
areSameParity (1, 1, 0) == False
areSameParity (0, 2, 4) == True
areSameParity (1, 3, 5) == True
areSameParity (-123456, 987654, -765432) == True
areSameParity (-234567, 876543, -654321) == True
areSameParity (-123456, 876543, -765432) == False
areSameParity (-234567, 987654, -654321) == False
```

## Elemek kiválasztása (2 pont)

Definiáljuk a `selectElems` függvényt, amely az első listából kiválasztja azokat az elemeket, amelyek helyén a második listában `True` áll!

```hs
selectElems :: [a] -> [Bool] -> [a]
```

Tesztesetek:
```hs
selectElems [] [] == []
selectElems [1] [] == []
selectElems [] [False] == []
selectElems [] [True] == []
selectElems [1] [False] == []
selectElems [1] [True] == [1]
selectElems "Hello!" [False,True,True,True,True,False] == "ello"
selectElems [1..] [True,False,True,False,True] == [1,3,5]
selectElems [1..10] [False,False ..] == []
selectElems [1..10] [True,True ..] == [1..10]
```

## Kongruens elemek (3 pont)

Definiáljuk a `congruentElems` függvényt, amely egy pozitív egész `M`-et, egy egész `X`-et és egy listát kap, majd kiválasztja a lista azon elemeit, amelyek `X`-szel modulo `M` kongruensek!

Az `A` és `B` szám modulo `M` kongruensek, ha `A mod M = B mod M`. Itt az `A mod M` az `A` szám `M`-mel való osztásának maradékát jelöli.

```hs
congruentElems :: Integral i => i -> i -> [i] -> [i]
```

Tesztesetek:
```hs
congruentElems 1 1 [] == []
congruentElems 2 1 [] == []
congruentElems 3 0 [] == []
congruentElems 3 3 [] == []
congruentElems 2 0 [1..10] == [2,4,6,8,10]
congruentElems 2 1 [1..10] == [1,3,5,7,9]
congruentElems 2 2 [1..10] == [2,4,6,8,10]
congruentElems 2 3 [1..10] == [1,3,5,7,9]
congruentElems 3 0 [1..10] == [3,6,9]
congruentElems 3 1 [1..10] == [1,4,7,10]
congruentElems 3 2 [1..10] == [2,5,8]
congruentElems 1 0 [1..10] == [1..10]
congruentElems 1 1 [1..10] == [1..10]
congruentElems 1 2 [1..10] == [1..10]
take 10 (congruentElems 5 2 [7,14..]) == [7,42,77,112,147,182,217,252,287,322]
```
