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

optional "haveAtLeastTwoAndThreeElems" {
    points = 1
    pretest =
    - haveAtLeastTwoAndThreeElems
    tests =
    - haveAtLeastTwoAndThreeElems ([], []) == False
    - haveAtLeastTwoAndThreeElems ([], [1]) == False
    - haveAtLeastTwoAndThreeElems ([1], []) == False
    - haveAtLeastTwoAndThreeElems ([], [1,2]) == False
    - haveAtLeastTwoAndThreeElems ([1], [1]) == False
    - haveAtLeastTwoAndThreeElems ([1,2], []) == False
    - haveAtLeastTwoAndThreeElems ([], [1,2,3]) == False
    - haveAtLeastTwoAndThreeElems ([1], [1,2]) == False
    - haveAtLeastTwoAndThreeElems ([1,2], [1]) == False
    - haveAtLeastTwoAndThreeElems ([1,2,3], []) == False
    - haveAtLeastTwoAndThreeElems ([], [1,2,3,4,5]) == False
    - haveAtLeastTwoAndThreeElems ([1], [1,2,3,4]) == False
    - haveAtLeastTwoAndThreeElems ([1,2], [1,2,3]) == True
    - haveAtLeastTwoAndThreeElems ([1,2,3], [1,2]) == True
    - haveAtLeastTwoAndThreeElems ([1,2,3,4], [1]) == False
    - haveAtLeastTwoAndThreeElems ([1,2,3,4,5], []) == False
    - haveAtLeastTwoAndThreeElems ([], [1,2,3,4,5,6]) == False
    - haveAtLeastTwoAndThreeElems ([1], [1,2,3,4,5]) == False
    - haveAtLeastTwoAndThreeElems ([1,2], [1,2,3,4]) == True
    - haveAtLeastTwoAndThreeElems ([1,2,3], [1,2,3]) == True
    - haveAtLeastTwoAndThreeElems ([1,2,3,4], [1,2]) == True
    - haveAtLeastTwoAndThreeElems ([1,2,3,4,5], [1]) == False
    - haveAtLeastTwoAndThreeElems ([1,2,3,4,5,6], []) == False
    - haveAtLeastTwoAndThreeElems ("", "") == False
    - haveAtLeastTwoAndThreeElems ("", "bar") == False
    - haveAtLeastTwoAndThreeElems ("foo", "") == False
    - haveAtLeastTwoAndThreeElems ("foo", "bar") == True
    - haveAtLeastTwoAndThreeElems ([1..], []) == False
    - haveAtLeastTwoAndThreeElems ([1..], [1]) == False
    - haveAtLeastTwoAndThreeElems ([1..], [1,2]) == True
    - haveAtLeastTwoAndThreeElems ([], [1..]) == False
    - haveAtLeastTwoAndThreeElems ([1], [1..]) == False
    - haveAtLeastTwoAndThreeElems ([1,2], [1..]) == True
    - haveAtLeastTwoAndThreeElems ([1..], [1..]) == True
}

optional "sumProduct" {
    points = 2
    pretest =
    - sumProduct
    tests =
    - sumProduct [] [] == 0
    - sumProduct [1] [] == 0
    - sumProduct [] [1] == 0
    - sumProduct [1] [1] == 1
    - sumProduct [1,2] [1] == 1
    - sumProduct [1] [1,2] == 1
    - sumProduct [1,2] [1,2] == 5
    - sumProduct [1,2] [2,1] == 4
    - sumProduct [1..5] [5,4..1] == 35
    - sumProduct [9,6,7] [4,2,0] == 48
    - sumProduct [9,6,7] [4,1,1] == 49
}

optional "dropEveryNth" {
    points = 3
    pretest =
    - dropEveryNth
    tests =
    - dropEveryNth 1 [] == []
    - dropEveryNth 1 [1] == []
    - dropEveryNth 1 [1..10] == []
    - dropEveryNth 1 "hello" == ""
    - dropEveryNth 2 [] == []
    - dropEveryNth 2 [1] == [1]
    - dropEveryNth 2 [1..10] == [1,3..9]
    - dropEveryNth 2 "hello" == "hlo"
    - dropEveryNth 3 [] == []
    - dropEveryNth 3 [1] == [1]
    - dropEveryNth 3 [1..10] == [1,2,4,5,7,8,10]
    - dropEveryNth 3 "hello" == "helo"
    - take 10 (dropEveryNth 2 [1..]) == [1,3..19]
    - take 10 (dropEveryNth 19 ['X','X'..]) == replicate 10 'X'
}
