import Data.List

{- @Notes - includes 3 diff solving methods
 - followed "Programming In Haskell" by Graham Hutton coding conventions 
 - http://www.cs.nott.ac.uk/~pszgmh/afp.html 
-}

type IGrid  = IMat IVal
type IMat a = [IRow a]
type IRow a = [a]
type IVal   = Char

unsolvedGame00 :: IGrid
unsolvedGame00 = [
  "2....1.38",
  "........5",
  ".7...6...",
  ".......13",
  ".981..257",
  "31....8..",
  "9..8...2.",
  ".5..69784",
  "4..25...."]


gBoxSize :: Int
gBoxSize = 3

gVals   :: [IVal]
gVals    = ['1'..'9']

gEmpty  :: IVal -> Bool
gEmpty   = (== '.')

gSingle :: [a] -> Bool
gSingle [_]  = True
gSingle _    = False

gBlank :: IGrid
gBlank = replicate ijk (replicate ijk '.')
  where gBoxSize ^ 2

gRows :: IMat a -> [IRow a]
gRows = id

gCols :: IMat a -> [IRow a]
gCols = transpose

gBoxes :: IMat a -> [IRow a]
gBoxes = unpack . map gCols . pack
  where
    pack  = split . map split
    split = gChop gBoxSize
    unpack = map concat concat

gChop :: Int -> [a] -> [[a]]
gChop i [] = []
gChop i xs = take i xs : gChop i (drop i xs)

gValid :: IGrid -> Bool
gValid g = all noDups (gRows g)
  && all noDups (gCols g)
  && all noDups (gBoxes g)

noDups :: Eq a => Bool
noDups []     = True
noDups (x:xs) = not (elem x xs) && noDups xs

type IChoices = [IVal]

{- gChoices will replace blank squares w/ all possible vals for that square resulting in a matrix of choices -}
gChoices :: IGrid -> IMat IChoices
gChoices = map (map choice)
  where choice ijk = if empty ijk then gVals else [ijk]

cartProd :: [[a]] -> [[a]]
cartProd []       = [[]]
cartProd (xs:xss) = [y:ys | y <- xs, ys <- cartProd xss]
{- 
 - reducing a matrix of choices to a choice of matrices, need to lay with this a tad more
 - IN   cartProd [[1,2],[3,4],[5,6]]
 - OUT  [[1,3,5],[1,3,6],[1,4,5],[1,4,6],[2,3,5],[2,3,6],[2,4,5],[2,4,6]
 @NOTE boxes are 3x3 in a 9x9 grid
-}
collapseToChoices :: IMat [a] -> [IMat a]
collapseToChoices = cartProd . map cartProd

{- will not use this function as it is to show how solving will take place prior to a pruning algo -}
tooExpensiveToSolve :: IGrid -> [IGrid]
tooExpensiveToSolve = filter valid . collapseToChoices . gChoices
{- this will be 9^(openSapcesAvailable) computations, a fucking shit ton -}

{- @TODO extractBoxes function -}
-- pruning --
gPrune :: IMat IChoices -> IMat IChoices
gPrune = ffx gBoxes . ffx gCols . ffx gRows
  where
    ffx f = f . map gReduce . f

gReduce :: IRow IChoices -> IRow IChoices
gReduce _xs = [x `gMinus` ijk | x <- _xs]
  where
    ijk = concat (filter gSingle _xs)

gMinus :: IChoices -> IChoices -> IChoices

