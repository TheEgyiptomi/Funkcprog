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

optional "sameSignCoordinates" {
    points = 1
    pretest =
    - sameSignCoordinates
    tests =
    - sameSignCoordinates (0, 0) == True
    - sameSignCoordinates (0, 1) == False
    - sameSignCoordinates (0, -1) == False
    - sameSignCoordinates (1, 0) == False
    - sameSignCoordinates (1, 1) == True
    - sameSignCoordinates (1, -1) == False
    - sameSignCoordinates (-1, 0) == False
    - sameSignCoordinates (-1, 1) == False
    - sameSignCoordinates (-1, -1) == True
    - sameSignCoordinates (1, 2) == True
    - sameSignCoordinates (1, -2) == False
    - sameSignCoordinates (-1, 2) == False
    - sameSignCoordinates (-1, -2) == True
    - sameSignCoordinates (1, 0.5) == True
    - sameSignCoordinates (1, -0.5) == False
    - sameSignCoordinates (-1, 0.5) == False
    - sameSignCoordinates (-1, -0.5) == True
    - sameSignCoordinates (1, 0.0001) == True
    - sameSignCoordinates (1, -0.0001) == False
    - sameSignCoordinates (-1, 0.0001) == False
    - sameSignCoordinates (-1, -0.0001) == True
}

optional "sameNeighbours" {
    points = 2
    pretest =
    - sameNeighbours
    tests =
    - sameNeighbours [] == False
    - sameNeighbours [1] == False
    - sameNeighbours [False] == False
    - sameNeighbours "a" == False
    - sameNeighbours [1,2] == False
    - sameNeighbours [1,1] == True
    - sameNeighbours [1,2,2,1] == True
    - sameNeighbours [True,False,True] == False
    - sameNeighbours [True,True,True] == True
    - sameNeighbours "helo!" == False
    - sameNeighbours "hello!" == True
}

optional "sumGroupsOfN" {
    points = 3
    pretest =
    - sumGroupsOfN
    tests =
    - sumGroupsOfN 1 [] == []
    - sumGroupsOfN 1 [1] == [1]
    - sumGroupsOfN 1 [1,2] == [1,2]
    - sumGroupsOfN 1 [1,2,3] == [1,2,3]
    - sumGroupsOfN 1 [1,2,3,4] == [1,2,3,4]
    - sumGroupsOfN 1 [1,2,3,4,5] == [1,2,3,4,5]
    - sumGroupsOfN 1 [1,2,3,4,5,6] == [1,2,3,4,5,6]
    - sumGroupsOfN 1 [1..10] == [1..10]
    - sumGroupsOfN 2 [] == []
    - sumGroupsOfN 2 [1] == [1]
    - sumGroupsOfN 2 [1,2] == [3]
    - sumGroupsOfN 2 [1,2,3] == [3,3]
    - sumGroupsOfN 2 [1,2,3,4] == [3,7]
    - sumGroupsOfN 2 [1,2,3,4,5] == [3,7,5]
    - sumGroupsOfN 2 [1,2,3,4,5,6] == [3,7,11]
    - sumGroupsOfN 2 [1..10] == [3,7,11,15,19]
    - sumGroupsOfN 3 [] == []
    - sumGroupsOfN 3 [1] == [1]
    - sumGroupsOfN 3 [1,2] == [3]
    - sumGroupsOfN 3 [1,2,3] == [6]
    - sumGroupsOfN 3 [1,2,3,4] == [6,4]
    - sumGroupsOfN 3 [1,2,3,4,5] == [6,9]
    - sumGroupsOfN 3 [1,2,3,4,5,6] == [6,15]
    - sumGroupsOfN 3 [1..10] == [6,15,24,10]
    - take 10 (sumGroupsOfN 3 [1..]) == [6,15..87]
}
