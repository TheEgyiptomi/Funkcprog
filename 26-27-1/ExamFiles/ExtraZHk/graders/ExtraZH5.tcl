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

optional "haveAtLeastThreeAndMostSixElems" {
    points = 1
    pretest =
    - haveAtLeastThreeAndMostSixElems
    tests =
    - haveAtLeastThreeAndMostSixElems [] == False
    - haveAtLeastThreeAndMostSixElems [1] == False
    - haveAtLeastThreeAndMostSixElems [1,2] == False
    - haveAtLeastThreeAndMostSixElems [1,2,3] == True
    - haveAtLeastThreeAndMostSixElems [1,2,3,4] == True
    - haveAtLeastThreeAndMostSixElems [1,2,3,4,5] == True
    - haveAtLeastThreeAndMostSixElems [1,2,3,4,5,6] == True
    - haveAtLeastThreeAndMostSixElems [1,2,3,4,5,6,7] == False
    - haveAtLeastThreeAndMostSixElems [1,2,3,4,5,6,7,8] == False
    - haveAtLeastThreeAndMostSixElems [1..100] == False
    - haveAtLeastThreeAndMostSixElems [1..] == False
    - haveAtLeastThreeAndMostSixElems "" == False
    - haveAtLeastThreeAndMostSixElems "a" == False
    - haveAtLeastThreeAndMostSixElems "ab" == False
    - haveAtLeastThreeAndMostSixElems "abc" == True
    - haveAtLeastThreeAndMostSixElems "abcd" == True
    - haveAtLeastThreeAndMostSixElems "abcde" == True
    - haveAtLeastThreeAndMostSixElems "abcdef" == True
    - haveAtLeastThreeAndMostSixElems "abcdefg" == False
    - haveAtLeastThreeAndMostSixElems "abcdefgh" == False
    - haveAtLeastThreeAndMostSixElems ['a'..'z'] == False
    - haveAtLeastThreeAndMostSixElems ['a'..] == False
}

optional "weirdInterleave" {
    points = 2
    pretest =
    - weirdInterleave
    tests =
    - weirdInterleave [] [] == []
    - weirdInterleave [1] [] == [1]
    - weirdInterleave [] [2] == [2]
    - weirdInterleave [1] [2] == [1,2]
    - weirdInterleave [1] [2,3] == [1,2,3]
    - weirdInterleave [1,4] [2,3] == [1,2,3,4]
    - weirdInterleave [1,4] [2,3,5] == [1,2,3,4,5]
    - weirdInterleave [1,4] [2,3,5,6] == [1..6]
    - weirdInterleave "HlWl" "elo ord!" == "Hello World!"
    - take 10 (weirdInterleave [1,1..] [2,2..]) == [1,2,2,1,2,2,1,2,2,1]
    - take 10 (weirdInterleave ['0','0'..] ['A'..]) == "0AB0CD0EF0"
}

optional "intersection" {
    points = 3
    pretest =
    - intersection
    tests =
    - intersection [] [] == []
    - intersection [1,2,3] [] == []
    - intersection [] [1,2,3] == []
    - sort (intersection [1,2,3] [1,2,3]) == [1,2,3]
    - sort (intersection [1,2,3] [1,2,3,4]) == [1,2,3]
    - sort (intersection [1,3] [1,2,3]) == [1,3]
    - sort (intersection [1,2,3] [3,2,1]) == [1,2,3]
    - sort (intersection [1..10] [1..10]) == [1..10]
    - sort (intersection [1..10] [10,9..1]) == [1..10]
    - sort (intersection [1..20] [15..25]) == [15..20]
    - sort (intersection [1..20] [25,24..15]) == [15..20]
}
