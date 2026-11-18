general {
  module = haskell
  grade = True
  language = hu
  minscore = 1
}

haskell {
  safemode = True
  autofix = True
    ghcoptions =
    - fdefer-type-errors
}

optional "max3" {
    points = 1
    pretest =
    - max3
    tests =
    - max3 (1, 2, 3) == 3
    - max3 (2, 3, 1) == 3
    - max3 (3, 1, 2) == 3
    - max3 (0, 0, 0) == 0
    - max3 (1, 2, 2) == 2
    - max3 (False, True, False) == True
    - max3 (False, True, True) == True
    - max3 (False, False, False) == False
    - max3 ('a', 'b', 'c') == 'c'
    - max3 ('b', 'c', 'a') == 'c'
    - max3 ('c', 'a', 'b') == 'c'
    - max3 ("Alfa", "Bravo", "Charlie") == "Charlie"
    - max3 ("Bravo", "Charlie", "Alfa") == "Charlie"
    - max3 ("Charlie", "Alfa", "Bravo") == "Charlie"
}

optional "areTriosEqual" {
    points = 2
    pretest =
    - areTriosEqual
    tests =
    - areTriosEqual [] == True
    - areTriosEqual [1] == True
    - areTriosEqual [1,2] == True
    - areTriosEqual [1,2,3] == False
    - areTriosEqual [1,1,1] == True
    - areTriosEqual [1,1,1,2] == True
    - areTriosEqual [1,1,1,2,3] == True
    - areTriosEqual [1,1,1,2,3,4] == False
    - areTriosEqual [1,1,1,2,2,2] == True
    - areTriosEqual [1,1,1,2,2,2,3,3,3,4,4,4,5,5,5] == True
    - areTriosEqual "000AAAaaa" == True
}

optional "indexOf" {
    points = 3
    pretest =
    - indexOf
    tests =
    - indexOf 0 [-10..10] == 10
    - indexOf 67 [18,68,23,91,35,92,67,29,95,34,67,12] == 6
    - indexOf 'o' "Hello world!" == 4
    - indexOf 'x' "the quick brown fox jumps over the lazy brown dog" == 18
    - indexOf False [False,False,True,False,True] == 0
    - indexOf True [False,False,True,False,True] == 2
    - indexOf "bar" ["foo","foo","bar","bar"] == 2
    - indexOf 0 ([1,2,3] ++ repeat 0) == 3
    - indexOf 'x' ("asdasdasd" ++ repeat 'x') == 9
    - indexOf False (replicate 20 True ++ repeat False) == 20
    - indexOf "hello" (repeat "hello") == 0
}
