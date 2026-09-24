module Lesson09 where

-- Rögtön az elején leírom, hogy két módon lehet saját típust létrehozni. Vagy a "newtype" kulcsszóval vagy a "data" kulcsszóval.
-- Amilyen példák voltak eddig korábban, azok mind datával voltak megadva, továbbá a tárgy során a data lesz használva.
-- Amit csinál a newtype, azt meg tudja csinálni a data is.
-- Akit érdekel esetleg a különbség a kettő között, konzultáción tudunk beszélgetni róla.

------------------------------
-- Saját típus: data
------------------------------

{-
Eddig volt szó listáról, rendezett n-esről, Int-ről, Integer-ről, Char-ról, Float-ról, Double-ről, Bool-ról, mint konkrét típusokról.
Azonban ezekkel nem lehet mindent pontosan úgy elkódolni, ahogy mi szeretnénk; továbbá saját típussal sokkal olvashatóbban reprezentálhatók
egyes műveletek eredményei, pl. tegyük fel, hogy egy elemet feltételesen szeretnénk beilleszteni egy listába. Ezen függvény típusa nagyjából az lenne, hogy:

conditionalInsert :: Bool -> a -> [a] -> [a]

Most honnan tudjuk, hogy a False, meg a True ez esetben mit reprezentál? Abban a pillanatban, hogy megírjuk, még emlékszünk rá; nézzünk rá egy év múlva
csak a típusra és arra, ahol és ahogyan használjuk. Valahol kódban látunk egy olyat, hogy `conditionalInsert True 1 [2,3,4]`, nem hiszem, hogy
emlékeznénk rá csak olvasással.
Helyette tudunk egy saját típust definiálni:

data InsertFlag = Insert | DoNotInsert

conditionalInsert :: InsertFlag -> a -> [a] -> [a]

Így a típusból egyből látszódik, hogy mit szeretne a függvény, illetve ha használjuk: `conditionalInsert Insert 1 [2,3,4]`, olvasásra egyből látszódik,
hogy mit szeretnénk az értékkel csinálni.
Maga a saját típus lényegében egy Bool, de mégis egy sokkal olvashatóbb változatát adtuk meg.

----------------

Ahogy korábban is láttuk megadva, saját típust definiálni a "data" kulcsszóval lehet. Szintaxisa az alábbi:

data <Új típus neve> [típusváltozók...] = <Konstruktor1> [paraméterek...] | <Konstruktor2> [paraméterek...] | ...

Nem kötelező típusváltozót megadni (de lehet, arról is lesz szó), továbbá a konstruktoroknak lehet, hogy van paraméterük, lehet, hogy nincs.
-}

-- Feladatok:
-- Definiáld a Day típust, amelynek 7 paraméter nélküli konstruktora van: Mon, Tue, Wed, Thu, Fri, Sat, Sun.



-- Kérdezzük meg ghci-től, hogy mi lesz a Fri konstruktor típusa!
-- A konstruktorok ugyanolyan értékek/függvények, mint a többi. Annyiban speciálisak a konstruktorok, hogy ezekre lehet mintailleszteni.

-- Definiáld a nextDay függvényt, amely egy adott napnak megadja, hogy mi a rákövetkező napja.
-- Segítség: Konstruktorokkal mit lehet csinálni?
nextDay :: undefined
nextDay = undefined

{-
Próbáljuk meg a ghci-ben meghívni a nextDay függvényt.
Mi lesz az eredménye annak, hogy `nextDay Sun`?

-----------------------------------

Ha kipróbáltuk, hogy mi történik, akkor azt tapasztaltuk, hogy hibát kaptunk.
A probléma az, hogy a GHCi nem tudja megjeleníteni a saját típusunkat, mert nem mondtuk meg neki, hogy hogyan kell vagy hogy meg lehet jeleníteni egyáltalán.
Ha szeretnénk, hogy a saját típusunk megjeleníthető legyen, akkor erről a tényről a fordítót is tájékoztatni kell a következő módon:
A saját típusunk definíciója után a "deriving" kulcsszót kell rakni, majd utána azt a típusosztályt odaírni, amelyik a megjelenítésért felelős; ez a Show.
-}

