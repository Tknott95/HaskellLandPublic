module StateMonad00 where

import Control.Monad.State
import qualified Data.Array as A
import qualified Data.Ix as I
import System.Random 
-- (randomR, StdGen, newStdGen)
-- initGameState (mkStdGen 137)
{- Ref: 
 - From reading "Monday Morning Haskell" 
 -  * https://mmhaskell.com/monads/state -}


data Player = PO | PX deriving Show

data GameState = GameState {
  board      ::  A.Array TileIndex TileState,
  currPlayer ::  Player,
  generator  ::  StdGen
} deriving Show

data TileState = IEmpty | IsX | IsO deriving (Eq, Show)
type TileIndex = (Int, Int)

initGameState :: StdGen -> GameState
initGameState seed = GameState
  (A.array (head boardIndices, last boardIndices) [(i, IEmpty) | i <- boardIndices])
  PX
  seed


boardIndices :: [TileIndex]
boardIndices = I.range ((0, 0), (2, 2))

{-
 - @TODO rename the parameters coming in -
 get :: State s s
 put :: s -> State s ()

 - returns the result of the computation and the final state
 runState :: s -> State s a -> (a, s)

 - to discard the final state -
 evalState :: State s a -> s -> a

 - to discard the computational result -
 execState :: State s a -> s -> s
-}

switchPlayer :: Player -> Player
switchPlayer PX = PO
switchPlayer PO = PX

tileForPlayer :: Player -> TileState
tileForPlayer PX = IsX
tileForPlayer PO = IsO

pickRndMove :: State GameState TileIndex
pickRndMove = do
  game <- get
  let openTiles = [fst pair | pair <- A.assocs (board game), snd pair == IEmpty]
  let genr = generator game
  let (i, genr') = randomR (0, length openTiles - 1) genr
  put $ game { generator = genr' }
  return $ openTiles !! i


applyMove :: TileIndex -> State GameState ()
applyMove a = do
  game <- get
  a <- pickRndMove
  applyMove a
  let iPlyr = currPlayer game
  let newBoard = board game A.// [(a, tileForPlayer iPlyr)]
  put $ game { currPlayer = switchPlayer iPlyr, board = newBoard }

--  putStrLn "... Choosing Tic Tac Toe, Why not War Games?\n"
