# ExtraZH #3

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

## Legnagyobb háromból (1 pont)

Definiáljuk a `max3` függvényt, amely visszaadja a rendezett hármas legnagyobb elemét!

```hs
max3 :: Ord a => (a, a, a) -> a
```

Tesztesetek:
```hs
max3 (1, 2, 3) == 3
max3 (2, 3, 1) == 3
max3 (3, 1, 2) == 3
max3 (0, 0, 0) == 0
max3 (1, 2, 2) == 2
max3 (False, True, False) == True
max3 (False, True, True) == True
max3 (False, False, False) == False
max3 ('a', 'b', 'c') == 'c'
max3 ('b', 'c', 'a') == 'c'
max3 ('c', 'a', 'b') == 'c'
max3 ("Alfa", "Bravo", "Charlie") == "Charlie"
max3 ("Bravo", "Charlie", "Alfa") == "Charlie"
max3 ("Charlie", "Alfa", "Bravo") == "Charlie"
```

## Az elemek egyenlősége hármasával (2 pont)

Definiáljuk az `areTriosEqual` függvényt, amely eldönti, hogy a lista elejétől hármasával képzett csoportokban mindhárom elem egyenlő-e egymással!

Ha a lista hossza nem osztható hárommal, hagyjuk figyelmen kívül a végén fennmaradó elemeket.

```hs
areTriosEqual :: Eq a => [a] -> Bool
```

Tesztesetek:
```hs
areTriosEqual [] == True
areTriosEqual [1] == True
areTriosEqual [1,2] == True
areTriosEqual [1,2,3] == False
areTriosEqual [1,1,1] == True
areTriosEqual [1,1,1,2] == True
areTriosEqual [1,1,1,2,3] == True
areTriosEqual [1,1,1,2,3,4] == False
areTriosEqual [1,1,1,2,2,2] == True
areTriosEqual [1,1,1,2,2,2,3,3,3,4,4,4,5,5,5] == True
areTriosEqual "000AAAaaa" == True
```

## Egy elem indexe (3 pont)

Definiáljuk az `indexOf` függvényt, amely visszaadja a keresett elem első előfordulásának indexét a listában (az indexelés 0-tól kezdődik)!

Feltehetjük, hogy a keresett elem szerepel a listában.

Ne használjuk a `Data.List` modul `elemIndex` függvényét!

```hs
indexOf :: (Eq a, Num b) => a -> [a] -> b
```

Tesztesetek:
```hs
indexOf 0 [-10..10] == 10
indexOf 67 [18,68,23,91,35,92,67,29,95,34,67,12] == 6
indexOf 'o' "Hello world!" == 4
indexOf 'x' "the quick brown fox jumps over the lazy brown dog" == 18
indexOf False [False,False,True,False,True] == 0
indexOf True [False,False,True,False,True] == 2
indexOf "bar" ["foo","foo","bar","bar"] == 2
indexOf 0 ([1,2,3] ++ repeat 0) == 3
indexOf 'x' ("asdasdasd" ++ repeat 'x') == 9
indexOf False (replicate 20 True ++ repeat False) == 20
indexOf "hello" (repeat "hello") == 0
```
