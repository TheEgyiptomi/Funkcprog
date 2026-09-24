# Functional Languages exam, 05-01-2026

## Useful Links

 - [Haskell library documentation](http://lambda.inf.elte.hu/haskell/doc/libraries/),
 - [Hoogle (local)](http://lambda.inf.elte.hu/haskell/hoogle/),
 - [Lambda page](http://lambda.inf.elte.hu/Index_en.xml),
 - [Haskell syntax summary](http://lambda.inf.elte.hu/CheatSheet_en.xml).

## Visual Studio Code Haskell Syntax Highlighting

You can find the *Visual Studio Code Haskell Syntax Highlighting* extension attached as Instructor files.

Download the attached `justusadam.language-haskell-3.6.0.vsix` file.

Installation in VS Code:

1. Open the Extensions on the left (`Ctrl + Shift + X`).
2. Click `...` at the upper right corner of the new window.
3. Chose `Install from VSIX...`, then choose the downloaded file.

## Grading (quiz + programming)

- from 15 points the grade is 2
- from 19 points the grade is 3
- from 22 points the grade is 4
- from 25 points the grade is 5

## General information

If there are any questions about the tasks (not understandable what the wants), then
please tell it to an instructor! **Do not** talk to any other studendts under any circumstances!

**IMPORTANT:**

- In your solution there should be at least one function solved that **uses recursion**.
  This can be the function itself or its helper function, however, it has to do the task directly.
  Defining library functions recursively doesn't count. If there is no function defined using
  recursion, then the exam is failed.

- From the programming part you need **at least 7 points**! For the passing grade, you need **at least 15 points total**!

- The given tasks must be done by the description of them using the given type signature
  **without modifying it**! If some changes happened to the type signature, then the task will worth 0 points!

- The uploaded code **must compile**, otherwise the exam is failed! If there are some parts of the code you want to include in the final solution, but the code doesn't compile with those inclusions, those are still worth it to include them in a comment block for possible extra points, just make sure that in the end the code compiles!

- Tests are there to help you understand a given task better. The tester is going to give some feedback on the uploaded code, but **that's not the final score/grade**.

# Tasks

## 0. Module

Define the `Exam2` module! Make sure to name your exam file as `Exam2.hs`!

## 1. Function separation (1 point)

Define a function, which converts a function that has a pair as its
output type into a pair of functions, each with one of the outputs.

```hs
divFun :: (a -> (b,c)) -> (a -> b, a -> c)
```

```hs
fst (divFun (`divMod` 5)) 23 == 4
snd (divFun (`divMod` 5)) 23 == 3
fst (divFun (\x -> (x*2,x+10))) 90 == 180
snd (divFun (\x -> (x*2,x+10))) 90 == 100
fst (divFun (\x -> (x,length x))) "abc" == "abc"
snd (divFun (\x -> (x,length x))) "abc" == 3
```

## 2. Indeces (2 points)

Define the `indecesOfNothings` function which returns the indeces of `Nothing`s from a list. Start the indexing from `0`.

```hs
indecesOfNothings :: Num b => [Maybe a] -> [b]
```

```hs
null (indecesOfNothings [])
null (indecesOfNothings [Just 'a', Just 'b', Just 'c', Just 'd'])
indecesOfNothings [Nothing] == [0]
indecesOfNothings [Just True, Nothing] == [1]
indecesOfNothings [Nothing, Just [1], Nothing] == [0,2]
indecesOfNothings [Nothing, Just [1..], Nothing] == [0,2]
indecesOfNothings [Just [1..], Nothing, Just [2,3,4,1,0], Nothing] == [1,3]
indecesOfNothings [Nothing, Just [1..], Just [2..], Nothing, Nothing, Just[2,1,1]] == [0,3,4]
take 15 (indecesOfNothings (cycle [Nothing, Just [1..], Just [2..], Nothing, Nothing, Just [2,1,1]])) == [0,3,4,6,9,10,12,15,16,18,21,22,24,27,28]
take 10 (indecesOfNothings (cycle [Just [1..], Just [2..], Nothing, Just [2,1,1], Nothing])) == [2,4,7,9,12,14,17,19,22,24]
```

## 3. Conditional joining (2 points)

Implement the `applyWhen` function, which has the following four
parameters:

- A joining function `(a -> b -> c)`
- A binary predicate `(a -> b -> Bool)`
- Two input lists `[a]` and `[b]`

It traverses the two lists simultaneously and at each pair of elements
creates an output result using the joining function if the predicate
holds for the two values or skips them otherwise.

The output list is at most as long as the shorter list among the inputs.

```hs
applyWhen :: (a -> b -> c) -> (a -> b -> Bool) -> [a] -> [b] -> [c]
```

```hs
applyWhen (,) (>) [1..10] [10,9..1] == [(6,5),(7,4),(8,3),(9,2),(10,1)]
applyWhen (+) (\a b -> a + b /= 5) [1,6,2,3,4,6] [5,4,3,2,1,0] == [6,10,6]
applyWhen (,) (>) [] [1..] == []
applyWhen (,) (>) [1..] [] == []
applyWhen (+) (\a b -> a + b == 5) [0,1,2,3,4,5] [5,4,3,2,1,0] == replicate 6 5
applyWhen (++) (\a b -> null a || null b) [[], "apple", "banana", []] ["lemon", [], "peach", []] == ["lemon", "apple", ""]
take 50 (applyWhen (\_ b -> (b, not b)) (flip const) (repeat undefined) (iterate not True)) == replicate 50 (True, False)
```

## 4. Lots of same elements (2 points)

Define the `factRepl` function which replicates factorial many elements the list has (1ˢᵗ parameter) of a given (2ⁿᵈ parameter) element. You can assume the list to be finite.

```hs
factRepl :: [b] -> a -> [a]
```

```hs
factRepl "" 'a' == "a"
factRepl "abc" 2 == [2,2,2,2,2,2]
factRepl [1,6] 5 == [5,5]
factRepl [0,0,2,7] 't' == "tttttttttttttttttttttttt"
let res = factRepl [1,5,9,10,11] True in length res == 120 && all id res
let res = factRepl [9,1,5,9,10,11] 'k' in length res == 720 && all (== head res) res
not (null (factRepl [21,20..1] even))
not (null (factRepl [30,20..1] 4))
```

## 5. Neighbours with a given difference (2 points)

Define the `neighbourDiff` function which determines whether there are two consecutive elements in a list of numbers with the given difference.

```hs
neighbourDiff :: (Num a, Eq a) => [a] -> a -> Bool
```

```hs
neighbourDiff [2,3] 1
neighbourDiff [5,2,3] 3
neighbourDiff [-2,-3] 1
neighbourDiff [2,-3] 5
neighbourDiff [1..10] 1
neighbourDiff [1,10,2,20] 9
neighbourDiff [1..1000] 1
neighbourDiff [0,2..1000] 2
neighbourDiff [-100..10] 1
neighbourDiff [10, 20 .. 100] 10
neighbourDiff [10,20..] 10
neighbourDiff [x^2 | x <- [1..]] 25
not (neighbourDiff [] 5)
not (neighbourDiff [5] 5)
not (neighbourDiff [1,10,100] 5)
not (neighbourDiff [1..10] 0)
not (neighbourDiff [1..10] 5)
not (neighbourDiff [1,3,6,10] 1)
not (neighbourDiff [10, 20 .. 100] 5)
```

## 6. Flour (1 + 3 points)

We are in the kingdom of Haskell and as a nobleman, we own a big piece of the `Domain`. Roughly speaking the `Domain` consists of some of these `Land` pieces:

- Some `Forest :: Integer -> Land` where some wild animals live.
- Some `Pasture :: Integer -> Land` where your flock of sheep, cows and other farm animals can live and eat.
- Some `Farmland :: Crop -> Integer -> Land` where you have your `Crop`s, namely `Potato`, `Wheat` and `Barley`.

The `Integer` values in all cases represent the area of the given `Land`.

**a)** Represent the aforementioned types. `Domain` is just a synonym for a list of `Land`. The `Land` and `Crop` types should be datatypes.

**b)** It's winter farming time. Though a bit late to farm these crops but they are tough (let's not call these "supercrops" by their modern names). **On 1 unit area of land 1 unit of crop grows.** For winter it is nice to have some warm bread but for that you need flour. To fill 1 sack of flour, we need 10 unit of crops. During winter times you have to store the flour in sacks and <u>important</u>, **you don't want to mix the different flour types!** Define the `flourSacks` function to determine how many sacks you would need to store all the flour you can get, you don't want to waste a single powder of flour! You can assume the `Domain` is finite.

```hs
flourSacks :: Domain -> Integer
```

```hs
flourSacks [] == 0
flourSacks [Farmland Wheat 109] == 11
flourSacks [Farmland Barley 100] == 10
flourSacks [Farmland Potato 109] == 0
flourSacks [Farmland Wheat 9] == 1
flourSacks [Farmland Wheat 10, Farmland Barley 10, Farmland Potato 10] == 2
flourSacks [Farmland Wheat 16, Farmland Barley 16] == 4
flourSacks [Farmland Wheat 15, Farmland Barley 15, Farmland Wheat 15, Farmland Wheat 15] == 7
flourSacks [Farmland Wheat 15, Farmland Barley 15, Farmland Potato 11, Farmland Wheat 15, Farmland Wheat 15] == 7
flourSacks [Forest 250, Forest 100, Pasture 250, Forest 150, Pasture 100] == 0
flourSacks [Forest 250, Farmland Barley 537, Farmland Barley 312, Forest 1440, Farmland Potato 766, Pasture 1000, Farmland Potato 305, Farmland Wheat 318, Farmland Barley 391] == 156
flourSacks [Forest 250, Farmland Barley 537, Farmland Barley 312, Forest 1440, Farmland Potato 766, Pasture 1000, Farmland Potato 305, Farmland Wheat 318, Farmland Barley 392] == 157
```

## 7. Batteries (3 + 2 points)

Santa Claus is happy about last Christmas. After the event, after delivering the gifts and after a well-deserved rest now it's time for a winter cleanup. His factory at the North-pole has lots of battery packs as a backup plan in case the electricity shuts down and he has to do some maintainence on them. One battery pack contains several battery units (let's represent one battery unit as `Char`) which are charged to some level (characters `0-9`) or showing some error code (any other character).

