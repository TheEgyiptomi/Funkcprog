# ExtraZH #7

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

## Gömb térfogata (1 pont)

Definiáljuk a `sphereVolume` függvényt, amely a gömb sugarából számítja ki a térfogatát!

A gömb térfogatának képlete: $ V = \frac{4}{3} \pi r^3 $

Negatív sugár esetén a függvény `0`-t adjon vissza!

```hs
sphereVolume :: (Floating a, Ord a) => a -> a
```

Tesztesetek:
```hs
abs (sphereVolume 0 - 0) <= 1e-6
abs (sphereVolume 1 - 4.1887902047863905) <= 1e-6
abs (sphereVolume 2 - 33.510321638291124) <= 1e-6
abs (sphereVolume 3 - 113.09733552923254) <= 1e-6
abs (sphereVolume 4 - 268.082573106329) <= 1e-6
abs (sphereVolume 5 - 523.5987755982989) <= 1e-6
abs (sphereVolume 6 - 904.7786842338603) <= 1e-6
abs (sphereVolume 7 - 1436.7550402417319) <= 1e-6
abs (sphereVolume 8 - 2144.660584850632) <= 1e-6
abs (sphereVolume 9 - 3053.6280592892786) <= 1e-6
abs (sphereVolume 10 - 4188.7902047863905) <= 1e-6
abs (sphereVolume (-1) - 0) <= 1e-6
abs (sphereVolume (-2) - 0) <= 1e-6
abs (sphereVolume (-3) - 0) <= 1e-6
abs (sphereVolume (-4) - 0) <= 1e-6
abs (sphereVolume (-5) - 0) <= 1e-6
abs (sphereVolume (-6) - 0) <= 1e-6
abs (sphereVolume (-7) - 0) <= 1e-6
abs (sphereVolume (-8) - 0) <= 1e-6
abs (sphereVolume (-9) - 0) <= 1e-6
abs (sphereVolume (-10) - 0) <= 1e-6
abs (sphereVolume 0.5 - 0.5235987755982988) <= 1e-6
abs (sphereVolume 1.5 - 14.137166941154068) <= 1e-6
abs (sphereVolume 2.5 - 65.44984694978736) <= 1e-6
abs (sphereVolume pi - 129.87878804533656) <= 1e-6
abs (sphereVolume 3.5 - 179.594380030432) <= 1e-6
```

## Listahosszak szorzata (2 pont)

Definiáljuk a `productOfLengths` függvényt, amely a listák hosszának szorzatát számítja ki!

Feltehetjük, hogy a külső lista és az abban szereplő belső listák is végesek.

```hs
productOfLengths :: [[a]] -> Int
```

Tesztesetek:
```hs
productOfLengths [] == 1
productOfLengths [[]] == 0
productOfLengths [[1]] == 1
productOfLengths [[1,2]] == 2
productOfLengths [[1],[1]] == 1
productOfLengths [[1,2],[4,3]] == 4
productOfLengths [[1..2],[1..3],[1..5],[1..7]] == 210
productOfLengths ["hello"] == 5
productOfLengths ["hello","world"] == 25
productOfLengths ["foo","bar","foo","bar"] == 81
productOfLengths [[True,False],[False,True,False,True],[False],[True,True],[True,False,True]] == 48
```

## Csak kisbetűs magánhangzók és nagybetűs nem magánhangzók (3 pont)

Definiáljuk az `onlyLowercaseVowelsAndUppercaseNonVowels` függvényt, amely egy szövegből csak a kisbetűs magánhangzókat és a nagybetűs nem magánhangzókat tartja meg! (Ki gondolta volna?)

Csak az `'a'`, `'e'`, `'i'`, `'o'` és `'u'` karaktereket, valamint nagybetűs megfelelőiket tekintsük magánhangzónak!

Használjuk a `Data.Char` modul `isLower` és `isUpper` függvényeit!

```hs
onlyLowercaseVowelsAndUppercaseNonVowels :: String -> String
```

Tesztesetek:
```hs
onlyLowercaseVowelsAndUppercaseNonVowels "" == ""
onlyLowercaseVowelsAndUppercaseNonVowels "aeiou" == "aeiou"
onlyLowercaseVowelsAndUppercaseNonVowels "AEIOU" == ""
onlyLowercaseVowelsAndUppercaseNonVowels "aEiOu" == "aiu"
onlyLowercaseVowelsAndUppercaseNonVowels "AeIoU" == "eo"
onlyLowercaseVowelsAndUppercaseNonVowels "Hello World!" == "HeoWo"
take 26 (onlyLowercaseVowelsAndUppercaseNonVowels ['A'..]) == "BCDFGHJKLMNPQRSTVWXYZaeiou"
```
