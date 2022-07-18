module Stated01 where

import Control.Monad.State


data ISurreal = ISurreal {
  sId    ::   Int,
  sName  :: String
} deriving Show

setData0 :: State ISurreal ()
setData0 = do
  iData <- get
  -- print "\n  setData0 fired!"
  put $ iData { sId = 137, sName="Dali" }

getName :: State ISurreal String
getName = do
  iDa <- get
  let sfx = sName iDa
  return sfx

runShit = do
  setData0
  -- let sfx = getName