**a)** Santa will have to determine the strength of the charge of a **single battery pack**. To determine the strength of the charge, you have to create the greatest double digit number from the charge levels of the good batteries without changing the order of the battery units (otherwise it won't function correctly). Help Santa by definining the `batteryCharge` function to determine the strength of the charge of a pack. Return the **greatest double digit number** you can create complying with the rules as a `String`. If there are no two good batteries, return `Nothing`. You can assume a battery pack is finite.

```hs
type BatteryPack = String
batteryCharge :: BatteryPack -> Maybe String
```

```hs
batteryCharge "329879" == Just "99"
batteryCharge "" == Nothing
batteryCharge "0" == Nothing
batteryCharge "aA" == Nothing
batteryCharge "error" == Nothing
batteryCharge "0123" == Just "23"
batteryCharge "4327error68321011problem4343" == Just "84"
batteryCharge "10110203033014" == Just "34"
batteryCharge "101102030330140" == Just "40"
batteryCharge "1batterydead0" == Just "10"
batteryCharge "2232133233333122223222321121432322323324333234233221423334362333113343833132233313523312322224432234" == Just "85"
batteryCharge "9544718948279477416294977734546287758964484675984344448638555429875995525496945633428322464129775449" == Just "99"
batteryCharge "2342431222323242222322132121222212212132223222221322252221222222422212122222231227223222421241422222" == Just "74"
batteryCharge "6244953925232293122334482643333513353336433435373235433333433333344373324258246634153623454355543453" == Just "99"
batteryCharge "7736344447654414443368344654254336514625323365763557557347345633456536654753356543554224337423655645" == Just "87"
batteryCharge "7678256455884537672778638766849667285882535872669457673757574863687675953957763739884526852357676358" == Just "99"
batteryCharge "6418138815172751627482363178142568277778573255724443532712835875457855664165654688176581654473178739" == Just "89"
batteryCharge "6854446345485434355456557454552353525455763235344855551758634555554555645555644535645534531743242554" == Just "88"
batteryCharge "2222222322322223322332612212222225222322331322242221255172251455232132122221223222221221222241222221" == Just "75"
batteryCharge "3522465222652563115529464642233332216344152233612263521373322232245234334452353472671944353144627333" == Just "99"
batteryCharge "5545321222222522222344243223154223534233224542342331245267254214331654424232831423343325435272544421" == Just "87"
batteryCharge "3542524122211624341522322226153222251432222222223323326252321225121362141322235161225221111222227241" == Just "74"
batteryCharge "2455322717243462411254243226323523121523342233134641142441394244224254232641451244318434422422224383" == Just "98"
batteryCharge "4553343324447136364342223433344524634414373234332183266461265223446463254334435343223462442245322567" == Just "87"
batteryCharge "6563436486136355463655575366345554384456562545629262586425424652243626548657625466455656653543945665" == Just "99"
batteryCharge "7535454577563343346435454343443457475576543343854334614444838455344744678754354444737744257755677424" == Just "88"
batteryCharge "5564445435564444634466844337565445844465549459245334613233554632368925514334436545333343645355776454" == Just "99"
batteryCharge "8687888777879988878786888689883788878676787767787678887576788777889856868587889748756884386837718787" == Just "99"
```

**b)** Santa wants to see how much electricity he will need to charge the batteries. For this he will need the total strength of the charges of all of the battery packs that is available in his factory. Define the `totalCharge` function which sums (as an `Integer`) all the individual strengths of the charges of the battery packs. You can assume you have finitely many battery packs.

*Hint: To convert some text to a number, use the `read` function. Check its type in GHCi. It is a good practice to give the type explicitly to the expression in which we used the function.*

If you didn't do the previous task, you can still get the points for this task by assuming you have the `batteryCharge` function but you won't be able to test it for obvious reasons.

```hs
totalCharge :: [BatteryPack] -> Integer
```

```hs
totalCharge ["329879","","alma","5732960"] == 195
totalCharge ["al3ma","al1m4a5","8787"] == 133
totalCharge ["101102030330140","2232133233333122223222321121432322323324333234233221423334362333113343833132233313523312322224432234","8687888777879988878786888689883788878676787767787678887576788777889856868587889748756884386837718787","5545321222222522222344243223154223534233224542342331245267254214331654424232831423343325435272544421"] == 311
```