-- Módosítsd a Day típust úgy, hogy a ghci meg tudja jeleníteni azt.

{-
A deriving után legfeljebb 7 típusosztály írható rendezett n-es stílusban (alapból, mindenféle mágiázás nélkül), ezek a következők:
- Show: értéket alakít String-gé
- Read: String-et alakít értékké, ha tudja
- Eq: egyenlőségvizsgálat
- Ord: rendezhetőség
- Enum: felsorolhatóság
- Bounded: korlátos
- Ix: indexelésre használt típus

Most próbáljuk meg a `nextDay Sun` kifejezést kiértékelni!
-------------------------
Saját típusokkal is természetesen tudjuk példányosítani a típusosztályokat. Ehhez nem kell mást tenni, mint:

instance <Típusosztály> <Típus> where
  <bentebb húzva megírni a szükséges függvényeket>

Hogy melyik típusosztálynak milyen függvényei vannak, azt a :i-vel meg lehet nézni.

pl.
> :i Eq
type Eq :: Type -> Constraint
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  {-# MINIMAL (==) | (/=) #-}
  	-- Defined in ‘GHC.Classes’
instance forall a. Eq a => Eq (Maybe a) -- Defined in ‘GHC.Maybe’
...
instance forall a b. (Eq a, Eq b) => Eq (Either a b) -- Defined in ‘Data.Either’

Innen nekünk csak az eleje fontos, a "-- Defined in GHC.Classes"-ig.

Ebből két dolgot is látni:
- Az Eq osztályba az (==) és a (/=) tartozik.
- A MINIMAL sor megmondja, hogy melyik függvényeket KELL implementálni. A vesszővel való elválasztás és kapcsolatot, a |-pal való elválasztás pedig egy vagy kapcsolatot jelöl.
  Eq esetén ez azt jelenti, hogy VAGY az (==)-t VAGY a (/=)-t kell implementálni.

-- SZÉP KÓD: Ugyan a vagy kapcsolat nem zárja ki, hogy mindkét függvényt implementáljuk,
             de a legsűrűbb esetben nem érdemes vaggyal elválasztott függvény mindkét felét implementálni.
-}

-- Példányosítsuk kézzel az Eq osztályt a Day típusra!



-- Saját Show instance példa:
-- Definiáld a Colour típust, amelynek legyen 4 konstruktora: Red, Green, Yellow, Blue


-- Definiálj a Colour típusra saját Show példányt, amely a névvel azonos színű #-karaktert ír ki a terminálba.
-- Írd felül a showList működését úgy, hogy a #-eket egy '‾' karakter kösse össze.

-- piros "\ESC[0;91m#\ESC[0m"
-- zöld "\ESC[0;92m#\ESC[0m"
-- sárga "\ESC[0;93m#\ESC[0m"
-- kék "\ESC[0;94m#\ESC[0m"

-- [Red, Green, Red, Yellow, Blue, Green, Yellow, Red, Blue]
-- putStrLn (shows [Red, Green, Red, Yellow, Blue, Green, Yellow, Red, Blue] "@-c")

------------------------------------------
-- Paraméteres konstruktorok
------------------------------------------

{-
Ahogy a rendezett pároknak, meg ahogy a listáknak is vannak olyan konstruktoraik, amik paramétereket várnak (pl. (,) és (:)),
úgy mi is tudunk ilyeneket definiálni.
-}

-- Például: a modern vívásban három fegyvernem van, ezek a Kard (~ Sabre), a Tőr (~ Foil) és a Párbajtőr (~ Epeé).
-- Deifiniáld a Disciplines típust, amelynek legyen a három konstruktora a három fegyvernem: Sabre, Foil, Epeé
-- Ez után definiáld a Event típust, amelyenek egy konstruktora van: Event, és ennek két paramétere legyen: egy Discipline és egy Integer
-- Ez a típus léyegében azt írja le hogy egy versenyszámon hány versenyző van.
-- Megjegyzés: Ki fog derülni a következő feladatból, hogy így azért nem az igazi ez a típus; meg lehet ezt oldani jobban is.



-- Kérdezzük meg ghci-től, hogy mi lesz az Event konstruktor típusa!

-- Definiáld a sumComp függvényt, amely megszámolja egy listányi Event-ben, hogy hány darab versenyzőnk van.
-- Nem válogatjuk külön a versenyzőket, csak a versenyzők száma az érdekes összesen.
sumComp :: undefined
sumComp = undefined

-- Definiáld az sumDifferentDisciplines függvényt, amely összeadja egy listányi Event-ben, hogy a különböző fegyvernemekből hány darabunk van.
-- Ez előtt tegyük egy kicsit beszédesebbé a típust. Definiálj 3 típusszinonimát Integer-re: NumberOfSabres', NumberOfFoilis', NumberOfEpeés'

-- sumDifferentDisciplines :: [Event] -> (NumberOfSabres',NumberOfFoils',NumberOfEpeés')
sumDifferentDisciplines = undefined

-- A függvény írása közben esetleg tapasztalható, hogy senki nem állít meg abban, hogy a kardozókat hozzáadjam a tőrozőkhöz.

-- Ennek egy megoldása ugyan egyszerű, de körülményes.
-- Definiáld a NumberOfSabres, NumberOfFoils, NumberOfEpeés típusokat, mindhárom típusnak legyen egy konstruktora a típussal azonos névvel, azoknak egy Integer paramétere.

-- SZÉP KÓD: Ha egy típusnak pontosan egy konstruktora van, akkor az a legsűrűbb esetben jó, ha azonos nevű a típussal.
--           Ez nem probléma, hogy a konstruktor azonos nevű a típussal, hiszen a típus és az értékkonstruktorok két külön névtérben élnek.




-- A fenti három típus legyen a Num osztály példánya és a műveletek működjenek pontosan ugyanúgy, mint az Integer-en.




-- Definiáljuk újra a sumDifferentDisciplines' függvényt a helyes típussal. (Most már nehezebben lesz lehetséges összeadni az almákat a körtékkel, természetesen még mindig lehet.)
-- sumDifferentDisciplines' :: [Event] -> (NumberOfSabres,NumberOfFoils,NumberOfEpeés)
sumDifferentDisciplines' = undefined

-- Mi történne, ha a Disciplines típushoz hozzávennénk a párbajkardot is? Mit kéne csinálni?
-- És ha mondjuk még más fegyvernemeket is hozzávennénk?

-- A fenti kérdésekre adott remélhetőleg helyes válaszból kiderül, hogy túl körülményes így kezelni ezt.
-- Ennek a megoldása érdekes, nem nehéz, de túlmutat a tárgy keretein; konzultáció közben lehet erről is beszélgetni.

------------------------------------------------------------
-- Komplex számok reprezentálása

-- Nem analízisen/matalapon vagyunk, így nem mászunk bele nagyon mélyen a komplex számokba, minket a számítógépen való ábrázolása fog érdekelni.
{-
Aki esetleg nem ismeri, nem hallott róla:
A gyökvonás műveletét csak nemnegatív számokon lehet elvégezni; √4 = 2; √2 ≈ 1.414...
x² + x + 1 = 0, másodfokú képlettel azt kapjuk, hogy
       -1 ± √(1 - 4 * 1 * 1)   -1 ± √(-3)
x₁,₂ = ───────────────────── = ──────────; gyök alatt negatív szám szerepel, tehát az egyenletnek nincs valós megoldása.
               2 * 1               2

Hangsúly azon, hogy nincs VALÓS megoldása!

A komplex számok ebből az ötletből születtek, hogy "mi lenne, ha a gyök alatti negatív szám mégis értelmes lenne?"

A komplex egységet i-vel szokás jelölni, és azt tudjuk róla, hogy i² = -1 (tehát i = √(-1))
Így lényegében két dimenziós számokat kapunk, amelyeknek van valós része (azon részben nincs i), illetve van képzetes része (ahol van i).
Az ilyen komplex számok (halmaz jelölése: ℂ) formája a következő: a + b*i, ahol a,b ∈ ℝ

Hogyan reprezentáljuk ezt Haskellben? Könnyen! Saját típussal; látjuk, hogy az "a" és "b" részek külön meg vannak említve, így ezeket kell csak elkódolni.
(Ahol "a" a valós rész, "b" a képzetes rész.)

Definiáljunk egy saját típust Complex névvel, ami a komplex számokat reprezentálja! Az egy konstruktorának a neve legyen azonos a típussal!
A konstruktornak a szükséges paraméterei Double-ök legyenek.
Ne legyen rajta semmilyen deriving.
-}



-- Példányosítsuk értelemszerűen a következő osztályokat Complex-re: Eq, Show, Num, Fractional.
-- Eq: Az egyenlőségvizsgálat értelemszerű, két komplex csak akkor egyenlő, ha két szám valós része, illetve a két szám képzetes része megegyezik.

{-
Show: Jelenítsük meg a komplex számokat úgy, ahogy matematikában is szokás írni azokat, alapértelmezett formában a + bi.
      Ez azt jelenti, hogy az alábbiak szerint járjunk el egyes speciális esetekben:
      -- Ha b == 1, akkor az 1-est ne írjuk ki, pl 2 + i legyen 2 + 1i helyett kiírva.
      -- Ha b == 0, akkor csak a valós rész legyen kiírva.
      -- Ha b < 0, akkor a - bi formában legyen kiírva.
      -- Következetesen járjunk el b == -1 esetén is.
-}

{-
Num: Mivel a komplex számok... hát... számok, ezért meg kell mondani, hogy ezen számok hogy viselkednek az alapműveletekkel.
     -- Nézzük meg :i-vel, hogy miket kell definiálni.
     -- Összeadás, kivonás, szorzás remélhetőleg értelemszerű.
     -- abszolútérték: komplexek esetén a két dimenziós számot reprezentáló vektor hosszát jelenti. Használjuk a Pitagorasz-tételt a számoláshoz.
     -- signum: Előjel függvény. Komplexek esetén az "adott irányú" egységvektort jelenti, tehát nincs más dolgunk, mint az eredeti számot elosztani a szám abszolútértékével.
                (Megj.: Ezt nem tudjuk közvetlen megtenni, de részenként már tudunk osztani, hiszen a komplex szám két Double-lel van reprezentálva.)
     -- fromInteger: Ez az a függvény, aminek a segítségével egy leírt számliterál be tud állni tetszőleges típusú szám helyére,
                     pl. ahogy 2 lehet Int, lehet Double, lehet Float; különböző típusok esetén ez a függvény alakítja át az Integer-t a megfelelőre.
                     Megj.: Mivel Integer-t, tehát egész számot alakítunk át, ezért az eredményben mindig mennyi lesz a képzetes rész?
-}

{-
Fractional: Komplex számokat osztani is lehet. :i-vel nézzük meg, hogy miket kell definiálni egy Fractional-ben:
            -- (/) vagy recip: osztás vagy reciprok, mindkettő remélhetőleg értelemszerű.
            -- fromRational: Ahogy a számok Integer-ről vannak átalakítva; a törtek Rational-ről vannak átalakítva.
                             A Rational egy még eddig nem látott típus, lényegében a racionális számokat kódolja el, definíció szerint két egész szám hányadosa.
                             A Rational típus a Data.Ratio modulban található meg.
                             :bro Data.Ratio-val meg lehet nézni, hogy a modulban milyen függvények találhatók.
                             Ez a függvény a tizedesponttal felírt számokat alakítja a megfelelő típusúra (Double-re, Float-ra, stb.)
-}
